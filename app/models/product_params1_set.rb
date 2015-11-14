# t.string  :processor_type, default: ''
# t.decimal :display_size, precision: 8, scale: 2
# t.decimal :weight, precision: 8, scale: 2

class ProductParams1Set < ActiveRecord::Base
  PROCESSORS_TYPES = %w[ Atom A8 A7 A31s CoreM i7Core i5Core CoreDuo ]
  DISPLAY_SIZES    = [ 17, 19, 21, 22.5 ]

  class << self
    def join_prefix
      1
    end

    def join_fields
      _columns = column_names - ['id', 'title', 'created_at', 'updated_at']
      _columns.map do |column|
        "#{ table_name }.#{ column } AS pf#{ join_prefix }_#{ column }"
      end.join(', ')
    end

    def filters
      [
        {
          type: :select,
          options: PROCESSORS_TYPES,

          field: :processor_type,
          value_type: :string,
          visible: true
        },
        {
          type: :select,
          options: DISPLAY_SIZES,

          field: :display_size,
          value_type: :string,
          visible: false
        }
      ]
    end
  end

  has_one :product, as: :product_params_set
end
