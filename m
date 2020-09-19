Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751592709B9
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 03:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgISBoF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 21:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgISBoE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Sep 2020 21:44:04 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FBD20DD4;
        Sat, 19 Sep 2020 01:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600479843;
        bh=wjTfbTkItm+JL+9VQEiIKtfFew/XlrH870YgGwtSe9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltyryp4Q2fi45A1H7sFSl4gnaljtAGb58jTEhXMep/lFQLkQMNPvGUYVI+YouVRGt
         00gzd04PH5iKmToMZI6Xdics+T1TrWdB6t8rG6CeEEFyIkXDbVMEOka6PEtiHksZtj
         dRmY5GV4GpMLJbzIvrG4/jLWHzpXYkjHHaoljEcc=
Date:   Fri, 18 Sep 2020 18:44:01 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Meng Wang <meng@hcdatainc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: kernel panics when hot removing U.2 nvme disk
Message-ID: <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 11:47:27PM +0000, Meng Wang wrote:
> Hi,
> We found kernel panics today when doing test on hot remove U.2 nvme
> disk. After hot remove the nvme disk (formatted as ext4), the system
> freezes and all services stuck. Lot of kernel message flushed the
> syslog, including the CPU soft lockup, ext4 NULL point er dereferece
> and ib nic transmission timeout. The kernel panics and configuration
> are shown below. The used kernel is 5.4.0-050400-generic and OS is
> Ubuntu 16.04. Not sure whether it's a known bug or configuration
> error. Any advise are welcome.

[cc'ing ext4 mailing list]

The NULL dereference occured before the soft lockup, so I'm guessing the
Oops'ed process is holding the same lock the removal task wants.

Your kernel is a bit older, so it may be worth verifying if your
observation still occurs on the current stable or current mainline, but
the ext4 developers may have a better idea as this doesn't at least
initially appear specific to nvme.


> ------------------------------------------------------
> kernel panic snippet on cpu soft lockup
> ------------------------------------------------------
> Sep 18 21:27:27 hcd56 kernel: [88463.800033] watchdog: BUG: soft lockup - CPU#38 stuck for 23s! [irq/27-pciehp:416]
> Sep 18 21:27:27 hcd56 kernel: [88463.804076] ib0: transmit timeout: latency 20428 msecs
> Sep 18 21:27:27 hcd56 kernel: [88463.807609] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper intel_cstate input_leds intel_rapl_perf joydev mei_me mei lpc_ich ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm mlx4_ib sunrpc ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi scsi_transport_iscsi ib_ipoib ib_cm ib_core parport_pc ppdev lp parport autofs4 btrfs xor zstd_compress raid6_pq libcrc32c mlx4_en hid_generic usbhid hid ast drm_vram_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm ahci nvme xfrm_algo libahci nvme_core dca mdio wmi
> Sep 18 21:27:27 hcd56 kernel: [88463.812748] ib0: queue stopped 1, tx_head 7638106, tx_tail 7637978
> Sep 18 21:27:27 hcd56 kernel: [88463.894312] CPU: 38 PID: 416 Comm: irq/27-pciehp Tainted: G      D W         5.4.0-050400-generic #201911242031
> Sep 18 21:27:27 hcd56 kernel: [88463.894313] Hardware name: Supermicro SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
> Sep 18 21:27:27 hcd56 kernel: [88463.894329] RIP: 0010:native_queued_spin_lock_slowpath+0x62/0x1d0
> Sep 18 21:27:27 hcd56 kernel: [88463.894331] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 48 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 8b 37 81 fe 00 01 00 00
> Sep 18 21:27:27 hcd56 kernel: [88463.894332] RSP: 0000:ffffb1da46eefa40 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> Sep 18 21:27:27 hcd56 kernel: [88463.894334] RAX: 0000000000000101 RBX: ffff9717c9abe380 RCX: ffffb1da46eefa9c
> Sep 18 21:27:27 hcd56 kernel: [88463.894334] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9701e12d7b88
> Sep 18 21:27:27 hcd56 kernel: [88463.894335] RBP: ffffb1da46eefa40 R08: ffffb1da46eef918 R09: 0000000000000000
> Sep 18 21:27:27 hcd56 kernel: [88463.894336] R10: 0000000000000001 R11: ffff97183ffd4000 R12: ffff9717f9da0528
> Sep 18 21:27:27 hcd56 kernel: [88463.894336] R13: ffff9701e12d7b88 R14: ffff9703fa860000 R15: ffff9717f9da0630
> Sep 18 21:27:27 hcd56 kernel: [88463.894337] FS:  0000000000000000(0000) GS:ffff9717ffa80000(0000) knlGS:0000000000000000
> Sep 18 21:27:27 hcd56 kernel: [88463.894338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Sep 18 21:27:27 hcd56 kernel: [88463.894339] CR2: 00007fdd7bb3c000 CR3: 000000103564c002 CR4: 00000000003606e0
> Sep 18 21:27:27 hcd56 kernel: [88463.894340] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 18 21:27:27 hcd56 kernel: [88463.894340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 18 21:27:27 hcd56 kernel: [88463.894341] Call Trace:
> Sep 18 21:27:27 hcd56 kernel: [88463.894359]  _raw_spin_lock+0x1e/0x30
> Sep 18 21:27:27 hcd56 kernel: [88463.894376]  jbd2_journal_release_jbd_inode+0xb7/0x120
> Sep 18 21:27:27 hcd56 kernel: [88464.032946]  ? ext4_es_remove_extent+0x82/0x100
> Sep 18 21:27:27 hcd56 kernel: [88464.037480]  ext4_clear_inode+0x5f/0xa0
> Sep 18 21:27:27 hcd56 kernel: [88464.041318]  ext4_evict_inode+0x60/0x5b0
> Sep 18 21:27:27 hcd56 kernel: [88464.045234]  evict+0xd2/0x1b0
> Sep 18 21:27:27 hcd56 kernel: [88464.048196]  dispose_list+0x39/0x50
> Sep 18 21:27:27 hcd56 kernel: [88464.051680]  invalidate_inodes+0x160/0x190
> Sep 18 21:27:27 hcd56 kernel: [88464.055773]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
> Sep 18 21:27:27 hcd56 kernel: [88464.060730]  __invalidate_device+0x38/0x60
> Sep 18 21:27:27 hcd56 kernel: [88464.064822]  invalidate_partition+0x32/0x50
> Sep 18 21:27:27 hcd56 kernel: [88464.069006]  del_gendisk+0x117/0x2f0
> Sep 18 21:27:27 hcd56 kernel: [88464.072582]  nvme_ns_remove+0xf6/0x140 [nvme_core]
> Sep 18 21:27:27 hcd56 kernel: [88464.077371]  nvme_remove_namespaces+0x9f/0xe0 [nvme_core]
> Sep 18 21:27:27 hcd56 kernel: [88464.082760]  nvme_remove+0x66/0x170 [nvme]
> Sep 18 21:27:27 hcd56 kernel: [88464.086853]  pci_device_remove+0x3e/0xb0
> Sep 18 21:27:27 hcd56 kernel: [88464.090770]  device_release_driver_internal+0xf0/0x1c0
> Sep 18 21:27:27 hcd56 kernel: [88464.095898]  device_release_driver+0x12/0x20
> Sep 18 21:27:27 hcd56 kernel: [88464.100165]  pci_stop_bus_device+0x70/0xa0
> Sep 18 21:27:27 hcd56 kernel: [88464.104253]  pci_stop_and_remove_bus_device+0x13/0x20
> Sep 18 21:27:27 hcd56 kernel: [88464.109301]  pciehp_unconfigure_device+0x80/0x12f
> Sep 18 21:27:27 hcd56 kernel: [88464.114004]  pciehp_disable_slot+0x6e/0x100
> Sep 18 21:27:27 hcd56 kernel: [88464.118182]  pciehp_handle_presence_or_link_change+0xe1/0x150
> Sep 18 21:27:27 hcd56 kernel: [88464.123919]  pciehp_ist+0x122/0x130
> Sep 18 21:27:27 hcd56 kernel: [88464.127401]  irq_thread_fn+0x28/0x60
> Sep 18 21:27:27 hcd56 kernel: [88464.130973]  irq_thread+0xda/0x170
> Sep 18 21:27:27 hcd56 kernel: [88464.134369]  ? irq_forced_thread_fn+0x80/0x80
> Sep 18 21:27:27 hcd56 kernel: [88464.138724]  kthread+0x104/0x140
> Sep 18 21:27:27 hcd56 kernel: [88464.141953]  ? irq_thread_check_affinity+0xf0/0xf0
> Sep 18 21:27:27 hcd56 kernel: [88464.146736]  ? kthread_park+0x90/0x90
> Sep 18 21:27:27 hcd56 kernel: [88464.150397]  ret_from_fork+0x35/0x40
> 
> ---------------------------------------------------------------
> kernel panic on ext4 NULL pointer dereference
> ---------------------------------------------------------------
> Sep 18 21:27:00 hcd56 kernel: [88437.232231] VFS: busy inodes on changed media or resized disk nvme0n2
> Sep 18 21:27:01 hcd56 kernel: [88437.577487] Aborting journal on device nvme0n2-8.
> Sep 18 21:27:01 hcd56 kernel: [88437.582192] JBD2: Error -5 detected when updating journal superblock for nvme0n2-8.
> Sep 18 21:27:01 hcd56 kernel: [88437.589853] BUG: kernel NULL pointer dereference, address: 0000000000000008
> Sep 18 21:27:01 hcd56 kernel: [88437.596808] #PF: supervisor write access in kernel mode
> Sep 18 21:27:01 hcd56 kernel: [88437.602026] #PF: error_code(0x0002) - not-present page
> Sep 18 21:27:01 hcd56 kernel: [88437.607157] PGD 8000000b59cba067 P4D 8000000b59cba067 PUD fa8d3d067 PMD 0
> Sep 18 21:27:01 hcd56 kernel: [88437.614021] Oops: 0002 [#1] SMP PTI
> Sep 18 21:27:01 hcd56 kernel: [88437.617505] CPU: 31 PID: 3660 Comm: jbd2/nvme0n2-8 Tainted: G        W         5.4.0-050400-generic #201911242031
> Sep 18 21:27:01 hcd56 kernel: [88437.627781] Hardware name: Supermicro SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
> Sep 18 21:27:01 hcd56 kernel: [88437.635694] RIP: 0010:jbd2_journal_grab_journal_head+0x22/0x40
> Sep 18 21:27:01 hcd56 kernel: [88437.641522] Code: eb e7 66 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 f0 48 0f ba 2f 18 72 1c 48 8b 17 31 c0 f7 c2 00 00 02 00 74 08 48 8b 47 40 <83> 40 08 01 f0 80 67 03 fe 5d c3 f3 90 48 8b
> 07 a9 00 00 00 01 75
> Sep 18 21:27:01 hcd56 kernel: [88437.660259] RSP: 0018:ffffb1da4a17fce0 EFLAGS: 00010206
> Sep 18 21:27:01 hcd56 kernel: [88437.665475] RAX: 0000000000000000 RBX: ffff9717a5c274b0 RCX: 000000008020001c
> Sep 18 21:27:01 hcd56 kernel: [88437.672599] RDX: 0000000001e2c021 RSI: ffff9710e77ea900 RDI: ffff97120026fa90
> Sep 18 21:27:01 hcd56 kernel: [88437.679722] RBP: ffffb1da4a17fce0 R08: 0000000000000000 R09: ffffffffa67e2700
> Sep 18 21:27:01 hcd56 kernel: [88437.686848] R10: ffff971017b71400 R11: 0000000000000001 R12: ffff9710e77ea900
> Sep 18 21:27:01 hcd56 kernel: [88437.693973] R13: ffff9701e12d7b88 R14: ffff97120026fa92 R15: ffff9710e77ea900
> Sep 18 21:27:01 hcd56 kernel: [88437.701095] FS:  0000000000000000(0000) GS:ffff9717ff8c0000(0000) knlGS:0000000000000000
> Sep 18 21:27:01 hcd56 kernel: [88437.709174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Sep 18 21:27:01 hcd56 kernel: [88437.714909] CR2: 0000000000000008 CR3: 000000103564c005 CR4: 00000000003606e0
> Sep 18 21:27:01 hcd56 kernel: [88437.722035] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 18 21:27:01 hcd56 kernel: [88437.729160] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 18 21:27:01 hcd56 kernel: [88437.736284] Call Trace:
> Sep 18 21:27:01 hcd56 kernel: [88437.738733]  __jbd2_journal_insert_checkpoint+0x28/0x80
> Sep 18 21:27:01 hcd56 kernel: [88437.743954]  jbd2_journal_commit_transaction+0x124f/0x178d
> Sep 18 21:27:01 hcd56 kernel: [88437.749434]  ? try_to_del_timer_sync+0x54/0x80
> Sep 18 21:27:01 hcd56 kernel: [88437.753881]  kjournald2+0xb6/0x280
> Sep 18 21:27:01 hcd56 kernel: [88437.757286]  ? wait_woken+0x80/0x80
> Sep 18 21:27:01 hcd56 kernel: [88437.760778]  kthread+0x104/0x140
> Sep 18 21:27:01 hcd56 kernel: [88437.763231] EXT4-fs error (device nvme0n2): ext4_journal_check_start:61: Detected aborted journal
> Sep 18 21:27:01 hcd56 kernel: [88437.763293] EXT4-fs error (device nvme0n2): ext4_journal_check_start:61: Detected aborted journal
> Sep 18 21:27:01 hcd56 kernel: [88437.764002]  ? commit_timeout+0x20/0x20
> Sep 18 21:27:01 hcd56 kernel: [88437.764004]  ? kthread_park+0x90/0x90
> Sep 18 21:27:01 hcd56 kernel: [88437.764009]  ret_from_fork+0x35/0x40
> Sep 18 21:27:01 hcd56 kernel: [88437.764011] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper intel_cstate input_leds intel_rapl_perf joydev mei_me mei lpc_ich ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm mlx4_ib sunrpc ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi scsi_transport_iscsi ib_ipoib ib_cm ib_core parport_pc ppdev lp parport autofs4 btrfs xor zstd_compress raid6_pq libcrc32c mlx4_en hid_generic usbhid hid ast drm_vram_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm ahci nvme xfrm_algo libahci nvme_core dca mdio wmi
> Sep 18 21:27:01 hcd56 kernel: [88437.874368] CR2: 0000000000000008
> Sep 18 21:27:01 hcd56 kernel: [88437.877683] ---[ end trace 5a47dfdfd127baf6 ]---
