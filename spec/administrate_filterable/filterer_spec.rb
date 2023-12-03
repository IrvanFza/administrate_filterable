require 'rails_helper'

RSpec.describe AdministrateFilterable::Filterer, type: :controller do
  controller(Admin::UsersController) do
    include AdministrateFilterable::Filterer
    def resource_class
      User
    end
  end

  let!(:user1) { User.create(first_name: 'John', last_name: 'Doe') }
  let!(:user2) { User.create(first_name: 'Jane', last_name: 'Doe') }

  let(:scoped_resources) { User.all }

  before(:each) do
    allow(User).to receive(:default_scoped).and_return(scoped_resources)
    allow(controller).to receive(:resource_name).and_return('user')
  end

  # Clean up the database
  after(:each) do
    User.delete_all
  end

  describe "#filterable" do
    it 'calls filtered_resources method with default scoped resources' do
      expect(controller.class).to receive(:define_method).with(:scoped_resource)
      controller.class.filterable
    end
  end

  describe "#filtered_resources" do
    context "when filter_params is blank" do
      before do
        allow(controller).to receive(:params).and_return({ 'user' => nil })
      end

      it "returns scoped resources" do
        expect(controller.filtered_resources(scoped_resources)).to eq(scoped_resources)
      end
    end

    context "when a column exists and its associated value is present" do
      let(:params) { { 'user' => { 'first_name' => 'John' } } }

      before do
        allow(controller).to receive(:params).and_return(params)
      end

      it 'filters resources based on the filter params' do
        filter_result = controller.filtered_resources(scoped_resources)
        expect(filter_result.to_a).to eq([user1]) # we only expect to see user1 in the filtered results
      end
    end

    context 'when params contains non-existing column or null values' do
      let(:params) { { 'user' => { 'invalid_column' => 'Ruby', 'first_name' => nil } } }

      before do
        allow(controller).to receive(:params).and_return(params)
      end

      it 'does not filter the resources based on invalid column or null value' do
        filter_result = controller.filtered_resources(scoped_resources)
        expect(filter_result).to eq(scoped_resources)
      end
    end
  end
end