function [ err ] = compressorNsError( logns, middle_actual )

logns
if middle_actual > 0.076445106688
        middle = 0.076445106688;
    elseif middle_actual < 1.214995715627480
        middle = -0.643301783584803*logns+0.706787306595485;
    else
        middle = 0.488977-0.426379*logns+0.638746*logns^2-0.637014*logns^3-0.249812*logns^4+0.580012*logns^5-0.196472*logns^6;
end
    
err=middle-middle_actual;

end

