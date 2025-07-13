# frozen_string_literal: true

RSpec.describe Ke2daira do
  it "has a version number" do
    expect(described_class::VERSION).not_to be_nil
  end

  describe ".ke2dairanize" do
    subject { described_class.ke2dairanize(name) }

    parameterized(:name, :expected) do
      input { ["松平 健", "ケツダイラ マン"] }
      input { ["ポール マッカートニー", "マール ポッカートニー"] }
      input { ["チェ ゲバラ", "ゲ チェバラ"] }
      input { ["加藤 あい", "アトウ カイ"] }
      input { ["森 進一", "シリ モンイチ"] }
      input { ["デーモン 小暮", "コーモン デグレ"] }

      it { is_expected.to eq(expected) }
    end

    context "阿藤 快", pending: "快がココロヨと読まれてしまう" do
      let(:name) { "阿藤 快" }
      it { is_expected.to eq("カトウ アイ") }
    end
  end
end
