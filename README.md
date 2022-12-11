# README

Demo: https://timers-url-shortener.fly.dev/urls

About thie App:

* Ruby version
`3.1.2`
* Rails version
`7.0.4`

* System dependencies

  - use a modern version of either unix/linux.
  - PostgreSQL is used as the database, so please have this set up (e.g you can install this via Homebrew)

* Database creation
```
rake db:prepare
```

* Deployment instructions

  - Simply push to main, and the workflow will deploy the app using `fly.io`.

## How this works

This coding exercise implements a URL shortening service. A user can shorten a URL to be the hostname + 7 extra characters (all 7 being hexidecimal). For example:

- original URL: `https://github.com/karimtimer/url-shortener`
- Could shorten into something like: `timers-url-shortener.fly.dev/44daa93`

There are two main REST-ful API endpoints that we make use of. 

### 1. `Urls#create`

This creates a new URL, which has two fields: `long_url` (i.e the original url) and `short_url` (its shortened version). The client sends a POST request when this is hit.

### 2. `Urls#redirect`

This is a redirecting endpoint. It does this by taking the shortened URL and seeing if it exists within our DB. If it does, it redirects the client to the original URL. The client sends a GET request when this is hit.

## Points of Note

### Redirecting

We use 302 redirect, as opposed to a 301. Both have their pros and cons, and the main reason I went with 302 is for future additions of analytics & tracking. This is due to 302 'temporarily' moving the long url, meaning subsequent requests to the same URL will be sent via our server first. Then, they are redirected to the original URL's server. The con here is that this has more server load vs a 301.

### URL Shortening

As mentioned previously, we store a 7 character long string as the shortened version of the long url. This is encapsulated within an operation (`app/operations/shortener.rb`). 

We first check if the provided long url exists in our DB. If it does, return its shortened URL and we avoid creating a new record in our DB.

If it does not, we then create a new `URL`. `short_url` gets its string by invoking `SecureRandom.hex.first(7)`. This produces a 7 hexidecimal string. We should note that this might lead to a collision (i.e this same `short_url` re-appearing for another `long_url`). However, this is improbable and a non-worry for this project. Mathematically, the chance of getting two duplicate strings here would be a 1:268435456. Also, we have a unique contrainst so our DB will never have two `short_urls` that are identical. If in the future we want to reconsider this approach and eliminate the chance of getting a duplicate, we could use a base 62 conversion.

## Things To Do Next

- [ ] Make these API endpoints follow the JSON-API schema https://jsonapi.org/
  - I would personally use Graphiti as I have experience with it https://www.graphiti.dev/guides/
- [ ] Tracking and useful metrics
  - For example, click rates.
- [ ] Make this pretty! :sweat_smile:
  - Any framework would do, so will leave this as an exploration for the future
- [ ] Add authentication
  - Some mechanism to authenticate the user.
- [ ] Add a rate limiter
  - A user could send an overwhelmingly large nuber of requests. To avoid this from happening, we can rate limit the request to our endpoints, based on I.P Address and other filtering rules.
