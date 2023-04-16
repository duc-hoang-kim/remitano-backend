## What's done:
- APIs for the Frontend client
- Support multiple form of youtube video urls: sharing urls, youtube short urls, ...
- Service object to fetch video information
- `Dockerfile`, `docker-compose.yml` for deployment, it's deployed [here](http://3.26.19.253/) on AWS EC2 
- Integration testing, I put the guide to run integration test below
- Unit test

## For Unit Test + Integration test:
In case you haven't setup db for test database yet
```
RAILS_ENV=test bundle exec rails db:create
RAILS_ENV=test bundle exec rails db:migrate
```
1. `yarn start:test` (run at remitano-frontend project dir)
2. `RAILS_ENV=test bundle exec rails server`
3. `bundle exec rspec`
