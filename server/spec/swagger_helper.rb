# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'api/v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      basePath: '/api/v1',
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      components: {
        schemas: {
          objective_attributes: {
            type: 'object',
            properties: {                    
              title: {
                type: 'string'
              },
              weight: {
                type: 'integer',
                format: 'int32'
              },
              created_at: {
                type: 'string',
                format: 'date-time'
              },
              updated_at: {
                type: 'string',
                format: 'date-time'
              }   
            },
            required: ['title', 'weight', 'created_at', 'updated_at']         
          },
          objective: {
            type: 'object',
            properties: {
              data: {
                type: 'object',
                properties: {
                  type: {
                    type: 'string',
                    value: 'objectives'
                  },
                  id: {
                    type: 'integer',
                    format: 'int64'
                  },
                  attributes: {
                    schema: '#/components/schemas/objective_attributes'
                  },
                  required: ['type', 'id', 'attributes']
                }
              }
            }
          },
          objectives: {
            type: 'object',
            properties: {
              data: {
                type: 'array',
                items: {
                  schema: '#/components/schemas/objective'
                }
              }
            }
          },
          errors: {
            type: 'object',
            properties: {
              errors: {
                type: 'array',
                items: {
                  type: 'object',
                  properties: {
                    title: {
                      type: 'string'
                    },
                    detail: {
                      type: 'string'
                    },
                    source: {
                      type: 'object',
                      additionalProperties: {
                        type: 'string'
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end
