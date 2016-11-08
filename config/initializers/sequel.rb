::Sequel.extension :core_extensions
::Sequel.extension :migration

::Sequel::Model.plugin :boolean_readers
::Sequel::Model.plugin :timestamps, update_on_create: true
::Sequel::Model.plugin :update_or_create
::Sequel::Model.plugin :validation_helpers

SEQUEL_DB = ::Sequel::Model.db

Sequel.default_timezone = :local
Sequel.database_timezone = :utc
