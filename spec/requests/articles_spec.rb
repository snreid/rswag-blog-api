require 'swagger_helper'

RSpec.describe 'articles', type: :request, document_response: true do

  path '/articles' do
    get('list articles') do
      produces "application/json"
      let!(:article) { create(:article) }

      response(200, 'successful') do
        run_test! do |response|
          response = JSON.parse(response.body)
          expect(response.first["id"]).to eq(article.id)
          expect(response.first["title"]).to eq(article.title)
        end
      end
    end

    post('create article') do
      consumes "application/json"
      produces "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          article: {
            type: :object,
            properties: {
              author: { type: :string },
              title: { type: :string },
              body: { type: :string }
            }
          }
        } 
      }

      response(201, 'successful') do
        let(:params) do
          {
            article: {
              author: "Test Author",
              title: "Title",
              body: "Lorem Ipsum Body."
            }
          }
        end
        run_test!
      end
    end
  end

  path '/articles/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show article') do
      produces "application/json"
      let!(:article) { create(:article) }

      response(200, 'successful') do
        let(:id) { article.id }

        run_test!
      end
    end

    patch('update article') do
      consumes "application/json"
      produces "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          article: {
            type: :object,
            properties: {
              author: { type: :string },
              title: { type: :string },
              body: { type: :string }
            }
          }
        },  
      }

      let!(:article) { create(:article) }
      response(200, 'successful') do
        let(:id) { article.id }
        let(:params) do
          {
            article: {
              title: "Title"
            }
          }
        end

        run_test!
      end
    end

    put('update article') do
      consumes "application/json"
      produces "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          article: {
            type: :object,
            properties: {
              author: { type: :string },
              title: { type: :string },
              body: { type: :string }
            }
          }
        },  
      }


      let!(:article) { create(:article) }
      response(200, 'successful') do
        let(:id) { article.id }
        let(:params) do
          {
            article: {
              title: "Title"
            }
          }
        end

        run_test!
      end
    end

    delete('delete article') do
      produces "application/json"
      let!(:article) { create(:article) }
      let(:id) { article.id }

      response(204, 'no content') do
        run_test!
      end
    end
  end
end
