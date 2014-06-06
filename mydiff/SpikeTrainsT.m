function X = SpikeTrainsT(ras, p, Tlen, stv)
if ~exist('stv', 'var') || isempty(stv)
  stv = 0.5;
end
len = floor(Tlen/stv);
X = zeros(p,len);
for neuron_id = 1:p
  st = SpikeTrain(ras, len, neuron_id, 1, stv);
  X(neuron_id,:) = st;
end