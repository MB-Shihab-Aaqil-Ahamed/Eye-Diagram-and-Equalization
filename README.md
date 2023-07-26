# Eye-Diagram-and-Equalization

## Summary of MATLAB Tasks:

In this MATLAB project, we have implemented and analyzed three tasks related to digital communication systems.

## Task 1:
For Task 1, we generated eye diagrams for baseband 2-PAM signaling with different pulse shaping filters. The steps involved were:
1. Generated an impulse train representing BPSK symbols.
2. Obtained the transmit signal by convolving the impulse train with a pulse shaping filter (sinc function and raised cosine with roll-off factors of 0.5 and 1).
3. Generated the eye diagram of the transmit signal.

## Task 2:
In Task 2, we repeated Task 1, but this time in the presence of additive white Gaussian noise (AWGN). The steps were:
1. Generated a random binary sequence.
2. Performed 2-PAM modulation on the binary sequence.
3. Generated the received signal samples by convolving the symbols with a 3-tap multipath channel.
4. Added AWGN with a specified 𝐸𝑏/𝑁0 ratio (10 dB).
5. Compared the BER performance for different equalizer tap lengths and 𝐸𝑏/𝑁0 values.

## Task 3:
For Task 3, we designed a zero-forcing (ZF) equalizer for a 3-tap multipath channel. The steps were:
1. Generated a random binary sequence.
2. Performed 2-PAM modulation on the binary sequence.
3. Generated the received signal samples by convolving the symbols with a 3-tap multipath channel.
4. Added AWGN with 𝐸𝑏/𝑁0 varying from 0 to -10 dB.
5. Computed the ZF equalization filters at the receiver for different tap lengths (3, 5, 7, and 9).
6. Demodulated and converted the received symbols back to bits.
7. Calculated the bit error rate (BER) for each tap length and 𝐸𝑏/𝑁0 value.
8. Plotted the BER for all tap settings and 𝐸𝑏/𝑁0 values in the same figure.
9. Plotted the BER for an additive white Gaussian noise (AWGN) channel in the same figure.

### Explanation of Repository Content:
1. Source codes (.zip file): Contains MATLAB scripts and functions used to implement all three tasks.
2. Report (.pdf file): A comprehensive report presenting the methods, results, and analysis for each task.
3. Eye Diagrams: A folder containing the generated eye diagrams for Task 1.
4. BER Plots: A folder containing the BER plots for Task 2 and Task 3, comparing the performance under different conditions.
5. README: A README file providing a brief overview of the repository content and how to run the MATLAB scripts.

By following these tasks, we gained valuable insights into the performance of different signaling schemes, pulse shaping filters, and equalization techniques under the influence of noise and multipath channels. The results and analysis provided in the report will be useful for understanding the robustness of the communication system and making informed design choices for practical applications.
