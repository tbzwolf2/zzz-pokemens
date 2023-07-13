Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the URL base path to your API
    :base_path => "http://localhost:3000",
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # Ability to setup base controller for each api version. Api::V1::SomeController for example.
    # :parent_controller => Api::V1::SomeController,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "ZZZ pokemens",
        "description" => "A pokemon api app.",
      }
    }
  }
})