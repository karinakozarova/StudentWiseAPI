class V1::ExpensePresenter < ApplicationPresenter
  include ActionView::Helpers::NumberHelper

  presents :expense

  def price
    number_with_precision(expense.price, precision: 2, separator: '.')
  end

  def archived_changed?
    expense.archived_previously_changed?
  end
end
