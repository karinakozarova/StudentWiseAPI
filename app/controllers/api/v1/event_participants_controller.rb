class Api::V1::EventParticipantsController < ApiController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_event_participant, only: :destroy

  def create
    @event_participant = EventParticipant.new(event_participant_params)
    @event_participant.event_id = @event.id

    @event_participant.save!
    render :show, status: :created
  end

  def destroy
    @event_participant.destroy
  end

  private

  def set_event
    @event = Event.with_creator(current_user).find(params[:event_id])
  end

  def set_event_participant
    @event_participant = EventParticipant.find_by!(event_id: @event.id, participant_id: event_participant_params[:participant_id])
  end

  def event_participant_params
    params.require(:event_participant).permit(:participant_id)
  end
end
