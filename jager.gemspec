Gem::Specification.new do |spec|
  
  spec.name = "jager"
  spec.version = "0.0.1"
  spec.authors = ["Miraj P Rajeendran", "Tinu"]
  spec.email = ["miraj@nuventure.in"]
  spec.summary = "Cloud.net API endpoit wrapper"
  spec.description = "All Cloud.net apis in one gem"
  spec.files = ["lib/jager.rb"]
  spec.license = 'MIT'

  spec.add_dependency 'faraday'
  spec.add_dependency 'json'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
end