require 'spec_helper'

describe PartnersController do
  let :valid_attributes do
    { 
      org: 'salvation army',
      address: '121 here place',
      phone: 8186754321,
      email: 'calvin@harris.com',
      website: 'imagnoway.com'
    }
  end

  describe "GET 'index'" do
    before do
      @oneguy = Partner.create! valid_attributes
      @otherdude = Partner.create! valid_attributes
      get :index
    end

    it 'returns http success' do
      response.should be_success
    end

    it 'should assign partners to all partners' do
      expect(assigns(:partners)).to include(@oneguy)
      expect(assigns(:partners)).to include(@otherdude)
    end

  end

  describe "GET 'new'" do

    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

 

  describe "GET 'show'" do
    before do
      @otherdude = Partner.create! valid_attributes
    end
    it "returns http success" do
      get :show, :id => @otherdude.id
      response.should be_success
    end
  end

end
