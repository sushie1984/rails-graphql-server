# Grapqhl query examples

POST the following as **value** of a key `query` of a JSON with your favorite query tool (e.g. `postman` or `curl`) to `api/graphql`

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
