class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i(show update destroy)
  before_action :check_event, only: %i(update destroy)

  def index
    @events = Event.with_participant(current_user).all
  end

  def show
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id

    @event.save!
    render :show, status: :created
  end

  def update
    @event.update!(event_params)
    render :show, status: :ok
  end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.created_by(current_user).find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_type, :title, :description, :starts_at, :finishes_at)
  end

  def check_event
    return unless @event.locked?

    case params[:action].to_sym
    when :update
      event_params.keys.each do |param|
        @event.errors.add(:base, "Parameter '#{param}' is not allowed when event is locked") unless whitelisted_param?(param)
      end
    when :destroy
      @event.errors.add(:base, 'Cannot remove event when it is locked')
    end

    raise ActiveRecord::RecordInvalid.new(@event) if @event.errors.any?
  end

  def whitelisted_param?(param)
    whitelist = %i(title description)

    whitelist.each do |prop|
      return true if param.to_sym == prop
    end
    return false
  end
end
