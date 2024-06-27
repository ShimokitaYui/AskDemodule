
//------------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------ 
//
// C Model configuration for the "lps" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: -0.000000000000,-0.001336193413,-0.002621205416,-0.002733766157,0.000000000000,0.005833813023,0.011612705304,0.011286970966,-0.000000000000,-0.020296555983,-0.038076381152,-0.035897337464,0.000000000000,0.069373223511,0.153944232061,0.223615729383,0.250589530675,0.223615729383,0.153944232061,0.069373223511,0.000000000000,-0.035897337464,-0.038076381152,-0.020296555983,-0.000000000000,0.011286970966,0.011612705304,0.005833813023,0.000000000000,-0.002733766157,-0.002621205416,-0.001336193413,-0.000000000000
// chanpats: 173
// name: lps
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 33
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 1
// coeff_width: 12
// coeff_fract_width: 12
// chan_seq: 0
// num_channels: 1
// num_paths: 1
// data_width: 8
// data_fract_width: 0
// output_rounding_mode: 0
// output_width: 21
// output_fract_width: 12
// config_method: 0

const double lps_coefficients[33] = {-0.000000000000,-0.001336193413,-0.002621205416,-0.002733766157,0.000000000000,0.005833813023,0.011612705304,0.011286970966,-0.000000000000,-0.020296555983,-0.038076381152,-0.035897337464,0.000000000000,0.069373223511,0.153944232061,0.223615729383,0.250589530675,0.223615729383,0.153944232061,0.069373223511,0.000000000000,-0.035897337464,-0.038076381152,-0.020296555983,-0.000000000000,0.011286970966,0.011612705304,0.005833813023,0.000000000000,-0.002733766157,-0.002621205416,-0.001336193413,-0.000000000000};

const xip_fir_v7_2_pattern lps_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_lps_config() {
  xip_fir_v7_2_config config;
  config.name                = "lps";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &lps_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 33;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_QUANTIZED_ONLY;
  config.coeff_width         = 12;
  config.coeff_fract_width   = 12;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = lps_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 8;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_FULL_PRECISION;
  config.output_width        = 21;
  config.output_fract_width  = 12,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config lps_config = gen_lps_config();

