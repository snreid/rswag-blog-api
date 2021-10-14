require 'rails_helper'

RSpec.configure do |config|

  # There is a bug in RSwag where the response schema is being outputted
  # incorrectly, causing it to be inaccessible in the UI and invalid
  # in the YML artifact. This workaround ensures that both the response schema and
  # the response example are properly situated.
  # See: https://github.com/rswag/rswag/issues/268
  config.after do |example|
    # if there's no response metadata, we can assume we're not in RSwag territory
    next if example.metadata.dig(:operation, :produces).blank?

    example.metadata[:response][:content] = {
      example.metadata[:operation][:produces].first => {
        **rswag_schema(example),
        **rswag_response_example(example, response)
      }
    }
  end

  def rswag_schema(example)
    return {} if example.metadata.dig(:response, :schema).blank?

    { schema: example.metadata.dig(:response, :schema) }
  end

  def rswag_response_example(example, response)
    return {} unless example.metadata[:document_response].present? && response&.body.present?

    { example: JSON.parse(response.body, symbolize_names: true) }
  end

  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'Rswag Blog API'
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }
end
