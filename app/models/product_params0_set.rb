# t.integer :size_x, default: 0
# t.integer :size_y, default: 0
# t.integer :size_z, default: 0

# t.integer :volume,      default: 512
# t.string  :volume_text, default: '512 Megabytes'

# t.string  :interface_1,   default: 'USB 2.0'
# t.string  :interface_2,   default: 'USB 3.0'

class ProductParams0Set < ActiveRecord::Base
  INTERFACES = ['USB 2.0', 'USB 3.0']

  class << self
    def join_prefix
      0
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
          type: :integer_range,
          mix: 128,
          max: 8192,

          name: :volume,
          field: :volume,
          value_type: :integer,
          visible: true
        },
        {
          type: :checkbox_list,
          options: INTERFACES,

          name: :interfaces,
          field: [:interface_1, :interface_2],
          value_type: :string,
          visible: false
        }
      ]
    end
  end

  has_one :product, as: :product_params_set
end
