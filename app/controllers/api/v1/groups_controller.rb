class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :require_admin!, only: %i(create update destroy)
  before_action :set_group, only: %i(show update destroy)

  def index
    @groups = Group.all
  end

  def show
  end

  def create
    @group = Group.new(group_params)

    @group.save!
    render :show, status: :created
  end

  def update
    @group.update!(group_params)
    render :show, status: :ok
  end

  def destroy
    @group.destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :rules)
  end
end
