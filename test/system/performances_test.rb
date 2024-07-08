# frozen_string_literal: true

require 'application_system_test_case'

class PerformancesTest < ApplicationSystemTestCase
  setup do
    @performance = performances(:one)
  end

  test 'visiting the index' do
    visit performances_url
    assert_selector 'h1', text: 'Performances'
  end

  test 'should create performance' do
    visit performances_url
    click_on 'New performance'

    fill_in 'Artist', with: @performance.artist_id
    fill_in 'Description', with: @performance.description
    fill_in 'End time', with: @performance.end_time
    check 'Is headline' if @performance.is_headline
    fill_in 'Stage', with: @performance.stage_id
    fill_in 'Start time', with: @performance.start_time
    click_on 'Create Performance'

    assert_text 'Performance was successfully created'
    click_on 'Back'
  end

  test 'should update Performance' do
    visit performance_url(@performance)
    click_on 'Edit this performance', match: :first

    fill_in 'Artist', with: @performance.artist_id
    fill_in 'Description', with: @performance.description
    fill_in 'End time', with: @performance.end_time
    check 'Is headline' if @performance.is_headline
    fill_in 'Stage', with: @performance.stage_id
    fill_in 'Start time', with: @performance.start_time
    click_on 'Update Performance'

    assert_text 'Performance was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Performance' do
    visit performance_url(@performance)
    click_on 'Destroy this performance', match: :first

    assert_text 'Performance was successfully destroyed'
  end
end
