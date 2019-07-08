Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5B61FD1
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jul 2019 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfGHNuT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 8 Jul 2019 09:50:19 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45580 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731507AbfGHNuT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jul 2019 09:50:19 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3E4DA285A5
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jul 2019 13:50:18 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 32F7D285BD; Mon,  8 Jul 2019 13:50:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Mon, 08 Jul 2019 13:50:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: howaboutsynergy@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203317-13602-u4ZtEYw0ZV@https.bugzilla.kernel.org/>
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

howaboutsynergy (howaboutsynergy@pm.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chris@chris-wilson.co.uk,
                   |                            |howaboutsynergy@pm.me,
                   |                            |jack@suse.cz, tytso@mit.edu

--- Comment #1 from howaboutsynergy (howaboutsynergy@pm.me) ---
Just hit this on the newly released kernel 5.2:

```
Jul 08 14:49:04 i87k kernel: i2c i2c-3: NAK from device addr 0x50 msg #0
Jul 08 14:49:22 i87k kernel: WARNING: CPU: 11 PID: 1021 at fs/ext4/inode.c:3925
ext4_set_page_dirty+0x39/0x50
Jul 08 14:49:22 i87k kernel: Modules linked in: msr xt_TCPMSS iptable_mangle
iptable_security iptable_nat nf_nat iptable_raw nf_log_ipv4 nf_log_common
xt_owner xt_LOG xt_connlimit nf_conncount xt_conntrack nf_conntrack
nf_defrag_ipv4 xt_hashlimit xt_multiport xt_addrtype snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp i915 crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel intel_cstate snd_hda_intel i2c_algo_bit snd_hda_codec
drm_kms_helper snd_hwdep snd_hda_core syscopyarea sysfillrect snd_pcm sysimgblt
fb_sys_fops snd_timer intel_uncore iTCO_wdt drm snd iTCO_vendor_support pcspkr
intel_rapl_perf e1000e soundcore i2c_i801 drm_panel_orientation_quirks xhci_pci
xhci_hcd
Jul 08 14:49:22 i87k kernel: CPU: 11 PID: 1021 Comm: Xorg Kdump: loaded
Tainted: G     U            5.2.0-g0ecfebd2b524 #16
Jul 08 14:49:22 i87k kernel: Hardware name: System manufacturer System Product
Name/PRIME Z370-A, BIOS 1002 07/02/2018
Jul 08 14:49:22 i87k kernel: RIP: 0010:ext4_set_page_dirty+0x39/0x50
Jul 08 14:49:22 i87k kernel: Code: 48 8b 00 a8 01 75 16 48 8b 57 08 48 8d 42 ff
83 e2 01 48 0f 44 c7 48 8b 00 a8 08 74 0d 48 8b 07 f6 c4 20 74 0f e9 87 eb f8
ff <0f> 0b 48 8b 07 f6 c4 20 75 f1 0f 0b e9 76 eb f8 ff 66 0f 1f 44 00
Jul 08 14:49:22 i87k kernel: RSP: 0018:ffffb04a8622bc88 EFLAGS: 00010246
Jul 08 14:49:22 i87k kernel: RAX: 002fffc000002036 RBX: ffff99c48020e3c0 RCX:
0000000000000000
Jul 08 14:49:22 i87k kernel: RDX: 0000000000000000 RSI: 000000076c000000 RDI:
ffffdd669db10840
Jul 08 14:49:22 i87k kernel: RBP: ffffdd669db10840 R08: 0000000000000000 R09:
0000000000000000
Jul 08 14:49:22 i87k kernel: R10: 0000000000000000 R11: 0000000000000000 R12:
000000000076c421
Jul 08 14:49:22 i87k kernel: R13: ffff99c4477923c0 R14: ffff99c4896cbbd0 R15:
0000000000000000
Jul 08 14:49:22 i87k kernel: FS:  00007bd2ce71edc0(0000)
GS:ffff99c4edac0000(0000) knlGS:0000000000000000
Jul 08 14:49:22 i87k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 08 14:49:22 i87k kernel: CR2: 000070a6f8001920 CR3: 00000008253e2006 CR4:
00000000003606e0
Jul 08 14:49:22 i87k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
Jul 08 14:49:22 i87k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
Jul 08 14:49:22 i87k kernel: Call Trace:
Jul 08 14:49:22 i87k kernel:  i915_gem_userptr_put_pages+0x135/0x180 [i915]
Jul 08 14:49:22 i87k kernel:  __i915_gem_object_put_pages+0x56/0x90 [i915]
Jul 08 14:49:22 i87k kernel:  userptr_mn_invalidate_range_start+0x17f/0x210
[i915]
Jul 08 14:49:22 i87k kernel:  __mmu_notifier_invalidate_range_start+0x52/0x90
Jul 08 14:49:22 i87k kernel:  unmap_vmas+0xb3/0xd0
Jul 08 14:49:22 i87k kernel:  unmap_region+0xa3/0x100
Jul 08 14:49:22 i87k kernel:  ? ep_poll+0x29d/0x450
Jul 08 14:49:22 i87k kernel:  __do_munmap+0x1eb/0x450
Jul 08 14:49:22 i87k kernel:  __vm_munmap+0x6a/0xc0
Jul 08 14:49:22 i87k kernel:  __x64_sys_munmap+0x12/0x20
Jul 08 14:49:22 i87k kernel:  do_syscall_64+0x50/0x170
Jul 08 14:49:22 i87k kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 08 14:49:22 i87k kernel: RIP: 0033:0x7bd2cfd7230b
Jul 08 14:49:22 i87k kernel: Code: ff ff 0f 1f 44 00 00 f7 d8 48 8b 15 7f 8b 0c
00 64 89 02 48 c7 c0 ff ff ff ff e9 76 ff ff ff f3 0f 1e fa b8 0b 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 8b 0c 00 f7 d8 64 89 01 48
Jul 08 14:49:22 i87k kernel: RSP: 002b:00007ffe5dcb0e88 EFLAGS: 00000202
ORIG_RAX: 000000000000000b
Jul 08 14:49:22 i87k kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007bd2cfd7230b
Jul 08 14:49:22 i87k kernel: RDX: 0000000000000000 RSI: 00000000003d8600 RDI:
00007bd2c9c83000
Jul 08 14:49:22 i87k kernel: RBP: 000063b039dfb230 R08: 000063b0394fc014 R09:
0000000000000007
Jul 08 14:49:22 i87k kernel: R10: 000063b039d110a0 R11: 0000000000000202 R12:
0000000001600013
Jul 08 14:49:22 i87k kernel: R13: 000063b039d11138 R14: 0000000000000012 R15:
000063b037c857c0
Jul 08 14:49:22 i87k kernel: ---[ end trace 41ece918a42b1617 ]---
Jul 08 14:49:39 i87k kernel: snd_hda_intel 0000:00:1f.3: PME# enabled
```

`fs/ext4/inode.c`:

```
  static int ext4_set_page_dirty(struct page *page)
  {
    WARN_ON_ONCE(!PageLocked(page) && !PageDirty(page)); // this is line 3925
    WARN_ON_ONCE(!page_has_buffers(page));
    return __set_page_dirty_buffers(page);
  }
```

I'm using ext4 only on zram, like (/etc/fstab):
/dev/zram1                   /tmp        ext4   
defaults,auto,rw,exec,nosuid,strictatime,nodev,discard,delalloc,block_validity,user_xattr,nojournal_checksum,barrier
0 0
/dev/zram2               /var/tmp        ext4   
defaults,auto,rw,exec,nosuid,strictatime,nodev,discard,delalloc,block_validity,user_xattr,nojournal_checksum,barrier
0 0

```
$ mount|grep ext4
/dev/zram1 on /tmp type ext4 (rw,nosuid,nodev,discard)
/dev/zram2 on /var/tmp type ext4 (rw,nosuid,nodev,discard)
```

my root filesystem is btrfs/zstd:5

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
