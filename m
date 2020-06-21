Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605FA202CC3
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jun 2020 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgFUUjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 21 Jun 2020 16:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgFUUjr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 21 Jun 2020 16:39:47 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 208271] New: Occurred when tried to create an ext4 filesystem
 on an exfat micro-sd. Trace is in dexcription
Date:   Sun, 21 Jun 2020 20:39:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dreamshader@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-208271-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208271

            Bug ID: 208271
           Summary: Occurred when tried to create an ext4 filesystem on an
                    exfat micro-sd. Trace is in dexcription
           Product: File System
           Version: 2.5
    Kernel Version: 4.15.0-106-generic
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: dreamshader@gmx.de
        Regression: No

[  125.833223] ------------[ cut here ]------------
[  125.833228] kernel BUG at
/build/linux-WWApIw/linux-4.15.0/fs/ext4/extents_status.c:763!
[  125.833243] invalid opcode: 0000 [#1] SMP PTI
[  125.833245] Modules linked in: mmc_block rfcomm vmw_vsock_vmci_transport
vsock vmw_vmci appletalk ipx p8023 psnap p8022 llc pci_stub vboxpci(OE)
vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) cmac bnep binfmt_misc
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic nls_iso8859_1
i915 arc4 iwldvm mac80211 intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel btusb btrtl btbcm btintel bluetooth kvm iwlwifi cdc_mbim
cdc_wdm qcserial cdc_ncm usb_wwan usbnet usbserial ecdh_generic mii irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel
drm_kms_helper cfg80211 drm aes_x86_64 crypto_simd glue_helper cryptd
intel_cstate intel_rapl_perf snd_hda_intel snd_hda_codec joydev input_leds
serio_raw rtsx_pci_ms memstick mac_hid mei_me mei snd_hda_core snd_hwdep
snd_pcm
[  125.833293]  snd_timer snd tpm_infineon soundcore i2c_algo_bit lpc_ich
fb_sys_fops syscopyarea sysfillrect shpchp sysimgblt fujitsu_laptop
sparse_keymap video nfsd auth_rpcgss nfs_acl lockd sch_fq_codel grace sunrpc
parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid
rtsx_pci_sdmmc psmouse e1000e ahci libahci rtsx_pci ptp pps_core
[  125.833319] CPU: 1 PID: 1910 Comm: pool Tainted: G        W  OE   
4.15.0-106-generic #107-Ubuntu
[  125.833321] Hardware name: FUJITSU LIFEBOOK E752/FJNB253, BIOS Version 2.07
02/25/2013
[  125.833331] RIP: 0010:ext4_es_cache_extent+0xfa/0x110
[  125.833334] RSP: 0018:ffffa34fc2d3b850 EFLAGS: 00010213
[  125.833337] RAX: 07ffffffffffffff RBX: ffff8ba23bbdb018 RCX:
0000ffffffffffff
[  125.833339] RDX: 0000000000007fff RSI: 00000000ffffffff RDI:
ffff8ba25bbf1208
[  125.833342] RBP: ffffa34fc2d3b8a0 R08: 1000ffffffffffff R09:
00000000000003bb
[  125.833344] R10: 0000000000000000 R11: 0000005053b79602 R12:
0000000000007ffd
[  125.833346] R13: ffff8ba25bbf1208 R14: 00000000ffffffff R15:
00000000ffffffff
[  125.833349] FS:  00007fd078f7a700(0000) GS:ffff8ba29e240000(0000)
knlGS:0000000000000000
[  125.833352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.833354] CR2: 00005613c0127640 CR3: 0000000406eec002 CR4:
00000000001606e0
[  125.833357] Call Trace:
[  125.833365]  ext4_cache_extents+0x87/0xd0
[  125.833369]  __read_extent_tree_block+0xed/0x180
[  125.833374]  ? _cond_resched+0x19/0x40
[  125.833379]  ext4_find_extent+0x153/0x310
[  125.833382]  ext4_ext_map_blocks+0x77/0xf10
[  125.833389]  ? blk_queue_bio+0x35f/0x450
[  125.833393]  ? bit_wait+0x60/0x60
[  125.833396]  ? schedule+0x2c/0x80
[  125.833399]  ? io_schedule+0x16/0x40
[  125.833405]  ext4_map_blocks+0x414/0x600
[  125.833410]  _ext4_get_block+0x75/0x100
[  125.833415]  ext4_get_block+0x16/0x20
[  125.833420]  generic_block_bmap+0x4e/0x70
[  125.833425]  ext4_bmap+0x75/0xe0
[  125.833430]  bmap+0x1f/0x30
[  125.833437]  jbd2_journal_init_inode+0x16/0xd0
[  125.833440]  ext4_load_journal+0x18a/0x5e1
[  125.833444]  ? down_write+0x12/0x40
[  125.833450]  ? register_shrinker+0x25/0x30
[  125.833454]  ext4_fill_super+0x29e7/0x3200
[  125.833462]  mount_bdev+0x248/0x290
[  125.833465]  ? ext4_calculate_overhead+0x4a0/0x4a0
[  125.833469]  ? mount_bdev+0x248/0x290
[  125.833472]  ? ext4_calculate_overhead+0x4a0/0x4a0
[  125.833477]  ext4_mount+0x15/0x20
[  125.833482]  mount_fs+0x37/0x160
[  125.833485]  ? alloc_vfsmnt+0x1b3/0x230
[  125.833490]  vfs_kern_mount.part.24+0x5d/0x110
[  125.833495]  do_mount+0x5ed/0xce0
[  125.833498]  ? memdup_user+0x4f/0x80
[  125.833503]  SyS_mount+0x98/0xe0
[  125.833508]  do_syscall_64+0x73/0x130
[  125.833514]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  125.833517] RIP: 0033:0x7fd07bb853ca
[  125.833520] RSP: 002b:00007fd078f792a8 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[  125.833523] RAX: ffffffffffffffda RBX: 00007fd06c00c400 RCX:
00007fd07bb853ca
[  125.833525] RDX: 00007fd06c06fea0 RSI: 00007fd06c06fe80 RDI:
00007fd06c06fec0
[  125.833527] RBP: 0000000000000000 R08: 0000000000000000 R09:
00007fd06c06696f
[  125.833529] R10: 00000000c0ed0006 R11: 0000000000000202 R12:
00007fd06c06fec0
[  125.833531] R13: 00007fd06c06fea0 R14: 0000000000000000 R15:
00007fd07d4ea8a4
[  125.833534] Code: 2f 01 48 85 db 74 1f 48 8b 03 48 8b 7b 08 48 83 c3 18 48
8d 55 b0 4c 89 ee e8 f3 d7 8d 00 48 8b 03 48 85 c0 75 e4 e9 55 ff ff ff <0f> 0b
e8 8f a8 d6 ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 
[  125.833566] RIP: ext4_es_cache_extent+0xfa/0x110 RSP: ffffa34fc2d3b850
[  125.833570] ---[ end trace 3ba194e33d8cb275 ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
