class IndicatorType < ApplicationRecord
    has_many :indicators, class_name: 'Indicator', foreign_key: 'type'
end
