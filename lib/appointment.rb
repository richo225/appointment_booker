require "json"

class Appointment
  attr_reader :slots, :requested_time

  def initialize(time)
    @requested_time = time
    get_slots
  end

  def get_slots
    json = File.read("lib/availability_slots.json")
    @slots = JSON.parse(json)["availability_slots"]
  end

  def check_validity
    if valid?
      check_availability
    else
      raise "Please pick a time between 08:00:00 and 15:00:00"
    end
  end

  def check_availability
    if available?
      "Appointment confirmed at #{@requested_time}"
    else
      raise "Appointment unavailable. Please pick an earlier time"
    end
  end

  private

  def valid?
    requested_time.between?("08:00:00","15:00:00")
  end

  def available?
    slots.any? {|slot| slot["time"] >= requested_time}
  end

  # Check if exact time is available ie. "booked" => false or deleted
  # If it is, run booking method and either delete that appointment or add a key "booked" => true
    # Write this to the JSON file
  # If it isn't, find nearest value and repeat

end
