module API
  module V1
    class ObjectivesController < ApplicationController
      before_action :set_objective, only: [:show, :update, :destroy]

      deserializable_resource :objective, only: [:create, :update]

      def index
        @objectives = Objective.all
        
        render jsonapi: @objectives, class: proc { ObjectiveResource }, fields: { objectives: [:title, :weight, :created_at, :updated_at] }
      end

      def show
        render jsonapi: @objective, class: proc { ObjectiveResource }, fields: { objectives: [:title, :weight, :created_at, :updated_at] }
      end

      def create
        @objective = Objective.new(objective_params)

        if @objective.save
          render jsonapi: @objective, status: :created, class: proc { ObjectiveResource }, fields: { objectives: [:title, :weight, :created_at, :updated_at] }
        else
          render jsonapi_errors: @objective.errors, status: :unprocessable_entity
        end
      end

      def update
        if @objective.update(objective_params)
          render jsonapi: @objective, class: proc { ObjectiveResource }, fields: { objectives: [:title, :weight, :created_at, :updated_at] }
        else
          render jsonapi_errors: @objective.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @objective.destroy

        head :no_content
      end

      private

      def objective_params
        params.require(:objective).permit(:weight, :title)
      end

      def set_objective
        @objective = Objective.find(params[:id])
      end
    end
  end
end
