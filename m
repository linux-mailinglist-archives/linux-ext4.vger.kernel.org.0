Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E25108343
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Nov 2019 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKXMEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 24 Nov 2019 07:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfKXMEA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 24 Nov 2019 07:04:00 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205641] New: kernel BUG at fs/buffer.c:3382!
Date:   Sun, 24 Nov 2019 12:03:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: udovdh@xs4all.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205641-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205641

            Bug ID: 205641
           Summary: kernel BUG at fs/buffer.c:3382!
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.12
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: udovdh@xs4all.nl
        Regression: No

Any advise on this one?


Nov 24 11:24:10 box3 kernel: [146269.049106] ------------[ cut here
]------------
Nov 24 11:24:10 box3 kernel: [146269.049110] kernel BUG at fs/buffer.c:3382!
Nov 24 11:24:10 box3 kernel: [146269.049118] invalid opcode: 0000 [#1]
PREEMPT SMP NOPTI
Nov 24 11:24:10 box3 kernel: [146269.049122] CPU: 6 PID: 231 Comm:
kswapd0 Tainted: G        W         5.3.11 #18
Nov 24 11:24:10 box3 kernel: [146269.049125] Hardware name: Gigabyte
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F10c 11/08/2019
Nov 24 11:24:10 box3 kernel: [146269.049131] RIP:
0010:free_buffer_head+0x5a/0x60
Nov 24 11:24:10 box3 kernel: [146269.049134] Code: 11 00 65 ff 0d b7 5a
e6 5b e8 c2 fe ff ff bf 01 00 00 00 e8 f8 cd ed ff 65 8b 05 09 ee e5 5b
85 c0 74 01 c3 e8 57 a6 e4 ff c3 <0f> 0b 0f 1f 40 00 0f b6 d2 41 57 41
56 66 83 fa 01 41 55 41 bd 00
Nov 24 11:24:10 box3 kernel: [146269.049136] RSP: 0018:ffffbca300343ab8
EFLAGS: 00010202
Nov 24 11:24:10 box3 kernel: [146269.049139] RAX: ffff9c097d4ebd90 RBX:
ffff9c097d4ebd68 RCX: 0000000000000000
Nov 24 11:24:10 box3 kernel: [146269.049141] RDX: ffff9c097d4ebdb0 RSI:
ffff9c097d4ebd68 RDI: ffff9c097d4ebd68
Nov 24 11:24:10 box3 kernel: [146269.049142] RBP: ffffe770070c8fd8 R08:
ffff9c0a4603c000 R09: 0000000000000002
Nov 24 11:24:10 box3 kernel: [146269.049143] R10: ffff9c0a48f656a0 R11:
ffff9c08646153a8 R12: ffff9c0a48f65724
Nov 24 11:24:10 box3 kernel: [146269.049144] R13: 0000000000000001 R14:
ffffe770070c8fd8 R15: ffffe770070c8fe0
Nov 24 11:24:10 box3 kernel: [146269.049145] FS:  0000000000000000(0000)
GS:ffff9c0a5f180000(0000) knlGS:0000000000000000
Nov 24 11:24:10 box3 kernel: [146269.049146] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 11:24:10 box3 kernel: [146269.049147] CR2: 0000096d455fe000 CR3:
0000000167346000 CR4: 00000000003406e0
Nov 24 11:24:10 box3 kernel: [146269.049148] Call Trace:
Nov 24 11:24:10 box3 kernel: [146269.049150]  try_to_free_buffers+0xb6/0x100
Nov 24 11:24:10 box3 kernel: [146269.049153]  shrink_page_list+0xbec/0xe60
Nov 24 11:24:10 box3 kernel: [146269.049155]
shrink_inactive_list+0x1ad/0x350
Nov 24 11:24:10 box3 kernel: [146269.049157]
shrink_node_memcg.isra.0+0x46e/0x7b0
Nov 24 11:24:10 box3 kernel: [146269.049159]  ? 0xffffffffa4000000
Nov 24 11:24:10 box3 kernel: [146269.049161]  ? __switch_to_asm+0x34/0x70
Nov 24 11:24:10 box3 kernel: [146269.049163]  shrink_node+0x80/0x2e0
Nov 24 11:24:10 box3 kernel: [146269.049164]  balance_pgdat+0x239/0x4a0
Nov 24 11:24:10 box3 kernel: [146269.049166]  kswapd+0x165/0x2f0
Nov 24 11:24:10 box3 kernel: [146269.049168]  ? wait_woken+0x70/0x70
Nov 24 11:24:10 box3 kernel: [146269.049170]  kthread+0xfb/0x130
Nov 24 11:24:10 box3 kernel: [146269.049171]  ? balance_pgdat+0x4a0/0x4a0
Nov 24 11:24:10 box3 kernel: [146269.049173]  ? kthread_park+0x70/0x70
Nov 24 11:24:10 box3 kernel: [146269.049174]  ret_from_fork+0x22/0x40
Nov 24 11:24:10 box3 kernel: [146269.049176] Modules linked in:
usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6 xt_state
ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack it87 hwmon_vid
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter msr uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev snd_usb_audio
videobuf2_common snd_hwdep snd_usbmidi_lib snd_rawmidi cdc_acm
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec
snd_hda_core snd_seq snd_seq_device snd_pcm k10temp i2c_piix4 snd_timer
snd bfq evdev acpi_cpufreq binfmt_misc ip_tables x_tables hid_generic
aesni_intel amdgpu backlight gpu_sched ttm sr_mod cdrom usbhid i2c_dev
autofs4
Nov 24 11:24:10 box3 kernel: [146269.049199] ---[ end trace
927d9ba4cbacd793 ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
