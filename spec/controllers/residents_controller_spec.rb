require 'spec_helper'

describe ResidentsController, :type => :controller do
	before do
	@partneruser = User.create!(role_id: 3, email: 'pineapple@gmail.com', password:'12345678')
	@rcspartner = Partner.create!(org: 'salvation army', address: '121 here place', phone: 8186754321, email: 'calvin@harris.com', website: 'imagnoway.com', user_id: @partneruser.id)
  	end
  	before do 
  		@residentuser = User.create!(role_id: 2, email: 'spongebob@gmail.com', password:'12345678')
    	sign_in @residentuser
  	end
  let :valid_attributes do
    { 
      partner_id: @rcspartner.id,
      user_id: @residentuser.id,
      name: 'Doctor Who',
      bio: 'I live in a blue box.',
      goals: 'Be a good doctor.'
    }
  end

  describe 'GET index' do
  	before do 
  		@gooddoctor = Resident.create! valid_attributes
  		@wardoctor = Resident.create! valid_attributes
  		get :index
  	end
  	it {should respond_with(:success)}
  	it 'should assign residents to all residents' do
      expect(assigns(:residents)).to include(@gooddoctor)
      expect(assigns(:residents)).to include(@wardoctor)
    end
  
  end
  describe 'GET new' do
  	before do
  		get :new
  	end
  	it {should respond_with(:success)}
  	it 'should expect resident to be a new Resident' do
      expect(assigns(:resident)).to be_a_new(Resident)
    end
  end
	
  describe "GET 'show'" do
    before do
      @gooddoctor = Resident.create! valid_attributes
      get :show, :id => @gooddoctor.id
    end
    it "returns http success" do
      response.should be_success
    end
    it "should assign partner to gotten partner" do
      expect(assigns(:resident)).to eq(@gooddoctor)
    end
  end
  describe 'POST create' do
    describe 'successful create' do 
      it 'should save to db' do 
        expect do
          post :create, resident: valid_attributes
        end.to change(Resident, :count).by(1)
      end
      it 'should redirect to residents index' do
        
        post :create, resident: valid_attributes   
        expect(response).to redirect_to residents_path
      end
      end
      describe 'unsuccessful create' do
        let :invalid_attributes do
          {
             name: 'hi',
             bio: nil,
             goals: nil,
          }
        end
        it 'should not create anything new in the db' do
          expect do
            post :create, resident: invalid_attributes
          end.to_not change(Resident, :count)
        end
        
        it "should rerender the new template" do
          post :create, resident: invalid_attributes
          expect(response).to render_template :new
        end
      end
    end
  describe 'PUT update' do
    before do
      @resident = Resident.create! valid_attributes
    end
    describe 'successful update' do
      let :update_attributes do
	    { 
	      partner_id: @rcspartner.id,
	      user_id: @residentuser.id,
	      name: 'The Master',
	      bio: 'I dont even have a box.',
	      goals: 'To get a blue box.'
	    }
      end
      before do
        put :update, id: @resident.id, resident: update_attributes
      end
     
      it "should redirect to the index of all residents" do
        expect(response).to redirect_to residents_path
      end
      it 'should update the resident record' do
        expect(@resident.reload.name).to eq('The Master')
      end
    end
    describe 'with invalid update attributes' do
      let :invalid_update_attributes do
	    { 
	      partner_id: @rcspartner.id,
	      user_id: @residentuser.id,
	      name: nil,
	      bio: nil,
	      goals: nil
	    }
      end
      before do
        put :update, id: @resident.id, resident: invalid_update_attributes
      end
      it 'should not update the resident record' do
        expect(@resident.name).to eq('Doctor Who')
      end
    end
  end

  

end
