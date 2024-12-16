# Teste de controladores

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { Game.create(game_state: Array.new(9, "")) }
  
  describe "POST #create" do
    it "creates a new game and returns it with status created(201)" do
      post :create
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET #show" do
    context "when the game exists" do
      it "returns the game with status ok(200)" do
        get :show, params: { id: game.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(game.id)
      end
    end

    context "when the game does not exist" do
      it "returns an error with status not_found(404)" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT #move" do
    context "when the move is valid" do
      it "updates the game with the player's move and returns it with status ok(200)" do
        game.save
        put :move, params: { id: game.id, position: 0, player: "X" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["game_state"][0]).to eq("X")
      end
    end

    context "when the move is invalid" do
      it "returns an error with status bad_request(400)" do
        game.save
        game.game_state[0] = "O"
        game.save
        put :move, params: { id: game.id, position: 0, player: "X" }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
  
  describe "GET #index" do 
    it "returns all games with status ok(200)" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the game and returns it with status ok(200)" do
      game.save
      delete :destroy, params: { id: game.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT #reset" do
    it "resets the game and returns it with status ok(200)" do
      game.save
      put :reset, params: { id: game.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["game_state"]).to eq(Array.new(9, ""))
      expect(JSON.parse(response.body)["winner"]).to eq("")
    end
  end

  describe "PUT #update" do
    it "updates the game and returns it with status ok(200)" do
      game.save
      put :update, params: { id: game.id, game: { winner: "X" } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["winner"]).to eq("X")
    end
  end
end