require 'swagger_helper'

describe 'Reports API', swagger_doc: 'api/v1/swagger.json', type: :request do
  let!(:objectives) { create_list(:objective, 3) }

  path '/objectives' do
    get 'Lists objectives' do
      tags 'Objectives'
      produces 'application/json'
      consumes 'application/json'
      description 'Loads all objectives'

      response '200', 'Objectives loaded' do
        schema '$ref': '#/components/schemas/objectives'

        run_test!
      end
    end
  end
end
