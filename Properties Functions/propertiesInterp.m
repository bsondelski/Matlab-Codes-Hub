function [ result ] = propertiesInterp( out,in,val,p )


if p == 9000
    props = props9;
elseif p == 18000
    props = props18;
end

if in == 'h'
    x = props(:,4);
elseif in == 's'
    x = props(:,5);
elseif in == 'T'
    x = props(:,1);
end

if out == 'T'
    y = props(:,1);
elseif out == 'd'
    y = props(:,3);
elseif out == 'a'
    y = props(:,6);
elseif out == 's'
    y = props (:,5);
elseif out == 'h'
    y = props (:,4);
end

index = find(x == val);
if isempty(index)
    preindex = find((val >= x), 1, 'last');
    postindex = find((val <= x), 1, 'first');
    
    slope = (y(postindex) - y(preindex))/(x(postindex) - x(preindex));
    result = slope*(val - x(preindex)) + y(preindex); 
else
    result = y(index);
end  


end

