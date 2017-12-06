json.cache! ['v1', @releases], expires_in: 10.minutes do
  json.array! @releases, partial: 'releases/event', as: :release
end
