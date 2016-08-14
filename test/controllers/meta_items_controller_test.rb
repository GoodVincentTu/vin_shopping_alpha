require 'test_helper'

class MetaItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meta_item = meta_items(:one)
  end

  test "should get index" do
    get meta_items_url
    assert_response :success
  end

  test "should get new" do
    get new_meta_item_url
    assert_response :success
  end

  test "should create meta_item" do
    assert_difference('MetaItem.count') do
      post meta_items_url, params: { meta_item: { name: @meta_item.name, price: @meta_item.price, sku: @meta_item.sku } }
    end

    assert_redirected_to meta_item_url(MetaItem.last)
  end

  test "should show meta_item" do
    get meta_item_url(@meta_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_meta_item_url(@meta_item)
    assert_response :success
  end

  test "should update meta_item" do
    patch meta_item_url(@meta_item), params: { meta_item: { name: @meta_item.name, price: @meta_item.price, sku: @meta_item.sku } }
    assert_redirected_to meta_item_url(@meta_item)
  end

  test "should destroy meta_item" do
    assert_difference('MetaItem.count', -1) do
      delete meta_item_url(@meta_item)
    end

    assert_redirected_to meta_items_url
  end
end
