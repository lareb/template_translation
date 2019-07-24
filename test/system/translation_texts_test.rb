require "application_system_test_case"

class TranslationTextsTest < ApplicationSystemTestCase
  setup do
    @translation_text = translation_texts(:one)
  end

  test "visiting the index" do
    visit translation_texts_url
    assert_selector "h1", text: "Translation Texts"
  end

  test "creating a Translation text" do
    visit translation_texts_url
    click_on "New Translation Text"

    fill_in "Key value", with: @translation_text.key_value
    fill_in "Local", with: @translation_text.local
    fill_in "Template", with: @translation_text.template_id
    click_on "Create Translation text"

    assert_text "Translation text was successfully created"
    click_on "Back"
  end

  test "updating a Translation text" do
    visit translation_texts_url
    click_on "Edit", match: :first

    fill_in "Key value", with: @translation_text.key_value
    fill_in "Local", with: @translation_text.local
    fill_in "Template", with: @translation_text.template_id
    click_on "Update Translation text"

    assert_text "Translation text was successfully updated"
    click_on "Back"
  end

  test "destroying a Translation text" do
    visit translation_texts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Translation text was successfully destroyed"
  end
end
