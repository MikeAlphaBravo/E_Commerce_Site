rails new [NAME OF FILE HERE] -d postgresql -T


add  to gem file gems
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'jquery-rails'
gem 'faker'
gem 'devise', '~> 4.3'
gem "paperclip", "~> 5.0.0"
gem 'rails_admin', '~> 1.2'

add to gem file test

gem 'rspec-rails'
gem 'launchy'
gem 'pry'
gem 'shoulda-matchers'
gem 'capybara'
gem 'factory_bot_rails'
gem 'simplecov', require: false

Run Bundle

rails generate rspec:install


add to rails_helper below require rspec/rails

require 'capybara/rails'

add to rails helper on bottom

Shoulda::Matchers.configure do |config|
	  config.integrate do |with|
	    with.test_framework :rspec
	    with.library :rails
	  end
	end

add to top of spec helper

require 'simplecov'

SimpleCov.start

in envirements/test.rb

change config.eager_load = true

change application.css to application.scss

add this to assets/javascript/application.js

//= require jquery3
//= require popper
//= require bootstrap-sprockets

add this to assets/stylesheets/application.scss

 @import "bootstrap";

run rails generate devise:install

rails generate devise users

rails generate devise:views

rails g migration add_admin_to_users

def change
	add_column :users, :admin, :boolean, default: false
end

rails g rails_admin:install

add this to config/initializers/rails_admin.rb

 ## == Devise ==
	  config.authenticate_with do
	    warden.authenticate! scope: :user
	  end
	  config.current_user_method(&:current_user)


	  ## authorize admin
	  config.authorize_with do
	    redirect_to main_app.root_path unless current_user.admin
	  end

rails g controller pages

add index to controller

add new pages/index.html

restart server

run rails c

User.create(email: 'admin@admin.com', password: '123456', admin: true)


make this application/views/layouts.

<!DOCTYPE html>
	<html>
	  <head>
	    <title>E-Commerce</title>
	    <%= csrf_meta_tags %>


	    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
	    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
	  </head>
	  <header>
	    <nav class="navbar navbar-expand-lg navbar-light bg-secondary">
	      <ul><%= link_to('Home', root_path) %></ul>
	      <% if current_user %>
	        <ul><%= link_to('Edit User', edit_user_registration_path) %></ul>
	      <% end %>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="navbar-toggler-icon"></span>
	      </button>


	      <div class="collapse navbar-collapse" id="navbarSupportedContent">
	        <ul class="navbar-nav mr-auto">


	          </li>
	        </ul>


	        <% if current_user %>
	        <%= link_to('Logout', destroy_user_session_path, method: :delete) %>
	        <% end %>
	      </div>
	    </nav>
	  </header>
	  <body>
	    <div class='container'>
	      <% flash.each do |key, value| %>
	         <div class='alert alert-info alert-dismissible fade show' role='alert'>
	           <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	             <span aria-hidden="true">&times;</span>
	           </button>
	           <%= value %>
	         </div>
	       <% end %>
	      <%= yield %>
	    </div>
	  </body>
	</html>

ad models to project

rails g model MODEL_NAME_SINGULAR name:string price:decimal image:string account_id:integer

after all models populated
Make relationships between models

ad controllers to project

rails g controller CONTROLLER_NAME_PLURAL + any controllers to create if different than default

add resources to routes
