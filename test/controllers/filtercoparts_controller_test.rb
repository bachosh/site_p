require 'test_helper'

class FiltercopartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filtercopart = filtercoparts(:one)
  end

  test "should get index" do
    get filtercoparts_url
    assert_response :success
  end

  test "should get new" do
    get new_filtercopart_url
    assert_response :success
  end

  test "should create filtercopart" do
    assert_difference('Filtercopart.count') do
      post filtercoparts_url, params: { filtercopart: { buy_it_now_price: @filtercopart.buy_it_now_price, damage_description: @filtercopart.damage_description, drive: @filtercopart.drive, engine: @filtercopart.engine, fuel_type: @filtercopart.fuel_type, location_city: @filtercopart.location_city, lot_cond: @filtercopart.lot_cond, make: @filtercopart.make, model_detail: @filtercopart.model_detail, model_group: @filtercopart.model_group, odometer: @filtercopart.odometer, record_status: @filtercopart.record_status, runs_drives: @filtercopart.runs_drives, transmission: @filtercopart.transmission, vechile_type: @filtercopart.vechile_type, year: @filtercopart.year } }
    end

    assert_redirected_to filtercopart_url(Filtercopart.last)
  end

  test "should show filtercopart" do
    get filtercopart_url(@filtercopart)
    assert_response :success
  end

  test "should get edit" do
    get edit_filtercopart_url(@filtercopart)
    assert_response :success
  end

  test "should update filtercopart" do
    patch filtercopart_url(@filtercopart), params: { filtercopart: { buy_it_now_price: @filtercopart.buy_it_now_price, damage_description: @filtercopart.damage_description, drive: @filtercopart.drive, engine: @filtercopart.engine, fuel_type: @filtercopart.fuel_type, location_city: @filtercopart.location_city, lot_cond: @filtercopart.lot_cond, make: @filtercopart.make, model_detail: @filtercopart.model_detail, model_group: @filtercopart.model_group, odometer: @filtercopart.odometer, record_status: @filtercopart.record_status, runs_drives: @filtercopart.runs_drives, transmission: @filtercopart.transmission, vechile_type: @filtercopart.vechile_type, year: @filtercopart.year } }
    assert_redirected_to filtercopart_url(@filtercopart)
  end

  test "should destroy filtercopart" do
    assert_difference('Filtercopart.count', -1) do
      delete filtercopart_url(@filtercopart)
    end

    assert_redirected_to filtercoparts_url
  end
end
