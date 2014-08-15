require 'rails_helper'

describe TimetracksController, type: :controller do
  let(:user) {Fabricate(:user)}

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'sets @date to Date.today' do
      get :index
      expect(assigns(:date)).to eq Date.today
    end

    it 'loads all dates for current month into @month' do
      get :index
      expect(assigns(:month)).to eq (Date.today.beginning_of_month..Date.today.end_of_month).to_a
    end

    it 'loads all timetracks into @timetracks' do
      get :index
      expect(assigns(:timetracks)).to match_array(user.timetracks)
    end
  end
end
