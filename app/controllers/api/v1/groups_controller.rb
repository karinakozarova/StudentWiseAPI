class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :require_admin!, only: %i(create update destroy)
  before_action :set_group, only: %i(show update destroy)
  before_action :check_group, only: %i(update destroy)

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

  def check_group
    return unless @group.is_default?

    case params[:action].to_sym
    when :update
      group_params.keys.each do |param|
        @group.errors.add(:base, "Parameter '#{param}' is not allowed for default group") unless whitelisted_param?(param)
      end
    when :destroy
      @group.errors.add(:base, 'Cannot remove default group')
    end

    raise ActiveRecord::RecordInvalid.new(@group) if @group.errors.any?
  end
end

def whitelisted_param?(param)
  whitelist = %i(description rules)

  whitelist.each do |prop|
    return true if param.to_sym == prop
  end
  return false
end
