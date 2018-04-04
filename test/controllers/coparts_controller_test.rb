require 'test_helper'

class CopartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @copart = coparts(:one)
  end

  test "should get index" do
    get coparts_url
    assert_response :success
  end

  test "should get new" do
    get new_copart_url
    assert_response :success
  end

  test "should create copart" do
    assert_difference('Copart.count') do
      post coparts_url, params: { copart: { lot_img_fld: @copart.lot_img_fld, lot_n: @copart.lot_n, record_status: @copart.record_status, row_hash: @copart.row_hash } }
    end

    assert_redirected_to copart_url(Copart.last)
  end

  test "should show copart" do
    get copart_url(@copart)
    assert_response :success
  end

  test "should get edit" do
    get edit_copart_url(@copart)
    assert_response :success
  end

  test "should update copart" do
    patch copart_url(@copart), params: { copart: { lot_img_fld: @copart.lot_img_fld, lot_n: @copart.lot_n, record_status: @copart.record_status, row_hash: @copart.row_hash } }
    assert_redirected_to copart_url(@copart)
  end

  test "should destroy copart" do
    assert_difference('Copart.count', -1) do
      delete copart_url(@copart)
    end

    assert_redirected_to coparts_url
  end
end
