# frozen_string_literal: true

require 'test_helper'

class OperationDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation_detail = operation_details(:one)
  end

  test 'should get index' do
    get operation_details_url
    assert_response :success
  end

  test 'should get new' do
    get new_operation_detail_url
    assert_response :success
  end

  test 'should create operation_detail' do
    assert_difference('OperationDetail.count') do
      post operation_details_url, params: { operation_detail: {} }
    end

    assert_redirected_to operation_detail_url(OperationDetail.last)
  end

  test 'should show operation_detail' do
    get operation_detail_url(@operation_detail)
    assert_response :success
  end

  test 'should get edit' do
    get edit_operation_detail_url(@operation_detail)
    assert_response :success
  end

  test 'should update operation_detail' do
    patch operation_detail_url(@operation_detail), params: { operation_detail: {} }
    assert_redirected_to operation_detail_url(@operation_detail)
  end

  test 'should destroy operation_detail' do
    assert_difference('OperationDetail.count', -1) do
      delete operation_detail_url(@operation_detail)
    end

    assert_redirected_to operation_details_url
  end
end
