class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order,pay_type_params)
    order.charge!(pay_type_params)
    # Do something later
  end
end
