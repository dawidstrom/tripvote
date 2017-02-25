class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :authenticate_user!

  # GET /votes
  # GET /votes.json
  def index
    @items_and_votes = []
    VoteableItem.all.each do |i|
      @items_and_votes.push([i, Vote.where(:voteable_item_id => i.id).pluck(:value).reduce(:+)]).sort
    end
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
    unless vote_params[:value].to_d.between?(-1,2)
      return redirect_to '/', notice: "value out of range"
    end

    my_votes = Vote.where(:user_id => current_user.id, :voteable_item_id => vote_params[:id]).first
    @vote = my_votes
    if my_votes.nil?
      @vote = Vote.new
    end
    @vote.voteable_item = VoteableItem.find(vote_params[:id])
    @vote.user = current_user
    @vote.value = vote_params[:value]

    if @vote.save
      if my_votes.nil?
        redirect_to '/', notice: 'Vote was successfully created.'
      else
        redirect_to '/', notice: 'Vote was successfully updated.'
      end
    else
      render :new
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
      params.require(:vote).permit([:value, :id])
    end
end
