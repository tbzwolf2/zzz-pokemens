# ZZZ-Pokemens tech test

## Installing, setting up and updating the app

1. Install ruby 3.2.2 https://www.ruby-lang.org/en/downloads/
2. Install postgres https://www.postgresql.org/download/
3. Clone project from git with `git clone`
4. Run `gem add bundler`
5. Run `gem add rails` 
6. CD to root of project and run `bundle`
7. Configure the app to connect to your postgres database via `config/database.yml`
8. Create your database by running `rails db:create` and then `rails db:migrate`
9. Start the server with `rails s` 
10. Navigate in browser to `localhost:3000/setup` and view the message "Process started", the database will now fill via a asyncronous action, feel free to navigate away from this page
11. The database will take around 1 minute to setup, make a cup of tea
12. Navigate to the two available  endpoints of `/api/v1/pokemon/` and `/api/v1/pokemon/:(id OR name)`
13. Sip tea as you enjoy the many pokemen that are available to you

## Swagger docs go here

Unforunately the gem I chose to create the swagger docs seems to be broken, and the alternative gem requires a re-write of all my tests, which I have no time to do now :(