Return-Path: <linux-ext4+bounces-5746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE29F6581
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 13:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF0188A58F
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F21A3042;
	Wed, 18 Dec 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLo0ULKn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E818E047
	for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523449; cv=none; b=MkA1hZHw9/MKym0ITCT1KvxiDZ0ghOQU+ztAx9xW826eWbseTCjvW6BLjcdvGv4Jum6YsurnJgLO/anML0DnmOo7PhIPETgTzQOlDrFXswzGrvQ7LzTnCZ6loNaQUbhWMuvmchnPo9Fbrwqf8m97p/Dgpwir/bkpcKKi04Jolzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523449; c=relaxed/simple;
	bh=Z44FAniIqVdE4eJ1DMhrxu1k0wD/rF6HB1UBW6gDOus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=go6aJMHXnj1ABbuSHzJcXlosqHrvmGIdvKUuPXJFmykuSoTIUkJlDYO+hm9yX1t7o40PiadyoXNjqGYutsgID7FeqLAtPPvCntEjSIvLpxA4IFnlhTDexl3SSe/HM1BMY07g0/LvRUp1ViyNJFyyM+ZcbJ2ajLmC74+1vPCQJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLo0ULKn; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b11a110e4eso1690079137.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2024 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734523445; x=1735128245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQY9BLw4W1MMvAxVy9abkXVYBwgNl5383JEhF42QChY=;
        b=RLo0ULKnL24tIl/xE+Z7SgWfhSCZTE4OiwSqb1uKi3KzzKx4YM5fahyGoq/8sCdrKh
         J3MYUBZ7O3oWCdteXXnFczwZpwwg4U/OPdR+dX1feN4i/As1kiYimiVS64Mgmpapprk/
         2mspREPrBWfL1n7aazzmIcYtAH3Bda5vx9o5qHfEOr43BurU0+0m3xCzQtMc8V25wedf
         Z/pou3I+ZAqU5AG6PokVhagFhMYMb8Bwk0ZbmFdCUA6RgT/OFcea6L4jW2XSKAyVA0lo
         1ha04P0LSDbe9X9rhWBMm9ix7+mz2ftOsK3wEOfbWR83+LEzeGRPzsamgWMu+ikgiuLz
         FpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523445; x=1735128245;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQY9BLw4W1MMvAxVy9abkXVYBwgNl5383JEhF42QChY=;
        b=O3n2oUYt5+UKr87SZBA31ha3MLmUZrAGJZWTX3UPptDRLglpNc6meMx4+Y35yKZs6R
         yRwuIiLiruwQoz8pfDHEGDvAbz98zypN4yPvECMDCw2I638pGXjDRTDaU1BpKlryw4lO
         1pyhp0TyYjW/yvMyZsD1J8Yn1KzAKQQvDG7e+1GEPJOOTkR9TinSe5UUfA7jYVDbi+Rf
         WOAVnK1RS1ab/KeFi6TttK/6s5ih7l0xYRYAlXNEW53KtmilNbKJC41tQJGr1CPuwvL2
         Md6GBf58/4W/mGPi1OZjG0TQgkZkG58RZSQ34MfK6k271OylPj55zoeXv6DAu0aXUo8a
         QOoA==
X-Forwarded-Encrypted: i=1; AJvYcCXLjYGle6D/3qF4crtZ6wCsPgkKtaHLB/9T9223NgVVS9AZCeTDgjffHq+n3a0hptm0XSN1M0gAOR+V@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjGMznG6yIUYBV7SneALlaBKOHRtvXCQDHraAfh4UfsaLzsaI
	7b/YAFRUVokjuhabAIk+ubWxV+LGe733r8FouOfGrA53ex3/X7fz6/BRxtLDBK+swIQxA5FtKfC
	beLalH0vb9hHy2OuZ3U1f8MwkqIU+gzQ7RkoWgw==
X-Gm-Gg: ASbGncs/CQow0U2OF8imJMYKb6zbnxatQzbIl8bVvSfMNSmq2L0xbzdaxnD8uR98YhC
	SkxKYle7G+R1iBWcV8q7sDi6nf7haq1DTWw7rJkM=
X-Google-Smtp-Source: AGHT+IFF4y0Qvj1MFi4Ee7rcfpFyuopBdneXK5P177IbST2PevqMa3d4SpMgFpKOa9tfatfdGagMnTjm4Ttkdq3J9F8=
X-Received: by 2002:a05:6122:d05:b0:518:859e:87ab with SMTP id
 71dfb90a1353d-51a36d6377dmr1990131e0c.9.1734523445340; Wed, 18 Dec 2024
 04:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 17:33:54 +0530
Message-ID: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
Subject: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64 with
 Linux next-20241210 and above
To: qemu-devel@nongnu.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel crash noticed on qemu-arm64 while running the
Linux next-20241210 tag (to next-20241218) kernel built with
 - CONFIG_ARM64_64K_PAGES=y
 - CONFIG_ARM64_16K_PAGES=y
and running LTP smoke tests.

First seen on Linux next-20241210.
  Good: next-20241209
  Bad:  next-20241210 and next-20241218

qemu-arm64: 9.1.2

Anyone noticed this ?

Test log:
---------
tst_test.c:1799: TINFO: === Testing on btrfs ===
tst_test.c:1158: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
<6>[   71.880167] BTRFS: device fsid
d492b571-012c-40a9-b8e1-efc97408d3bc devid 1 transid 6 /dev/loop0
(7:0) scanned by chdir01 (476)
tst_test.c:1170: TINFO: Mounting /dev/loop0 to
/tmp/LTP_chdJeywxF/mntpoint fstyp=btrfs flags=0
<6>[   71.960245] BTRFS info (device loop0): first mount of filesystem
d492b571-012c-40a9-b8e1-efc97408d3bc
<6>[   71.970667] BTRFS info (device loop0): using crc32c
(crc32c-arm64) checksum algorithm
<2>[   71.993486] BTRFS critical (device loop0): corrupt superblock
syschunk array: chunk_start=22020096, invalid chunk sectorsize, have
65536 expect 4096
<3>[   71.995802] BTRFS error (device loop0): superblock contains fatal errors
<3>[   72.014538] BTRFS error (device loop0): open_ctree failed: -22
tst_test.c:1170: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil))
failed: EINVAL (22)

Summary:
passed   48
failed   0
broken   1
skipped  0
warnings 0

Duration: 7.002s


===== symlink01 =====
command: symlink01
<12>[   72.494428] /usr/local/bin/kirk[253]: starting test symlink01 (symlink01)
symlink01    0  TINFO  :  Using /tmp/LTP_symmsYXet as tmpdir (tmpfs filesystem)
symlink01    1  TPASS  :  Creation of symbolic link file to no object file is ok
symlink01    2  TPASS  :  Creation of symbolic link file to no object file is ok
symlink01    3  TPASS  :  Creation of symbolic link file and object
file via symbolic link is ok
symlink01    4  TPASS  :  Creating an existing symbolic link file
error is caught
symlink01    5  TPASS  :  Creating a symbolic link which exceeds
maximum pathname error is caught

Summary:
passed    5
failed    0
broken    0
skipped   0
warnings  0

Duration: 0.052s


===== stat04 =====
command: stat04
<12>[   72.966706] /usr/local/bin/kirk[253]: starting test stat04 (stat04)
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staEABwgV as tmpdir (tmpfs filesystem)
<6>[   73.447708] loop0: detected capacity change from 0 to 614400
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc3-next-20241218 #1 SMP
PREEMPT @1734498806 aarch64
tst_test.c:1703: TINFO: Timeout per run is 0h 05m 24s
stat04.c:60: TINFO: Formatting /dev/loop0 with ext2 opts='-b 4096' extra opts=''
mke2fs 1.47.1 (20-May-2024)
<3>[   73.859753] operation not supported error, dev loop0, sector
614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
stat04.c:61: TINFO: Mounting /dev/loop0 to /tmp/LTP_staEABwgV/mntpoint
fstyp=ext2 flags=0
<6>[   73.939263] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
<1>[   73.946378] Unable to handle kernel paging request at virtual
address a8fff00000c0c224
<1>[   73.947878] Mem abort info:
<1>[   73.949153]   ESR = 0x0000000096000005
<1>[   73.959105]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   73.960031]   SET = 0, FnV = 0
<1>[   73.960349]   EA = 0, S1PTW = 0
<1>[   73.960638]   FSC = 0x05: level 1 translation fault
<1>[   73.961005] Data abort info:
<1>[   73.961293]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
<1>[   73.963739]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   73.964980]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   73.967132] [a8fff00000c0c224] address between user and kernel
address ranges
<0>[   73.968923] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
<4>[   73.970516] Modules linked in: btrfs blake2b_generic xor
xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[   73.974237] CPU: 1 UID: 0 PID: 529 Comm: stat04 Not tainted
6.13.0-rc3-next-20241218 #1
<4>[   73.975359] Hardware name: linux,dummy-virt (DT)
<4>[   73.977170] pstate: 62402009 (nZCv daif +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 73.978295] pc : __kmalloc_node_noprof (mm/slub.c:492
mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
mm/slub.c:4293 mm/slub.c:4300)
<4>[ 73.980200] lr : alloc_cpumask_var_node (lib/cpumask.c:62 (discriminator 2))
<4>[   73.981466] sp : ffff80008258f950
<4>[   73.982228] x29: ffff80008258f970 x28: ffffa93389398000 x27:
0000000000000001
<4>[   73.983875] x26: fffffc1fc0303080 x25: 00000000ffffffff x24:
a8fff00000c0c224
<4>[   73.985649] x23: 0000000000000cc0 x22: ffffa93387f51d0c x21:
00000000ffffffff
<4>[   73.986188] x20: fff00000c0010400 x19: 0000000000000008 x18:
0000000000000000
<4>[   73.988686] x17: fff056cd748b0000 x16: ffff800080020000 x15:
0000000000000000
<4>[   73.990276] x14: 0000000000002a66 x13: 0000000000004000 x12:
0000000000000001
<4>[   73.992401] x11: 0000000000000002 x10: 0000000000004001 x9 :
ffffa93387f51d0c
<4>[   73.993108] x8 : fff00000c2c99240 x7 : 0000000000000001 x6 :
0000000000000001
<4>[   73.993886] x5 : fff00000c4879800 x4 : 0000000000000000 x3 :
000000000033a401
<4>[   73.995550] x2 : 0000000000000000 x1 : a8fff00000c0c224 x0 :
fff00000c0010400
<4>[   73.997017] Call trace:
<4>[ 73.998266] __kmalloc_node_noprof+0x100/0x4a0 P
<4>[ 73.999716] alloc_cpumask_var_node (lib/cpumask.c:62 (discriminator 2))
<4>[ 74.000942] alloc_workqueue_attrs (kernel/workqueue.c:4624
(discriminator 1))
<4>[ 74.001327] apply_wqattrs_prepare (kernel/workqueue.c:5263)
<4>[ 74.003095] apply_workqueue_attrs_locked (kernel/workqueue.c:5351)
<4>[ 74.003855] alloc_workqueue (kernel/workqueue.c:5722
(discriminator 1) kernel/workqueue.c:5772 (discriminator 1))
<4>[ 74.005398] ext4_fill_super (fs/ext4/super.c:5484 fs/ext4/super.c:5722)
<4>[ 74.006132] get_tree_bdev_flags (fs/super.c:1636)
<4>[ 74.007624] get_tree_bdev (fs/super.c:1660)
<4>[ 74.008664] ext4_get_tree (fs/ext4/super.c:5755)
<4>[ 74.009423] vfs_get_tree (fs/super.c:1814)
<4>[ 74.009703] path_mount (fs/namespace.c:3556 fs/namespace.c:3883)
<4>[ 74.010608] __arm64_sys_mount (fs/namespace.c:3896
fs/namespace.c:4107 fs/namespace.c:4084 fs/namespace.c:4084)
<4>[ 74.011527] invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
<4>[ 74.012798] do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
<4>[ 74.014042] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:745 (discriminator 1))
<4>[ 74.014942] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763)
<4>[ 74.015917] el0t_64_sync (arch/arm64/kernel/entry.S:600)
<0>[ 74.017042] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)
All code
========
   0: 12800019 mov w25, #0xffffffff            // #-1
   4: b9402a82 ldr w2, [x20, #40]
   8: aa1803e1 mov x1, x24
   c: aa1403e0 mov x0, x20
  10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f8626b1a ldr x26, [x24, x2]
<4>[   74.019014] ---[ end trace 0000000000000000 ]---
tst_test.c:1763: TBROK: Test killed by SIGSEGV!

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
tst_device.c:269: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
Tainted kernel: ['kernel died recently, i.e. there was an OOPS or BUG'][0m
Restarting SUT: host

===== df01_sh =====
command: df01.sh
<12>[   76.370093] /usr/local/bin/kirk[253]: starting test df01_sh (df01.sh)
Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
<1>[   76.603065] Unable to handle kernel paging request at virtual
address a8fff00000c0c224
<1>[   76.603922] Mem abort info:
<1>[   76.604197]   ESR = 0x0000000096000005
<1>[   76.604638]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   76.605128]   SET = 0, FnV = 0
<1>[   76.606996]   EA = 0, S1PTW = 0
<1>[   76.607274]   FSC = 0x05: level 1 translation fault
<1>[   76.607611] Data abort info:
<1>[   76.607897]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
<1>[   76.609765]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   76.610958]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   76.611652] [a8fff00000c0c224] address between user and kernel
address ranges
<0>[   76.612130] Internal error: Oops: 0000000096000005 [#2] PREEMPT SMP
<4>[   76.613305] Modules linked in: btrfs blake2b_generic xor
xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[   76.617688] CPU: 1 UID: 0 PID: 553 Comm: df01.sh Tainted: G
D            6.13.0-rc3-next-20241218 #1
<4>[   76.620869] Tainted: [D]=DIE
<4>[   76.621184] Hardware name: linux,dummy-virt (DT)
<4>[   76.622671] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 76.623693] pc : __kmalloc_node_noprof (mm/slub.c:492
mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
mm/slub.c:4293 mm/slub.c:4300)
<4>[ 76.624180] lr : __vmalloc_node_range_noprof
(include/linux/slab.h:922 mm/vmalloc.c:3647 mm/vmalloc.c:3846)
<4>[   76.625290] sp : ffff80008258fa90
<4>[   76.626275] x29: ffff80008258fab0 x28: fff00000c2c98e80 x27:
fff00000c48fd100
<4>[   76.626966] x26: fffffc1fc0303080 x25: 00000000ffffffff x24:
a8fff00000c0c224
<4>[   76.627599] x23: 0000000000000dc0 x22: ffffa93386d87390 x21:
00000000ffffffff
<4>[   76.628603] x20: fff00000c0010400 x19: 0000000000000008 x18:
0000000000000000
<4>[   76.629618] x17: 0000000000000000 x16: ffff800082180000 x15:
ffff800080000000
<4>[   76.630999] x14: fff00000c00203f0 x13: 00000ffff8000821 x12:
0000000000000000
<4>[   76.632089] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffffa93386d87390
<4>[   76.634293] x8 : ffff80008258f908 x7 : fff00000c2c98e80 x6 :
0000000000010000
<4>[   76.634816] x5 : ffffa93389379000 x4 : 0000000000000000 x3 :
000000000033b801
<4>[   76.636355] x2 : 0000000000000000 x1 : a8fff00000c0c224 x0 :
fff00000c0010400
<4>[   76.638309] Call trace:
<4>[ 76.639031] __kmalloc_node_noprof+0x100/0x4a0 P
<4>[ 76.640890] __vmalloc_node_range_noprof (include/linux/slab.h:922
mm/vmalloc.c:3647 mm/vmalloc.c:3846)
<4>[ 76.641267] copy_process (kernel/fork.c:314 (discriminator 1)
kernel/fork.c:1061 (discriminator 1) kernel/fork.c:2176 (discriminator
1))
<4>[ 76.641795] kernel_clone (kernel/fork.c:2758)
<4>[ 76.643003] __do_sys_clone (kernel/fork.c:2902)
<4>[ 76.644078] __arm64_sys_clone (kernel/fork.c:2869)
<4>[ 76.645306] invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
<4>[ 76.646337] do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
<4>[ 76.646974] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:745 (discriminator 1))
<4>[ 76.647709] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763)
<4>[ 76.649032] el0t_64_sync (arch/arm64/kernel/entry.S:600)
<0>[ 76.649724] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)

<trim>

All code
========
   0: 12800019 mov w25, #0xffffffff            // #-1
   4: b9402a82 ldr w2, [x20, #40]
   8: aa1803e1 mov x1, x24
   c: aa1403e0 mov x0, x20
  10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f8626b1a ldr x26, [x24, x2]
 <4>[   79.647693] ---[ end trace 0000000000000000 ]---
 <0>[   79.649260] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
 <2>[   79.650229] SMP: stopping secondary CPUs
 <0>[   79.651558] Kernel Offset: 0x293306a00000 from 0xffff800080000000
 <0>[   79.652015] PHYS_OFFSET: 0x40000000
 <0>[   79.652461] CPU features: 0x000,000000d0,60bef2d8,cb7e7f3f
 <0>[   79.653039] Memory Limit: none
 <0>[   79.653854] ---[ end Kernel panic - not syncing: Attempted to
kill init! exitcode=0x0000000b ]---


Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241218/testrun/26396709/suite/log-parser-test/test/panic-multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241212/testrun/26277241/suite/log-parser-test/test/panic-multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/log
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2qNMDhPFtR8j185QSvZMn989u84
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCQazNJteQLGCw7MnMtUwzkD/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241211/testrun/26266202/suite/log-parser-test/test/panic-multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/details/


metadata:
----
  git describe: next-20241210..next-20241218
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCQazNJteQLGCw7MnMtUwzkD/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCQazNJteQLGCw7MnMtUwzkD/
  toolchain: gcc-13
  config: CONFIG_ARM64_64K_PAGES=y, CONFIG_ARM64_16K_PAGES=y
  arch: arm64
  qemu: qemu-arm64 version 9.1.2

 --
Linaro LKFT
https://lkft.linaro.org

