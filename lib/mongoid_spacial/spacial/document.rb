module Mongoid
  module Spacial
    module Document 
      extend ActiveSupport::Concern

      included do
        attr_accessor :geo
        cattr_accessor :spacial_fields, :spacial_fields_indexed
        @@spacial_fields = []
        @@spacial_fields_indexed = []
      end

      module ClassMethods #:nodoc:
        # create spacial index for given field
        # @param [String,Symbol] name
        # @param [Hash] options options for spacial_index
        def spacial_index name, *options
          self.spacial_fields_indexed << name
          index [[ name, Mongo::GEO2D ]], *options
        end
      end

      module InstanceMethods #:nodoc:
        def distance_from(key,center, unit = nil, formula = nil)
          loc = res.send(key)
          Mongoid::Spacial.distance(center, loc, unit, formula = nil)
        end
      end
    end
  end
end