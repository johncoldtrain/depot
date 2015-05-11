require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

# ------  #INDEX ------
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

# ------  #NEW  ------
  test "should get new" do
    get :new
    assert_response :success
  end


# ------ #CREATE ------
  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to root_path
  end

  # responding to ajax
  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, product_id: products(:ruby).id
    end
    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 2.2/
    end
  end



# ------  #SHOW  ------
  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

# ------  #EDIT  ------
  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

# ------  #UPDATE  ------
  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

# ------  #DESTROY  ------
  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end
end
