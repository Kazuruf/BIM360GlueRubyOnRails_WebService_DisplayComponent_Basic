# BIM360Glue_RubyOnRails_Basic
Ruby on Rails example on how to use web services of Autodesk BIM 360 Glue to login, list projects, models and display 3d models in web browser.
There is an even more basic code examples [here](https://github.com/lushibi/BIM360Glue_RubyOnRails_Basic) to show how to do login and logout with Glue API.

## Prerequisition
* Install Ruby and Rails from http://railsinstaller.org
* Run `rails -v` to make sure rails installed successfully

## How to run:
* Clone this repository
* Run `bundle install` to install all dependencies
* Run `rails s` to start the web server
* Browse to `http://localhost:3000`

if you want to see how Glue API is called, you can refer to this file directly: [app/helpers/application_helper.rb](https://github.com/lushibi/BIM360Glue_RubyOnRails_Basic/blob/master/app/helpers/application_helper.rb)

## How to create this project from scratch:

Step1: Install and try
* Run `rails new BIM360Glue_RubyOnRails_Basic` to create a new rails app
* Run `cd <YourCodeDirectory> && bundle install`, note: this step may be executed automatically by the previous command
* Run `rails s`
* Browser to "http://localhost:3000/"

Step2: Change default home page
* Add home page: run `rails generate controller welcome index`, see [Ruby on rails getting started](http://guides.rubyonrails.org/getting_started.html), It will generate several files, followings are the most important ones
  * app/views/welcome/index.html.erb - the html page template
  * app/controllers/welcome_controller.rb - the controller
  * app/assets/javascripts/welcome.js.coffee - javascript written in [coffeescript](http://coffeescript.org/), which will be compiled into application.js
  * app/assets/stylesheets/welcome.css.scss - css written in [sass](http://sass-lang.com/), which will be compiled into application.css
* Open the file `config/routes.rb` in your editor, uncomment this line `# root 'welcome#index'`
* Run `rails s` and browser to `http://localhost:3000` again, you will see the home page changed to what you've just created

Step3: Add functions to login to Glue
* Copy `app/helpers/application_helper.rb` from this github to your local folder, and modify credential information `CREDENTIALS_API_KEY`, `CREDENTIALS_API_SECRET`, `CREDENTIALS_COMPANY_ID` with your own api_key, api_secret and company_id, this file also defines login url and a function named `glue_login` which is used to login to Glue
* Open `app/controllers/application_controller.rb`, add `include ApplicationHelper` before `end`, this allows all variables and functions in ApplicationHelper are available in ApplicationController and its derived classes
* Copy `app/views/welcome/index.html.erb` from this github to your local folder
* Run `rails generate controller Sessions new` to create session controller and views
* Open `router.rb`, add following code under `get 'welcome/index'`, it defines login and logout routes
      ````
      get    'login'   => 'sessions#new'
      post   'login'   => 'sessions#create'
      delete 'logout'  => 'sessions#destroy'
      ````
* Copy `app/controllers/sessions_controller.rb` and `app/helpers/sessions_helper.rb` in this repository to your local folder, the login logout controller are defined
* Include SessionsHelper in ApplicationControllers by adding `include SessionsHelper` in file `app/controllers/application_controller.rb`
* Copy `app/views/sessions/new.html.erb` to your local folder, it defines the login form
* Copy `app/views/layouts/application.html.erb` from this repository to your local folder to overwrite the default home page. Notice that it contains error prompt for login failur, see following html segment in `app/views/layouts/application.html.erb` and css segment in `app/assets/stylesheets/application.css`
      ````
      <div>
        <% flash.each do |message_type, message| %>
          <div class="alert alert-<%= message_type %>"><%= message %></div>
        <% end %>
      </div>
      ````

      ````
      .alert.alert-danger {
        color: red;
      }
      ````
* Now the login logout feature is ready to use, run `rails s` and browse to `http://localhost:3000` to have a try, you will see an error: undefined local variable or method `projects_path', which will be resolved in following step

Step4: Add project information pages
* Run `rails generate controller Projects`
* Add functions `glue_get_projects` and `glue_get_project_by_id` to `app/helpers/application_helper.rb` to get information of projects via Glue API
* Add functions `index` and `show` to `app/controllers/projects_controller.rb` to call helper methods and retrieve objects for rendering
* Add routes
      ````
      get    'projects'     => 'projects#index'
      get    'projects/:id' => 'projects#show', as: :project
      ````
* Copy html templates from this repository, `app/views/projects/index.html.erb` and `app/views/projects/show.html.erb`

Step5: Add model information pages
* Run `rails generate controller Models`
* Add functions `glue_get_model_by_id` to `app/helpers/application_helper.rb` to get information of models via Glue API
* Add functions `show` to `app/controllers/models_controller.rb` to call helper method
* Add routes, we did not add index page because model list will be shown in `models#show` page
      ````
      get    'models/:id' => 'models#show', as: :model
      ````
* Copy html template from this repository to your local folder, `app/views/models/show.html.erb`

Step6: View 3D model with display component
* Run `rails generate controller Glue_Views`
* Add functions `glue_get_view_url_by_id` to `app/helpers/application_helper.rb` to construct glue view url and other information
* Add functions `show` to `app/controllers/glue_views_controller.rb` to call helper method
* Add routes
      ````
      get    'glue_views/:id' => 'glue_views#show', as: :glue_view
      ````
* Copy html template from this repository to your local folder, `app/views/glue_views/show.html.erb`

Step7: Run `rails s` and browse to `http://localhost:3000`.

Note: as for today, the display component (the 3d view component) is only available for firefox, chrome and IE does not support it.
