require 'swagger_helper'

describe 'Reports API', swagger_doc: 'api/v1/swagger.json', type: :request do
  let!(:objective) { ObjectiveResource.new(object: FactoryBot.build(:objective)).as_jsonapi }
  let(:id) { objective.id }

  put '/objectives/:id' do
    post 'Creates objectives' do
      tags 'Objectives'
      produces 'application/json'
      consumes 'application/json'
      description 'Loads all objectives'
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :objective, in: :body, schema: { '$ref': '#/components/schemas/objective' }

      response '201', 'Objective Created' do
        schema '$ref': '#/components/schemas/objective'

        run_test!
      end

      response '422', 'Invalid Request' do
        schema '$ref': '#/components/schemas/errors'

        run_test!
      end
    end
  end
end
