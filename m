Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3212B17FF
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Nov 2020 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKMJQU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 13 Nov 2020 04:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgKMJQS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Nov 2020 04:16:18 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] New: kernel BUG at fs/ext4/page-io.c:126!
Date:   Fri, 13 Nov 2020 09:16:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emchroma@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210185

            Bug ID: 210185
           Summary: kernel BUG at fs/ext4/page-io.c:126!
           Product: File System
           Version: 2.5
    Kernel Version: 5.9.8
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: emchroma@gmail.com
        Regression: No

We get the following error on several machines with kernel 5.9.8 (the same with
5.9.1).
The setup on all machines is identical. The error happens after 10-15 minutes
of
moderate I/O with a threaded application.

[ 2443.940844] kernel BUG at fs/ext4/page-io.c:126!
[ 2443.941045] invalid opcode: 0000 [#1] SMP PTI
[ 2443.941070] CPU: 8 PID: 982 Comm: kworker/u64:1 Not tainted 5.9.8-kd-cluster
#1
[ 2443.941111] Hardware name: Supermicro SYS-1028GQ-TR/X10DGQ, BIOS 1.0a
08/14/2015
[ 2443.941183] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work [ext4]
[ 2443.941234] RIP: 0010:ext4_finish_bio+0x25e/0x260 [ext4]
[ 2443.941262] Code: da 49 c1 e6 06 4c 03 30 e9 11 fe ff ff 48 83 c4 30 5b 5d
41 5c 41 5d 41 5e 41 5f c3 4d 8b 7e 28 4c 89 74 24 28 e9 2b fe ff ff <0f> 0b 0f
1f 44 00 00 48 8b 07 48 39 c7 0f 85 cf 00 00 00 f6 47 28
[ 2443.941365] RSP: 0018:ffffb1c68731bd98 EFLAGS: 00010246
[ 2443.941391] RAX: 0000000000000081 RBX: ffff9e662470f000 RCX:
0000000000000001
[ 2443.941413] RDX: 0000000000001000 RSI: 0000000000000001 RDI:
0000000000001000
[ 2443.941436] RBP: 0000000000000000 R08: ffff9e6834e68800 R09:
0000000000000000
[ 2443.941457] R10: ffffb1c68731bd00 R11: 0000000000000000 R12:
ffff9e662470f000
[ 2443.941480] R13: ffff9e65f71fcc18 R14: ffffe6bb792cb0c0 R15:
ffff9e66b626e2d8
[ 2443.941502] FS:  0000000000000000(0000) GS:ffff9e783fa00000(0000)
knlGS:0000000000000000
[ 2443.941527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2443.941545] CR2: 0000564319c27638 CR3: 0000000fce3ae002 CR4:
00000000001706e0
[ 2443.941568] Call Trace:
[ 2443.941593]  ext4_release_io_end+0x48/0xf0 [ext4]
[ 2443.941618]  ext4_end_io_rsv_work+0xbd/0x180 [ext4]
[ 2443.941637]  process_one_work+0x199/0x380
[ 2443.941653]  ? pwq_activate_delayed_work+0x3b/0xa0
[ 2443.941671]  worker_thread+0x4f/0x3b0
[ 2443.941685]  ? rescuer_thread+0x360/0x360
[ 2443.941700]  kthread+0xfc/0x130
[ 2443.941712]  ? kthread_associate_blkcg+0x90/0x90
[ 2443.941729]  ret_from_fork+0x22/0x30
[ 2443.942216] Modules linked in: nfsv3 nfs_acl xt_conntrack xt_MASQUERADE
nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter
bridge bpfilter 8021q garp mrp stp llc rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace nfs_ssc fscache overlay intel_rapl_msr iTCO_wdt
intel_pmc_bxt iTCO_vendor_support intel_rapl_common sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd
cryptd glue_helper rapl intel_cstate intel_uncore pcspkr ast drm_vram_helper
drm_ttm_helper ttm drm_kms_helper cec joydev sg drm snd_hda_codec_hdmi lpc_ich
snd_hda_intel snd_intel_dspcfg snd_hda_codec mei_me mei snd_hda_core snd_hwdep
snd_pcm snd_timer snd soundcore ioatdma acpi_ipmi ipmi_si ipmi_devintf
ipmi_msghandler evdev acpi_power_meter acpi_pad tiny_power_button button
ecryptfs cbc encrypted_keys parport_pc ppdev
[ 2443.942244]  lp parport sunrpc ip_tables x_tables autofs4 hid_generic usbhid
hid ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor sd_mod t10_pi raid6_pq libcrc32c crc32c_generic
raid1 raid0 multipath linear md_mod ahci libahci ehci_pci ehci_hcd libata igb
i2c_i801 i2c_algo_bit crc32c_intel scsi_mod i2c_smbus usbcore dca wmi
[ 2443.948743] ---[ end trace f72fe3c4ac9cf471 ]---
[ 2443.952835] RIP: 0010:ext4_finish_bio+0x25e/0x260 [ext4]
[ 2443.953707] Code: da 49 c1 e6 06 4c 03 30 e9 11 fe ff ff 48 83 c4 30 5b 5d
41 5c 41 5d 41 5e 41 5f c3 4d 8b 7e 28 4c 89 74 24 28 e9 2b fe ff ff <0f> 0b 0f
1f 44 00 00 48 8b 07 48 39 c7 0f 85 cf 00 00 00 f6 47 28
[ 2443.955098] RSP: 0018:ffffb1c68731bd98 EFLAGS: 00010246
[ 2443.955755] RAX: 0000000000000081 RBX: ffff9e662470f000 RCX:
0000000000000001
[ 2443.956572] RDX: 0000000000001000 RSI: 0000000000000001 RDI:
0000000000001000
[ 2443.957394] RBP: 0000000000000000 R08: ffff9e6834e68800 R09:
0000000000000000
[ 2443.958071] R10: ffffb1c68731bd00 R11: 0000000000000000 R12:
ffff9e662470f000
[ 2443.958790] R13: ffff9e65f71fcc18 R14: ffffe6bb792cb0c0 R15:
ffff9e66b626e2d8
[ 2443.959509] FS:  0000000000000000(0000) GS:ffff9e783fa00000(0000)
knlGS:0000000000000000
[ 2443.960272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2443.961139] CR2: 0000564319c27638 CR3: 0000000fce3ae002 CR4:
00000000001706e0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
