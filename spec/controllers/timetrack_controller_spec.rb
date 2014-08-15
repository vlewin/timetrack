require 'rails_helper'

describe TimetracksController, type: :controller do
  let(:user) { Fabricate(:user) }
  let(:timetrack) { user.timetracks.last }
  let(:new_timetrack) { Fabricate.build(:timetrack, date: '2000-01-01') }

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

  describe 'POST #create' do
    it 'saves the new timetrack in the database and redirects to the index page' do
      timetracks_count = user.timetracks.count

      post :create, { timetrack: new_timetrack.attributes }

      expect(user.timetracks.count).to eq(timetracks_count+1)
      expect(response).to redirect_to(timetracks_path(date: new_timetrack.date))
    end

    it 'redirects to the index page with an error if save fails' do
    end
  end

  describe 'PUT/PATCH #update' do
    it 'updates the existing timetrack and redirects to the index page' do
      finish = timetrack.finish.to_time + 10.minutes

      put :update, id: timetrack, timetrack: { finish: finish }

      expect(timetrack.reload.finish).to eq(finish)
      expect(response).to redirect_to(timetracks_path(date: timetrack.date))
    end

    it 'redirects to the index page with an error if update fails' do
    end
  end

end
