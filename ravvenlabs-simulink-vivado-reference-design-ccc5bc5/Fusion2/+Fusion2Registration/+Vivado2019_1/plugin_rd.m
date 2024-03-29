function hRD = plugin_rd()
% Reference design definition

% Construct reference design object
hRD = hdlcoder.ReferenceDesign('SynthesisTool', 'Xilinx Vivado');

hRD.ReferenceDesignName = 'Demo system';
hRD.BoardName = 'Fusion2';

% Tool information
hRD.SupportedToolVersion = {'2019.1'};

% add custom Vivado design
hRD.addCustomVivadoDesign( ...
    'CustomBlockDesignTcl', 'design_1.tcl', ...
    'VivadoBoardPart','krtkl.com:snickerdoodle_black:part0:1.0');

% points to C:\ProgramData\MATLAB\SupportPackages\R2020b\toolbox\hdlcoder\supportpackages\zynq7000\+fusion2
hRD.addIPRepository(...
    'IPListFunction', 'fusion2.fusion2_ip');

% Add constraint files
hRD.CustomConstraints = {'constraints.xdc'};

%% Add interfaces
% add clock interface
hRD.addClockInterface( ...
  'ClockConnection',   'processing_system7_0/FCLK_CLK0', ...
  'ResetConnection',   'rst_ps7_0_50M/peripheral_aresetn');

% add AXI4 and AXI4-Lite slave interfaces
hRD.addAXI4SlaveInterface( ...
    'InterfaceConnection', 'ps7_0_axi_periph/M05_AXI', .....
    'BaseAddress',         '0x43C60000', ...
    'MasterAddressSpace',  'processing_system7_0/Data');
     
% add AXI4-Stream interface
hRD.addAXI4StreamVideoInterface( ...
    'MasterChannelEnable',      true, ...
    'SlaveChannelEnable',       true, ...
    'MasterChannelConnection', 'axi_vdma_2/S_AXIS_S2MM', ...
    'SlaveChannelConnection',  'axis_broadcaster_0/M00_AXIS', ...
    'MasterChannelDataWidth',   64, ...
    'SlaveChannelDataWidth',    64);