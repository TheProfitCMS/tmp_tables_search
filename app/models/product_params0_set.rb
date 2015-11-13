# t.integer :size_x, default: 0
# t.integer :size_y, default: 0
# t.integer :size_z, default: 0

# t.integer :volume,      default: 512
# t.string  :volume_text, default: '512 Megabytes'

# t.string  :interface_1,   default: 'USB 2.0'
# t.string  :interface_2,   default: 'USB 3.0'

class ProductParams0Set < ActiveRecord::Base
  INTERFACES = ['USB 2.0', 'USB 3.0']

  def self.filters
    [
      {
        name: :volume,
        field: :volume,
        value_type: :integer,
        visible: true,

        type: :range,
        mix: 128,
        max: 8192
      },
      {
        name: :interfaces,
        field: [:interface_1, :interface_2],
        value_type: :string,
        visible: false,

        type: :select,
        options: INTERFACES
      }
    ]
  end

  has_one :product, as: :product_params_set
end
