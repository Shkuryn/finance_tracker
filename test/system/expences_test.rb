require "application_system_test_case"

class ExpencesTest < ApplicationSystemTestCase
  setup do
    @expence = expences(:one)
  end

  test "visiting the index" do
    visit expences_url
    assert_selector "h1", text: "Expences"
  end

  test "creating a Expence" do
    visit expences_url
    click_on "New Expence"

    click_on "Create Expence"

    assert_text "Expence was successfully created"
    click_on "Back"
  end

  test "updating a Expence" do
    visit expences_url
    click_on "Edit", match: :first

    click_on "Update Expence"

    assert_text "Expence was successfully updated"
    click_on "Back"
  end

  test "destroying a Expence" do
    visit expences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expence was successfully destroyed"
  end
end
