function [ message ] = AQC_write_dac( AQC, dac, channel, value )
% Write a value to a DAC connected to AQC
% Can pass an 'AQC' serial instrument for faster execution
% Otherwise, one will be created, used, and then closed

    empty_flag = isempty( AQC );
    
    if( empty_flag )
        AQC = AQC_open_serial( [] );
    end
    
    fprintf( AQC, [ 'W' num2str( dac ) value num2str( channel ) ] );
    pause( 0.1 );   % Wait to allow time for response

    message = [];
    while AQC.BytesAvailable > 0
        message = [ message fgets( AQC ) ];
    end
    
    if( empty_flag )
        fclose( AQC );
    end
    
end