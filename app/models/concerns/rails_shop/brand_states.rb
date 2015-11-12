module RailsShop
  module BrandStates
    extend ActiveSupport::Concern

    STATES = %w[ draft published deleted ]

    included do
      validates_inclusion_of :state, in: STATES
      scope :with_state, ->(states){ where( state: Array.wrap(states) ) if states.present? }

      STATES.each do |state|
        scope state, ->{ with_state state }

        define_method "#{ state }?" do
          self.state.to_s == state.to_s
        end

        define_method "#{ state }!" do
          self.state = state
          save!
        end
      end # STATES.each
    end # included

  end
end