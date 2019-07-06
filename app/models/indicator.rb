class Indicator < ApplicationRecord
    belongs_to :company, class_name: 'Company', foreign_key: 'company_id'
end
