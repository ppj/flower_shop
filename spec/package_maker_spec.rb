# frozen_string_literal: true

require_relative "../lib/package_maker"

RSpec.describe PackageMaker do
  describe ".make" do
    subject(:make) { described_class.make(quantity: quantity, bundles: bundles) }

    context "when available bundle sizes are [10]" do
      let(:bundles) { [10] }

      context "when packaging for 3 pieces" do
        let(:quantity) { 3 }

        it "returns an empty package" do
          expect(make).to eq({})
        end
      end

      context "when packaging for 10 pieces" do
        let(:quantity) { 10 }

        it "returns the bundle as {10 => 1}" do
          expect(make).to eq({ 10 => 1 })
        end
      end

      context "when packaging for 20 pieces" do
        let(:quantity) { 20 }

        it "returns the bundle as {10 => 2}" do
          expect(make).to eq({ 10 => 2 })
        end
      end

      context "when packaging for 24 pieces" do
        let(:quantity) { 24 }

        it "returns an empty package" do
          expect(make).to eq({})
        end
      end
    end

    context "when available bundle sizes are [5, 10]" do
      let(:bundles) { [5, 10] }

      context "when packaging for 3 pieces" do
        let(:quantity) { 3 }

        it "returns the bundle as {}" do
          expect(make).to eq({})
        end
      end

      context "when packaging for 5 pieces" do
        let(:quantity) { 5 }

        it "returns the bundle as { 5 => 1 }" do
          expect(make).to eq({ 5 => 1 })
        end
      end

      context "when packaging for 10 pieces" do
        let(:quantity) { 10 }

        it "returns the bundle as { 10 => 1 }" do
          expect(make).to eq({ 10 => 1 })
        end
      end

      context "when packaging for 15 pieces" do
        let(:quantity) { 15 }

        it "returns the bundle as { 10 => 1, 5 => 1 }" do
          expect(make).to eq({ 10 => 1, 5 => 1 })
        end
      end

      context "when packaging for 25 pieces" do
        let(:quantity) { 25 }

        it "returns the bundle as { 10 => 2, 5 => 1 }" do
          expect(make).to eq({ 10 => 2, 5 => 1 })
        end
      end
    end
  end
end
