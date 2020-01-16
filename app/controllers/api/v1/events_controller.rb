class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i(show)
  before_action :set_event_with_creator, only: %i(update destroy)
  before_action :set_event_with_participant, only: %i(mark_as_finished unmark_as_finished)
  before_action :check_event, only: %i(update destroy mark_as_finished unmark_as_finished)

  def index
    @events = Event.all
  end

  def show
  end

  def create
    @event = Event.new(event_params)
    @event.status = :pending
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

  def mark_as_finished
    @event.update!(status: :marked_as_finished)
    render :mark, status: :ok
  end

  def unmark_as_finished
    @event.update!(status: :pending)
    render :mark, status: :ok
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_event_with_creator
    @event = Event.with_creator(current_user).find(params[:id])
  end

  def set_event_with_participant
    @event = Event.with_participant(current_user).find(params[:event_id])
  end

  def event_params
    params.require(:event).permit(:kind, :title, :description, :starts_at, :finishes_at)
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
    when :mark_as_finished
      @event.errors.add(:base, 'Cannot mark event as finished when it is locked')
    when :unmark_as_finished
      @event.errors.add(:base, 'Cannot unmark event as finished when it is locked')
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
