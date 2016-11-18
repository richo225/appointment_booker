require "appointment"

describe Appointment do

  let(:appointment){Appointment.new("08:00:00")}

  it "correctly parses JSON to an array" do
    expect{appointment.get_slots}.to_not raise_error
    expect(appointment.get_slots).to be_an Array
  end

  context "slot is available" do
    it "returns confirmation message if time available" do
      message = "Appointment confirmed at 08:00:00"
      expect(appointment.check_availability).to eq message
    end
  end

  context "slot is not available" do
    let(:appointment){Appointment.new("22:00:00")}

    it "returns error message if time unavailable" do
      message = "Please pick another time"
      expect(appointment.check_availability).to eq message
    end
  end

end
