
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:current_user) { Fabricate(:user) }
  let(:selected_video) { Fabricate(:video) do
    reviews { 3.times.map { Fabricate(:review) } }
    end }

  describe 'POST #create' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
      end

      context 'with valid attributes' do

        let(:valid_review_attributes) { Fabricate.attributes_for(:review) }

        it 'creates a review in the database' do
          expect { post :create, review: valid_review_attributes, video_id: selected_video.id }.to change { Review.count }.by(1)
        end

        before :each do
          post :create, review: valid_review_attributes, video_id: selected_video.id
        end

        it 'sets the @video instance variable' do
          expect(assigns(:video)).to eq(selected_video)
        end

        it 'sets the @review instance variable' do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it 'associates the @review instance variable with the @video instance variable' do
          expect(Review.last.video).to eq(selected_video)
        end

        it 'associates the @review instance variable with the current user' do
          expect(Review.last.author).to eq(current_user)
        end

        it 'flashes a success alert' do
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects the user to the video path' do
          expect(response).to redirect_to video_path(selected_video)
        end
      end

      context 'with invalid attributes' do

        let(:invalid_review_attributes) { Fabricate.attributes_for(:review, body: '') }

        it 'does not create a review in the database' do
          expect { post :create, review: invalid_review_attributes, video_id: selected_video.id }.to change { Review.count }.by(0)
        end

        before :each do
          post :create, review: invalid_review_attributes, video_id: selected_video.id
        end

        it 'sets the @video instance variable' do
          expect(assigns(:video)).to eq(selected_video)
        end

        it 'sets the @review instance variable' do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it 'sets the @reviews instance variable' do
          expect(assigns(:reviews)).to match_array(selected_video.reviews.reload)
        end

        it 'flashes a danger alert' do
          expect(flash[:danger]).not_to be_blank
        end

        it 'renders to videos/show template' do
          expect(response).to render_template 'videos/show'
        end

        it 'responds with an HTTP 200 status code' do
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'with an unauthenicated user' do

      let(:valid_review_attributes) { Fabricate.attributes_for(:review) }

      before :each do
        post :create, review: valid_review_attributes, video_id: selected_video.id
      end

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
