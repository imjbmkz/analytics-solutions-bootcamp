with person_parsed as (
	SELECT
	    p.business_entity_id,
	    p.person_type,
	    p.name_style,
	    p.title,
	    p.first_name,
	    p.middle_name,
	    p.last_name,
	    p.suffix,
	    p.email_promotion,
	
	--    /* Raw XML retained for auditing */
	--    p.additional_contact_info,
	--    p.demographics,
	
	    /* Demographics */
	    survey.total_purchase_ytd as demog__total_purchase_ytd,
	    CAST(
	        REPLACE(survey.date_first_purchase_raw, 'Z', '')
	        AS date
	    ) AS demog__date_first_purchase,
	
	    CAST(
	        REPLACE(survey.birth_date_raw, 'Z', '')
	        AS date
	    ) AS demog__birth_date,
	
	    survey.marital_status as demog__marital_status ,
	    survey.yearly_income as demog__yearly_income,
	    survey.gender as demog__gender,
	    survey.total_children as demog__total_children,
	    survey.number_children_at_home as demog__number_children_at_home,
	    TRIM(survey.education) AS demog__education,
	    survey.occupation as demog__occupation,
	
	    CASE survey.home_owner_flag_raw
	        WHEN '1' THEN true
	        WHEN '0' THEN false
	        ELSE NULL
	    END AS demog__home_owner_flag,
	
	    survey.number_cars_owned as demog__number_cars_owned,
	    survey.commute_distance as demog__commute_distance,
	    survey.comments as demog__comments,
	    hobbies.hobbies as demog__hobbies,
	
	    /* Additional phone contacts */
	    phones.telephone_numbers as addtl_contact__telephone_numbers,
	    phones.mobile_numbers as addtl_contact__mobile_numbers,
	    phones.pager_numbers as addtl_contact__pager_numbers,
	    phones.fax_numbers as addtl_contact__fax_numbers,
	    phones.telex_numbers as addtl_contact__telex_numbers,
	    phones.isdn_numbers as addtl_contact__isdn_numbers,
	    phones.phone_special_instructions as addtl_contact__phone_special_instructions,
	
	    /* Additional emails */
	    emails.email_addresses as addtl_contact__email_addresses,
	    emails.email_special_instructions as addtl_contact__email_special_instructions,
	
	    /* Additional addresses */
	    addresses.home_postal_addresses as addtl_contact__home_postal_addresses,
	    addresses.office_addresses as addtl_contact__office_addresses,
	    addresses.registered_addresses as addtl_contact__registered_addresses,
	    addresses.address_special_instructions as addtl_contact__address_special_instructions,
	
	    /* CRM contact history and free-form root notes */
	    contact_records.contact_history as addtl_contact__contact_history,
	    root_notes.additional_contact_notes as addtl_contact__additional_contact_notes,
	
	    p.rowguid,
	    p.modified_date
	
	FROM person.person AS p
	
	/* =========================================================
	   Demographic scalar fields
	   ========================================================= */
	
	LEFT JOIN LATERAL XMLTABLE(
	    XMLNAMESPACES(
	        'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey'
	        AS aw
	    ),
	
	    '/aw:IndividualSurvey'
	
	    PASSING CAST(p.demographics AS xml)
	
	    COLUMNS
	        total_purchase_ytd numeric
	            PATH 'aw:TotalPurchaseYTD',
	
	        date_first_purchase_raw text
	            PATH 'aw:DateFirstPurchase',
	
	        birth_date_raw text
	            PATH 'aw:BirthDate',
	
	        marital_status text
	            PATH 'aw:MaritalStatus',
	
	        yearly_income text
	            PATH 'aw:YearlyIncome',
	
	        gender text
	            PATH 'aw:Gender',
	
	        total_children integer
	            PATH 'aw:TotalChildren',
	
	        number_children_at_home integer
	            PATH 'aw:NumberChildrenAtHome',
	
	        education text
	            PATH 'aw:Education',
	
	        occupation text
	            PATH 'aw:Occupation',
	
	        home_owner_flag_raw text
	            PATH 'aw:HomeOwnerFlag',
	
	        number_cars_owned integer
	            PATH 'aw:NumberCarsOwned',
	
	        commute_distance text
	            PATH 'aw:CommuteDistance',
	
	        comments text
	            PATH 'aw:Comments'
	) AS survey ON true
	
	/* Repeatable hobbies */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            NULLIF(TRIM(h.hobby), ''),
	            ' | '
	            ORDER BY h.sequence_number
	        ) AS hobbies
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey'
	            AS aw
	        ),
	
	        '/aw:IndividualSurvey/aw:Hobby'
	
	        PASSING CAST(p.demographics AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	            hobby text PATH '.'
	    ) AS h
	) AS hobbies ON true
	
	/* =========================================================
	   Additional phone contacts
	   ========================================================= */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'telephoneNumber'
	        ) AS telephone_numbers,
	
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'mobile'
	        ) AS mobile_numbers,
	
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'pager'
	        ) AS pager_numbers,
	
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'facsimileTelephoneNumber'
	        ) AS fax_numbers,
	
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'telexNumber'
	        ) AS telex_numbers,
	
	        string_agg(
	            c.phone_number,
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE c.contact_type = 'internationaliSDNNumber'
	        ) AS isdn_numbers,
	
	        string_agg(
	            concat_ws(
	                ': ',
	                c.contact_type,
	                NULLIF(TRIM(c.special_instructions), '')
	            ),
	            ' | ' ORDER BY c.sequence_number
	        ) FILTER (
	            WHERE NULLIF(TRIM(c.special_instructions), '') IS NOT NULL
	        ) AS phone_special_instructions
	
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes'
	            AS act
	        ),
	
	        '//act:telephoneNumber
	         | //act:mobile
	         | //act:pager
	         | //act:facsimileTelephoneNumber
	         | //act:telexNumber
	         | //act:internationaliSDNNumber'
	
	        PASSING CAST(p.additional_contact_info AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	
	            contact_type text
	                PATH 'local-name(.)',
	
	            phone_number text
	                PATH 'act:number',
	
	            special_instructions text
	                PATH 'normalize-space(act:SpecialInstructions)'
	    ) AS c
	) AS phones ON true
	
	/* =========================================================
	   Additional email addresses
	   ========================================================= */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            e.email_address,
	            ' | ' ORDER BY e.sequence_number
	        ) AS email_addresses,
	
	        string_agg(
	            concat_ws(
	                ': ',
	                e.email_address,
	                NULLIF(TRIM(e.special_instructions), '')
	            ),
	            ' | ' ORDER BY e.sequence_number
	        ) FILTER (
	            WHERE NULLIF(TRIM(e.special_instructions), '') IS NOT NULL
	        ) AS email_special_instructions
	
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes'
	            AS act
	        ),
	
	        '//act:eMail'
	
	        PASSING CAST(p.additional_contact_info AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	
	            email_address text
	                PATH 'act:eMailAddress',
	
	            special_instructions text
	                PATH 'normalize-space(act:SpecialInstructions)'
	    ) AS e
	) AS emails ON true
	
	/* =========================================================
	   Additional addresses
	   ========================================================= */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            concat_ws(
	                ', ',
	                NULLIF(TRIM(a.street_1), ''),
	                NULLIF(TRIM(a.street_2), ''),
	                NULLIF(TRIM(a.city), ''),
	                NULLIF(TRIM(a.state_province), ''),
	                NULLIF(TRIM(a.postal_code), ''),
	                NULLIF(TRIM(a.country_region), '')
	            ),
	            ' | ' ORDER BY a.sequence_number
	        ) FILTER (
	            WHERE a.address_type = 'homePostalAddress'
	        ) AS home_postal_addresses,
	
	        string_agg(
	            concat_ws(
	                ', ',
	                NULLIF(TRIM(a.street_1), ''),
	                NULLIF(TRIM(a.street_2), ''),
	                NULLIF(TRIM(a.city), ''),
	                NULLIF(TRIM(a.state_province), ''),
	                NULLIF(TRIM(a.postal_code), ''),
	                NULLIF(TRIM(a.country_region), '')
	            ),
	            ' | ' ORDER BY a.sequence_number
	        ) FILTER (
	            WHERE a.address_type = 'physicalDeliveryOfficeName'
	        ) AS office_addresses,
	
	        string_agg(
	            concat_ws(
	                ', ',
	                NULLIF(TRIM(a.street_1), ''),
	                NULLIF(TRIM(a.street_2), ''),
	                NULLIF(TRIM(a.city), ''),
	                NULLIF(TRIM(a.state_province), ''),
	                NULLIF(TRIM(a.postal_code), ''),
	                NULLIF(TRIM(a.country_region), '')
	            ),
	            ' | ' ORDER BY a.sequence_number
	        ) FILTER (
	            WHERE a.address_type = 'registeredAddress'
	        ) AS registered_addresses,
	
	        string_agg(
	            concat_ws(
	                ': ',
	                a.address_type,
	                NULLIF(TRIM(a.special_instructions), '')
	            ),
	            ' | ' ORDER BY a.sequence_number
	        ) FILTER (
	            WHERE NULLIF(TRIM(a.special_instructions), '') IS NOT NULL
	        ) AS address_special_instructions
	
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes'
	            AS act
	        ),
	
	        '//act:homePostalAddress
	         | //act:physicalDeliveryOfficeName
	         | //act:registeredAddress'
	
	        PASSING CAST(p.additional_contact_info AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	
	            address_type text
	                PATH 'local-name(.)',
	
	            street_1 text
	                PATH 'act:Street[1]',
	
	            street_2 text
	                PATH 'act:Street[2]',
	
	            city text
	                PATH 'act:City',
	
	            state_province text
	                PATH 'act:StateProvince',
	
	            postal_code text
	                PATH 'act:PostalCode',
	
	            country_region text
	                PATH 'act:CountryRegion',
	
	            special_instructions text
	                PATH 'normalize-space(act:SpecialInstructions)'
	    ) AS a
	) AS addresses ON true
	
	/* =========================================================
	   Historical CRM contact records
	   ========================================================= */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            concat_ws(
	                ': ',
	                REPLACE(r.contact_date_raw, 'Z', ''),
	                NULLIF(TRIM(r.contact_notes), '')
	            ),
	            ' | ' ORDER BY r.sequence_number
	        ) AS contact_history
	
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord'
	            AS crm
	        ),
	
	        '//crm:ContactRecord'
	
	        PASSING CAST(p.additional_contact_info AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	
	            contact_date_raw text
	                PATH '@date',
	
	            contact_notes text
	                PATH 'normalize-space(.)'
	    ) AS r
	) AS contact_records ON true
	
	/* =========================================================
	   Free text directly under AdditionalContactInfo
	   ========================================================= */
	
	LEFT JOIN LATERAL (
	    SELECT
	        string_agg(
	            NULLIF(TRIM(n.note), ''),
	            ' | ' ORDER BY n.sequence_number
	        ) AS additional_contact_notes
	
	    FROM XMLTABLE(
	        XMLNAMESPACES(
	            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo'
	            AS ci
	        ),
	
	        '/ci:AdditionalContactInfo/text()[normalize-space()]'
	
	        PASSING CAST(p.additional_contact_info AS xml)
	
	        COLUMNS
	            sequence_number FOR ORDINALITY,
	            note text PATH 'normalize-space(.)'
	    ) AS n
	) AS root_notes ON true
)
select *
from person_parsed;
