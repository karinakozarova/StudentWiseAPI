class Api::V1::EventVotesController < ApiController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_event_vote, only: %i(update destroy)
  before_action :check_event

  def create
    @event_vote = EventVote.new(event_vote_params)
    @event_vote.event_id = @event.id
    @event_vote.voter_id = current_user.id

    @event_vote.save!
    render :show, status: :created
  end

  def update
    @event_vote.update!(event_vote_params)
    render :show, status: :ok
  end

  def destroy
    @event_vote.destroy
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_vote
    @event_vote = EventVote.find_by!(event_id: @event.id, voter_id: current_user.id)
  end

  def event_vote_params
    params.require(:event_vote).permit(:finished)
  end

  def check_event
    @event.errors.add(:kind, "'#{@event.kind}' is not subject to voting") unless @event.votable?
    @event.errors.add(:status, 'does not accept votes right now') unless @event.in_review?
    @event.errors.add(:event_id, 'cannot vote for event you participate in') if @event.participants.include?(current_user)

    raise ActiveRecord::RecordInvalid.new(@event) if @event.errors.any?
  end
end
