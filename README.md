# README

## Description

Rails engine is a custom API that returns information from [this](https://github.com/turingschool-examples/sales_engine/tree/master/data) data set. The API provides business insights into the data, like total revenue for a given merchant, merchants with the most revenue, etc.

This was a project for module 3 at the Turing School. The project outline can be found [here](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md).

## Running Locally

- `git clone https://github.com/toriejw/rails-engine.git`  
- `cd rails-engine`  
- `bundle`  
- `rails s`  

You can then make requests to `localhost:3000` using Postman or a similar service.

Example:

You can send a GET request to: `localhost:3000/api/v1/merchants/13/favorite_customer.json`

And you should get back:

`{  
  "id": 814,  
  "first_name": "Shannon",  
  "last_name": "Jacobs",  
  "created_at": "2012-03-27T14:57:30.000Z",  
  "updated_at": "2012-03-27T14:57:30.000Z"  
}`

Make you sure have PostgreSQL installed and open on your computer.

### Running tests

To run tests:

`bundle exec rake test`
