# sqlcmdline
Drop in replacement for [sqlcmd](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility) that works better with sql-mode in Emacs.

## Table of contents
   * [Usage](#usage)
   * [Commands](#commands)
   * [Building](#building)
   * [Contributors](#contributors)


## Usage
Depending on if using the source or a release, run either `python sqlcmdline.py` or `sqlcmdline.exe` with a combination of parameters.
    * `-S <server>` - server name. Port can additionally be passed using the format `<server name, port>`. Optionally you can specify a DNS when `--driver DNS` is used.
    * `-d <database>` - database to open
    * `-E` - use integrated security
    * `-U <user>` - SQL login username
    * `-P <password>` - SQL login password

Use `--help` for *slightly* more detail.

### Sending Commands
`GO` can be used to send commands to the server. You can also use `;;` as a shorthand at the end of a line instead:

```
ServerName@DatabaseName
> SELECT * FROM SomeTable
> GO

-- results here--

> SELECT * FROM SomeTable;;

-- results here--

```

### Parameters
Using a `?` in a query will prompt for parameters. This is not as useful inline, although escaping is handy, but great for custom commands (more on this
later):

```
ServerName@DatabaseName
> SELECT * FROM SomeTable WHERE username = ? AND tool = ?;;

parameter 1>sebasmonia
parameter 2>git


-- results here--
```


## Commands

Anything that starts with `:` is interpreted as a command. The `:help` command will print the following text:

```
--Available commands--
Syntax: :command required_parameter [optional_parameter].

Common command modifiers are:
	-eq: makes the search text  parameter an exact match, by default all parameters use LIKE comparisons
	-full: in some commands, will return * from INFORMATION_SCHEMA instead of a smaller subset of columns

:help -- prints the command list
:truncate [chars] -- truncates the results to columns of maximum "chars" length. Default = 100. Setting to 0 shows full contents.
:rows [rownum] -- prints only "rownum" out of the whole resultset. Default = 100. Setting to 0 prints all the rows.
:tables [table_name] -- List all tables, or tables "like table_name"
:cols [-eq] table_name [-full] -- List columns for the table "like table_name" (optionally, equal table_name).
:views [view_name] [-full] -- List all views, or views "like view_name"
:procs [proc_name] [-full] -- List all procedures, or procs "like proc_name"
:funcs [func_name] [-full] -- List all functions, or functions "like func_name"
:src obj.name -- Will call "sp_helptext obj.name". Results won't be truncated.
:deps [to|from] obj.name -- Show dependencies to/from obj.name.
:file [-enc] path -- Opens a file and runs the script. No checking/parsing of the file will take place. Use -enc to change the encoding
 used to read the file. Examples: -utf8, -cp1250, -latin_1
:dbs database_name -- List all databases, or databases "like database_name".
:use database_name -- changes the connection to "database_name".
:timeout [seconds] -- sets the command timeout. Default: 30 seconds.
```

Notes:
  * `:use` starts a new ODBC connection to `database_name` in the current server.
  * `:tables`, `:cols`, `:views`, `:procs` and `:funcs` use INFORMATION_SCHEMA so they should work across many engines
  * `:dbs` currently supports MySQL, MSSQL and Postgres.
  * `:deps` and `:src` are MSSQL-only
  * Be careful when using `:file`, as the notes above say, the contents will be sent to the server without any validation.

### Custom commands

The file `commands.ini` can be used to define custome commands, which you also invoke via the prefix `:`.

You can use Python's `format` syntax to replace placeholders in the query text by something else, which is really flexible
as it allows changing the table name or list of fields on each invocation.

After the `format` replacements are done, the query is processed "as usual" so you get prompted for `?` placeholders, if any.  

There are samples for different types of commands (with format parameters only, both combined, etc.) in the repository.

## Building 
If you want to build the executable yourself, a [pyinstaller](https://pyinstaller.org/) `.spec` file has been included. This can be run manually or using the makefile.


## Contributors 

Sebastián Monía - https://github.com/sebasmonia

Hodge - https://github.com/sukeyisme

Kevin Brubeck Unhammer - https://github.com/unhammer
