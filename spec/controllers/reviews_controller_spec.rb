
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:current_user) { Fabricate(:user) }
  let(:selected_video) { Fabricate(:video) }

  describe 'POST #create' do

    let(:valid_review_attributes) { Fabricate.attributes_for(:review) }
    let(:invalid_review_attributes) { Fabricate.attributes_for(:review, body: '') }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }

      context 'with valid attributes' do

        before { post :create, review: valid_review_attributes, video_id: selected_video.id }

        it 'sets the @video instance variable' do
          expect(assigns(:video)).to eq(selected_video)
        end

        it 'sets the @review instance variable' do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it 'associates the @review instance variable with the @video instance variable' do
          expect(Review.first.video).to eq(selected_video)
        end

        it 'associates the @review instance variable  with the current user' do
          expect(Review.first.author).to eq(current_user)
        end

        it 'creates a review in the database' do
          expect(Review.count).to eq(1)
        end

        it 'redirects the user to the video path' do
          expect(response).to redirect_to video_path(selected_video)
        end
      end

      context 'with invalid attributes' do

        before { post :create, review: invalid_review_attributes, video_id: selected_video.id }

        it 'sets the @video instance variable' do
          expect(assigns(:video)).to eq(selected_video)
        end

        it 'sets the @review instance variable' do
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it 'does not create a review in the database' do
          expect {}.to change {Review.count}.by(0)
        end

        it 'sets the @reviews instance variable' do
          expect(assigns(:reviews)).to match_array(existing_reviews)
        end

        it 'renders to videos/show template' do
          expect(response).to render_template 'videos/show'
        end
      end
    end

    context 'with an unauthenicated user' do

      before { post :create, review: valid_review_attributes, video_id: selected_video.id }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
