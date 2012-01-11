module ActiveRecord
  module ConnectionAdapters
    module Sqlserver
      module CoreExt
        module ODBC

          module Statement
            
            def finished?
              begin
                connected?
                false
              rescue ::ODBC::Error
                true
              end
            end
            
          end

          module Database
            
            def run_block(*args)
              yield sth = run(*args)
              sth.drop
            end
            
          end
          module TimeStamp
            
            def to_date
              ODBC.to_date(self)
            end
            
          end

        end
      end
    end
  end
end


ODBC::Statement.send :include, ActiveRecord::ConnectionAdapters::Sqlserver::CoreExt::ODBC::Statement
ODBC::Database.send :include, ActiveRecord::ConnectionAdapters::Sqlserver::CoreExt::ODBC::Database
ODBC::TimeStamp.send :include, ActiveRecord::ConnectionAdapters::Sqlserver::CoreExt::ODBC::TimeStamp

