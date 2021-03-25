class Column < ApplicationRecord
    belongs_to :battery, foreign_key: "battery_id"
    has_many :elevators
end
