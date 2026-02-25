# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        render json: {
          user: resource.as_json(only: %i[id email username created_at])
        }, status: :ok
      end

      def respond_to_on_destroy(non_navigational_status: :no_content)
        head non_navigational_status
      end
    end
  end
end
