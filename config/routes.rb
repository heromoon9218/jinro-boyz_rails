Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "users/me", to: "current_user#show"
      devise_for :users,
                 path: "users",
                 path_names: {
                   sign_in: "sign_in",
                   sign_out: "sign_out",
                   registration: ""
                 },
                 controllers: {
                   sessions: "api/v1/sessions",
                   registrations: "api/v1/registrations"
                 }
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
