function txParams = txConfig()
    txParams.QAM = 16;
    txParams.softQAM = 1;
    
    % SNR in db
    txParams.SNRdb = 20;
    
    % Trellis Structure for 1/2 code rate convolution coder obtained from
    % a MATLAB tutorial on channel coding. (Constraint length, M = 7)
    txParams.coding.cc.trellis = poly2trellis(7, {'1 + x^3 + x^4 + x^5 + x^6', '1 + x + x^3 + x^4 + x^6'});
    txParams.coding.cc.tbl = 32;
    txParams.coding.codeRate = 1/2;
    
    % Symbol length for codebook mapping
    txParams.symLen = 2;
    
    % codebook word length
    txParams.wordLen = 4;
    
    % Length of each message of every user
    txParams.dataLength = 960;
    
    % Number of users
    txParams.numUsers = 2;
    
    % Assuming the CSI (Rayleigh Fading)
    txParams.CSI = randn(txParams.numUsers, 1);
%     txParams.CSI = randn(txParams.numUsers, 1) + 1i * (randn(txParams.numUsers, 1));
    [~, sortIdx] = sort(abs(txParams.CSI), 'ascend');
    txParams.CSI = txParams.CSI(sortIdx);
    
%     txParams.CSI = [1.15; 1.1];
    txParams.CSI = [0.5; 1];
    
    % Allocating buffer space for power allocation coefficients
    txParams.powerLevels = zeros(txParams.numUsers, 1);
    
    % Codebooks
    
    % Codebooks
    CB(:,:,1) = [ 0                  0                  0                  0;...
                 -0.1815-1j*0.1318  -0.6351-1j*0.4615   0.6351+1j*0.4615   0.1815+1j*0.1318;...
                  0                  0                  0                  0;...
                  0.7851            -0.2243             0.2243            -0.7851 ];

    CB(:,:,2) = [ 0.7851            -0.2243             0.2243            -0.7851;...
                  0                  0                  0                  0;...
                 -0.1815-1j*0.1318  -0.6351-1j*0.4615   0.6351+1j*0.4615   0.1815+1j*0.1318;...
                  0                  0                  0                  0 ];

    CB(:,:,3) = [-0.6351+1j*0.4615   0.1815-1j*0.1318  -0.1815+1j*0.1318   0.6351-1j*0.4615;...
                  0.1392-1j*0.1759   0.4873-1j*0.6156  -0.4873+1j*0.6156  -0.1392+1j*0.1759;...
                  0                  0                  0                  0;...
                  0                  0                  0                  0 ];

    CB(:,:,4) = [ 0                  0                  0                  0;...
                  0                  0                  0                  0;...
                  0.7851            -0.2243             0.2243            -0.7851;...
                 -0.0055-1j*0.2242  -0.0193-1j*0.7848   0.0193+1j*0.7848   0.0055+1j*0.2242 ];

    CB(:,:,5) = [-0.0055-1j*0.2242  -0.0193-1j*0.7848   0.0193+1j*0.7848   0.0055+1j*0.2242;...
                  0                  0                  0                  0;...
                  0                  0                  0                  0;...
                 -0.6351+1j*0.4615   0.1815-1j*0.1318  -0.1815+1j*0.1318   0.6351-1j*0.4615 ];

    CB(:,:,6) = [ 0                  0                  0                  0;...
                  0.7851            -0.2243             0.2243            -0.7851;...
                  0.1392-1j*0.1759   0.4873-1j*0.6156  -0.4873+1j*0.6156  -0.1392+1j*0.1759;...
                  0                  0                  0                  0 ];
              
    txParams.codeBook = CB;

end