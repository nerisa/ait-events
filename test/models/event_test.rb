require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "should have a name" do
    event = Event.new
    assert !event.valid?
    assert_equal ["Please enter a name for the event."], event.errors[:name]
  end

  test "should have a description" do
    event = Event.new
    assert !event.valid?
    assert_equal ["Please enter a description for the event."], event.errors[:description]
  end

  test "should belong to a committee" do
    event = Event.new
    assert !event.valid?
    assert_equal ["Please select a committee under which this event falls under."], event.errors[:committee]
  end

  test "start date and end date should be future dates" do
    event = Event.new(start_date: Date.yesterday, end_date: Date.yesterday)
    assert !event.valid?
    assert_equal ["Event cannot start in the past."], event.errors[:start_date]
    assert_equal ["Event cannot end in the past."], event.errors[:end_date]
  end

  test "end date of event should be after the start date" do
    event = Event.new(start_date: Date.tomorrow, end_date: Date.today)
    assert !event.valid?
    assert_equal ["Event cannot end before it starts."], event.errors[:end_date]
  end

  test "an event which has the start date in future should be shown as in future" do
    event = Event.new(start_date: Date.tomorrow, name: 'Event 1', description: 'This is a new event')
    assert event.isInFuture
  end

  test "an event which has the start date in the past or an empty start date should not be shown as in future" do
    event = Event.new(start_date: Date.yesterday, name: 'Event 1', description: 'This is a new event')
    event_plan = Event.new(name: 'Event 1', description: 'This is a new event')
    assert !event.isInFuture
    assert !event_plan.isInFuture
  end

end
