require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  context 'not logged in' do

    let(:my_wiki) { create(:wiki)}

    describe "GET #show" do
      subject { get :show, params: { id: my_wiki.id } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders show wiki" do
        expect(subject).to render_template("show")
      end

    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { id: my_wiki.id  }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in?' do

    describe "#create" do

      it "assigns the new wiki to @wiki" do
        expect(create(:wiki, user: build(:user))).to eq Wiki.last
      end
    end

    describe "#delete" do

    end
  end

end
