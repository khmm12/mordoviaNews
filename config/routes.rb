Rails.application.routes.draw do

    scope '/admin_panel/' do
        devise_for :admins
    end
    mount RailsAdmin::Engine => '/admin_panel', as: 'rails_admin'
    mount Ckeditor::Engine => '/ckeditor'

    scope '/api/v1/' do
        devise_for :users, :controllers => {:registrations => "users/registrations"}
    end
    namespace :api, defaults: {format: 'json'} do
        namespace :v1 do
            resources :news do
                resources :news_comments
            end
            resources :news_categories
        end
    end
    root 'angular#index'
    get 'angular/:id' => 'angular#show', constraints: {id: /[^\/]+/}
end
