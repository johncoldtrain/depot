require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  # ------  #INDEX ------
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  # ------  #NEW  ------
  test "requires items in cart" do
    get :new
    assert_redirected_to root_path
    assert_equal flash[:notice], 'Your cart is empty'
  end

  test "should get new" do
    #Setup items in cart
    item = LineItem.new
    item.build_cart
    item.product = products(:ruby)
    item.save!
    session[:cart_id] = item.cart.id

    get :new
    assert_response :success
  end

  # ------ #CREATE ------
  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end

    assert_redirected_to root_path(assigns(:order))
  end

  # ------  #SHOW  ------
  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  # ------  #EDIT  ------
  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  # ------  #UPDATE  ------
  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    assert_redirected_to order_path(assigns(:order))
  end

  # ------  #DESTROY  ------
  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
