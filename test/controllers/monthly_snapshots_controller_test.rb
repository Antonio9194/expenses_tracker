require "test_helper"

class MonthlySnapshotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get monthly_snapshots_index_url
    assert_response :success
  end

  test "should get new" do
    get monthly_snapshots_new_url
    assert_response :success
  end

  test "should get create" do
    get monthly_snapshots_create_url
    assert_response :success
  end
end
