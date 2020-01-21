class Api::V1::TwoFaController < ApiController
  include TwoFaHelper

  before_action :authenticate_user!, except: :check_challenge
  before_action :set_user
  before_action :require_two_fa!, except: :enable

  def enable
    @user.update!(two_fa_enabled: true, two_fa_secret: generate_two_fa_secret)
    render :show, status: :ok
  end

  def disable
    @user.update!(two_fa_enabled: false, two_fa_secret: nil, two_fa_challenge: nil)
    render :show, status: :ok
  end

  def check_challenge
    if validate_response_for(@user, challenge_params[:response])
      sign_in(@user)
      @user.set_two_fa_challenge!

      render 'api/v1/users/show', status: :ok
    else
      unauthorized_response('Challenge failed')
    end
  end

  private

  def set_user
    @user = current_user
    @user ||= User.find_by(two_fa_challenge: challenge_params[:two_fa_challenge])

    unauthorized_response('Challenge failed') unless @user
  end

  def challenge_params
    params.require(:challenge).permit(:two_fa_challenge, :response)
  end

  def require_two_fa!
    unauthorized_response('You must first enable 2FA to perform this action') unless @user.two_fa_enabled?
  end
end
