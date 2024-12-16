class GamesController < ActionController::API

  # Captura cada exceção ActiveRecord::RecordNotFound(quando o id não é econtrado no banco de dados) e executa o método `record_not_found` como erro padrão
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    game = Game.create(game_state: Array.new(9, ""), winner: "")
    render json: game, status: :created # Código 201
  end

  def index
    games = Game.all
    render json: games, status: :ok # Código 200
  end

  def show
    game = Game.find(params[:id])
    render json: game, status: :ok # Código 200
  end

  def move
    @game = Game.find(params[:id])
    position = params[:position].to_i
    player = params[:player]

    if @game.game_state[position].blank? && @game.winner.blank?
      @game.game_state[position] = player
      @game.save
      @game.check_winner(player)
      render json: @game, status: :ok # Código 200
    else
      render json: { error: "Invalid move" }, status: :bad_request # Código 400
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    render json: game, status: :ok # Código 200
  end

  def reset
    @game = Game.find(params[:id])

    @game.update(game_state: Array.new(9, ""), winner: "")
    render json: @game, status: :ok # Código 200
  end

  def update
    @game = Game.find(params[:id])

    @game.update(game_params)
    render json: @game, status: :ok # Código 200
  end

  private

  # Define os parâmetros permitidos para o update
  def game_params
    params.require(:game).permit(:winner, game_state: [])
  end

  # Define o erro padrão para o RecordNotFound
  def record_not_found
    render json: { error: "Game not found" }, status: :not_found # Código 404
  end

end
