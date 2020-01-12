class Api::V1::ExpenseParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense
  before_action :set_expense_participant, only: :destroy

  def create
    @expense_participant = ExpenseParticipant.new(expense_participant_params)
    @expense_participant.expense_id = @expense.id

    @expense_participant.save!
    render :show, status: :created
  end

  def destroy
    @expense_participant.destroy
  end

  private

  def set_expense
    @expense = Expense.with_creator(current_user).find(params[:expense_id])
  end

  def set_expense_participant
    @expense_participant = ExpenseParticipant.find_by!(expense_id: @expense.id, participant_id: expense_participant_params[:participant_id])
  end

  def expense_participant_params
    params.require(:expense_participant).permit(:participant_id)
  end
end
