class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :authenticate_user!

  # GET /votes
  # GET /votes.json
  def index
    @items = VoteableItem.all
  end

  # GET /votes/new
  def new
    @vote = Vote.new
    my_votes = Vote.where(:user_id => current_user.id).all
    @item = VoteableItem.where.not(:id => my_votes.map{|v| v.voteable_item_id}).sample
    if @item.nil?
      redirect_to '/', notice: 'No new items to vote on.'
    end
  end

  # get /votes/:id
  # get /votes.json/:id
  def create
    @vote = Vote.new
    @vote.voteable_item = VoteableItem.find(params[:id])
    @vote.user = current_user

    respond_to do |format|
      if @vote.save
        format.html { redirect_to '/', notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.fetch(:vote, {})
    end
end
