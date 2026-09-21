# Take-Home Case Study: Building a RAG and AI Agent with ShopEase Philippines Data

## Analytics Solutions Bootcamp — Artificial Intelligence Essentials

## Background

ShopEase Philippines is a fictional omnichannel retail company that manages customer orders, products, stores, inventory, support tickets, promotions, and company policies.

The company has information stored across different file formats and data sources. Employees often need to combine information from several of these sources to answer customer questions.

For example, a customer may ask:

> "My order arrived damaged. Can I still return it, and is a replacement available?"

Answering this question may require information from:

- the customer's order,
- the product catalog,
- the return and refund policy,
- current store inventory, and
- possibly an existing support ticket.

Your task is to build a simple **Retrieval-Augmented Generation (RAG)** application and a simple **AI Agent** using the provided ShopEase dataset.

This is **not intended to be a production-grade AI engineering project**. The objective is to experience how RAG and Agents work and understand the difference between retrieving knowledge and allowing an AI system to choose and use tools.

---

# Objectives

By completing this case study, you should be able to:

1. Load information from different file formats.
2. Extract text from documents that can be used for retrieval.
3. Split documents into smaller chunks.
4. Generate embeddings for document chunks.
5. Retrieve relevant information using vector similarity.
6. Provide retrieved information to a language model as context.
7. Build a simple RAG question-answering workflow.
8. Create simple Python functions that an AI Agent can use as tools.
9. Allow an Agent to decide which tools are needed for a question.
10. Combine structured-data tools and RAG retrieval in one workflow.
11. Explain the difference between RAG and an AI Agent.
12. Consider basic safety controls when Agents are allowed to perform actions.

The emphasis is on **understanding the architecture and experiencing the workflow**, not building the most sophisticated RAG or Agent framework.

---

# Dataset

Use the provided **ShopEase Philippines RAG + Agent Dataset**.

The package contains:

| File | Format | Contents |
|---|---|---|
| `company_handbook.pdf` | PDF | Employee and company policies |
| `return_refund_policy.docx` | DOCX | Return, refund, exchange, and warranty rules |
| `product_catalog.csv` | CSV | Product master data |
| `orders.xlsx` | Excel | Customer order transactions |
| `customers.json` | JSON | Customer profiles |
| `shipping_policy.md` | Markdown | Shipping rules and fees |
| `support_tickets.json` | JSON | Customer support cases |
| `promotions.txt` | Text | Current promotions |
| `stores.csv` | CSV | Store information |
| `store_inventory.csv` | CSV | Store-level product inventory |
| `faq.html` | HTML | Frequently asked questions |
| `README.md` | Markdown | Dataset relationships and reference information |

The files are connected through identifiers such as:

```text
customer_id
order_id
sku
store_id
```

For example:

```text
customers.json
     │
     │ customer_id
     ↓
orders.xlsx
     │
     ├──────── sku ──────────→ product_catalog.csv
     │
     └── fulfillment_store ─→ stores.csv
                                  │
                                  ↓
                           store_inventory.csv

support_tickets.json
     │
     ├── customer_id
     └── order_id
```

---

# Part 1 — Build a Simple RAG Application

## 1. Select the Knowledge Documents

Start by identifying the files that contain **knowledge or policy information** that would be useful for answering questions.

Examples include:

```text
company_handbook.pdf
return_refund_policy.docx
shipping_policy.md
promotions.txt
faq.html
```

You do not need to place every structured transaction file into your RAG knowledge base.

Think about the difference between:

```text
Knowledge documents
        ↓
Good candidates for RAG

vs.

Transactional / structured data
        ↓
Often better accessed using tools or queries
```

---

## 2. Extract Text from the Documents

Write Python code that reads the selected files and converts their contents into text.

You may use appropriate Python libraries depending on the file format.

Your resulting data may conceptually look like:

```python
documents = [
    {
        "source": "return_refund_policy.docx",
        "text": "Most eligible products may be returned..."
    },
    {
        "source": "shipping_policy.md",
        "text": "Standard shipping costs PHP 99..."
    }
]
```

Preserve the **source filename** so that you know where retrieved information came from.

---

# 3. Split Documents into Chunks

Large documents should be divided into smaller pieces before generating embeddings.

Create a simple chunking strategy.

For example:

```text
Document
   ↓
Chunk 1
Chunk 2
Chunk 3
Chunk 4
```

You may use:

- fixed character lengths,
- fixed word lengths,
- paragraphs,
- document sections, or
- another reasonable approach.

Keep your implementation simple.

Record metadata such as:

```python
{
    "source": "return_refund_policy.docx",
    "chunk_id": 3,
    "text": "Items that arrive damaged..."
}
```

Briefly explain why retrieving smaller chunks may be more useful than retrieving an entire document.

---

# 4. Generate Embeddings

Use an embedding model to convert each chunk into a numerical vector.

If you are using Ollama, you may use an embedding model such as:

```text
nomic-embed-text
```

Conceptually:

```text
"Items that arrive damaged..."
              ↓
        Embedding Model
              ↓
[0.12, -0.37, 0.51, ..., 0.08]
```

Store the embeddings together with:

- chunk text,
- source,
- chunk identifier.

For this exercise, you may store the vectors using:

- NumPy / Python lists, or
- a vector database of your choice.

A vector database is **not required**.

---

# 5. Build the Retrieval Step

Create a function that accepts a user question.

For example:

```text
"What should I do if my order arrives damaged?"
```

Your program should:

```text
Question
   ↓
Generate Question Embedding
   ↓
Compare Against Chunk Embeddings
   ↓
Calculate Similarity
   ↓
Retrieve Top Matching Chunks
```

Retrieve several relevant chunks, such as the **Top 3**.

Display:

- similarity score,
- source document,
- retrieved text.

This step is important because you should be able to observe what the retrieval system found **before the language model generates an answer**.

---

# 6. Build the Augmented Prompt

Pass the retrieved chunks to your language model as context.

Your prompt should clearly instruct the model to answer using the provided information.

For example:

```text
Use only the following context to answer the question.

If the answer cannot be determined from the provided context,
say that the information is not available in the provided documents.

CONTEXT:

[Retrieved Chunk 1]

[Retrieved Chunk 2]

[Retrieved Chunk 3]

QUESTION:

{user_question}
```

Then send the prompt to your language model.

If you are using Ollama, you may use any suitable locally available instruction/chat model.

---

# 7. Test Your RAG Application

Test at least **five questions**.

Your tests should include:

### Questions that should be answerable

Examples:

```text
How many days does a customer have for a standard return?

What should a customer provide when reporting a damaged item?

Do Gold members receive free shipping?

How long do approved refunds normally take?

What does the company say about AI systems issuing refunds?
```

### At least one question whose answer is not available

Ask something that the documents do not contain.

Your RAG system should avoid inventing an answer.

For each question, show:

```text
Question
↓
Retrieved Sources / Chunks
↓
Generated Answer
```

---

# Part 2 — Build Simple Agent Tools

Your RAG system is useful for retrieving information from documents.

However, some questions require **structured data lookups**.

For example:

> "What product did CUST-001 order?"

The answer is better retrieved from structured data than from a policy document.

Create simple Python functions that expose the structured datasets as tools.

---

# 8. Create Basic Tools

Build at least **four tools**.

Suggested tools include:

```python
get_customer(customer_id)

get_order(order_id)

get_product(sku)

get_store(store_id)

check_inventory(sku)

get_support_tickets(customer_id=None, order_id=None)
```

You may implement these using Pandas, Python dictionaries, or another simple approach.

For example:

```python
def get_product(sku):
    result = products[
        products["sku"] == sku
    ]

    return result
```

Test each function independently before connecting it to an Agent.

---

# 9. Turn Your RAG Application into a Tool

Your RAG workflow can also become a tool.

For example:

```python
search_policy(question)
```

Conceptually:

```text
search_policy()
       ↓
Question Embedding
       ↓
Vector Retrieval
       ↓
Relevant Policy Chunks
       ↓
Return Context
```

Your Agent can now access both:

```text
Structured Data Tools
        +
RAG / Knowledge Search
```

---

# Part 3 — Build a Simple AI Agent

## 10. Give the Agent Access to Your Tools

Create an Agent that can choose which available tool or tools should be used to answer a user's question.

Your architecture should conceptually look like:

```text
                    USER
                      │
                      ↓
                 AI AGENT
                      │
           "What do I need?"
                      │
       ┌──────────────┼───────────────┐
       ↓              ↓               ↓
 get_order()     get_product()   search_policy()
       │              │               │
       └──────────────┼───────────────┘
                      ↓
                 Tool Results
                      ↓
                    Agent
                      ↓
                 Final Answer
```

You may implement the Agent using:

- Ollama tool/function calling,
- a simple custom routing approach,
- an Agent framework of your choice.

The important requirement is that the Agent should be able to **select tools based on the question**.

---

# 11. Test Single-Tool Questions

Start with simple questions that require only one tool.

Examples:

```text
What product is SKU-0042?

What is the status of ORD-1025?

Who is CUST-001?

Which stores currently have SKU-0042 in stock?
```

Observe which tool the Agent selects.

---

# 12. Test Multi-Tool Questions

Next, ask questions requiring information from multiple sources.

For example:

> **"What product did CUST-001 purchase in ORD-1025?"**

The Agent may need:

```text
get_order("ORD-1025")
        ↓
SKU-0042
        ↓
get_product("SKU-0042")
        ↓
Product information
```

Try at least **three multi-tool questions**.

---

# 13. Combine Agent + RAG

Now test a question requiring both structured information and policy knowledge.

Use the prepared ShopEase scenario:

```text
Customer: CUST-001
Order:    ORD-1025
Product:  SKU-0042
Ticket:   TKT-5001
```

Ask:

> **"CUST-001 says the item from ORD-1025 arrived damaged. Based on the order and company policy, what should Customer Support tell the customer?"**

Your Agent may need to:

```text
get_order()
      ↓
get_product()
      ↓
get_support_tickets()
      ↓
search_policy()
      ↓
Combine Results
      ↓
Generate Answer
```

This is the key part of the exercise.

Observe how the Agent combines **structured data retrieval** with **RAG-based knowledge retrieval**.

---

# 14. Try Additional Agent Questions

Test questions such as:

### Inventory

```text
Which stores currently have SKU-0042 available?
```

### Shipping

```text
Does this customer's order qualify for free shipping?
```

The Agent may need to combine:

```text
Customer membership
       +
Order amount
       +
Shipping policy
```

### Warranty

```text
Is this customer's product potentially still under warranty?
```

The Agent may need:

```text
Order delivery date
       +
Product warranty period
```

### Customer Support

```text
Find the customer's latest support ticket and summarize what information
the support representative should review before responding.
```

---

# Part 4 — Agent Safety

Agents become more powerful when they are allowed to perform actions.

Consider the difference between:

```text
READ

get_order()
get_product()
check_inventory()
search_policy()
```

and:

```text
WRITE / ACTION

cancel_order()
issue_refund()
update_customer()
change_inventory()
```

For this exercise, you are **not required to implement real write actions**.

If you choose to create functions such as:

```python
cancel_order(order_id)
issue_refund(order_id)
```

they should be **simulated only**.

For example:

```python
def issue_refund(order_id):
    return {
        "status": "SIMULATION ONLY",
        "message": "Refund would require human approval."
    }
```

Do not modify the provided dataset.

---

# 15. Explain Your Safety Controls

Briefly explain what controls you would add if the Agent were connected to a real e-commerce system.

Consider:

- user authorization,
- tool permissions,
- confirmation before important actions,
- transaction limits,
- audit logs,
- protection of customer information,
- validation of tool inputs,
- human approval,
- monitoring Agent behavior.

You do not need to implement these controls.

---

# Required Submission

Submit a **Jupyter Notebook (`.ipynb`)** containing the following:

## RAG

1. Load selected knowledge documents.
2. Extract document text.
3. Split documents into chunks.
4. Generate embeddings.
5. Store chunk embeddings.
6. Embed user questions.
7. Calculate similarity.
8. Retrieve relevant chunks.
9. Generate answers using retrieved context.
10. Test at least five RAG questions.

## Agent

11. Load the structured ShopEase datasets.
12. Create at least four Agent tools.
13. Test the tools independently.
14. Make the RAG workflow available as a knowledge-search tool.
15. Build a simple Agent.
16. Test single-tool questions.
17. Test at least three multi-tool questions.
18. Demonstrate at least one question requiring **Agent + RAG**.
19. Briefly discuss Agent safety.

Use Markdown cells throughout the notebook to explain what you built and what you observed.

---

# Short Reflection

At the end of your notebook, answer the following questions:

1. What is the role of embeddings in your RAG application?
2. Why did you split documents into chunks?
3. How does the system determine which chunks are relevant to a question?
4. What is the difference between RAG and an Agent?
5. Why might structured data be better accessed through a tool instead of embedding every row?
6. How can an Agent use RAG?
7. What risks appear when an Agent is allowed to perform actions?
8. What was the most interesting thing you learned while building the application?

Keep your answers concise.

---

# Important Reminder

The objective is **not** to build a production-grade RAG platform or autonomous Agent.

Focus on understanding the flow.

## RAG

```text
Documents
    ↓
Extract Text
    ↓
Chunk
    ↓
Embed
    ↓
Store
    ↓
Question
    ↓
Retrieve Relevant Chunks
    ↓
Add Context to Prompt
    ↓
LLM
    ↓
Answer
```

## Agent

```text
User Request
     ↓
Agent
     ↓
Decide What Information Is Needed
     ↓
Select Tool(s)
     ↓
Use Structured Data and/or RAG
     ↓
Combine Results
     ↓
Answer
```

The key idea is:

> **RAG helps the model retrieve relevant knowledge. An Agent can decide what actions or tools are needed, and RAG itself can be one of those tools.**

Experiment, observe what happens, and focus on understanding how the components work together.
