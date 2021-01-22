# frozen_string_literal: true

class Catalogue
  PRODUCTS = {
    "R12" => {
      5 => 699,
      10 => 1299,
    },
    "L09" => {
      3 => 995,
      6 => 1695,
      9 => 2495,
    },
    "T58" => {
      3 => 595,
      5 => 995,
      9 => 1699,
    },
  }
  private_constant :PRODUCTS

  def self.bundles
    PRODUCTS
  end
end
