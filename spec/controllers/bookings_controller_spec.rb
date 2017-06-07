require 'rails_helper'

RSpec.describe BookingsController do
  describe '#create' do
    let!(:room) { create :room, number: 17 }

    let!(:booking_1) { create :booking, room_id: room.id, start: '2017-02-01', end: '2017-02-15'}
    let!(:booking_2) { create :booking, room_id: room.id, start: '2017-03-01', end: '2017-03-15'}

    let(:msg_ok)  { "Booking created." }
    let(:msg_bad) { "Booking conflicts with an existing booking" }

    [ { start: '2017-01-01', end: '2017-01-20', expected_result: true },
      { start: '2017-02-01', end: '2017-02-10', expected_result: false},
      { start: '2017-02-01', end: '2017-02-20', expected_result: false},
      { start: '2017-02-15', end: '2017-02-25', expected_result: false},
      { start: '2017-02-16', end: '2017-02-25', expected_result: true},
      { start: '2017-01-01', end: '2017-02-17', expected_result: false},     # the case send a fake positif :/ the origin algo is wrong
      { start: '2017-02-16', end: '2017-03-01', expected_result: true} ].each do |current_case|

      it "check between " + current_case[:start].to_s + " and " + current_case[:end].to_s do
        post :create, { params: { room_id: room.id, start: current_case[:start], end: current_case[:start] }}

        if current_case[:expected_result]
          expect(JSON.parse(response.body, symbolize_names: true)[:message]).to eql msg_ok
        else
          expect(JSON.parse(response.body, symbolize_names: true)[:message]).to eql msg_bad
        end
        JSON.parse(response.body, symbolize_names: true)

      end

    end


  end

end
