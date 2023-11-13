module Admin
  class UsersController < Admin::ApplicationController
    include AdministrateFilterable::Filterer
  end
end
