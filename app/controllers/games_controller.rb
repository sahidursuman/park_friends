class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :login_required, only: [:edit, :update, :new, :create, :destroy]

  def index
    @games = Game.all
  end

  def new
  	@game = Game.new
  end

  # creates new game object from params hash
  def create
  	@game = Game.new(game_params)
  	if @game.save
  		redirect_to @game, :notice => "Congrats! You're hosting a game!"
      # idea: have :notice display include "Now invite some friends!" => as a link to our mailer
  	end
  end

  # update game settings
  def update
    if @game.update(game_params)
      redirect_to :back, :notice => "Game updated."
    else
      redirect_to :back, :notice => "Sorry, unable to update game."
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_path }
      # format.json { head :no_content }
    end
  end

  private
    # finds existing game object in database using params[:id]
    def set_game
    	@game = Game.find(params[:id])
    end

    # sets @user to current_user
    def set_user
      @user = current_user
    end

    # strong params
    def game_params
    	params.require(:game).permit(:description, :date, :time, :game_category, :player_limit, :park_id, :host_id, :additional_info, reservations_attributes: [:player_id, :game_id])
    end

end
