require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
  mail = ActionMailer::Base.deliveries.last
  assert_equal ["virginia@iberojapan.com"],          mail.to
  assert_equal 'Sam Ruby <virginia@iberojapan.com>', mail[:from].value
  assert_equal "Pragmatic Store Order Confirmation", mail.subject
  
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Pay type", with: @order.pay_type
    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Pay type", with: @order.pay_type
    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "check routing number" do
    LineItem.delete_all
    Order.delete_all
    visit store_index_url
    click_on 'Add to cart', match: :first
    click_on 'Checkout'
    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector "order_routing_number"
    select 'Check', from: 'Pay type'
    assert_selector "#order_routing_number"
    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987654"
  end

  perform_enqueued_jobs do
   click_button "Place Order"
  end

  orders = Order.all
  assert_equal 1, orders.size

  order = orders.first

  assert_equal "Dave Thomas", order.name
  assert_equal "123 Main Street", order.address
  assert_equal "virginia@iberojapan.com", order.email
  assert_equal "Check", order.pay_type
  assert_equal 1, order.line_items.size

end
