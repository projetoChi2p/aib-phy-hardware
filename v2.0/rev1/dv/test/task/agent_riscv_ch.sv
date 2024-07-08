// SPDX-License-Identifier: Apache-2.0
// Copyright (C) 2019 Intel Corporation. 

  task reset_duts ();
    begin
         $display("\n////////////////////////////////////////////////////////////////////////////");
         $display("%0t: Into task reset_dut", $time);
         $display("////////////////////////////////////////////////////////////////////////////\n");


         $display("\n////////////////////////////////////////////////////////////////////////////");
         $display("%0t:  task reset master and slave csr", $time);
         $display("////////////////////////////////////////////////////////////////////////////\n");

         avmm_if_m1.rst_n = 1'b0;
         avmm_if_m1.address = '0;
         avmm_if_m1.write = 1'b0;
         avmm_if_m1.read  = 1'b0;
         avmm_if_m1.writedata = '0;
         avmm_if_m1.byteenable = '0;
         avmm_if_s1.rst_n = 1'b0;
         avmm_if_s1.address = '0;
         avmm_if_s1.write = 1'b0;
         avmm_if_s1.read  = 1'b0;
         avmm_if_s1.writedata = '0;
         avmm_if_s1.byteenable = '0;

         intf_s1.por = 1'b1;
         intf_s1.i_conf_done = 1'b0;
         intf_s1.ns_mac_rdy      = '0;
         intf_s1.ns_adapter_rstn = '0;
         intf_s1.sl_rx_dcc_dll_lock_req = '0;
         intf_s1.sl_tx_dcc_dll_lock_req = '0;

         intf_m1.por = 1'b1;
         intf_m1.i_conf_done = 1'b0;
         intf_m1.ns_mac_rdy      = '0;
         intf_m1.ns_adapter_rstn = '0;
         intf_m1.ms_rx_dcc_dll_lock_req = '0;
         intf_m1.ms_tx_dcc_dll_lock_req = '0;

         intf_m1.data_in[79:0] = 80'b0;
         intf_s1.data_in[79:0] = 80'b0;
         intf_m1.data_in_f[319:0] = 320'b0;
         intf_s1.data_in_f[319:0] = 320'b0;

         #100ns;

         avmm_if_m1.rst_n = 1'b1;
         avmm_if_s1.rst_n = 1'b1;

         #100ns;
         $display("%0t: %m: de-asserting configuration reset and start configuration setup", $time);



  //     intf_m1.m_por_ovrd = 1'b1;   //Check with Wei regarding the polarity      
  //     intf_s1.m_device_detect_ovrd = 1'b0;
  //     intf_s1.m_power_on_reset = 1'b0;
         #100ns;
         intf_s1.por = 1'b0;
         $display("\n////////////////////////////////////////////////////////////////////////////");
         $display("%0t:  slave power on  de-asserted", $time);
         $display("////////////////////////////////////////////////////////////////////////////\n");

         #200ns;
         intf_m1.por = 1'b0;
         $display("\n////////////////////////////////////////////////////////////////////////////");
         $display("%0t: master power_on_reset de-asserted", $time);
         $display("////////////////////////////////////////////////////////////////////////////\n");
    end
  endtask

  task duts_wakeup ();
     begin
          intf_m1.i_conf_done = 1'b1;
          intf_s1.i_conf_done = 1'b1;

          intf_m1.ns_mac_rdy = 1'b1; 
          intf_s1.ns_mac_rdy = 1'b1; 

          #1000ns;
          intf_m1.ns_adapter_rstn = 1'b1;
          intf_s1.ns_adapter_rstn = 1'b1;
          #1000ns;
          intf_s1.sl_rx_dcc_dll_lock_req = 1'b1;
          intf_s1.sl_tx_dcc_dll_lock_req = 1'b1;

          intf_m1.ms_rx_dcc_dll_lock_req = 1'b1;
          intf_m1.ms_tx_dcc_dll_lock_req = 1'b1;


     end
  endtask

  task link_up (); 
       begin
         wait (intf_s1.ms_tx_transfer_en == 1'b1);
         wait (intf_s1.sl_tx_transfer_en == 1'b1);
          
       end
  endtask
