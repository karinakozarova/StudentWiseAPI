class Api::V1::ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, only: %i(mark_as_in_progress mark_as_rejected mark_as_resolved)
  before_action :set_complaint, only: %i(mark_as_in_progress mark_as_rejected mark_as_resolved)
  before_action :set_complaint_with_creator, only: %i(show update destroy)
  before_action :check_complaint, only: %i(update destroy)

  def index
    @complaints = Complaint.with_creator(current_user).all
    @complaints.map(&:change_sent_to_received!) if current_user.admin?
  end

  def show
    @complaint.change_sent_to_received! if current_user.admin?
  end

  def create
    @complaint = Complaint.new(complaint_params)
    @complaint.status = :sent
    @complaint.creator_id = current_user.id

    @complaint.save!
    render :show, status: :created
  end

  def update
    @complaint.update!(complaint_params)
    render :show, status: :ok
  end

  def destroy
    @complaint.destroy
  end

  def mark_as_in_progress
    @complaint.update!(status: :in_progress)
    render :mark, status: :ok
  end

  def mark_as_rejected
    @complaint.update!(status: :rejected)
    render :mark, status: :ok
  end

  def mark_as_resolved
    @complaint.update!(status: :resolved)
    render :mark, status: :ok
  end

  private

  def set_complaint
    @complaint = Complaint.find(params[:id] || params[:complaint_id])
  end

  def set_complaint_with_creator
    @complaint = Complaint.with_creator(current_user).find(params[:id] || params[:complaint_id])
  end

  def complaint_params
    params.require(:complaint).permit(:title, :description)
  end

  def check_complaint
    return if current_user.admin? || !@complaint.locked?

    case params[:action].to_sym
    when :update
      complaint_params.keys.each do |param|
        @complaint.errors.add(:base, "Parameter '#{param}' is not allowed when complaint is locked") unless whitelisted_param?(param)
      end
    when :destroy
      @complaint.errors.add(:base, 'Cannot remove complaint when it is locked')
    end

    raise ActiveRecord::RecordInvalid.new(@complaint) if @complaint.errors.any?
  end

  def whitelisted_param?(param)
    whitelist = %i(title)

    whitelist.each do |prop|
      return true if param.to_sym == prop
    end
    return false
  end
end
