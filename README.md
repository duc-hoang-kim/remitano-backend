## What's done:
- APIs for the Frontend client
- Support multiple form of youtube video urls: sharing urls, youtube short urls, ...
- Service object to fetch video information
- `Dockerfile`, `docker-compose.yml` for deployment, it's deployed [here](http://3.26.19.253/) on AWS EC2 
- Integration testing, I put the guide to run integration test below
- Unit test
Note: I overwrote devise controllers to better follow the project api convention, everything are retained except API's response schema. It would be nice if we have unit tests for Devise overwritten files. But the timeframe is really tight and so let skip it for now, it should be all good 

## For Unit Test + Integration test:
In case you haven't setup db for test database yet
```
RAILS_ENV=test bundle exec rails db:create
RAILS_ENV=test bundle exec rails db:migrate
```
1. `yarn start:test` (run at remitano-frontend project dir)
2. `RAILS_ENV=test bundle exec rails server`
3. `bundle exec rspec`
