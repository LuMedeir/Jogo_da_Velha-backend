class GamesController < ActionController::API

  def create
    game = Game.create(game_state: Array.new(9, ""), winner: "")
    render json: game
  end

  def index
    games = Game.all
    render json: games
  end

  def show
    game = Game.find(params[:id])
    render json: game
  end

  def move
    @game = Game.find(params[:id])
    position = params[:position].to_i
    player = params[:player]

    if @game.game_state[position].blank? && @game.winner.blank?
      @game.game_state[position] = player
      @game.save
      @game.check_winner(player) 
    end

    render json: @game
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    render json: game
  end

  def reset
    @game = Game.find(params[:id])

    @game.update(game_state: Array.new(9, ""))  
    @game.update(winner: "")
    render json: @game
  end

  def update
    @game = Game.find(params[:id])

    @game.update(game_params)
    render json: @game

  end

  private

  # Define os parâmetros permitidos para o update
  def game_params
    params.require(:game).permit(:winner, game_state: [])
  end

end
