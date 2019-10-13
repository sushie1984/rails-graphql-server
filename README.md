# Description

This is demo project which implements a `graphql` in a rails server environment. It implements the 2 following types and its scalar fields:

* `Deparment`: *id*, *name*, *location*

* `Employee`: *id*, *name*, *age*, *yearlySalary*, *workStart*

Both types have `has_many` association to each which allows to query also for their respective nested type association (*employees* and *departments*).

# Prerequisites

* Installed `ruby-2.6.0`

* `Sqlite` & `Postgres` dev-libraries (Stackoverflow is your friend if `bundle` fails)

# Installation

* Clone this github repo

* Run `bundle`

* Duplicate `env.template` for your desired environments (**suggestions:** `env.development` and `env.test`)

* In your terminal run `rails db:setup` and expect `db/<YOUR-ENVIRONMENT>.sqlite3` files (**suggestions:** `db/development.sqlite3` & `db/test.sqlite3`)

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
