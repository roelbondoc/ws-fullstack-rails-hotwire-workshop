# Building Fullstack Applications with Rails and Hotwire

Purpose: This interactive workshop will guide participants in building highly
interactive full stack applications using Rails and Hotwire.

Audience: Anyone curious how to leverage the entire Rails framework.

After this workshop participants will be able to:
1. Explain what Hotwire is and how it works with the Rails framework.
2. Develop interactive features using Rails and Hotwire.
3. Identify areas in feature development where you can use Rails and Hotwire.

Requirements: Docker installed locally.

## Introduction

This repo contains a sample admin application for a ficticious financial
company. The application is built using standard Rails operations. You'll find
that there is next to no JavaScript, views are rendered server side, and
all operations use normal `<form>` tags and normal HTTP operations.

This workshop will guide you through setting up the application to use
"Hotwire". Hotwire is comprised of 3 components:

1. Server side rendered HTML
2. Turbo
3. StimulusJS

You'll be adding Hotwire to this existing application. The goal is to augment
the UI to give it a better user experience, while maintaining a structure that
adheres to a basic Rails application framework.

## Pre workshop - Setup

1. Clone this repo:
```
git clone https://github.com/roelbondoc/ws-fullstack-rails-hotwire-workshop
```

2. Build the Docker images:
```
docker-compose build
```

3. Start the application:
```
docker-compose up
```

4. Prepare the database (this may take a while to seed the data):
```
docker-compose run --rm app rails db:reset
```

5. Verify the application is running by visiting [http://localhost:3000](http://localhost:3000).

## Improvement 0 - Install Importmap/StimulusJS/Turbo

The app already has the necessary gems installed. Let's configure the Rails app
by installing the following components:

* importmap
* stimulus
* turbo

## Improvement 1 - Slow dashboard

Issue: The dashboard has some intense operations whenever you load it. You'd
like to avoid caching if possible.

Fix: The dashboard is comprised of several key metrics. They currently load
sequentially through basic ActiveRecord queries. Break up the page into
separate components and load each metric individually.

## Improvement 2 - Persist filter open state

Issue: There's a usability issue where the filter form for all of the index
pages close whenever you use the filter. The filter form should persist the
open state when you change filters.

Fix: The filter forms on all the index pages use basic form submissions that
reload the page. Leverage the use of turbo frame targeting to give it a more
dynamic feel.

## Improvement 3 - Unified search

Issue: The unified search (found at the top right of the app) currently isn't
the best user experience. It requires a lot of navigation and doesn't save
the admin a lot of time.

Fix: Making the results appear directly in the modal should offer significant
improvements. Make this easier to use by adding auto submit and persisted
results.

## Improvement 4 - Accepting and rejecting orders

Issue: In the orders page, the `Accept` and `Reject` buttons all perform basic
form submissions. The buttons on the individual rows perform the operation
synchronously, while the "All" buttons queue the operations in the background.
This leads to a broken experience for the admin and they lose their bearing
when the page refreshes.

Fix: The individual buttons on the rows should submit and return the result in
it's place so that the admin wont' lose their place when acting on multiple
orders. The "All" buttons should do the same, but also give live feedback on
the progress as the app works through the tasks in the background.

## Improvement 5 - Activity page infinite scroll

Issue: The activity page can potentially contain a lot of data. Users have
requested to just be able to continue scrolling through the log instead of
having to click to get to the next page.

Fix: Convert the pagination to an infinite scroll.

## Improvement 6 - Make client drop downs autocomplete

Issue: Several of the filters have both a client and account drop down. These
drop downs have a large amount of options which becomes cumbersome to use.

Fix: Create an autocomplete component that merges the two drop downs together.
