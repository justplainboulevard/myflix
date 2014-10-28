
class UserSignup

  attr_reader :error_message

  def initialize(user)

    @user = user
  end

  def sign_up(stripe_token, invitation_token)

    if @user.valid?
      charge = charge_card(stripe_token)
      if charge.successful?
        @user.save
        handle_invitation(invitation_token)
        UserMailer.delay.welcome_email(@user)
        @status = :success
        self
      else
        @status = :failed
        @error_message = charge.error_message
        self
      end
    else
      @status = :failed
      @error_message = 'You provided invalid information. Please check the errors noted below.'
      self
    end
  end

  def successful?

    @status == :success
  end

private

  def handle_invitation(invitation_token)

    if invitation_token.present?
      invitation = Invitation.where(token: invitation_token).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

  def charge_card(stripe_token)

    StripeWrapper::Charge.create(
        amount: 999,
        card: stripe_token,
        description: "MyFlix subscription charge for #{@user.email_address}"
      )
  end
end
