require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user1) { User.create(first_name: 'John', last_name: 'Doe') }
  let!(:user2) { User.create(first_name: 'Jane', last_name: 'Doe') }

  render_views

  describe 'GET #index' do
    context 'with filter params' do
      before do
        get :index, params: { user: { first_name: 'John' } }
      end

      it 'filters data based on the params' do
        expect(response.body).to include(user1.first_name)
        expect(response.body).not_to include(user2.first_name)
      end
    end

    context 'with empty filter params' do
      before do
        get :index, params: { user: {} }
      end

      it 'returns all records when params are blank' do
        expect(response.body).to include(user1.first_name, user2.first_name)
      end
    end
  end
end