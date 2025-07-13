# frozen_string_literal: true

RSpec.describe Ke2daira do
  it "has a version number" do
    expect(described_class::VERSION).not_to be_nil
  end

  it "松平 健" do
    expect(described_class.ke2dairanize("松平 健")).to eq("ケツダイラ マン")
  end

  it "ポール マッカートニー" do
    expect(described_class.ke2dairanize("ポール マッカートニー")).to eq("マール ポッカートニー")
  end

  it "チェ ゲバラ" do
    expect(described_class.ke2dairanize("チェ ゲバラ")).to eq("ゲ チェバラ")
  end

  it "加藤 あい" do
    expect(described_class.ke2dairanize("加藤 あい")).to eq("アトウ カイ")
  end

  it "阿藤 快", pending: "快がココロヨと読まれてしまう" do
    expect(described_class.ke2dairanize("阿藤 快")).to eq("カトウ アイ")
  end

  it "森 進一" do
    expect(described_class.ke2dairanize("森 進一")).to eq("シリ モンイチ")
  end

  it "デーモン 小暮" do
    expect(described_class.ke2dairanize("デーモン 小暮")).to eq("コーモン デグレ")
  end
end
