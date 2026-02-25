# frozen_string_literal: true

module Api
  module V1
    class CurrentUserController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: {
          user: current_user.as_json(only: %i[id email username created_at])
        }
      end
    end
  end
end
