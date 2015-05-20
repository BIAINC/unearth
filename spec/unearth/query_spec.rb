require 'spec_helper'

describe Unearth::Query do
  describe '#to_query' do
    it 'builds a query' do
      now = Time.now

      expected = "SELECT min(timestamp), max(timestamp), sum(size) FROM test WHERE appName = 'test_app' WHERE id = 213 AND list in (1, 2, 'text') AND field LIKE '%text%' SINCE '#{now}' LIMIT 1000"

      query = Unearth::Query.create(:test, :test_app)
                .where(id: 213)
                .where(list: [1, 2, 'text'])
                .where("field LIKE '%text%'")
                .since(now)
                .limit(1000)
                .select('min(timestamp), max(timestamp), sum(size)')

      expect(query.to_query).to eq(expected)
    end

    it 'selects all fields if no select is specified' do
      now = Time.now

      expected = "SELECT * FROM test WHERE appName = 'test_app' WHERE id = 213 AND list in (1, 2, 'text') SINCE '#{now}' LIMIT 1000"

      query = Unearth::Query.create(:test, :test_app)
                .where(id: 213)
                .where(list: [1, 2, 'text'])
                .since(now)
                .limit(1000)

      expect(query.to_query).to eq(expected)
    end

    it 'can select count of everything' do
      now = Time.now

      expected = "SELECT count(*) FROM test WHERE appName = 'test_app'"

      query = Unearth::Query.create(:test, :test_app)
                .select("count(*)")

      expect(query.to_query).to eq(expected)
    end

    it 'behaves idempotently' do
      now = Time.now

      expected = "SELECT count(*) FROM test WHERE appName = 'test_app'"

      query = Unearth::Query.create(:test, :test_app)
                .select("count(*)")

      extra_query = query.where(id: 213)
                         .where(list: [1, 2, 'text'])
                         .where("field LIKE '%text%'")

      expect(query.to_query).to eq(expected)
    end
  end
end
