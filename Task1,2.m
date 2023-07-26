clear all; close all; clc;

% Task 1: Generate eye diagrams for baseband 2-PAM signaling with different pulse shaping filters

N = 1000;                   % Number of bits transmitted
SampleFreq = 10;            % Sampling frequency in Hz
BinarySeq = -SampleFreq:1/SampleFreq:SampleFreq; % Binary sequence

% Task 1: Generate an impulse train representing BPSK symbols
bpsk_symbols = 2*(rand(1,N)>0.5)-1;
SymbolIndex = 0:1/SampleFreq:99/SampleFreq;
stem(bpsk_symbols(1:100), 'LineWidth', 1.5);
xlabel('Symbol Index');
ylabel('Amplitude');
title('Impulse Train - BPSK Symbols');
axis([0 10 -1.2 1.2]);
grid on;

% Task 1: Generate eye diagrams for different pulse shaping filters
% Sinc Pulse Shape
Sinc_Num = sin(pi*BinarySeq); % numerator of the sinc function
Sinc_Den = (pi*BinarySeq); % denominator of the sinc function
Sinc_DenZero = find(abs(Sinc_Den) < 10^-10); % Finding the t=0 position
Sinc_Filt = Sinc_Num./Sinc_Den;
Sinc_Filt(Sinc_DenZero) = 1; % Defining the t=0 value

figure;
plot(BinarySeq, Sinc_Filt);
title('Sinc Pulse shape');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([-SampleFreq SampleFreq -0.5 1.2]);
grid on;

% Raised Cosine Pulse Shape
% roll-off = 0.5
roll_off = 0.5;
cos_Num = cos(roll_off*pi*BinarySeq);
cos_Den = (1 - (2 * roll_off * BinarySeq).^2);
cos_DenZero = abs(cos_Den) < 10^-10;
RaisedCosine = cos_Num./cos_Den;
RaisedCosine(cos_DenZero) = pi/4;
RC_gamma5 = Sinc_Filt.*RaisedCosine; % Getting the complete raised cosine pulse

figure;
plot(BinarySeq, RC_gamma5);
title('Raised Cosine Pulse shape gamma = 0.5');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([-SampleFreq SampleFreq -0.5 1.2]);
grid on;

% roll-off = 1
roll_off = 1;
cos_Num = cos(roll_off * pi * BinarySeq);
cos_Den = (1 - (2 * roll_off * BinarySeq).^2);
cos_DenZero = find(abs(cos_Den) < 10^-20);
RaisedCosine = cos_Num./cos_Den;
RaisedCosine(cos_DenZero) = pi/4;
RC_gamma1 = Sinc_Filt.*RaisedCosine; % Getting the complete raised cosine pulse

figure;
plot(BinarySeq, RC_gamma1);
title('Raised Cosine Pulse shape gamma = 1');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([-SampleFreq SampleFreq -0.5 1.2]);
grid on;

% Task 1: upsampling the transmit sequence
% Without Noise
BPSK_Upsample = [bpsk_symbols; zeros(SampleFreq-1, length(bpsk_symbols))]; % Upsampling the BPSK to match the sampling frequency
BPSK_U = BPSK_Upsample(:).';
figure;
stem(SymbolIndex, BPSK_U(1:100));
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train -Upsampled BPSK');
axis([0 10 -1.2 1.2]);
grid on;

% Task 1: Generate eye diagrams for different pulse shaping filters
% Without Noise
Conv_sincpulse = conv(BPSK_U, Sinc_Filt);
Conv_RCgamma5 = conv(BPSK_U, RC_gamma5);
Conv_RCgamma1 = conv(BPSK_U, RC_gamma1);

% Task 1: Taking only the first 10000 samples
% Without noise
Conv_sincpulse = Conv_sincpulse(1:10000);
Conv_RCgamma5 = Conv_RCgamma5(1:10000);
Conv_RCgamma1 = Conv_RCgamma1(1:10000);

% Task 1: Reshaping the sequences to build Eye Diagrams
% Without Noise
Conv_sincpulse_reshape = reshape(Conv_sincpulse, SampleFreq*2, N*SampleFreq/20).';
Conv_RCgamma5_reshape = reshape(Conv_RCgamma5, SampleFreq*2, N*SampleFreq/20).';
Conv_RCgamma1_reshape = reshape(Conv_RCgamma1, SampleFreq*2, N*SampleFreq/20).';

% Task 1: Plotting the Eye Diagrams
% Without Noise
figure;
plot(0:1/SampleFreq:1.99, real(Conv_sincpulse_reshape).', 'b');
title('Eye Diagram - sinc pulse');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -2.4 2.2]);
grid on;

figure;
plot(0:1/SampleFreq:1.99, Conv_RCgamma5_reshape.', 'b');
title('Eye Diagram - Raised Cosine (roll-off=0.5)');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -2.5 2.5]);
grid on;

figure;
plot(0:1/SampleFreq:1.99, Conv_RCgamma1_reshape.', 'b');
title('Eye Diagram - Raised Cosine (roll-off=1)');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -1.5 1.5]);
grid on;

% Task 2: Repeat Task 1 in the presence of additive white Gaussian noise (AWGN)

SNR_dB = 10;
NoisePower = 1./(10.^(0.1*SNR_dB)); % Noise Power (Eb = 1 in BPSK)

% Noise Array Generation based on SNR = 10dB
Noise1D = normrnd(0, sqrt(NoisePower/2), [1, N]);
AWGN_TX = bpsk_symbols + Noise1D;

figure;
stem(SymbolIndex, AWGN_TX(1:100));
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train - BPSK Symbols with Noise');
axis([0 10 -1.5 1.5]);
grid on;

% Task 1: Reshaping the sequences to build Eye Diagrams
% Without Noise
Conv_sincpulse_reshape = reshape(Conv_sincpulse, SampleFreq*2, N*SampleFreq/20).';
Conv_RCgamma5_reshape = reshape(Conv_RCgamma5, SampleFreq*2, N*SampleFreq/20).';
Conv_RCgamma1_reshape = reshape(Conv_RCgamma1, SampleFreq*2, N*SampleFreq/20).';

% Task 2: upsampling the transmit sequence
% With Noise
AWGNTx_Upsample = [AWGN_TX; zeros(SampleFreq-1, length(bpsk_symbols))];
AWGNTx_U = AWGNTx_Upsample(:);
figure;
stem(SymbolIndex, AWGNTx_U(1:100));
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train - Upsampled BPSK with noise');
axis([0 10 -1.5 1.5]);
grid on;

% Task 2: Generate eye diagrams for different pulse shaping filters
% With Noise
Conv_sincnoise = conv(AWGNTx_U, Sinc_Filt);
Conv_RC5noise = conv(AWGNTx_U, RC_gamma5);
Conv_R1noise = conv(AWGNTx_U, RC_gamma1);

% Task 2: Taking only the first 10000 samples
% With noise
Conv_sincnoise = Conv_sincnoise(1:10000);
Conv_RC5noise = Conv_RC5noise(1:10000);
Conv_R1noise = Conv_R1noise(1:10000);

% Task 2: Reshaping the sequences to build Eye Diagrams
% With Noise
Conv_sincnoise_reshape = reshape(Conv_sincnoise, SampleFreq*2, N*SampleFreq/20).';
Conv_RC5noise_reshape = reshape(Conv_RC5noise, SampleFreq*2, N*SampleFreq/20).';
Conv_R1noise_reshape = reshape(Conv_R1noise, SampleFreq*2, N*SampleFreq/20).';

% Task 2: Plotting the Eye Diagrams
% With Noise
figure;
plot(0:1/SampleFreq:1.99, Conv_sincnoise_reshape.', 'b');
title('Eye Diagram - Sinc Pulse with AWGN');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -2.4 2.2]);
grid on;

figure;
plot(0:1/SampleFreq:1.99, Conv_RC5noise_reshape.', 'b');
title('Eye Diagram - Raised Cosine (roll-off=0.5 noisy) with AWGN');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -2.4 2.2]);
grid on;

figure;
plot(0:1/SampleFreq:1.99, Conv_R1noise_reshape.', 'b');
title('Eye Diagram -  Raised Cosine (roll-off=1 noisy) with AWGN');
xlabel('Symbol Index');
ylabel('Amplitude');
axis([0 2 -2.4 2.2]);
grid on;
