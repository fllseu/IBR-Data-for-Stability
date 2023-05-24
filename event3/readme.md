## 20-Hz/80-Hz inverter-based resource dynamic event data 
The sets of event data were created from electromagnetic transient (EMT) simulation testbeds. 
case1_zeropower.mat: when the solar PV's exporting power level is zero.
case1_low.mat: the solar PV's exporting power level is 10%.
case1_high.mat: the solar PV's exporting power level is 100%. 
PLOT_sim.pdf is the live script file showing the simulation plots from the three data files. The dynamic event triggers 20-Hz oscillation in RMS voltage, current and power measurements, and 20-Hz/80-Hz in the phase voltage and current measurements. 


Details of the testbed can be found in the following paper:
https://ieeexplore.ieee.org/abstract/document/9893333

L. Fan et al., "Real-World 20-Hz IBR Subsynchronous Oscillations: Signatures and Mechanism Analysis," in IEEE Transactions on Energy Conversion, vol. 37, no. 4, pp. 2863-2873, Dec. 2022, doi: 10.1109/TEC.2022.3206795.

@ARTICLE{fan2022real,
  author={Fan, Lingling and Miao, Zhixin and Shah, Shahil and Cheng, Yunzhi and Rose, Jonathan and Huang, Shun-Hsien and Pal, Bikash and Xie, Xiaorong and Modi, Nilesh and Wang, Song and Zhu, Songzhe},
  journal={IEEE Transactions on Energy Conversion}, 
  title={Real-World 20-Hz IBR Subsynchronous Oscillations: Signatures and Mechanism Analysis}, 
  year={2022},
  volume={37},
  number={4},
  pages={2863-2873},
  doi={10.1109/TEC.2022.3206795}}
