Return-Path: <linux-ext4+bounces-2928-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D845914041
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F9DB225B1
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C624414;
	Mon, 24 Jun 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="a/6l/s2F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490F1FB4
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194253; cv=none; b=hh8WouYPFNem7E10uOJtV0nD435sSLoBXgfQ2Fb1rxLXYLc+G//WK1z5o6mmhsXiWACURlX7i22L9pqEHlwa2VItUlJp4cAolaCOusUqYEsfzDMFbbFu1cOVHF2TWvciGLy2meKRaCUSHPArR1XOKm0SlZ/8OZlgUoVQhypcJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194253; c=relaxed/simple;
	bh=j8DiVby2rfeVJtrLlv58PHgKl2kLO98m3a+vZcHG/Og=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tFfDg6+gyZK3+KdBKA6/OMks+WaObzes2T+WuekN/Cl5Ib/KHXBVrmBjYhUKbRO9Oa5G9xr9TITqHrAM15f/SDL/NgvizRvuI8ihsNcjwAclgXDahFxOtXrVr/z041A7OoNNrwQLrc+hnurs3HsmLZMnZipcW1ZxElPNSLsL/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=a/6l/s2F; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63bf3452359so36637247b3.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jun 2024 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1719194250; x=1719799050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Du4K5OC3Uqv02jsBy/C2/Nvusj6FMZ+/xSi51oT2hY=;
        b=a/6l/s2F8+nToPB1qJ4k1b3nXse67vU0WJ4nmviRKJIzBhzRE9Pd14KArSYTMU2TVN
         yC+pGEr+mUedOQkV+/nSNCiiUxmv0buP3c3KBnsqVB34FonUlfFZLkbRZaYyQgrrbhxM
         u4vkcMKh8S5qNQymEQKk/1I6RZfDA6Oxj7Ni0nRKupLriCmChP9i+zWisZ1qnCix0hQg
         S0r05wnOUuoprJ0secG4fi88r8664tJKhTI8yxAYv/IT9eXV8Q3161tM9e1pu6Vy37I4
         WBmUSW8GFALOT1CpySkNFKLEq1rhH3B1hJlSjw9HgpKoVsNUonVCMKPs+IW6lIFcV0VW
         BpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719194250; x=1719799050;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Du4K5OC3Uqv02jsBy/C2/Nvusj6FMZ+/xSi51oT2hY=;
        b=wRHBJa+g2xwStAuQu0Q0DsekzqsgWcjHapae2OuBPZsJ9Bf4iWdBrpmJ3964AC1Jkm
         lnNgPuBdxLr/D9jr6a2D0W6oRlTepAUu1T06THQneOQMxW7vubACvBS/3kewpealleGA
         mVUIXTvIOVZcfGlPt9CUfyXDj6xfj9aXs59UCUS03urm3QLaux4UTs3xMTL/k52znaAo
         suKEQTPmG5rXK5z67BzM73Hm4FXAJgdcRPHgw3pC1CvW+yEhA+FCiQUtX6dA6UW4SfNP
         JBOiuycr2VwnCW8/Id9A5h84vdDYA2ZD4JcPdmnHa5+5AiGyfIZ54yIFfxtGXSCj6Zg8
         dqVQ==
X-Gm-Message-State: AOJu0YzqlcJblhdAK8XK2riljiUDe61f+DFk7YTK7k+u8dDOuPYIk8aQ
	NOuRzUi/Uac1wNMXQUFVj+vX5Av4H3b3PzwiW+VbCAGrWhFv7NVbzO5RO4b/EFHJKDgCbHW0SNx
	UZ3nJFn4aQCBLUacKAzG53O5nTso8D6WEoCgVpTg82+rEByVTGYc5zg==
X-Google-Smtp-Source: AGHT+IGHp9vYsyt02JbX9RQ2nM117BFNA5O7gWIZUru95c+jSV8yciSJj/rMJCFQepeeeN+kIr7HDhNahKHMAztC+4E=
X-Received: by 2002:a81:bb54:0:b0:63b:f8cb:9281 with SMTP id
 00721157ae682-643aba463edmr30637437b3.41.1719194249540; Sun, 23 Jun 2024
 18:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Coffin <alex.coffin@maticrobots.com>
Date: Sun, 23 Jun 2024 18:57:13 -0700
Message-ID: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
Subject: PROBLEM: ext4 resize2fs on-line resizing panic
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[1.] One line summary of the problem:
Using resize2fs on-line resizing on a specific ext4 partition is
causing an Oops.

[2.] Full description of the problem/report:
I have a partition that if it is live mounted causes a kernel panic
upon invoking resize2fs on it. I believe this to be a bug, and
currently don't have time to investigate the issue further so I am
hoping someone else will be able to investigate this further.


[3.] Keywords (i.e., modules, networking, kernel):
resize2fs ext4

[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 6.10.0-rc5 (root@debian11-vm-acoffin) (gcc (Debian
10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #4
SMP PREEMPT_DYNAMIC Sun Jun 23 17:49:17 PDT 2024

The kernel was built from git commit
f2661062f16b2de5d7b6a5c42a9a5c96326b8454 with a config pretty much
copy, and pasted from the standard Debian ones (I don't believe the
config to be relevant although I have only tested the issue on Debian
kernels). It also appears to affect kernels 5.10, and 6.1 from the
Debian repositories.

[4.2.] Kernel .config file:
https://drive.google.com/file/d/1aG2-Ju0kPX09LPk9E8-ioHqQqQCgSl4x/view?usp=sharing

sha256sum of file
7af96f35d621f702433a74e171af11c34b99bd96e57ab08494614af7bfcb9c21

[5.] Most recent kernel version which did not have the bug:
None known.

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/admin-guide/bug-hunting.rst)

```
[  445.552287] ------------[ cut here ]------------
[  445.552300] kernel BUG at fs/jbd2/journal.c:846!
[  445.552345] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  445.552365] CPU: 12 PID: 1899 Comm: jbd2/loop0-8 Not tainted 6.10.0-rc5 #4
[  445.552374] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  445.552380] RIP: 0010:jbd2_journal_next_log_block
(fs/jbd2/journal.c:846 (discriminator 1)) jbd2
[ 445.552428] Code: 8b 85 88 03 00 00 48 89 85 70 03 00 00 4c 89 ef e8
b9 d3 98 e3 4c 89 e2 4c 89 f6 48 89 ef 5d 41 5c 41 5d 41 5e e9 a4 fe
ff ff <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
1f
All code
========
   0:    8b 85 88 03 00 00        mov    0x388(%rbp),%eax
   6:    48 89 85 70 03 00 00     mov    %rax,0x370(%rbp)
   d:    4c 89 ef                 mov    %r13,%rdi
  10:    e8 b9 d3 98 e3           callq  0xffffffffe398d3ce
  15:    4c 89 e2                 mov    %r12,%rdx
  18:    4c 89 f6                 mov    %r14,%rsi
  1b:    48 89 ef                 mov    %rbp,%rdi
  1e:    5d                       pop    %rbp
  1f:    41 5c                    pop    %r12
  21:    41 5d                    pop    %r13
  23:    41 5e                    pop    %r14
  25:    e9 a4 fe ff ff           jmpq   0xfffffffffffffece
  2a:*    0f 0b                    ud2            <-- trapping instruction
  2c:    66 90                    xchg   %ax,%ax
  2e:    90                       nop
  2f:    90                       nop
  30:    90                       nop
  31:    90                       nop
  32:    90                       nop
  33:    90                       nop
  34:    90                       nop
  35:    90                       nop
  36:    90                       nop
  37:    90                       nop
  38:    90                       nop
  39:    90                       nop
  3a:    90                       nop
  3b:    90                       nop
  3c:    90                       nop
  3d:    90                       nop
  3e:    0f                       .byte 0xf
  3f:    1f                       (bad)

Code starting with the faulting instruction
===========================================
   0:    0f 0b                    ud2
   2:    66 90                    xchg   %ax,%ax
   4:    90                       nop
   5:    90                       nop
   6:    90                       nop
   7:    90                       nop
   8:    90                       nop
   9:    90                       nop
   a:    90                       nop
   b:    90                       nop
   c:    90                       nop
   d:    90                       nop
   e:    90                       nop
   f:    90                       nop
  10:    90                       nop
  11:    90                       nop
  12:    90                       nop
  13:    90                       nop
  14:    0f                       .byte 0xf
  15:    1f                       (bad)
[  445.552435] RSP: 0018:ffffb03c006a7c48 EFLAGS: 00010246
[  445.552443] RAX: 0000000000000001 RBX: ffff9ba702ed1000 RCX: 00000000ffffffff
[  445.552449] RDX: 00000000000000ff RSI: ffffb03c006a7c70 RDI: ffff9ba707c78040
[  445.552454] RBP: ffff9ba707c78000 R08: ffffb03c013e3900 R09: ffffb03c013e3900
[  445.552458] R10: ffff9ba77ba35a80 R11: 0000000000000000 R12: ffffb03c006a7c70
[  445.552463] R13: ffff9ba707c78040 R14: 0000000000000000 R15: ffff9ba702ed1000
[  445.552468] FS:  0000000000000000(0000) GS:ffff9ba77ba00000(0000)
knlGS:0000000000000000
[  445.552474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  445.552479] CR2: 000055824eb84444 CR3: 0000000100ad4000 CR4: 0000000000750ef0
[  445.552492] PKRU: 55555554
[  445.552496] Call Trace:
[  445.552504]  <TASK>
[  445.552511] ? die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
[  445.552613] ? do_trap (arch/x86/kernel/traps.c:114
arch/x86/kernel/traps.c:155)
[  445.552633] ? jbd2_journal_next_log_block (fs/jbd2/journal.c:846
(discriminator 1)) jbd2
[  445.552660] ? do_error_trap (./arch/x86/include/asm/traps.h:58
arch/x86/kernel/traps.c:176)
[  445.552669] ? jbd2_journal_next_log_block (fs/jbd2/journal.c:846
(discriminator 1)) jbd2
[  445.552693] ? exc_invalid_op (arch/x86/kernel/traps.c:267)
[  445.552757] ? jbd2_journal_next_log_block (fs/jbd2/journal.c:846
(discriminator 1)) jbd2
[  445.552781] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
[  445.552818] ? jbd2_journal_next_log_block (fs/jbd2/journal.c:846
(discriminator 1)) jbd2
[  445.552842] ? jbd2_journal_next_log_block (fs/jbd2/journal.c:846) jbd2
[  445.552866] jbd2_journal_get_descriptor_buffer (fs/jbd2/journal.c:1007) jbd2
[  445.552894] journal_submit_commit_record.part.0 (fs/jbd2/commit.c:131) jbd2
[  445.552925] jbd2_journal_commit_transaction
(./include/linux/mm.h:1508 fs/jbd2/commit.c:881) jbd2
[  445.552957] ? _raw_spin_unlock_irqrestore
(./arch/x86/include/asm/paravirt.h:589
./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204
./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[  445.552977] kjournald2 (fs/jbd2/journal.c:202 (discriminator 3)) jbd2
[  445.553010] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383)
[  445.553049] ? __pfx_kjournald2 (fs/jbd2/journal.c:161) jbd2
[  445.553074] kthread (kernel/kthread.c:389)
[  445.553125] ? __pfx_kthread (kernel/kthread.c:342)
[  445.553135] ret_from_fork (arch/x86/kernel/process.c:147)
[  445.553179] ? __pfx_kthread (kernel/kthread.c:342)
[  445.553188] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[  445.553269]  </TASK>
[  445.553273] Modules linked in: loop intel_rapl_msr
intel_rapl_common intel_uncore_frequency_common intel_pmc_core
intel_vsec pmt_telemetry pmt_class kvm_intel kvm ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd cryptd
rapl snd_hda_codec_generic snd_hda_intel rfkill snd_intel_dspcfg
snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm
snd_timer iTCO_wdt snd intel_pmc_bxt iTCO_vendor_support joydev
watchdog serio_raw virtio_balloon pcspkr soundcore virtio_console
evdev qemu_fw_cfg nfsd auth_rpcgss binfmt_misc nfs_acl lockd grace
parport_pc ppdev lp sunrpc parport fuse configfs virtio_rng ip_tables
x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid virtio_gpu virtio_dma_buf drm_shmem_helper drm_kms_helper
virtio_net ahci libahci net_failover xhci_pci drm xhci_hcd failover
virtio_blk dimlib libata usbcore crct10dif_pclmul virtio_pci
crct10dif_common scsi_mod virtio_pci_legacy_dev psmouse crc32_pclmul
i2c_i801 virtio_pci_modern_dev crc32c_intel lpc_ich
[  445.553426]  virtio i2c_smbus scsi_common usb_common virtio_ring button
[  445.553513] ---[ end trace 0000000000000000 ]---
[  445.553519] RIP: 0010:jbd2_journal_next_log_block
(fs/jbd2/journal.c:846 (discriminator 1)) jbd2
[ 445.553546] Code: 8b 85 88 03 00 00 48 89 85 70 03 00 00 4c 89 ef e8
b9 d3 98 e3 4c 89 e2 4c 89 f6 48 89 ef 5d 41 5c 41 5d 41 5e e9 a4 fe
ff ff <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
1f
All code
========
   0:    8b 85 88 03 00 00        mov    0x388(%rbp),%eax
   6:    48 89 85 70 03 00 00     mov    %rax,0x370(%rbp)
   d:    4c 89 ef                 mov    %r13,%rdi
  10:    e8 b9 d3 98 e3           callq  0xffffffffe398d3ce
  15:    4c 89 e2                 mov    %r12,%rdx
  18:    4c 89 f6                 mov    %r14,%rsi
  1b:    48 89 ef                 mov    %rbp,%rdi
  1e:    5d                       pop    %rbp
  1f:    41 5c                    pop    %r12
  21:    41 5d                    pop    %r13
  23:    41 5e                    pop    %r14
  25:    e9 a4 fe ff ff           jmpq   0xfffffffffffffece
  2a:*    0f 0b                    ud2            <-- trapping instruction
  2c:    66 90                    xchg   %ax,%ax
  2e:    90                       nop
  2f:    90                       nop
  30:    90                       nop
  31:    90                       nop
  32:    90                       nop
  33:    90                       nop
  34:    90                       nop
  35:    90                       nop
  36:    90                       nop
  37:    90                       nop
  38:    90                       nop
  39:    90                       nop
  3a:    90                       nop
  3b:    90                       nop
  3c:    90                       nop
  3d:    90                       nop
  3e:    0f                       .byte 0xf
  3f:    1f                       (bad)

Code starting with the faulting instruction
===========================================
   0:    0f 0b                    ud2
   2:    66 90                    xchg   %ax,%ax
   4:    90                       nop
   5:    90                       nop
   6:    90                       nop
   7:    90                       nop
   8:    90                       nop
   9:    90                       nop
   a:    90                       nop
   b:    90                       nop
   c:    90                       nop
   d:    90                       nop
   e:    90                       nop
   f:    90                       nop
  10:    90                       nop
  11:    90                       nop
  12:    90                       nop
  13:    90                       nop
  14:    0f                       .byte 0xf
  15:    1f                       (bad)
[  445.553553] RSP: 0018:ffffb03c006a7c48 EFLAGS: 00010246
[  445.553561] RAX: 0000000000000001 RBX: ffff9ba702ed1000 RCX: 00000000ffffffff
[  445.553567] RDX: 00000000000000ff RSI: ffffb03c006a7c70 RDI: ffff9ba707c78040
[  445.553572] RBP: ffff9ba707c78000 R08: ffffb03c013e3900 R09: ffffb03c013e3900
[  445.553578] R10: ffff9ba77ba35a80 R11: 0000000000000000 R12: ffffb03c006a7c70
[  445.553583] R13: ffff9ba707c78040 R14: 0000000000000000 R15: ffff9ba702ed1000
[  445.553588] FS:  0000000000000000(0000) GS:ffff9ba77ba00000(0000)
knlGS:0000000000000000
[  445.553595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  445.553601] CR2: 000055824eb84444 CR3: 0000000100ad4000 CR4: 0000000000750ef0
[  445.553613] PKRU: 55555554
[  445.553618] note: jbd2/loop0-8[1899] exited with preempt_count 1
```

And the raw relevant dmesg section

```
[  154.118871] loop: module loaded
[  154.119555] loop0: detected capacity change from 0 to 1048576
[  154.452675] EXT4-fs (loop0): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w with ordered data mode. Quota
mode: none.
[  154.452686] ext4 filesystem being mounted at /mnt supports
timestamps until 2038-01-19 (0x7fffffff)
[  441.561378] EXT4-fs (loop0): resizing filesystem from 32769 to 524288 blocks
[  445.552287] ------------[ cut here ]------------
[  445.552300] kernel BUG at fs/jbd2/journal.c:846!
[  445.552345] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  445.552365] CPU: 12 PID: 1899 Comm: jbd2/loop0-8 Not tainted 6.10.0-rc5 #4
[  445.552374] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  445.552380] RIP: 0010:jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.552428] Code: 8b 85 88 03 00 00 48 89 85 70 03 00 00 4c 89 ef
e8 b9 d3 98 e3 4c 89 e2 4c 89 f6 48 89 ef 5d 41 5c 41 5d 41 5e e9 a4
fe ff ff <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
0f 1f
[  445.552435] RSP: 0018:ffffb03c006a7c48 EFLAGS: 00010246
[  445.552443] RAX: 0000000000000001 RBX: ffff9ba702ed1000 RCX: 00000000ffffffff
[  445.552449] RDX: 00000000000000ff RSI: ffffb03c006a7c70 RDI: ffff9ba707c78040
[  445.552454] RBP: ffff9ba707c78000 R08: ffffb03c013e3900 R09: ffffb03c013e3900
[  445.552458] R10: ffff9ba77ba35a80 R11: 0000000000000000 R12: ffffb03c006a7c70
[  445.552463] R13: ffff9ba707c78040 R14: 0000000000000000 R15: ffff9ba702ed1000
[  445.552468] FS:  0000000000000000(0000) GS:ffff9ba77ba00000(0000)
knlGS:0000000000000000
[  445.552474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  445.552479] CR2: 000055824eb84444 CR3: 0000000100ad4000 CR4: 0000000000750ef0
[  445.552492] PKRU: 55555554
[  445.552496] Call Trace:
[  445.552504]  <TASK>
[  445.552511]  ? die+0x33/0x90
[  445.552613]  ? do_trap+0xd9/0x100
[  445.552633]  ? jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.552660]  ? do_error_trap+0x6a/0x90
[  445.552669]  ? jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.552693]  ? exc_invalid_op+0x4e/0x70
[  445.552757]  ? jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.552781]  ? asm_exc_invalid_op+0x16/0x20
[  445.552818]  ? jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.552842]  ? jbd2_journal_next_log_block+0x1e/0x80 [jbd2]
[  445.552866]  jbd2_journal_get_descriptor_buffer+0x32/0x100 [jbd2]
[  445.552894]  journal_submit_commit_record.part.0+0x37/0x1d0 [jbd2]
[  445.552925]  jbd2_journal_commit_transaction+0x151c/0x1a20 [jbd2]
[  445.552957]  ? _raw_spin_unlock_irqrestore+0xa/0x40
[  445.552977]  kjournald2+0xa8/0x260 [jbd2]
[  445.553010]  ? __pfx_autoremove_wake_function+0x10/0x10
[  445.553049]  ? __pfx_kjournald2+0x10/0x10 [jbd2]
[  445.553074]  kthread+0xcc/0x100
[  445.553125]  ? __pfx_kthread+0x10/0x10
[  445.553135]  ret_from_fork+0x2d/0x50
[  445.553179]  ? __pfx_kthread+0x10/0x10
[  445.553188]  ret_from_fork_asm+0x1a/0x30
[  445.553269]  </TASK>
[  445.553273] Modules linked in: loop intel_rapl_msr
intel_rapl_common intel_uncore_frequency_common intel_pmc_core
intel_vsec pmt_telemetry pmt_class kvm_intel kvm ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd cryptd
rapl snd_hda_codec_generic snd_hda_intel rfkill snd_intel_dspcfg
snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm
snd_timer iTCO_wdt snd intel_pmc_bxt iTCO_vendor_support joydev
watchdog serio_raw virtio_balloon pcspkr soundcore virtio_console
evdev qemu_fw_cfg nfsd auth_rpcgss binfmt_misc nfs_acl lockd grace
parport_pc ppdev lp sunrpc parport fuse configfs virtio_rng ip_tables
x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic
usbhid hid virtio_gpu virtio_dma_buf drm_shmem_helper drm_kms_helper
virtio_net ahci libahci net_failover xhci_pci drm xhci_hcd failover
virtio_blk dimlib libata usbcore crct10dif_pclmul virtio_pci
crct10dif_common scsi_mod virtio_pci_legacy_dev psmouse crc32_pclmul
i2c_i801 virtio_pci_modern_dev crc32c_intel lpc_ich
[  445.553426]  virtio i2c_smbus scsi_common usb_common virtio_ring button
[  445.553513] ---[ end trace 0000000000000000 ]---
[  445.553519] RIP: 0010:jbd2_journal_next_log_block+0x7c/0x80 [jbd2]
[  445.553546] Code: 8b 85 88 03 00 00 48 89 85 70 03 00 00 4c 89 ef
e8 b9 d3 98 e3 4c 89 e2 4c 89 f6 48 89 ef 5d 41 5c 41 5d 41 5e e9 a4
fe ff ff <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
0f 1f
[  445.553553] RSP: 0018:ffffb03c006a7c48 EFLAGS: 00010246
[  445.553561] RAX: 0000000000000001 RBX: ffff9ba702ed1000 RCX: 00000000ffffffff
[  445.553567] RDX: 00000000000000ff RSI: ffffb03c006a7c70 RDI: ffff9ba707c78040
[  445.553572] RBP: ffff9ba707c78000 R08: ffffb03c013e3900 R09: ffffb03c013e3900
[  445.553578] R10: ffff9ba77ba35a80 R11: 0000000000000000 R12: ffffb03c006a7c70
[  445.553583] R13: ffff9ba707c78040 R14: 0000000000000000 R15: ffff9ba702ed1000
[  445.553588] FS:  0000000000000000(0000) GS:ffff9ba77ba00000(0000)
knlGS:0000000000000000
[  445.553595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  445.553601] CR2: 000055824eb84444 CR3: 0000000100ad4000 CR4: 0000000000750ef0
[  445.553613] PKRU: 55555554
[  445.553618] note: jbd2/loop0-8[1899] exited with preempt_count 1
```

[7.] A small shell script or example program which triggers the
     problem (if possible)

If anyone wants to investigate the ext4 partition themselves you can
download a version that should recreate this bug from here
https://drive.google.com/file/d/1lzWKlBOixVWtLwGN4WEIuRiLYQz9rrH3/view?usp=sharing
.

```bash
sha256sum foo.iso.gz

# It should show:
# d7c49a5f7c26aa9a04edefb57f3f23aae660901c9ad5e88b10eb31ae4757bee8  foo.iso.gz
gunzip ./foo.iso.gz
mkdir /mnt/foo
mount ./foo.iso /mnt/foo
# Or wherever it loop mounted if not /dev/loop0
resize2fs /dev/loop0
```


```
root@debian11-vm-acoffin:~/tmp# mount ./foo.iso /mnt
root@debian11-vm-acoffin:~/tmp# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            1.9G     0  1.9G   0% /dev
tmpfs           392M  1.1M  391M   1% /run
/dev/vda1        78G   71G  3.3G  96% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           392M   44K  392M   1% /run/user/0
/dev/loop0       30M   16M   12M  59% /mnt
root@debian11-vm-acoffin:~/tmp# resize2fs /dev/loop0
resize2fs 1.46.2 (28-Feb-2021)
Filesystem at /dev/loop0 is mounted on /mnt; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 4
```

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
Linux debian11-vm-acoffin 6.10.0-rc5 #4 SMP PREEMPT_DYNAMIC Sun Jun 23
17:49:17 PDT 2024 x86_64 GNU/Linux

GNU C                   10
GNU Make                4.3
Binutils                2.35.2
Util-linux              2.36.1
Mount                   2.36.1
Module-init-tools       28
E2fsprogs               1.46.2
PPP                     2.4.9
Nfs-utils               1.3.3
Bison                   3.7.5
Flex                    2.6.4
Linux C++ Library       6.0.28
Linux C Library         2.31
Dynamic linker (ldd)    2.31
Procps                  3.3.17
Kbd                     2.3.0
Console-tools           2.3.0
Sh-utils                8.32
Udev                    247
Modules Loaded          aesni_intel ahci auth_rpcgss autofs4
binfmt_misc button configfs crc16 crc32c_generic crc32c_intel
crc32_pclmul crct10dif_common crct10dif_pclmul cryptd crypto_simd
dimlib drm drm_kms_helper drm_shmem_helper evdev ext4 failover fuse
ghash_clmulni_intel grace hid hid_generic i2c_i801 i2c_smbus
intel_pmc_bxt intel_pmc_core intel_rapl_common intel_rapl_msr
intel_uncore_frequency_common intel_vsec ip_tables iTCO_vendor_support
iTCO_wdt jbd2 joydev kvm kvm_intel libahci libata lockd lp lpc_ich
mbcache net_failover nfs_acl nfsd parport parport_pc pcspkr pmt_class
pmt_telemetry ppdev psmouse qemu_fw_cfg rapl rfkill scsi_common
scsi_mod serio_raw sha1_ssse3 sha256_ssse3 sha512_ssse3 snd
snd_hda_codec snd_hda_codec_generic snd_hda_core snd_hda_intel
snd_hwdep snd_intel_dspcfg snd_intel_sdw_acpi snd_pcm snd_timer
soundcore sunrpc usb_common usbcore usbhid virtio virtio_balloon
virtio_blk virtio_console virtio_dma_buf virtio_gpu virtio_net
virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring
virtio_rng watchdog xhci_hcd xhci_pci x_tables

[8.2.] Processor information (from /proc/cpuinfo):
Not relevant. Can be recreated on both ARM64, and AMD64 systems. If
anyone wants this I will add it in a follow up email.

[8.3.] Module information (from /proc/modules):
intel_rapl_msr 20480 0 - Live 0xffffffffc0e43000
intel_rapl_common 49152 1 intel_rapl_msr, Live 0xffffffffc0ddf000
intel_uncore_frequency_common 16384 0 - Live 0xffffffffc0ec4000
intel_pmc_core 122880 0 - Live 0xffffffffc0e8d000
intel_vsec 20480 1 intel_pmc_core, Live 0xffffffffc0e47000
pmt_telemetry 16384 1 intel_pmc_core, Live 0xffffffffc0df2000
pmt_class 12288 1 pmt_telemetry, Live 0xffffffffc0bff000
kvm_intel 413696 0 - Live 0xffffffffc1144000
kvm 1323008 1 kvm_intel, Live 0xffffffffc0fa7000
ghash_clmulni_intel 16384 0 - Live 0xffffffffc0df7000
sha512_ssse3 45056 0 - Live 0xffffffffc0de4000
sha256_ssse3 32768 0 - Live 0xffffffffc0dd6000
sha1_ssse3 32768 0 - Live 0xffffffffc0dcd000
aesni_intel 364544 0 - Live 0xffffffffc0f56000
crypto_simd 16384 1 aesni_intel, Live 0xffffffffc0d95000
cryptd 28672 2 ghash_clmulni_intel,crypto_simd, Live 0xffffffffc0d87000
rapl 20480 0 - Live 0xffffffffc0b99000
rfkill 40960 1 - Live 0xffffffffc0d6b000
snd_hda_codec_generic 110592 1 - Live 0xffffffffc0f37000
snd_hda_intel 61440 0 - Live 0xffffffffc0f1c000
snd_intel_dspcfg 36864 1 snd_hda_intel, Live 0xffffffffc0b9b000
snd_intel_sdw_acpi 16384 1 snd_intel_dspcfg, Live 0xffffffffc0a33000
snd_hda_codec 212992 2 snd_hda_codec_generic,snd_hda_intel, Live
0xffffffffc0eca000
snd_hda_core 143360 3
snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, Live
0xffffffffc0e92000
iTCO_wdt 12288 0 - Live 0xffffffffc0e87000
snd_hwdep 16384 1 snd_hda_codec, Live 0xffffffffc0e6e000
intel_pmc_bxt 16384 1 iTCO_wdt, Live 0xffffffffc0e62000
joydev 24576 0 - Live 0xffffffffc0e53000
iTCO_vendor_support 12288 1 iTCO_wdt, Live 0xffffffffc0e49000
snd_pcm 188416 3 snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0xffffffffc0e06000
watchdog 49152 1 iTCO_wdt, Live 0xffffffffc0d70000
snd_timer 53248 1 snd_pcm, Live 0xffffffffc0c2b000
pcspkr 12288 0 - Live 0xffffffffc0bf2000
snd 147456 6 snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer,
Live 0xffffffffc0c6c000
serio_raw 16384 0 - Live 0xffffffffc0bbe000
soundcore 16384 1 snd, Live 0xffffffffc0bb2000
virtio_console 40960 1 - Live 0xffffffffc0b9e000
virtio_balloon 32768 0 - Live 0xffffffffc0b8f000
qemu_fw_cfg 20480 0 - Live 0xffffffffc0a43000
evdev 28672 6 - Live 0xffffffffc0a5f000
binfmt_misc 28672 1 - Live 0xffffffffc0da4000
nfsd 937984 3 - Live 0xffffffffc0c7d000
auth_rpcgss 192512 1 nfsd, Live 0xffffffffc0c39000
nfs_acl 12288 1 nfsd, Live 0xffffffffc0a45000
lockd 155648 1 nfsd, Live 0xffffffffc0c03000
grace 12288 2 nfsd,lockd, Live 0xffffffffc0bf9000
parport_pc 40960 0 - Live 0xffffffffc0be4000
ppdev 24576 0 - Live 0xffffffffc0bd5000
sunrpc 851968 18 nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffc0abb000
lp 20480 0 - Live 0xffffffffc0aae000
fuse 221184 1 - Live 0xffffffffc0a66000
parport 81920 3 parport_pc,ppdev,lp, Live 0xffffffffc0a49000
configfs 65536 1 - Live 0xffffffffc07a1000
virtio_rng 12288 0 - Live 0xffffffffc0a37000
ip_tables 36864 0 - Live 0xffffffffc0918000
x_tables 65536 1 ip_tables, Live 0xffffffffc07c5000
autofs4 57344 2 - Live 0xffffffffc077d000
ext4 1118208 1 - Live 0xffffffffc0920000
crc32c_generic 12288 0 - Live 0xffffffffc06ba000
crc16 12288 1 ext4, Live 0xffffffffc05f0000
mbcache 16384 1 ext4, Live 0xffffffffc0521000
jbd2 196608 1 ext4, Live 0xffffffffc08df000
hid_generic 12288 0 - Live 0xffffffffc04c6000
usbhid 73728 0 - Live 0xffffffffc074c000
hid 253952 2 hid_generic,usbhid, Live 0xffffffffc06a7000
virtio_gpu 98304 1 - Live 0xffffffffc04ff000
virtio_dma_buf 12288 1 virtio_gpu, Live 0xffffffffc0464000
drm_shmem_helper 28672 1 virtio_gpu, Live 0xffffffffc0461000
drm_kms_helper 253952 2 virtio_gpu, Live 0xffffffffc0589000
drm 749568 5 virtio_gpu,drm_shmem_helper,drm_kms_helper, Live 0xffffffffc07f3000
virtio_net 98304 0 - Live 0xffffffffc07ce000
ahci 49152 0 - Live 0xffffffffc07b5000
net_failover 24576 1 virtio_net, Live 0xffffffffc07a7000
libahci 61440 1 ahci, Live 0xffffffffc078e000
failover 12288 1 net_failover, Live 0xffffffffc0783000
virtio_blk 32768 1 - Live 0xffffffffc0771000
xhci_pci 24576 0 - Live 0xffffffffc0760000
dimlib 16384 1 virtio_net, Live 0xffffffffc0756000
libata 450560 2 ahci,libahci, Live 0xffffffffc06bf000
xhci_hcd 356352 1 xhci_pci, Live 0xffffffffc064c000
crct10dif_pclmul 12288 0 - Live 0xffffffffc0478000
crct10dif_common 12288 1 crct10dif_pclmul, Live 0xffffffffc0644000
scsi_mod 319488 1 libata, Live 0xffffffffc05ce000
virtio_pci 40960 0 - Live 0xffffffffc05c5000
crc32_pclmul 12288 0 - Live 0xffffffffc05bb000
i2c_i801 36864 0 - Live 0xffffffffc05a8000
usbcore 397312 3 usbhid,xhci_pci,xhci_hcd, Live 0xffffffffc0524000
virtio_pci_legacy_dev 16384 1 virtio_pci, Live 0xffffffffc051a000
crc32c_intel 16384 2 - Live 0xffffffffc050f000
psmouse 208896 0 - Live 0xffffffffc04c8000
virtio_pci_modern_dev 20480 1 virtio_pci, Live 0xffffffffc04bc000
lpc_ich 28672 0 - Live 0xffffffffc04ab000
i2c_smbus 16384 1 i2c_i801, Live 0xffffffffc049e000
scsi_common 16384 2 libata,scsi_mod, Live 0xffffffffc0494000
virtio 16384 7 virtio_console,virtio_balloon,virtio_rng,virtio_gpu,virtio_net,virtio_blk,virtio_pci,
Live 0xffffffffc048a000
usb_common 16384 2 xhci_hcd,usbcore, Live 0xffffffffc047e000
virtio_ring 57344 7
virtio_console,virtio_balloon,virtio_rng,virtio_gpu,virtio_net,virtio_blk,virtio_pci,
Live 0xffffffffc0466000
button 24576 0 - Live 0xffffffffc0457000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
In order to keep this email from going over any size limits I will
skip this unless requested in a follow up email.

[8.5.] PCI information ('lspci -vvv' as root)
In order to keep this email from going over any size limits I will
skip this unless requested in a follow up email.

[8.6.] SCSI information (from /proc/scsi/scsi)
In order to keep this email from going over any size limits I will
skip this unless requested in a follow up email.

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Nothing that I know of.

[X.] Other notes, patches, fixes, workarounds:
The file system was originally created with mkfs.ext4. The unmodified version of
the provided partition displayed these issues and in order to be able to upload
the file system here (keeping it small, and not leaking proprietary files) all
the files were zeroed, and unused blocks removed. The modified version shared
here shows the exact same issues and all of the bug report information filled
out in this email correspond to the version of the partition available in this
email.

