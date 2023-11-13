![Gem](https://img.shields.io/gem/v/administrate_filterable.svg)
![CI](https://github.com/IrvanFza/administrate_filterable/workflows/CI/badge.svg)

# Administrate Custom Filter

An [Administrate](https://github.com/thoughtbot/administrate/) plugin to add a custom filter to your index page. The filter will be rendered as an off-canvas component, so it won't take up too much space on your index page. Highly inspired by [ActiveAdmin](https://github.com/activeadmin/activeadmin)'s filter.

![administrate_filterable-open](https://github.com/IrvanFza/administrate_filterable/assets/4778169/c127f425-ed7b-4ea8-b92f-4644072b1576)

## Why do you need this?

Let's agree that the Administrate's team has done a great job with the default search or filter functionality. It already supports multiple search fields and relational table searches. It's easy to customize (like enabling/disabling the search, defining custom search fields, etc).

But there are some drawbacks that I found:
1. Since it uses a single search box, the search process behind it is quite heavy. It will search all the attributes of the model, and it will be slower if you have a lot of data.
2. Again, because it searches all the attributes, it will be hard to search for a specific attribute. For example, if you have `registration_status` and `employment_status`, and you want to search for "active" registration status only, you will get all the "active" records, including the employment status.
3. It's not user-friendly when it comes to a defined search list (e.g. dropdown list). The user will have to type the value manually, and it's not good for the user experience.

Please share your thoughts if you have any other reasons.

## Requirements

- Ruby on Rails version >= 5.0
- Administrate version >= 0.2.2

## Installation

Add `administrate_filterable` to your Gemfile:

```ruby
gem 'administrate_filterable'
```

And then execute:
```
$ bundle install
```

Or, simply just run:
```
$ bundle add administrate_filterable
```

## Usage

### Enable the filter
For each resource you want to add a custom filter, add the following line to their Administrate controller, respectively.
```ruby
include AdministrateFilterable::Filterer
```

Example:
```ruby
class UsersController < Administrate::ApplicationController
  include AdministrateFilterable::Filterer

  # ...
end
```

### Customizing the filter fields
By default, all the attributes from `COLLECTION_ATTRIBUTES` will be rendered as the filter fields. You can override this by adding `FILTER_ATTRIBUTES` to your Administrate's dashboard file.

Example (`app/dashboards/user_dashboard.rb`):
```ruby
class UserDashboard < Administrate::BaseDashboard
  # ..
  FILTER_ATTRIBUTES = [
    :first_name,
    :last_name,
    :email,
    :created_at
  ].freeze
  # ..
end
```

### Customizing the filter template
It is possible to customize the filter template (e.g. changing the filter button icon, etc). You can do this by overriding the default template in your application, just create a new file called `_index_filter.html.erb` in your desired resource folder.

For example, if you want to override the filter template for the `users` resource, you need to create the file in `app/views/admin/users/_index_filter.html.erb`. Then just copy and paste the content from the default template [here](app/views/admin/application/_index_filter.html.erb) and modify it to suit your needs.

### Asset Pipeline
If you use an assets pipeline, you need to include this gem's assets in your `app/assets/config/manifest.js` file:
```javascript
// ... other code here ...

//= link administrate_filterable/application.css
//= link administrate_filterable/application.js
```

Run `rails assets:precompile` if the assets are not loaded.


## Troubleshooting
### Overridden default search template
By default, this gem will add a filter button to `views/admin/application/_search.html.erb` partial. But if you have overridden that partial in your application you can add the button manually by adding the following line:
```erb
<%= render 'index_filter' %>
```

Example (`app/views/admin/users/_search.html.erb`):
```erb
<form class="search" role="search">
  ... other code here ...
</form>

<%= render 'index_filter' %>
```

### Filter button not showing
Since I use the `_search.html.erb` partial to add the filter button, it may not be showing if you turn all the searchable attributes to false in the model dashboard. So make sure you have at least one searchable attribute to make the filter button show up.

The reason why I use the partial is because:
1. It is rarely overridden by the user, so you won't have to add the button manually in most cases.
2. Previously, I used the `_index_header.html.erb` partial, but it conflicts with the export button from [administrate_exportable](https://github.com/SourceLabsLLC/administrate_exportable). Using both gems results in one button missing, due to the partial override.

## To Do
There are still a lot of things to do to make this gem better. Here are some of them (sorted by highest priority first):
- [ ] Add support for the relational filter (e.g. filter by `belongs_to` association, etc)
- [ ] Add support to customize the dropdown list (e.g. add `prompt` option, add `include_blank` option, etc)
- [ ] Exclude checkbox, radio, or select value from the filter params if no action is performed on them
- [ ] Figure out a better way to implement the filter functionality (currently I override the `scoped_resource` method)
- [ ] Figure out a better way to pass the filter attributes to the form (currently I use an instance variable in the overridden `scoped_resource` method)
- [ ] Add capability to customize the filter behavior (e.g. search by exact match, search by partial match, etc just like in the ActiveAdmin filter)
- [ ] Improve the toggle button user experience (e.g. add open/close animation, add dynamic open/close title, etc)

If you have any ideas or suggestions, please let me know by creating an issue or pull request.

## Contributing
You can help me to improve this gem by contributing to this project. Any help is highly appreciated.
1. Fork this repo and create a pull request
2. Please test your code: `bundle exec rspec`
3. Please document your code if needed

## License

[MIT License](https://github.com/IrvanFza/administrate_filterable/blob/master/LICENSE)

## Credits
Huge thanks for the following resources that helped me a lot in creating this gem:
- [administrate_exportable](https://github.com/SourceLabsLLC/administrate_exportable): I just copy and paste the code from this gem and modify it to suit my needs, highly recommended if you need to export your data from Administrate.
- [Off-Canvas Menu](https://web.archive.org/web/20210304195120/https://codepen.io/11bits/pen/jryEGW): I found this code from Google Images when I was looking for a way to create an off-canvas filter component. I modified it a little bit to suit my needs. But it seems the CodePen is no longer available, so I put the archived version here. If any of you know the original author, please let me know so I can give the proper credit.
