<img width="200" alt="hivemind-bee-logo" src="https://user-images.githubusercontent.com/26797256/132417870-44ffe1a0-cd00-48f6-9648-ab002a75c922.png">

# HiveMind Backend

HiveMind is where beekeepers go to get advice, ask questions to the experts, and meet our community of "bee-lievers." The HiveMind backend is a GraphQL API built in Ruby and Ruby on Rails and leverages ActiveStorage for image uploading along with an integration to Google Cloud Storage. 


[Check out the deployed app](https://hivemindapp.netlify.app/)

- OR -

[Explore the frontend repo](https://github.com/hivemindapp/hivemind-frontend)

## System Dependencies

* Ruby 2.7.2
* Rails 5.2.6

### Important Gems

* [google-cloud-storage](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-storage)
* [rack-cors](https://github.com/cyu/rack-cors)
* [graphql](https://graphql-ruby.org/)

## Configuration

1. Fork and clone this repo
2. Bundle install
4. Configure cors.rb with your specified allowable origins, methods, headers, and max_age
5. Configure Google Cloud storage (see details below)
6. `rails db:{create,migrate,seed}`

### Google Cloud Storage Configuration

This app is currently configured to use GCS for both the development and production (staging) environments, while it uses local disk storage for testing. This is set in the `storage.yml` file, but requires a substantial amount of external configuration for security purposes. You will need:
 
 * A GCS account with a project and bucket 
 * A service account and the key info provided for that, stored in a json file (but not checked into your git history). The [GCS config instructions found here](https://pjbelo.medium.com/setting-up-rails-5-2-active-storage-using-google-cloud-storage-and-heroku-23df91e830f8) should get you what you need for this app. We recommend following the config for rails credentials, which the article lists as optional.
 * A separate [CORS config for your cloud project](https://cloud.google.com/storage/docs/configuring-cors), which will require you to set up gsutil ([instructions here for gsutil quickstart](https://cloud.google.com/storage/docs/quickstart-gsutil)). Once you have gsutil and have selected your project according to the setup instructions, create a json file that will look something like this (slightly edited here):

```json
[
  {
    "origin": ["http://localhost:3000", "(backend prod url)", "(frontend app)"],
    "method": ["POST", "OPTIONS"], 
    "responseHeader": ["Origin", "content-type", "Content-Type", "Content-MD5", "Content-Disposition"],
    "maxAgeSeconds": 3600
  }
]
```

Then run this command in your root dir or where you've set up gsutil:

` $ gsutil cors set full_path/to/cors_config/file.json gs://your-bucket-name `

To view the config currently on your bucket: 

` $ gsutil cors get gs://your-bucket-name `

## Endpoints

Visit [our Wiki](https://github.com/hivemindapp/hivemind-backend/wiki/Hivemind-Backend-Overview) for more information on endpoints available, along with sample requests and responses.

## Database Schema

<img width="940" alt="hivemind-database-diagram" src="https://user-images.githubusercontent.com/26797256/132422388-71fcb946-2f98-415e-9f70-d28b5023946b.png">

## Testing

Run tests on mutations and queries using the GraphIQL interface:

1. Run your dev server: `rails s`
2. Visit `http:localhost:3000/graphiql`

To run the full test suite, simply run `bundle exec rspec`. Gems required for testing:

 * 'database_cleaner' # DB cleaning between test runs
 * 'factory_bot_rails' # Creating mock data "factories"
 * 'faker' # Generating fake data for our mocks
 * 'rspec-graphql_matchers' # Provides matchers for GraphQL query/mutation testing
 * 'shoulda-matchers' # Allows for simpler and more elegant expect statements

## Contributors

* Molly Krumholz: [Github](https://github.com/mkrumholz) & [Linkedin](https://www.linkedin.com/in/mkrumholz/)
* Kat White: [Github](https://github.com/k-atwhite) & [Linkedin](https://www.linkedin.com/in/ka-white/)
* Claire Fields: [Github](https://github.com/clairefields15) & [Linkedin](https://www.linkedin.com/in/clairefields15/)
* Joe Peterson: [Github](https://github.com/JoePeterson51) & [Linkedin](https://www.linkedin.com/in/joe-peterson-14718220b/)
* Richard DeSilvey: [Github](https://github.com/redferret) & [Linkedin](https://www.linkedin.com/in/richard-desilvey-33161696/)
