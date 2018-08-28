function [ result ] = propertiesInterp( out,in,val,p,mode )


% % global props18 props9
% props18 = mode(:,7:12);
% props9 = mode(:,1:6);
% 
% if p == 9000
%     props = props9;
% elseif p == 18000
%     props = props18;
% end
% 
% 
% if in == 'h'
%     x = props(:,4);
% elseif in == 's'
%     x = props(:,5);
% elseif in == 'T'
%     x = props(:,1);
% end
% 
% if out == 'T'
%     y = props(:,1);
% elseif out == 'd'
%     y = props(:,3);
% elseif out == 'a'
%     y = props(:,6);
% elseif out == 's'
%     y = props (:,5);
% elseif out == 'h'
%     y = props (:,4);
% end
% 
% % for i = 1:length(val)
% %     index = find(x == val);
% % end
% result = y(x == val);
% 
% if isempty(result)
% %     for i = 1:length(val)
% %         preindex(i) = find((val(i) >= x), 1, 'last');
% %         postindex(i) = find((val(i) <= x), 1, 'first');
% %     end
% %     
% %     slope = (y(postindex) - y(preindex))./(x(postindex) - x(preindex));
% %     result = slope.*(val' - x(preindex)) + y(preindex);
% %     
% %     result = result';
% 
% x1 = zeros(1,length(val));
% x2 = zeros(1,length(val));
% y1 = zeros(1,length(val));
% y2 = zeros(1,length(val));
% 
%     for i = 1:length(val)
%         x1vec = x(x < val(i));
%         x1(i) = x1vec(end);
%         x2vec = x(x > val(i));
%         x2(i) = x2vec(1);
%         y1(i) = y(x == x1(i));
%         y2(i) = y(x == x2(i));
%     end
%     
%     slope = (y2 - y1)./(x2 - x1);
%     result = slope.*(val - x1) + y1;
% else
% %     result = y(index);
% end
% 
% % result = spline(x,y,val)

% out 
% in 
% val
% p


if p == 25000
    props = mode(:,1:44);
elseif p == 50000
    props = mode(:,45:88);
end


if in == 'T'
    x = props(:,1);
    if out == 'd'
        y = props(:,2:6);
    elseif out == 'h'
        y = props(:,7:11);
    elseif out == 's'
        y = props(:,12:16);
    end
elseif in == 's'
    x = props(:,17);
    if out == 'h'
        y = props(:,18:22);
    elseif out == 'T'
        y = props(:,23:27);
    end
elseif in == 'h'
    if out == 'a'
        x = props(:,28);
        y = props(:,29:33);
    elseif out == 'd'
        x = props(:,34);
        y = props(:,35:39);
    elseif out == 'T'
        x = props(:,34);
        y = props(:,40:44);
    end
end

result = y(x == val,1);

if isempty(result)   
    
    a = zeros(length(val),1);
    b = zeros(length(val),1);
    c = zeros(length(val),1);
    d = zeros(length(val),1);
    xval = zeros(length(val),1);
    for i =1:length(val)
        xvec = x(x<val(i));
        xval(i) = xvec(end);
        a(i) = y(x == xval(i),2);
        b(i) = y(x == xval(i),3);
        c(i) = y(x == xval(i),4);
        d(i) = y(x == xval(i),5);
    end
    
    diff = val' - xval;
    result = (a.*diff.^3 + b.*diff.^2 + c.*diff + d)';
    
    
end


end

