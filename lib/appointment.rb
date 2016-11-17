require "json"

class Appointment

  def initialize(request)
    @requested_time = request
    get_slots
  end

  def get_slots
    json = File.read("lib/availability_slots.json")
    @slots = JSON.parse(json)["availability_slots"]
  end

end
