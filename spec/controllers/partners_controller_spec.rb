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
    before do
      get 'new'
    end

    it "returns http success" do
      response.should be_success
    end
    it 'should expect partner to be a new Partner' do
      expect(assigns(:partner)).to be_a_new(Partner)
    end
  end

 

  describe "GET 'show'" do
    before do
      @otherdude = Partner.create! valid_attributes
      get :show, :id => @otherdude.id
    end
    it "returns http success" do
      response.should be_success
    end
    it "should assign partner to gotten partner" do
      expect(assigns(:partner)).to eq(@otherdude)
    end
    it "should assign resident to the residents belonging to that partner" do
      expect(assigns(:residents)).to eq(@otherdude.residents)
    end
  end

  describe 'POST create' do
    describe 'successful create' do 
      it 'should save to db' do 
        expect do
          post :create, partner: valid_attributes
        end.to change(Partner, :count).by(1)
      end
      it 'should redirect to partners index' do
        post :create, partner: valid_attributes
        expect(response).to redirect_to partners_path
      end
      end
      describe 'unsuccessful create' do
        let :invalid_attributes do
          {
             org: nil,
             address: nil,
             phone: nil,
             email: nil,
             website: nil
          }
        end
        it 'should not create anything new in the db' do
          expect do
            post :create, partner: invalid_attributes
          end.to_not change(Partner, :count).by(1)
        end
        
        it "should rerender the new template" do
          post :create, partner: invalid_attributes
          expect(response).to render_template :new
        end
      end
    end
  describe 'PUT update' do
    before do
      @partner = Partner.create! valid_attributes
    end
    describe 'successful update' do
      let :update_attributes do
        {
          org: 'red cross',
          address: '34 westminster st',
          phone: 9996754321,
          email: 'destiny@children.com',
          website: 'tlc.com'
        }
      end
      before do
        put :update, id: @partner.id, partner: update_attributes
      end
     
      it "should redirect to the index of all yogurts" do
        expect(response).to redirect_to partners_path
      end
    end
    describe 'with invalid update attributes' do
      let :invalid_update_attributes do
        {
          org: nil,
          address: nil,
          phone: nil,
          email: nil,
          website: nil
        }
      end
      before do
        put :update, id: @partner.id, partner: invalid_update_attributes
      end
      it 'should not update the partner record' do
        expect(@partner.org).to eq('salvation army')
      end
    end
  end

end
