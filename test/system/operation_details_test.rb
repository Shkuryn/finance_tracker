require "application_system_test_case"

class OperationDetailsTest < ApplicationSystemTestCase
  setup do
    @operation_detail = operation_details(:one)
  end

  test "visiting the index" do
    visit operation_details_url
    assert_selector "h1", text: "Operation Details"
  end

  test "creating a Operation detail" do
    visit operation_details_url
    click_on "New Operation Detail"

    click_on "Create Operation detail"

    assert_text "Operation detail was successfully created"
    click_on "Back"
  end

  test "updating a Operation detail" do
    visit operation_details_url
    click_on "Edit", match: :first

    click_on "Update Operation detail"

    assert_text "Operation detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Operation detail" do
    visit operation_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Operation detail was successfully destroyed"
  end
end
