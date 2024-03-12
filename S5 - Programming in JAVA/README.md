# Programming in JAVA

**University:** South East European University, Tetovo - North Macedonia <br>
**Course:** Programming in JAVA <br>
**Semester:** 5th semester <br>
**Mentor:** Prof. Nuhi Besimi <br>
**Student:** Ron Ismaili, Fehmi Havziu <br>

# QueryHelper 🤖🔧

A tool to simplify data analysis by generating SQL queries from natural language input, tailored for a basic library
system database. <br>

_[How to setup QueryHelper](#setup)_

## Functionality

### What is QueryHelper

QueryHelper is the final project to our **programming in JAVA** course at university. It is a Spring Boot application
with only one endpoint, **query**, which takes the user's request given
in plain English and then converts it into SQL. <br>

The primary purpose of this project is to research how capable ChatGPT is in generating appropriate SQL queries
when given a user's prompt in plain english accompanied by the schema of the database.<br>

You can read about our findings _[here](#findings)_.

### How does QueryHelper work

The following is a list of steps we take to create the appropriate response:

1. Receive a request with the user query in natural language.
2. Generate the prompt that we will send to OpenAI's API.
3. Send a request with our generated prompt to OpenAI's API through the langchain library.
4. Receive a response from OpenAI's API with the SQL query.
5. Parse the response and retrieve the query.
6. Run the query against the database.
7. Create a response with the query and retrieved records.
8. Send response back to user.

At every step we have measures to check that we do not proceed unless we have received expected results.

## API

### Usage

As mentioned earlier, our API has only one endpoint with the following route `/query`, it expects a **POST** request
with
the following **JSON body**:

```
{
    "query": "Your query in plain english"
}
```

### Example

**Request body**

```
{
    "query": "Give me the names of the 3 students who have borrowed the most Science fiction books and how many books they have borrowed."
}
```

**Other Possible Queries**

Explore various inquiries you can make using QueryHelper to extract insightful information from the library database(provided in our repository), or any database of your own:

    Find the total number of books borrowed by each student.
    List all the books borrowed by a specific student.
    Retrieve the names of students who have borrowed more than five books.
    Show the number of books borrowed in each genre.
    Find the most borrowed book title.
    List the students who have not borrowed any books.
    Show the books borrowed by a student in a specific genre, like Mystery or Romance.
    Retrieve the names of students who have borrowed books authored by a specific author.
    List all the books borrowed by students from a particular department in the library.
    Find the total number of books borrowed by students in each academic year group.

**Response body**

```
{
    "data": {
        "schema": "basic_library",
        "responseTime": 4.113,
        "query": "SELECT s.name, COUNT(*) AS num_books_borrowed FROM students s JOIN borrows b ON s.studentId = b.studentId JOIN books bk ON b.bookId = bk.bookId JOIN types t ON bk.typeId = t.typeId WHERE t.name = 'Science fiction' GROUP BY s.name ORDER BY num_books_borrowed DESC LIMIT 3;",
        "records": [
            {
                "name": "Hadleigh",
                "num_books_borrowed": 2
            },
            {
                "name": "Annie",
                "num_books_borrowed": 1
            },
            {
                "name": "Akehurst",
                "num_books_borrowed": 1
            }
        ]
    },
    "message": "Query and records were retrieved successfully!",
    "statusCode": 200
}
```

## Findings

After having tested our endpoint extensively we have found that when chatGPT 3.5 is given a DDL with a simple database
schema it works almost flawlessly. It is capable of generating advanced queries with multiple joins, aggregate
functions, nested queries and complex where clauses. When given a very specific query in plain English it is able to
generate the
appropriate response in less than 5 seconds.

## Limitations

During our experiments we have also encountered some limitations:

- When working with larger databases the accuracy of the queries remained high and the response time constant, but if
  the schema of the database utilized a more complex structure, involving triggers, procedures, constraints and the
  sorts, the generated queries became less reliable.
- The DDL of the schema cannot be too long since there is a 16k token limit when communicating with OpenAI's service.
  This token limit is calculated by combining the prompt and the generated output, if they exceed the context length,
  the request will fail.
- In databases featuring tables with specified data types, such as our basic_library schema, the model operates without
  knowledge of the table content, as it only receives DDL without accompanying DML. We hit some challenges when
  requesting horror books; although ChatGPT generated a correct query, it overlooked specifying 'horror' with an
  uppercase 'H' instead of lowercase, returning an empty set for the records.

## Technical specification

For creating our project we have used the following technologies:

- JAVA v17
    - Spring Boot v3.2.1
    - Langchain v0.25.0
    - Gson v2.10.1
- PostgreSQL v16.1
- Postman

## Setup

Project requirements:

- JAVA v17
- OpenAI API key
- Postgresql database

After cloning the repository you need to take the following steps:

**Setting up your postgresql database** <br>
The default schema the project uses is called `basic_library`, so if you want to test the default functionality, you
need to
create a new schema with the same name.
After creating the schema make sure to execute the DDL and then the DML scripts found in `src/main/resources/static`.

**Setting up your OpenAI API key** <br>
You can generate your own OpenAI API key [here](https://platform.openai.com/api-keys), or alternatively you can try to
use `demo`.

**Setting up your environment variables** <br>
You have to set the following variables: `db_url`, `db_username`, `db_password` and `openai_api_key`. <br>
In case you are using a different schema and DDL for your database, make sure to also change `databaseSchema`
and `databaseDDL`.

Feel free to experiment with your own DDL and DML by changing the configuration of the project. If you find any issues
please report them to the authors!