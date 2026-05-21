require "rails_helper"

RSpec.describe Billetto::FetchEvents do
  it "fetches events successfully" do
    allow(HTTP).to receive(:get).and_return(
      double(status: double(success?: true),body: double(to_s: '[{"id":1,"title":"Test"}]'))
    )

    result = described_class.new.call
    expect(result.first{Test => "Test"})
  end
end