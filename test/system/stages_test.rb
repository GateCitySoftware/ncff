# frozen_string_literal: true

require 'application_system_test_case'

class StagesTest < ApplicationSystemTestCase
  setup do
    @stage = stages(:one)
  end

  test 'visiting the index' do
    visit stages_url
    assert_selector 'h1', text: 'Stages'
  end

  test 'should create stage' do
    visit stages_url
    click_on 'New stage'

    fill_in 'Description', with: @stage.description
    fill_in 'Google place address', with: @stage.google_place_address
    fill_in 'Google place', with: @stage.google_place_id
    fill_in 'Name', with: @stage.name
    click_on 'Create Stage'

    assert_text 'Stage was successfully created'
    click_on 'Back'
  end

  test 'should update Stage' do
    visit stage_url(@stage)
    click_on 'Edit this stage', match: :first

    fill_in 'Description', with: @stage.description
    fill_in 'Google place address', with: @stage.google_place_address
    fill_in 'Google place', with: @stage.google_place_id
    fill_in 'Name', with: @stage.name
    click_on 'Update Stage'

    assert_text 'Stage was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Stage' do
    visit stage_url(@stage)
    click_on 'Destroy this stage', match: :first

    assert_text 'Stage was successfully destroyed'
  end
end
