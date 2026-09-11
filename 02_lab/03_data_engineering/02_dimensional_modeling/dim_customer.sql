CREATE TABLE dim_customer AS 
WITH 
customer_source AS (
    SELECT
        CAST(c.customer_id AS integer)
            AS customer_id,

        NULLIF(TRIM(c.account_number), '')
            AS account_number,

        CAST(
            NULLIF(CAST(c.person_id AS text), '')
            AS integer
        ) AS person_id,

        CAST(
            NULLIF(CAST(c.store_id AS text), '')
            AS integer
        ) AS store_id,

        CASE
            WHEN NULLIF(CAST(c.store_id AS text), '') IS NOT NULL
                THEN 'STORE'
            WHEN NULLIF(CAST(c.person_id AS text), '') IS NOT NULL
                THEN 'INDIVIDUAL'
            ELSE 'UNKNOWN'
        END AS customer_type,

        COALESCE(
            NULLIF(TRIM(s.name), ''),
            NULLIF(
                TRIM(
                    concat_ws(
                        ' ',
                        NULLIF(TRIM(p.title), ''),
                        NULLIF(TRIM(p.first_name), ''),
                        NULLIF(TRIM(p.middle_name), ''),
                        NULLIF(TRIM(p.last_name), ''),
                        NULLIF(TRIM(p.suffix), '')
                    )
                ),
                ''
            ),
            NULLIF(TRIM(c.account_number), '')
        ) AS customer_name,

        p.person_type,

        CASE CAST(p.name_style AS text)
            WHEN '1' THEN true
            WHEN '0' THEN false
            ELSE NULL
        END AS name_style,

        NULLIF(TRIM(p.title), '')
            AS title,

        NULLIF(TRIM(p.first_name), '')
            AS first_name,

        NULLIF(TRIM(p.middle_name), '')
            AS middle_name,

        NULLIF(TRIM(p.last_name), '')
            AS last_name,

        NULLIF(TRIM(p.suffix), '')
            AS suffix,

        CAST(
            NULLIF(CAST(p.email_promotion AS text), '')
            AS smallint
        ) AS email_promotion,

        email.email_address,
        phone.phone_number,
        phone.phone_number_type,

        address.address_type,
        address.address_line1,
        address.address_line2,
        address.city,
        address.state_province_code,
        address.state_province_name,
        address.postal_code,
        address.country_region_code,
        address.country_region_name,

        CAST(
            NULLIF(CAST(c.territory_id AS text), '')
            AS integer
        ) AS territory_id,

        territory.name
            AS territory_name,

        territory."group"
            AS territory_group,

        territory.country_region_code
            AS territory_country_region_code,

        CAST(
            REPLACE(person_demographics.date_first_purchase_raw, 'Z', '')
            AS date
        ) AS demog__date_first_purchase,

        CAST(
            REPLACE(person_demographics.birth_date_raw, 'Z', '')
            AS date
        ) AS demog__birth_date,

        NULLIF(
            TRIM(person_demographics.marital_status),
            ''
        ) AS demog__marital_status,

        NULLIF(
            TRIM(person_demographics.yearly_income),
            ''
        ) AS demog__yearly_income,

        NULLIF(
            TRIM(person_demographics.gender),
            ''
        ) AS demog__gender,

        person_demographics.total_children
            AS demog__total_children,

        person_demographics.number_children_at_home
            AS demog__number_children_at_home,

        NULLIF(
            TRIM(person_demographics.education),
            ''
        ) AS demog__education,

        NULLIF(
            TRIM(person_demographics.occupation),
            ''
        ) AS demog__occupation,

        CASE person_demographics.home_owner_flag_raw
            WHEN '1' THEN true
            WHEN '0' THEN false
            ELSE NULL
        END AS demog__home_owner_flag,

        person_demographics.number_cars_owned
            AS demog__number_cars_owned,

        NULLIF(
            TRIM(person_demographics.commute_distance),
            ''
        ) AS demog__commute_distance,

        NULLIF(
            TRIM(store_demographics.contact_name),
            ''
        ) AS store_demog__contact_name,

        NULLIF(
            TRIM(store_demographics.job_title),
            ''
        ) AS store_demog__job_title,

        NULLIF(
            TRIM(store_demographics.business_type),
            ''
        ) AS store_demog__business_type,

        store_demographics.year_opened
            AS store_demog__year_opened,

        NULLIF(
            TRIM(store_demographics.specialty),
            ''
        ) AS store_demog__specialty,

        store_demographics.square_feet
            AS store_demog__square_feet,

        NULLIF(
            TRIM(store_demographics.brands),
            ''
        ) AS store_demog__brands,

        NULLIF(
            TRIM(store_demographics.internet),
            ''
        ) AS store_demog__internet,

        store_demographics.number_employees
            AS store_demog__number_employees,

        CAST(
            NULLIF(CAST(s.sales_person_id AS text), '')
            AS integer
        ) AS assigned_sales_person_id,

        GREATEST(
            CAST(
                NULLIF(CAST(c.modified_date AS text), '')
                AS timestamp
            ),
            CAST(
                NULLIF(CAST(p.modified_date AS text), '')
                AS timestamp
            ),
            CAST(
                NULLIF(CAST(s.modified_date AS text), '')
                AS timestamp
            ),
            CAST(
                NULLIF(CAST(territory.modified_date AS text), '')
                AS timestamp
            ),
            email.source_modified_at,
            phone.source_modified_at,
            address.source_modified_at
        ) AS source_modified_at

    FROM sales.customer AS c
    LEFT JOIN person.person AS p ON c.person_id = p.business_entity_id
    LEFT JOIN sales.store AS s ON c.store_id = s.business_entity_id
    LEFT JOIN sales.sales_territory AS territory ON c.territory_id = territory.territory_id

    LEFT JOIN LATERAL (
        SELECT
            NULLIF(TRIM(e.email_address), '')
                AS email_address,

            CAST(
                NULLIF(CAST(e.modified_date AS text), '')
                AS timestamp
            ) AS source_modified_at

        FROM person.email_address AS e

        WHERE e.business_entity_id = c.person_id

        ORDER BY
            CAST(
                NULLIF(CAST(e.modified_date AS text), '')
                AS timestamp
            ) DESC NULLS LAST,
            CAST(e.email_address_id AS integer) DESC

        LIMIT 1
    ) AS email ON true

    LEFT JOIN LATERAL (
        SELECT
            NULLIF(TRIM(pp.phone_number), '')
                AS phone_number,

            NULLIF(TRIM(pnt.name), '')
                AS phone_number_type,

            CAST(
                NULLIF(CAST(pp.modified_date AS text), '')
                AS timestamp
            ) AS source_modified_at

        FROM person.person_phone AS pp

        LEFT JOIN person.phone_number_type AS pnt
            ON pp.phone_number_type_id =
               pnt.phone_number_type_id

        WHERE pp.business_entity_id = c.person_id

        ORDER BY
            CASE LOWER(pnt.name)
                WHEN 'cell' THEN 1
                WHEN 'home' THEN 2
                WHEN 'work' THEN 3
                ELSE 4
            END,
            CAST(
                NULLIF(CAST(pp.modified_date AS text), '')
                AS timestamp
            ) DESC NULLS LAST,
            pp.phone_number

        LIMIT 1
    ) AS phone ON true

    LEFT JOIN LATERAL (
        SELECT
            NULLIF(TRIM(at.name), '')
                AS address_type,

            NULLIF(TRIM(a.address_line1), '')
                AS address_line1,

            NULLIF(TRIM(a.address_line2), '')
                AS address_line2,

            NULLIF(TRIM(a.city), '')
                AS city,

            NULLIF(TRIM(sp.state_province_code), '')
                AS state_province_code,

            NULLIF(TRIM(sp.name), '')
                AS state_province_name,

            NULLIF(TRIM(a.postal_code), '')
                AS postal_code,

            NULLIF(TRIM(cr.country_region_code), '')
                AS country_region_code,

            NULLIF(TRIM(cr.name), '')
                AS country_region_name,

            GREATEST(
                CAST(
                    NULLIF(CAST(bea.modified_date AS text), '')
                    AS timestamp
                ),
                CAST(
                    NULLIF(CAST(a.modified_date AS text), '')
                    AS timestamp
                ),
                CAST(
                    NULLIF(CAST(sp.modified_date AS text), '')
                    AS timestamp
                ),
                CAST(
                    NULLIF(CAST(cr.modified_date AS text), '')
                    AS timestamp
                )
            ) AS source_modified_at

        FROM person.business_entity_address AS bea

        INNER JOIN person.address AS a
            ON bea.address_id = a.address_id

        LEFT JOIN person.address_type AS at
            ON bea.address_type_id = at.address_type_id

        LEFT JOIN person.state_province AS sp
            ON a.state_province_id = sp.state_province_id

        LEFT JOIN person.country_region AS cr
            ON sp.country_region_code =
               cr.country_region_code

        WHERE bea.business_entity_id = COALESCE(c.store_id, c.person_id)

        ORDER BY
            CASE LOWER(at.name)
                WHEN 'home' THEN 1
                WHEN 'primary' THEN 2
                WHEN 'main office' THEN 3
                WHEN 'shipping' THEN 4
                WHEN 'billing' THEN 5
                ELSE 6
            END,
            CAST(
                NULLIF(CAST(bea.modified_date AS text), '')
                AS timestamp
            ) DESC NULLS LAST,
            CAST(bea.address_id AS integer) DESC

        LIMIT 1
    ) AS address ON true

    LEFT JOIN LATERAL XMLTABLE(
        XMLNAMESPACES(
            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey'
            AS aw
        ),

        '/aw:IndividualSurvey'

        PASSING CAST(p.demographics AS xml)

        COLUMNS
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
                PATH 'aw:CommuteDistance'
    ) AS person_demographics ON true

    LEFT JOIN LATERAL XMLTABLE(
        XMLNAMESPACES(
            'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey'
            AS aw
        ),

        '/aw:StoreSurvey'

        PASSING CAST(s.demographics AS xml)

        COLUMNS
            contact_name text
                PATH 'aw:ContactName',

            job_title text
                PATH 'aw:JobTitle',

            business_type text
                PATH 'aw:BusinessType',

            year_opened integer
                PATH 'aw:YearOpened',

            specialty text
                PATH 'aw:Specialty',

            square_feet double precision
                PATH 'aw:SquareFeet',

            brands text
                PATH 'aw:Brands',

            internet text
                PATH 'aw:Internet',

            number_employees integer
                PATH 'aw:NumberEmployees'
    ) AS store_demographics ON true
)


SELECT
    source.*,

    md5(
        CAST(
            jsonb_build_array(
                source.account_number,
                source.person_id,
                source.store_id,
                source.customer_type,
                source.customer_name,

                source.person_type,
                source.name_style,
                source.title,
                source.first_name,
                source.middle_name,
                source.last_name,
                source.suffix,
                source.email_promotion,

                source.email_address,
                source.phone_number,
                source.phone_number_type,

                source.address_type,
                source.address_line1,
                source.address_line2,
                source.city,
                source.state_province_code,
                source.state_province_name,
                source.postal_code,
                source.country_region_code,
                source.country_region_name,

                source.territory_id,
                source.territory_name,
                source.territory_group,
                source.territory_country_region_code,

                source.demog__date_first_purchase,
                source.demog__birth_date,
                source.demog__marital_status,
                source.demog__yearly_income,
                source.demog__gender,
                source.demog__total_children,
                source.demog__number_children_at_home,
                source.demog__education,
                source.demog__occupation,
                source.demog__home_owner_flag,
                source.demog__number_cars_owned,
                source.demog__commute_distance,

                source.store_demog__contact_name,
                source.store_demog__job_title,
                source.store_demog__business_type,
                source.store_demog__year_opened,
                source.store_demog__specialty,
                source.store_demog__square_feet,
                source.store_demog__brands,
                source.store_demog__internet,
                source.store_demog__number_employees,

                source.assigned_sales_person_id
            )
            AS text
        )
    ) AS attribute_hash

FROM customer_source AS source;
