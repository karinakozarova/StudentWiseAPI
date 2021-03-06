class Api::V1::ExpensesController < ApiController
  before_action :authenticate_user!
  before_action :require_group!
  before_action :set_expense, only: :show
  before_action :set_expense_with_creator, only: %i(update destroy archive unarchive)

  def index
    @expenses = Expense.with_group_of(current_user).all
  end

  def show
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.creator_id = current_user.id
    @expense.group_id = current_user.group.id

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
    @expense = Expense.with_group_of(current_user).find(params[:id] || params[:expense_id])
  end

  def set_expense_with_creator
    @expense = Expense.with_group_of(current_user).with_creator(current_user).find(params[:id] || params[:expense_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :notes, :price, :quantity)
  end
end
