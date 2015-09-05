class CountingActiveRecordOperationsProcessor < ActiveRecordOperationsProcessor
  after_find_operation do
    count = @operation.resource_klass.find_count(
      @operation.resource_klass.verify_filters(
        @operation.filters, @context
      ),
      context: @context,
      include_directives: @operation.include_directives,
      sort_criteria: @operation.sort_criteria
    )

    @operation_meta[:page] = {
      total: count,
      sort: @operation.sort_criteria
    }

    if @operation.paginator.respond_to?(:offset) && @operation.paginator.respond_to?(:limit)
      @operation_meta[:page][:offset] = @operation.paginator.offset
      @operation_meta[:page][:limit] = @operation.paginator.limit
    end

  end
end
