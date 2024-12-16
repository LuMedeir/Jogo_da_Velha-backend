# Teste de rotas

require 'rails_helper'

RSpec.describe "Games", type: :routing do
  it "route POST /games to game#create" do 
    expect(post: "/games").to route_to(controller: "games", action: "create")
  end

  it "route GET /games/:id to game#show" do
    expect(get: "/games/1").to route_to(controller: "games", action: "show", id: "1")
  end

  it "route GET /games to game#index" do
    expect(get: "/games").to route_to(controller: "games", action: "index")
  end

  it "route PATCH /games/:id/move to game#move" do
    expect(patch: "/games/1/move").to route_to(controller: "games", action: "move", id: "1")
  end

  it "route DELETE /games/:id to game#destroy" do 
    expect(delete: "/games/1").to route_to(controller: "games", action: "destroy", id: "1")
  end

  it "route PATCH /games/:id/reset to game#reset" do
    expect(patch: "/games/1/reset").to route_to(controller: "games", action: "reset", id: "1")
  end

  it "route PUT /games/:id to game#update" do
    expect(put: "/games/1").to route_to(controller: "games", action: "update", id: "1")
  end
end