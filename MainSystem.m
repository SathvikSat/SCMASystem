% clc;
clear all;

addpath(genpath('Blocks'));

%% System Initialisation
% Random seed set to 100
% rng(100);
% Initialising System Parameters
txParams = txConfig();

%% Generating Data

% Generating random data
txBitStreamMat = randi([0, 1], txParams.dataLength - txParams.coding.cc.tbl, txParams.numUsers);
txBitStreamMat = [txBitStreamMat; zeros(txParams.coding.cc.tbl, txParams.numUsers)];
txParams.test = txBitStreamMat;
%% Data Processing at Tx
% Passing the data for transmissioned.

txOut = Transmitter(txBitStreamMat, txParams);

%% Channel Model

% We assume that the CSI is perfectly known at the Tx
txDataStreamMat = txParams.CSI' .* txOut;

% Noise and Channel Tap

SNR = 10 ^ (txParams.SNRdb / 10);
noiseMat = (max(txParams.powerLevels) / sqrt(2 * SNR)) .* (randn(size(txDataStreamMat)) + (1i) * randn(size(txDataStreamMat)));

signalPower = norm(txOut) .^ 2;
noisePower = norm(noiseMat) .^ 2;

empSNR = signalPower / noisePower;
empSNRdb = 10 * log10(empSNR);

rxDataStreamMat = txDataStreamMat + noiseMat;


%% Receiver
% Detecting the information from received signal
rxBitStreamMat = Receiver(rxDataStreamMat, txParams);

% Error in received bitstream
errBits = sum(bitxor(txBitStreamMat, rxBitStreamMat));

if (~errBits)
    disp('Successful Transmission');
else
    disp(['Err Bits: ', num2str(errBits)]);
end
