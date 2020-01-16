class Api::V1::ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_complaint, only: %i(show update destroy)

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

  private

  def set_complaint
    @complaint = Complaint.with_creator(current_user).find(params[:id])
  end

  def complaint_params
    params.require(:complaint).permit(:title, :description)
  end
end
