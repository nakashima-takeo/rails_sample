Rails.application.routes.draw do
  get 'users/new'
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/foo", to: "static_pages#foo"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get 'foo/bar'
  get 'foo/baz'
end
