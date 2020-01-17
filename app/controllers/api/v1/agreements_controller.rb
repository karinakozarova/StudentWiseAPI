class Api::V1::AgreementsController < ApiController
  before_action :authenticate_user!
  before_action :require_group!
  before_action :set_agreement, only: :show
  before_action :set_agreement_with_creator, only: %i(update destroy)

  def index
    @agreements = Agreement.with_group_of(current_user).all
  end

  def show
  end

  def create
    @agreement = Agreement.new(agreement_params)
    @agreement.creator_id = current_user.id
    @agreement.group_id = current_user.group.id

    @agreement.save!
    render :show, status: :created
  end

  def update
    @agreement.update!(agreement_params)
    render :show, status: :ok
  end

  def destroy
    @agreement.destroy
  end

  private

  def set_agreement
    @agreement = Agreement.with_group_of(current_user).find(params[:id])
  end

  def set_agreement_with_creator
    @agreement = Agreement.with_group_of(current_user).with_creator(current_user).find(params[:id])
  end

  def agreement_params
    params.require(:agreement).permit(:title, :description)
  end
end
