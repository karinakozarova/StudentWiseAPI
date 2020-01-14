class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i(show)
  before_action :set_expense_with_creator, only: %i(update destroy archive unarchive)

  def index
    @expenses = Expense.all
  end

  def show
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.creator_id = current_user.id

    @expense.save!
    render :show, status: :created
  end

  def update
    @expense.update!(expense_params)
    render :show, status: :ok
  end

  def destroy
    @expense.destroy
  end

  def archive
    @expense.update!(archived: true)
    render :archive, status: :ok
  end

  def unarchive
    @expense.update!(archived: false)
    render :archive, status: :ok
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_expense_with_creator
    @expense = Expense.with_creator(current_user).find(params[:id] || params[:expense_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :notes, :price, :amount)
  end
end
