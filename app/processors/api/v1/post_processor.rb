class Api::V1::PostProcessor < JSONAPI::Processor
  after_find do
    unless @result.is_a?(JSONAPI::ErrorsOperationResult)
      @result.meta[:total_records_found] = @result.record_count
    end
  end
end
