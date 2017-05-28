require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  include ActiveJob::TestHelper
  test 'buying a product' do 
    LineItem.delete_all 
    Order.delete_all 
    ruby_book = products(:ruby)

    get "/"
    assert_response :success 
    assert_select 'h1', "Catlalog Listings"

    post '/line_items', params: { product_id: ruby_book.id }, xhr: true
    assert_response :success 

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size 
    assert_equal ruby_book, cart.line_items[0].product

    get '/orders/new'
    assert_response :success 
    assert_select 'legend', 'Please enter your details'

    perform_enqueued_jobs do 
      post "/orders", params: {
        order: {
                name: "Ronaldo",
                address: "123 real madrid street",
                email: "cr7thebest@live.com",
                pay_type: "Check"
        }
      }

      follow_redirect! 

      assert_response :success 
      assert_select 'h1', 'Catlalog Listings'
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.size 
    end 

    orders = Order.all
    assert_equal 1, orders.size   
    order = orders[0]

    assert_equal 'Ronaldo', order.name 
    assert_equal '123 real madrid street', order.address 
    assert_equal 'cr7thebest@live.com', order.email 
    assert_equal 'Check', order.pay_type

    assert_equal 1, order.line_items.size 
    line_item = order.line_items[0]
   # assert_equal ruby_book, line_items.product

    # mail = ActionMailer::Base.deliveries.last
    # assert_equal ["cr7thebest@live.com"], mail.to
    # assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    # assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end 
end
