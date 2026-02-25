# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      before_action :configure_permitted_parameters, if: :devise_controller?
      before_action :merge_user_params_from_registration, only: [ :create ]

      private

      def merge_user_params_from_registration
        return if params[:user].present?

        params[:user] = params[:registration]&.dig(:user) if params[:registration]&.key?(:user)
      end

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username)
      end

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {
            user: resource.as_json(only: %i[id email username created_at])
          }, status: :created
        else
          render json: {
            errors: resource.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
