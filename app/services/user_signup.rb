
class UserSignup

  attr_reader :error_message

  def initialize(user)

    @user = user
  end

  def sign_up(stripe_token, invitation_token)

    if @user.valid?
      customer = create_customer(stripe_token)
      if customer.successful?
        @user.customer_token = customer.customer_token
        @user.save
        handle_invitation(invitation_token)
        UserMailer.delay.welcome_email(@user)
        @status = :success
        self
      else
        @status = :failed
        @error_message = customer.error_message
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

  def create_customer(stripe_token)

    StripeWrapper::Customer.create(
        user: @user,
        card: stripe_token
      )
  end
end
