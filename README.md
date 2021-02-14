Rails Engine
![rails-badge](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat-square) ![ruby-badge](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat-square)

## Overview
Rails Engine is a RESTful API that serves up business intelligence analytics (like revenue across date range and top-selling merchant) to an e-commerce platform that aggregates several merchants.

## Readme Content
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [Testing](#testing)
- [Database Schema](#database-schema)
- [Next Steps](#next-steps)

## Getting Started
```
$ git clone git@github.com:leahriffell/rails_engine.git
 # or clone your own fork
$ cd rails_engine
```

### Prerequisites
- Ruby 2.5.3
- Rails 5.2.4.4

### Installing
#### Install gems and setup your database:
```
bundle install
rails db:create
rails db:migrate
rails db:seed
```
#### Run your own development server:
```
rails s
```

This is only an API, with no frontend view.

## Testing
- Run with $ bundle exec rspec. All tests should be passing.

## API Endpoints
- All requests sent to `http://localhost:3000/api/v1`

### Items REST Endpoints
```
# Get all items
GET http://localhost:3000/api/v1/items

# Get one item
GET http://localhost:3000/api/v1/items/:id

# Create new item
POST http://localhost:3000/api/v1/items

# Update existing item
PATCH http://localhost:3000/api/v1/items/:id

# Destroy an item
DELETE http://localhost:3000/api/v1/items/:id
```
#### Get an Item's Merchant
```
GET http://localhost:3000/api/v1/items/:id/merchants
```

### Merchants REST Endpoints
```
# Get all merchants
GET http://localhost:3000/api/v1/merchants

# Show one merchant
GET http://localhost:3000/api/v1/merchants/:id

# Get all Items based on one merchant id
GET http://localhost:3000/api/v1/merchants/:id/items
```

### Relationship Endpoints

#### Get all Items that belong to a Merchant
```
GET /api/v1/merchants/:id/items
```

### Search Endpoints

#### Items
- Search Criteria:
  - name
  - description
  - unit_price
  - merchant_id

- search is case insensitive and will also fetch partial matches

```
# Search for 1 Item
GET /api/v1/items/find?<attribute>=<value>


#### Merchants

```
# Search for all Merchants that match criteria
GET /api/v1/merchants/find_all?<attribute>=<value>
```

### Business intelligence Endpoints
#### Merchants with Most Revenue
- Returns a quantity of merchants sorted by descending revenue
```
GET /api/v1/merchants/most_revenue?quantity=x
# x is the number of merchants to be returned
```

#### Merchants with Most Items Sold
- Returns a quantity of merchants sorted by descending item quantity sold
```
GET /api/v1/merchants/most_items?quantity=x
# x is the number of merchants to be returned
```

#### Revenue across Date Range
- Returns total revenue generated in the whole system over a start/end date range
```
GET /api/v1/revenue?start=<start_date>&end=<end_date>
```

#### Revenue for a Merchant
- Returns total revenue for a given merchant
```
GET /api/v1/merchants/:id/revenue
```

## Database Schema

![DB Schema]("https://github.com/nessaarruda/rails-engine/blob/readme/app/images/Screen%20Shot%202021-02-14%20at%202.10.06%20PM.png" width="700")

## Next Steps:

- Add sad path tests
