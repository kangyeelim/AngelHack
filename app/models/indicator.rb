class Indicator < ApplicationRecord
    belongs_to :company, class_name: 'Company', foreign_key: 'company_id'
    belongs_to :indicator_type, class_name: 'IndicatorType', foreign_key: 'type'
end
