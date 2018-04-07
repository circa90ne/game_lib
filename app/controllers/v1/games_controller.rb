module V1
  class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    # GET /games
    # GET /games.json
    def index
      @games = Game.all
    end

    # GET /games/1
    # GET /games/1.json
    def show
    end

    # GET /games/new
    def new
      @game = Game.new
    end

    # GET /games/1/edit
    def edit
    end

    # POST /games
    # POST /games.json
    def create
      @game = Game.new(game_params)

      respond_to do |format|
        if @game.save
          format.html { redirect_to @game, notice: 'Game was successfully created.' }
          format.json { render :show, status: :created, location: @game }
        else
          format.html { render :new }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /games/1
    # PATCH/PUT /games/1.json
    def update
      respond_to do |format|
        if @game.update(game_params)
          format.html { redirect_to @game, notice: 'Game was successfully updated.' }
          format.json { render :show, status: :ok, location: @game }
        else
          format.html { render :edit }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /games/1
    # DELETE /games/1.json
    def destroy
      @game.destroy
      respond_to do |format|
        format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    # Only get the games for the desired category
    def find_by_category
      @games = Game.where(category_id: params[:category_id])

      render :index
    end

    # Search games based on title & category
    def search
      category_id = params[:category_id]

      if category_id.blank?
        @games = Game.where("title like ?", "%#{params[:title]}%")
      else
        @games = Game.where("title like ? AND category_id = ?", "%#{params[:title]}%", category_id)
      end

      render :index
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_game
        @game = Game.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def game_params
        params.require(:game).permit(:category_id, :title, :description, :author, :status)
      end
  end
end
