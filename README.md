# Making a Difference!

Noticing the ineffectiveness of recent initiatives to decrease homelessness in LA and that the crowdfunding model has been successful for raising money for people in need internationally, we created a crowdfunding platform for people to donate to specific homeless individuals for specific goals. 

Heroku app: http://homestreethome.herokuapp.com/

## Features

Profiles and status updates (donors have the option of being emailed or texted) of the homeless can be managed by them or by a partner organization (ex. a shelter). User authentication was completed with devise and cancancan. Text updates are sent using Twilio.

Partners and the site admins also have access to a custom dashboard to track progress and see what's been the most effective in raising money. Data is pulled from the DB with custom sql queries and formatted as JSON with an active model serializer. Charts were made with D3. 

## Technical Details

Tests writted in rspec, in the spec folder.

Used RoR, PostgreSQL, Angular, D3, Twilio, Twitter API.

Current profiles are samples and not real homeless people. Index page has infinite scroll and is displayed using angular and our own API.

## Future Project Plans

After fixing up some things, we hope to give it away to charities or anyone who would like to get it up and running! 
