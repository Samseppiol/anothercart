require 'test_helper'

class OrderNotifierMailerTest < ActionMailer::TestCase
  test "recieved" do
    mail = OrderNotifierMailer.recieved(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["cr7thebest@live.com"], mail.to
    assert_equal ["from@example.com"], mail.from
  end

  test "shipped" do
   mail = OrderNotifierMailer.recieved(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["cr7thebest@live.com"], mail.to
    assert_equal ["from@example.com"], mail.from
  end

end
