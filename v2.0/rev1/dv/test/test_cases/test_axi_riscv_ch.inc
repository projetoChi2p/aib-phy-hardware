  initial begin
    begin
      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: Get into Main initial", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");
      reset_duts ();
      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: Finish reset_duts", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");
      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: set to register mode for ms -> sl and sl -> ms", $time);
      $display("%0t: No dbi enabled", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");

      avmm_if_m1.cfg_write(17'h208, 4'hf, 32'h0600_0000);
      avmm_if_s1.cfg_write(17'h208, 4'hf, 32'h0600_0000);

      avmm_if_m1.cfg_write(17'h210, 4'hf, 32'h0000_0006);
      avmm_if_s1.cfg_write(17'h210, 4'hf, 32'h0000_0006);

      avmm_if_m1.cfg_write(17'h218, 4'hf, 32'h6060_0000);
      avmm_if_s1.cfg_write(17'h218, 4'hf, 32'h6060_0000);

      avmm_if_m1.cfg_write(17'h21c, 4'hf, 32'h0000_0000);
      avmm_if_s1.cfg_write(17'h21c, 4'hf, 32'h0000_0000);

      avmm_if_m1.cfg_write(17'h31c, 4'hf, 32'h0000_0000);
      avmm_if_s1.cfg_write(17'h31c, 4'hf, 32'h0000_0000);

      avmm_if_m1.cfg_write(17'h320, 4'hf, 32'h0000_0000);
      avmm_if_s1.cfg_write(17'h320, 4'hf, 32'h0000_0000);

      avmm_if_m1.cfg_write(17'h324, 4'hf, 32'h0000_0000);
      avmm_if_s1.cfg_write(17'h324, 4'hf, 32'h0000_0000);

      avmm_if_m1.cfg_write(17'h328, 4'hf, 32'h0000_0000);
      avmm_if_s1.cfg_write(17'h328, 4'hf, 32'h0000_0000);


      run_for_n_pkts_ms1 = 4;
      run_for_n_pkts_sl1 = 4;

      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: Performing duts_wakeup", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");

      duts_wakeup ();

      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: Waiting for link up", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");

      link_up ();

      $display("\n////////////////////////////////////////////////////////////////////////////");
      $display("%0t: AIB configuration successful", $time);
      $display("////////////////////////////////////////////////////////////////////////////\n");

      aib_cfg_done = 1'b1;
    end
  end
