class AttendanceEntry < ApplicationRecord
    belongs_to :event, {:foreign_key => "eventId"}
    belongs_to :member, {:foreign_key => "uin", :optional => true}
    belongs_to :officer, {:foreign_key => "uin", :optional => true}
end
