require 'test_helper'

class TranslationTextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @translation_text = translation_texts(:one)
  end

  test "should get index" do
    get translation_texts_url
    assert_response :success
  end

  test "should get new" do
    get new_translation_text_url
    assert_response :success
  end

  test "should create translation_text" do
    assert_difference('TranslationText.count') do
      post translation_texts_url, params: { translation_text: { key_value: @translation_text.key_value, local: @translation_text.local, template_id: @translation_text.template_id } }
    end

    assert_redirected_to translation_text_url(TranslationText.last)
  end

  test "should show translation_text" do
    get translation_text_url(@translation_text)
    assert_response :success
  end

  test "should get edit" do
    get edit_translation_text_url(@translation_text)
    assert_response :success
  end

  test "should update translation_text" do
    patch translation_text_url(@translation_text), params: { translation_text: { key_value: @translation_text.key_value, local: @translation_text.local, template_id: @translation_text.template_id } }
    assert_redirected_to translation_text_url(@translation_text)
  end

  test "should destroy translation_text" do
    assert_difference('TranslationText.count', -1) do
      delete translation_text_url(@translation_text)
    end

    assert_redirected_to translation_texts_url
  end
end
