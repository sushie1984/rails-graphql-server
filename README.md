# Description

This is demo project which implements a `graphql` in a rails server environment. It implements the 2 following types and its scalar fields:

* `Deparment`: *id*, *name*, *location*

* `Employee`: *id*, *name*, *age*, *yearlySalary*, *workStart*

Both types have `has_many` association to each which allows to query also for their respective nested type association (*employees* and *departments*).

# Prerequisites

* Installed `ruby-2.6.0`

* A running postgresql

* `Postgres` dev-libraries (Stackoverflow is your friend if `bundle` fails)

# Installation

* Clone this github repo

* Run `gem install bundler` and `bundle`

* Duplicate `env.template` for your desired environments (**example:** `env.development`)

* Set at least values for `RACK_ENV` and `SQL_DATABASE` (**example**: `development` and `rails_graphql_server_dev`)

* Export variables from `.env` file (**example**: `export $(cat env.development | xargs)`)

* In your terminal run `rails db:setup`

* Start rails server with `rails s`

* Now you can perform your `graphql` query against it via a **POST** to http://localhost:3000/graphql/

# Examples

POST the following as **value** of a key `query` of a JSON with your favorite query tool (e.g. `postman` or `curl`)

* Get all departments and select only *id* & *name*:

```
query { departments { id name } }
```

* Get all departments as before but also select each *employee* of each department with *yearlySalary*:

```
query { departments { id name employees { yearlySalary } } }
```

* Get only departments with id 1 and 2 and include the *employees* with their *names*:

```
query { departments(id: ["1", "2"]) { name employees { name } } }
```
