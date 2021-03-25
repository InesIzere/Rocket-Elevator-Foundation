class BuildingDetail < ApplicationRecord
    belongs_to :building, foreign_key: "building_id", optional: true
    serialize :information_key, Hash
    BuildingDetail.joins(:building)
end
