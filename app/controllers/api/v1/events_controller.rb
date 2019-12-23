class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i(show update destroy)

  def index
    @events = Event.all
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
    head :ok if @event.destroyed?
  end

  private

  def set_event
    @event = Event.created_by(current_user).find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_type, :title, :description, :starts_at, :finishes_at)
  end
end
