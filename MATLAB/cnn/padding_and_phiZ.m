function phiZ = padding_and_phiZ(model, net, m, num_data)

phiZ = padding(model, net, m, num_data);
% Calculate phiZ
phiZ = reshape(phiZ, [], num_data);
phiZ = phiZ(net.idx_phiZ{m}, :);

h = model.wd_filter(m);
d = model.ch_input(m);
phiZ = reshape(phiZ, h*h*d, []);


function output = padding(model, net, m, num_data)

a = model.ht_pad(m);
b = model.wd_pad(m);
d = model.ch_input(m);
idx = reshape(net.idx_pad{m} + [0:num_data-1]*a*b, [], 1);
%output = gpu(ftype(zeros(d, a*b*num_data)));
output = net.padding_zeros{m}(:,1:a*b*num_data);
output(:,idx) = net.Z{m};
