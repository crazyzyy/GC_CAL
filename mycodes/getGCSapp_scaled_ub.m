% calculate GC approximately
% S: spectrum fftlen*p*p
% ext_od: order used in the final summation
%add new output covxy_f_app0 by zyy
%unbiased approach

function [gc_app, covxy_f_app0, de11, de22] = getGCSapp_scaled_ub(S, freq, ext_od)
if size(S,2)~=size(S,3)
  error('S shoule be fftlen*p*p matrix');
end
if ~exist('ext_od','var')
  ext_od = 30;
end

[S3, de11, de22] = StdWhiteS(S);
% [S3, ~, ~, de11, de22] = StdWhiteS2(S);
% S3 = S;
plot(S3(:,1,2))
covxy_f_app0 = ifft(S3(:,1,2));
% plot(covxy_f_app0)

od = min(floor(size(S3,1)/2), ext_od);
gc_app = zeros(2,2);

gc_app(1,2) = real(sum(covxy_f_app0(2:od+1).^2));
gc_app(2,1) = real(sum(covxy_f_app0(end-od:end).^2));
% gc_ins = covxy_f_app0(1)^2
gc_app = gc_app*max(freq);