%Authors: Adrià Tauste /Raul Adell
%Description: Function to estimate tau coefficient for each neuron separately
%Date: 5/9/2023

function [tau, resnorm, exitflag, fittedParams] = Intrinsic_timescale(spikeCounts, maxLag, win_size, win_step)
    % Compute autocorrelation for different lags using sliding square filters
    nBins = length(spikeCounts);
    autoCorrVec = cell(1, maxLag + 1); % Cell array to store correlation coefficients at each lag

    % Compute spike counts in sliding square filters
    % Define windows for spike counting
    windowStarts = 1:win_step:(nBins - win_size + 1);
    windowEnds = windowStarts + win_size - 1;
    spikeCountsInWindows = arrayfun(@(s, e) sum(spikeCounts(s:e)), windowStarts, windowEnds);

    % Compute correlations for each lag
    for lag = 0:maxLag
        for j = (lag + 1):length(spikeCountsInWindows)
            % Compute correlation between spike counts in windows separated by 'lag'
            R = corrcoef(spikeCountsInWindows(j), spikeCountsInWindows(j - lag));
            if size(R, 1) > 1 && ~isnan(R(1, 2))
                autoCorrVec{lag + 1} = [autoCorrVec{lag + 1}, R(1, 2)];
            end
        end
    end

    % Average the correlation values for each lag
    auto_corr_to_fit = cellfun(@mean, autoCorrVec);

    % Prepare the time vector for the data points
    tdata = (0:maxLag)'; % Time data starts at 0 for lag 0

    % Define the model function for the decay
    decayModel = @(p, t) p(1) * exp(-p(2) * t) + p(3);

    % Initial parameter guesses
    initialParams = [1, 1/mean(tdata(2:end)), 0]; % Avoid division by zero by excluding the first element

    % Set options for the nonlinear fitting function
    options = optimoptions('lsqcurvefit', 'Algorithm', 'levenberg-marquardt');

    % Fit the model
    [fittedParams, resnorm, ~, exitflag] = lsqcurvefit(decayModel, initialParams, tdata, auto_corr_to_fit, [], [], options);

    % Extract the decay constant tau (tau = 1/B)
    tau = 1 / fittedParams(2);
end
