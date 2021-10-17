# frozen_string_literal: true

require_relative '../table'

module TTFunk
  class Table
    class Glyf < Table
      # Accepts a hash mapping (old) glyph-ids to glyph objects, and a hash
      # mapping old glyph-ids to new glyph-ids.
      #
      # Returns a hash containing:
      #
      # * :table - a string representing the encoded 'glyf' table containing
      #   the given glyphs.
      # * :offsets - an array of offsets for each glyph
      def self.encode(glyphs, new_to_old, old_to_new)
        result = { table: +'', offsets: [] }

        new_to_old.keys.sort.each do |new_id|
          glyph = glyphs[new_to_old[new_id]]
          result[:offsets] << result[:table].length
          result[:table] << glyph.recode(old_to_new) if glyph
        end

        # include an offset at the end of the table, for use in computing the
        # size of the last glyph
        result[:offsets] << result[:table].length
        result
      end

      def for(glyph_id)
        return @cache[glyph_id] if @cache.key?(glyph_id)

        index = file.glyph_locations.index_of(glyph_id)
        size = file.glyph_locations.size_of(glyph_id)

        if size.zero? # blank glyph, e.g. space character
          @cache[glyph_id] = nil
          return
        end

        parse_from(offset + index) do
          raw = io.read(size)
          number_of_contours = to_signed(raw.unpack1('n'))

          @cache[glyph_id] =
            if number_of_contours == -1
              Compound.new(glyph_id, raw)
            else
              Simple.new(glyph_id, raw)
            end
        end
      end

      private

      def parse!
        # because the glyf table is rather complex to parse, we defer
        # the parse until we need a specific glyf, and then cache it.
        @cache = {}
      end
    end
  end
end

require_relative 'glyf/compound'
require_relative 'glyf/path_based'
require_relative 'glyf/simple'
