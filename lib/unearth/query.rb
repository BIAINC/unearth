module Unearth
  class Query
    include HTTParty

    def self.create(event_type, app_name)
      relation = Relation.new.tap do |r|
        r.event_type = event_type
        r.app_name = app_name
      end

      self.new(relation)
    end

    def initialize(relation)
      @relation = relation
    end

    [:select, :where, :since, :limit, :facet].each do |relation_name|
      define_method "#{relation_name.to_s.downcase}" do |clause|
        self.class.new(@relation.dup.send(relation_name, clause))
      end
    end

    def to_query
      @relation.to_query
    end

    def run
      config.logger.debug { "Insights Query: #{to_query}" } if config.enable_log && config.logger

      self.class.post(config.insights_url + build_query_path_fragment, query: { nrql: to_query }, headers: headers)
    end

    def config
      Unearth.configuration
    end

    private

    def build_query_path_fragment
      "/v1/accounts/#{config.insights_account_id}/query"
    end

    def headers
      @headers ||=
      {
        'Accept' => 'application/json',
        'X-Query-Key' => config.insights_api_key
      }
    end

    def account_id
      @account_id ||= config.insights_account_id
    end
  end
end
