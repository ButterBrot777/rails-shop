# frozen_string_literal: true

json.array! @line_items, partial: 'line_items/line_item', as: :line_item
