module Unearth
  class Relation
    attr_accessor :event_type, :app_name, :select, :where, :since, :limit, :facet

    def initialize
      @where ||= []
      @select ||= '*'
    end

    def select(select)
      @select = select
      self
    end

    def where(clauses)
      @where += Array(clauses)
      self
    end

    def since(since)
      @since = since
      self
    end

    def limit(limit)
      @limit = limit
      self
    end

    def facet(facet)
      @facet = facet
      self
    end

    def to_query
      query = []

      query << build_select
      query << build_event_type
      query << build_app_name
      query << build_where
      query << build_since
      query << build_facet
      query << build_limit

      query = query.compact

      query.join(' ')
    end

    private

    def build_select
      "SELECT #{@select}"
    end

    def build_event_type
      "FROM #{@event_type}"
    end

    def build_app_name
      return unless @app_name

      "WHERE appName = '#{@app_name}'"
    end

    def build_where
      return unless @where
      return if @where.empty?

      clauses = @where.map do |k, v|
        if v.respond_to?(:each)
          "#{k} in (#{array_to_query(v)})"
        elsif v
          "#{k} = #{value_to_query(v)}"
        else
          k
        end
      end

      "WHERE #{clauses.join(' AND ')}"
    end

    def build_since
      return unless @since

      "SINCE '#{@since}'"
    end

    def build_limit
      return unless @limit

      "LIMIT #{@limit}"
    end

    def build_facet
      return unless @facet

      "FACET #{@facet}"
    end

    def array_to_query(array)
      queriables = array.map do |v|
        value_to_query(v)
      end

      queriables.join(', ')
    end

    def value_to_query(value)
      v_int = (Integer(value) rescue nil)

      return v_int unless v_int.nil?

      "'#{value.to_s}'"
    end
  end
end
