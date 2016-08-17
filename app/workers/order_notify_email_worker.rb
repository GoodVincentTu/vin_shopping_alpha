class OrderNotifyEmailWorker
  include Sidekiq::Worker

  # class << self
  # 	def order_confirmation_send_later(order)
  # 		OrderMailer.order_confirmation(order).deliver_later
  # 	end

  # 	def state_changed_send_later(order, previous_state)
  # 		OrderMailer.state_changed(order, previous_state).deliver_later
  # 	end
  # end

  def perform(order, previous_state="nil")
  	@order = order
  	@previous_state = previous_state
  	if @previous_state == "nil"
  		order_confirmation_send_later(@order)
  	else
  		state_changed_send_later(@order, @previous_state)
  	end
  end

  def order_confirmation_send_later(order)
  	OrderMailer.order_confirmation(order).deliver_later
  end

  def state_changed_send_later(order, previous_state)
  	OrderMailer.state_changed(order, previous_state).deliver_later
  end
end
