function memUsage --wraps='dysk -c label+default' --description 'alias memUsage dysk -c label+default'
  dysk -c label+default $argv
        
end
