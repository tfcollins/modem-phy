function frame = FindFrameStart(signal, xPreamble)

preambleLength = length(xPreamble);

% Estimate start of frame
eng = mean(abs(signal).^2); % Mean power
cor = abs(filter(xPreamble(end:-1:1).',1,signal));
stem(cor);
[val,ind] = max(cor);

% Reduce peaks
reduced = cor>0.8*val;

% Check gaps
indexes = 1:length(reduced);
valids = indexes(reduced==1);

% The max should be at least X times the mean
if (val/eng) > 4 %(Larger makes more selective)
%if (valids(2) - valids(1))==preambleLength/3    
    % Correct to edge of preamble
    ind = valids(1) - preambleLength;
    % Compare with true
    %est = ind - filterSymbolSpan; % compensate for filter delay
    %fprintf('True Delay %f | Estimate %f %f\n',delay,ind,est);
    %found = found + 1;
    %indexErrors(found) = abs(delay-est);
    frame = signal(ind+1:end);
    % Get orientation
    phaseEst = round(angle(mean(conj(xPreamble) .* frame(1:preambleLength)))*2/pi)/2*pi;
    % Compensating for the phase offset
    frame = frame .* exp(-1i*phaseEst);
else
    frame = [];
end

end