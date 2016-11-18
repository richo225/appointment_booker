require "appointment"

describe Appointment do

  let(:appointment){Appointment.new("08:00:00")}

  it "correctly parses JSON to an array" do
    expect{appointment.get_slots}.to_not raise_error
    expect(appointment.get_slots).to be_an Array
  end

  context "requested time is invalid" do
    invalid = "Please pick a time between 08:00:00 and 15:00:00"

    it "raises an error if time is before 08:00:00" do
      appointment = Appointment.new("07:30:00")
      expect{appointment.check_validity}.to raise_error invalid
    end

    it "raises an error if time is after 15:00:00" do
      appointment = Appointment.new("15:30:00")
      expect{appointment.check_validity}.to raise_error invalid
    end
  end

  context "requested time is available" do
    it "returns a confirmation message if time is available" do
      message = "Appointment confirmed at 08:00:00"
      expect(appointment.check_availability).to eq message
    end
  end

  context "requested time is not available" do
    let(:appointment){Appointment.new("22:00:00")}

    it "asks for another time if unavailable" do
      unavailable = "Appointment unavailable. Please pick an earlier time"
      expect{appointment.check_availability}.to raise_error unavailable
    end
  end

end
