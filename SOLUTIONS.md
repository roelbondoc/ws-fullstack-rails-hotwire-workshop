# Solutions

## Improvement 0 - Install Importmap/StimulusJS/Turbo

1. Install importmap
```
docker-compose run --rm app rails importmap:install
```

2. Install stimulus
```
docker-compose run --rm app rails stimulus:install
```

3. Install turbo, and setup to use redis
```
docker-compose run --rm app rails turbo:install
docker-compose run --rm app rails turbo:install:redis
```

4. Restart the application to ensure changes take effect
```
docker-compose restart app
```

## Improvement 1 - Slow dashboard

1. Move each call into it's own action in the `DashboardController`.
```
# dashboard_controller.rb
def index
end

def client_count
  @client_count = get_client_count
end

def account_count
  @account_count = get_account_count
end

def biggest_account
  @biggest_account = get_biggest_account
end

def aum
  @aum = get_aum
end
```

2. Add a route for each action.
```
# routes.rb
get 'dashboard/client_count', to: 'dashboard#client_count'
get 'dashboard/account_count', to: 'dashboard#account_count'
get 'dashboard/biggest_account', to: 'dashboard#biggest_account'
get 'dashboard/aum', to: 'dashboard#aum'
```

3. Create a template for each action with a `<turbo_frame>`. Note the id `dashboard-account-count`, which will be used again in the next step. Do this for each of the newly created actions (using a different id for each).
```
<!-- account_count.html.erb -->
<%= turbo_frame_tag 'dashboard-account-count' do %>
  <div class="box">
    <p class="subtitle is-5">Accounts</p>
    <p class="title is-2"><%= @account_count %></p>
  </div>
<% end %>
```

4. Modify `index.html.erb` by adding `<turbo_frame>` tags setting the `src` attribute. The id should match the one found in the templates above, and the src should be set to the corresponding path.
```
<!-- dashboard/index.html.erb -->
...
<div class="column">
  <%= turbo_frame_tag 'dashboard-account-count', src: dashboard_account_count_path do %>
    <div class="box">
      <p class="subtitle is-5">Accounts</p>
      <p class="title is-2">-</p>
    </div>
  <% end %>
</div>
...
```

## Improvement 2 - Persist filter open state

1. Wrap the table with a `<turbo_frame>` tag.
```
<!-- clients/index.html.erb -->
<%= turbo_frame_tag 'index-list' do %>
  <div class="container">
    <table class="table is-bordered is-fullwidth is-striped is-hoverable">
      ...
    </table>
    <%= paginate @clients %>
  </div>
<% end %>
```

2. Add use a `data-turbo-frame` attribute to target the tag.
```
<!-- clients/index.html.erb -->
...
<form class="is-hidden is-inline-block" data-turbo-frame="index-list">
...
```

3. Add `data-turbo-frame` attributes to view links for targeting. The `_top` value will ensure navigation replaces the whole page.
```
...
<td><%= link_to 'View', client_path(client), class: 'button is-link', data: { turbo_frame: '_top' } %></td>
...
```

4. Create a stimulus controller to get rid of inline js.
```
docker-compose run --rm app rails generate stimulus filter-toggle
```

5. Add function to filter-toggle controller.
```
// filter_toggle_controller.js
...
export default class extends Controller {
  static targets = ["form"];

  toggle() {
    if (this.hasFormTarget) {
      this.formTarget.classList.toggle('is-hidden');
    }
  }
}
```

6. Attach controller to page with data attributes.
```
<!-- encapsulating div -->
<div class="container mb-4" data-controller="filter-toggle">

<!-- form -->
<form class="is-hidden is-inline-block" data-turbo-frame="index-list" data-filter-toggle-target="form">

<!-- button -->
<button class="button is-inline-block" data-action="filter-toggle#toggle">&harr;</button>
```

## Improvement 3 - Unified search

1. Add an empty `<turbo_frame>` tag to the modal.
```
<!-- layout/application.html.erb -->
...
<section class="modal-card-body">
  ...
  <%= turbo_frame_tag 'search-results' %>
</section>
...
```

3. Add use a `data-turbo-frame` attribute to target the tag.
```
<!-- layouts/application.html.erb -->
...
<%= form_tag search_results_path, method: :get, data: { turbo_frame: 'search-results' } do %>
...
```

4. Wrap the results in `results.html.erb` with a corresponding `<turbo_frame>`.
```
<!-- search/results.html.erb -->
...
<div class="container">
  <%= turbo_frame_tag 'search-results' do %>
    <p class="content has-text-black"><%= pluralize @records.total_count, 'record' %></p>
    <% @records.each do |record| %>
      ...
    <% end %>
    <%= paginate @records %>
  <% end %>
</div>
...
```

5. Create stimulus controllers to get rid of inline js and add auto submit functionality.
```
docker-compose run --rm app rails generate stimulus modal-toggle
docker-compose run --rm app rails generate stimulus auto-submit
```

6. Add function to modal-toggle controller.
```
// modal_toggle_controller.js
...
export default class extends Controller {
  static targets = ["modal"];

  show() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add('is-active');
    }
  }

  hide() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove('is-active');
    }
  }
}
```

7. Attach modal-toggle controller to view.
```
<!-- layouts/application.html.erb -->
...
<div class="navbar-end">
  <div class="buttons" data-controller="modal-toggle">
    <button class="button is-primary" data-action="modal-toggle#show">Search</button>
    <div class="modal" data-modal-toggle-target="modal">
      ...
      <button class="delete" aria-label="close" data-action="modal-toggle#hide"></button>
...
```

8. Pin lodash with importmap.
```
docker-compose run --rm app bin/importmap pin lodash
```

9. Add function to auto-submit controller.
```
// auto_submit_controller.js
import { Controller } from "@hotwired/stimulus"
import _ from "lodash"

export default class extends Controller {
  initialize() {
    this.submit = _.debounce(this.submit, 250).bind(this);
  }

  submit() {
    this.element.requestSubmit();
  }
}
```

10. Attach auto-submit controller to view.
```
<!-- layouts/application.html.erb -->
...
<%= form_tag search_results_path, method: :get, data: { turbo_frame: 'search-results', controller: 'auto-submit' } do %>
  ...
  <%= text_field_tag 'q', nil, class: 'input', placeholder: 'Find a client, account, portfolio, security, etc.', data: { action: 'keyup->auto-submit#submit' } %>
...
```

11. Persist results using a `data-turbo-permanent` attribute (note that we also have to add an `id`).
```
<!-- layouts/application.html.erb -->
...
<div id="site-search-card" class="modal-card" data-turbo-permanent>
...
```

## Improvement 4 - Accepting and rejecting orders

Row actions
1. Wrap the contents of the action cell in `index.html.erb`.
```
<!-- orders/index.html.erb -->
<td>
  <%= turbo_frame_tag dom_id(order) do %>
    <% if order.rejected_at %>
      <span class="has-text-danger"><%= order.rejected_at %></span>
    <% elsif order.accepted_at %>
      <span class="has-text-success"><%= order.accepted_at %></span>
    <% else %>
      <%= form_with url: accept_order_path(order), class: 'is-inline mr-1' do |f| %>
        ...
      <% end %>
    <% end %>
  <% end %>
</td>
```

2. Modify the `accept` and `reject` actions so they don't redirect.
```
# orders_controller.rb
def accept
  @order = Order.find(params[:id])
  @order.slowly.update(rejected_at: nil, accepted_at: Time.current)
end

def reject
  @order = Order.find(params[:id])
  @order.slowly.update(accepted_at: nil, rejected_at: Time.current)
end
```

3. Add view templates for the actions so it returns the appropriate timestamp.
```
<!-- accept.html.erb -->
<%= turbo_frame_tag dom_id(@order) do %>
  <span class="has-text-success"><%= @order.reload.accepted_at %></span>
<% end %>

<!-- reject.html.erb -->
<%= turbo_frame_tag dom_id(@order) do %>
  <span class="has-text-danger"><%= @order.rejected_at %></span>
<% end %>
```

Table actions
1. Wrap the buttons in a `<turbo_frame>` tag.
```
<!-- orders/index.html.erb -->
...
<%= turbo_frame_tag 'bulk-order-action' do %>
  <% if Order.orders_in_process_count.zero? %>
    <%= form_with url: accept_all_orders_path, class: 'is-inline-block mr-1' do |f| %>
...
```

2. Add a `<turbo_stream_from>`. This can go anwhere on the page. The `id` here corresponds to the `id` we'll use when broadcasting.
```
<!-- orders/index.html.erb -->
<%= turbo_stream_from 'bulk-order-count' %>
```

3. Separate out the in progress part of the view into a partial.
```
<!-- orders/index.html.erb -->
<% if Order.orders_in_process_count.zero? %>
  ...
<% else %>
  <%= render partial: 'bulk_order' %>
<% end %>

<!-- orders/_bulk_order.html.erb -->
<%= turbo_frame_tag 'bulk-order-action' do %>
  <% if Order.orders_in_process_count.zero? %>
    Processing complete!
  <% else %>
    Processing <%= pluralize(Order.orders_in_process_count, 'order') %>.
  <% end %>
<% end %>
```

4. Add `Turbo::StreamsChannel.broadcast_replace_to` to the jobs.
```
# order_accept_job.rb
Turbo::StreamsChannel.broadcast_replace_to('bulk-order-count', target: 'bulk-order-action', partial: 'orders/bulk_order')

# order_reject_job.rb
Turbo::StreamsChannel.broadcast_replace_to('bulk-order-count', target: 'bulk-order-action', partial: 'orders/bulk_order')
```

## Improvement 5 - Activity page infinite scroll

1. Replace the table with a turbo frame and render the table with a partial.
```
<!-- activities/index.html.erb -->
<%= turbo_frame_tag 'index-list' do %>
  <div class="container">
    <%= render partial: 'activity_list', locals: { activities: @activities } %>
  </div>
<% end %>
```

2. Create the partial.
```
<!-- activities/_activity_list.html.erb -->
<%= turbo_frame_tag "activity-list-#{activities.current_page}", target: '_top' do %>
  <table class="table is-bordered is-fullwidth is-striped is-hoverable">
    ...
  </table>
<% end %>
```

3. Add the nested `<turbo_frame>` tag to point to the next page.
```
<!-- activities/_activity_list.html.erb -->
<%= turbo_frame_tag "activity-list-#{activities.current_page}", target: '_top' do %>
  <table class="table is-bordered is-fullwidth is-striped is-hoverable">
    ...
  </table>
  <% if activities.next_page %>
    <%= turbo_frame_tag "activity-list-#{activities.next_page}", src: activities_path(page: activities.next_page), loading: 'lazy', target: '_top' do %>
      Loading...
    <% end %>
  <% end %>
<% end %>
```

## Improvement 6 - Make client drop downs autocomplete

*If there is time, we'll do this live during the workshop together.*

* Switch the drop downs to a single text input.
* Setup a positioned drop down to contain results.
* Add an action to a controller that will return results.
* Clicking on a result should set a hidden form field.
