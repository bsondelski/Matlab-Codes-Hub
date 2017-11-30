logns=-5:0.1:5;

for i=1:length(logns)
    if logns(i)>1
        stdeviation(i)=0.2592+0.2495*1-0.1288*1^2;
    elseif logns(i)<-0.09
        stdeviation(i)=0.2592+0.2495*-0.09-0.1288*(-0.09)^2;
    else
        stdeviation(i)=0.2592+0.2495*logns(i)-0.1288*logns(i)^2;
    end
end


plot(logns,stdeviation)
xlabel('log n_s')
ylabel('Curve Width Term')
ylim([0.2 0.4])
xlim([-1.5 2])