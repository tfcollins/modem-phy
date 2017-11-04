function [frame,ind] = FindFrameStart(signal, xPreamble)

preambleLength = length(xPreamble);

% Estimate start of frame
eng = mean(abs(signal).^2); % Mean power
cor = abs(filter(xPreamble(end:-1:1).',1,signal));
% look in first half only
cor = cor(1:floor(length(cor)/2));
[val,ind] = max(cor);

% The max should be at least X times the mean
if (val/eng) > 4 %(Larger makes more selective)    
    % Correct to edge of preamble
    ind = ind - preambleLength;
    frame = signal(ind+1:end); % Includes preamble
    % Get orientation
    phaseEst = round(angle(mean(conj(xPreamble) .* frame(1:preambleLength)))*2/pi)/2*pi;
    % Compensating for the phase offset
    frame = frame .* exp(-1i*phaseEst);
    %[frame(1:10),xPreamble(1:10)]
else
    frame = [];
end

end
