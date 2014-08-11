
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe 'POST #create' do

    set_video

    it_behaves_like 'requires user' do
      let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
    end

    before :each do
      set_current_user
    end

    context 'with valid attributes' do

      let(:valid_review_attributes) { Fabricate.attributes_for(:review) }

      it 'creates a review in the database' do
        expect { post :create, review: valid_review_attributes, video_id: video.id }.to change { Review.count }.by(1)
      end

      before :each do
        post :create, review: valid_review_attributes, video_id: video.id
      end

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to eq(video)
      end

      it 'sets the @review instance variable' do
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'associates the @review instance variable with the @video instance variable' do
        expect(Review.last.video).to eq(video)
      end

      it 'associates the @review instance variable with the current user' do
        expect(Review.last.author).to eq(current_user)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects the user to the video path' do
        expect(response).to redirect_to video_path(video)
      end
    end

    context 'with invalid attributes' do

      let(:invalid_review_attributes) { Fabricate.attributes_for(:review, body: '') }

      it 'does not create a review in the database' do
        expect { post :create, review: invalid_review_attributes, video_id: video.id }.to change { Review.count }.by(0)
      end

      before :each do
        post :create, review: invalid_review_attributes, video_id: video.id
      end

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to eq(video)
      end

      it 'sets the @review instance variable' do
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'sets the @reviews instance variable' do
        expect(assigns(:reviews)).to match_array(video.reviews.reload)
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
end
