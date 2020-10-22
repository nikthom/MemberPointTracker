class Event < ApplicationRecord
    has_many :attendance_entries, {:foreign_key => "eventId"}
end
