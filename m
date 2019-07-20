Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F306F01A
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2019 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfGTQxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 20 Jul 2019 12:53:22 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41606 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbfGTQxW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 20 Jul 2019 12:53:22 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3376D288E4
        for <linux-ext4@vger.kernel.org>; Sat, 20 Jul 2019 16:53:21 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 2663B288E0; Sat, 20 Jul 2019 16:53:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Sat, 20 Jul 2019 16:53:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: slacker702@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203317-13602-8FKJBkQhTg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203317-13602@https.bugzilla.kernel.org/>
References: <bug-203317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203317

slack3r (slacker702@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |slacker702@gmail.com

--- Comment #3 from slack3r (slacker702@gmail.com) ---
Got similar here:
[ 3651.932517] WARNING: CPU: 3 PID: 3625 at fs/ext4/inode.c:3925
ext4_set_page_dirty+0x3e/0x50 [ext4]
[ 3651.932522] Modules linked in: fuse ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter nct6775 msr hwmon_vid sunrpc intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mousedev joydev
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec_hdmi
aesni_intel snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
aes_x86_64 crypto_simd snd_hda_intel iTCO_wdt iTCO_vendor_support cryptd
snd_hda_codec glue_helper snd_hda_core i2c_i801 snd_hwdep snd_pcm snd_timer snd
e1000e mxm_wmi soundcore intel_pch_thermal mei_me mei input_leds intel_cstate
led_class evdev intel_uncore mac_hid pcc_cpufreq intel_rapl_perf wmi loop sg
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sd_mod serio_raw
atkbd libps2 ahci libahci libata crc32c_intel scsi_mod i8042 serio hid_logitech
ff_memless i915 intel_gtt i2c_algo_bit cec rc_core drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops drm agpgart
[ 3651.932597] CPU: 3 PID: 3625 Comm: kworker/u8:3 Not tainted 5.2.1-1-mainline
#1
[ 3651.932599] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./Z170M Extreme4, BIOS P7.20 12/13/2016
[ 3651.932610] Workqueue: writeback wb_workfn (flush-8:0)
[ 3651.932662] RIP: 0010:ext4_set_page_dirty+0x3e/0x50 [ext4]
[ 3651.932669] Code: 48 8b 00 a8 01 75 16 48 8b 57 08 48 8d 42 ff 83 e2 01 48
0f 44 c7 48 8b 00 a8 08 74 0d 48 8b 07 f6 c4 20 74 0f e9 72 75 8d f1 <0f> 0b 48
8b 07 f6 c4 20 75 f1 0f 0b e9 61 75 8d f1 90 0f 1f 44 00
[ 3651.932672] RSP: 0018:ffffb250c86ab700 EFLAGS: 00010246
[ 3651.932677] RAX: 02ffff0000002036 RBX: ffff9ee52c494880 RCX:
0000000000000000
[ 3651.932679] RDX: 0000000000000000 RSI: 0000000206000000 RDI:
ffffe7a6481cdc40
[ 3651.932684] RBP: ffffe7a6481cdc40 R08: 0000000206000000 R09:
0000000000000000
[ 3651.932686] R10: ffff9ee55baacb98 R11: 0000000000000000 R12:
0000000000207371
[ 3651.932688] R13: ffff9ee52c7556c0 R14: ffff9ee54e66a790 R15:
0000000000000000
[ 3651.932692] FS:  0000000000000000(0000) GS:ffff9ee56eb80000(0000)
knlGS:0000000000000000
[ 3651.932695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3651.932697] CR2: 0000556097c527c0 CR3: 0000000159a0a003 CR4:
00000000003606e0
[ 3651.932699] Call Trace:
[ 3651.932888]  i915_gem_userptr_put_pages+0x13f/0x1c0 [i915]
[ 3651.933030]  __i915_gem_object_put_pages+0x5e/0xa0 [i915]
[ 3651.933187]  userptr_mn_invalidate_range_start+0x209/0x260 [i915]
[ 3651.933212]  __mmu_notifier_invalidate_range_start+0x57/0xa0
[ 3651.933229]  page_mkclean_one+0x1b6/0x1d0
[ 3651.933243]  rmap_walk_file+0xf4/0x260
[ 3651.933253]  page_mkclean+0xa4/0xc0
[ 3651.933261]  ? page_referenced_one+0x170/0x170
[ 3651.933269]  ? pmdp_collapse_flush+0x10/0x10
[ 3651.933276]  clear_page_dirty_for_io+0x9c/0x240
[ 3651.933353]  mpage_submit_page+0x1f/0x70 [ext4]
[ 3651.933410]  mpage_process_page_bufs+0xe7/0xf0 [ext4]
[ 3651.933458]  mpage_prepare_extent_to_map+0x1c4/0x280 [ext4]
[ 3651.933513]  ext4_writepages+0x4f7/0xef0 [ext4]
[ 3651.933527]  ? update_blocked_averages+0x894/0xa90
[ 3651.933538]  ? cpumask_next_and+0x19/0x20
[ 3651.933547]  ? do_writepages+0x43/0xd0
[ 3651.933599]  ? ext4_mark_inode_dirty+0x1e0/0x1e0 [ext4]
[ 3651.933606]  do_writepages+0x43/0xd0
[ 3651.933645]  __writeback_single_inode+0x3d/0x3d0
[ 3651.933653]  writeback_sb_inodes+0x1f0/0x430
[ 3651.933666]  __writeback_inodes_wb+0x4c/0xc0
[ 3651.933674]  wb_writeback+0x28f/0x340
[ 3651.933688]  ? get_nr_inodes+0x32/0x50
[ 3651.933695]  wb_workfn+0x3b6/0x480
[ 3651.933714]  process_one_work+0x1d1/0x3e0
[ 3651.933730]  worker_thread+0x4a/0x3d0
[ 3651.933752]  kthread+0xfb/0x130
[ 3651.933761]  ? process_one_work+0x3e0/0x3e0
[ 3651.933774]  ? kthread_park+0x90/0x90
[ 3651.933786]  ret_from_fork+0x35/0x40
[ 3651.933799] ---[ end trace 7a0001b6900a9f55 ]---

Kernel version: 5.2.1

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
