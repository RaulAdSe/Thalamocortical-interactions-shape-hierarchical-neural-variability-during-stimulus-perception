%Author: Raul Adell
%Description: Function to estimate Fano factor along the cognitive task for each neuron separately
%Date: 9/9/2023


function est_fano = Fano(spikeCounts, timesEvents, num_intervals, min_trials_per_amplitude)
    % Fano computes the Fano factor for neural spiking data across different stimulus amplitudes.
    % 
    % Inputs:
    %   spikeCounts - Matrix of spike counts with rows as trials and columns as time bins.
    %   timesEvents - Times of stimulus events corresponding to each trial.
    %   num_intervals - Number of time intervals to consider for spike counting.
    %   min_trials_per_amplitude - Minimum number of trials per stimulus amplitude to consider.
    %
    % Output:
    %   est_fano - Estimated Fano factors for each time interval.

    % Initialize matrices to collect spike counts per amplitude and interval
    unique_amplitudes = unique(timesEvents(:,4));
    spike_data = cell(length(unique_amplitudes), num_intervals);

    % Collect spikes in intervals for each amplitude
    for i = 1:length(unique_amplitudes)
        amp = unique_amplitudes(i);
        idx = timesEvents(:,4) == amp & timesEvents(:,5) == 1; % Filter trials by amplitude and hit condition
        data = spikeCounts(idx, :);
        if size(data, 1) >= min_trials_per_amplitude
            for interval = 1:num_intervals
                interval_data = data(:, (interval-1)*250+1:interval*250); % Assuming 250 ms intervals
                spike_data{i, interval} = sum(interval_data, 2); % Sum across columns to get total spikes in each interval
            end
        end
    end

    % Calculate mean and variance for each amplitude and interval, then fit linear regression to estimate Fano factor
    est_fano = zeros(1, num_intervals);
    for interval = 1:num_intervals
        variances = [];
        means = [];
        for i = 1:size(spike_data, 1)
            if ~isempty(spike_data{i, interval})
                interval_var = var(spike_data{i, interval});
                interval_mean = mean(spike_data{i, interval});
                variances = [variances, interval_var];
                means = [means, interval_mean];
            end
        end
        % Perform linear regression of variance on mean
        if ~isempty(variances)
            lm = fitlm(means, variances, 'y ~ x - 1'); % Linear model without intercept
            est_fano(interval) = lm.Coefficients.Estimate(1);
        end
    end

    return
end
