Return-Path: <linux-ext4+bounces-5868-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16084A00528
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 08:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2F1884051
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA91C1F10;
	Fri,  3 Jan 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRL6Uti8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842951C36;
	Fri,  3 Jan 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889868; cv=none; b=bpMs+zgQ9wtux6Vd0FRTVk6YQtN/bQrQ0xJcyA9MNly4wddrcAwPSbQPj9HR3Y46Jq7ZM82vZap1sSxrJzMFxAIxSme1c1P16gaZ5ZNQqYiTwlddtllrj1Dc/Gl4eMGfI1DfrDh7oJpaXGm1JRgT9ODhAdTCFXMaNNcxwRsMgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889868; c=relaxed/simple;
	bh=NDokplUOLSNRDCWRR0GNOYLE0BfDAYwk0z5ilhtQ+pA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dnNDOEtUiQUG+82wBqGZyTwnY66aTTJGwzLwRHCZUZcFnO1hWvct6SRIVktAxbRz0AovulyawSUp9zyV9SIbQNUqxmn6lhL9ZBzv378lpjsvOO7hKxKQByz7ogBcLx5QRtHMzg2cRFKegxP0/acDSSwy5AIPt8tKJ+UImtiBrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRL6Uti8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa692211331so2277811266b.1;
        Thu, 02 Jan 2025 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735889865; x=1736494665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDokplUOLSNRDCWRR0GNOYLE0BfDAYwk0z5ilhtQ+pA=;
        b=TRL6Uti8NU/s2+gOdTTrGRbDTP2evw35fIXFc0iHwc067lqqAyE8sAcNcL4CToSdCo
         mVnacLXEV8QHslPYPuGMXbvCiBxbwwzGlf9xZJsiwfc9Xk2OJ/hjHTt2/b45oGFP0JQu
         d0LE8TswdlQakTAoDqHmK8XLle1Ig9LhLeZwfUDIw/PqsaBF+aM0j0Pz3U0M3+fVj4rA
         EeaYbrHpok/3uJXVZKaQvEcJjTVxGEo6hooQXx3E3HxWCS7ZqznNuh32qPErbWKIlWHJ
         K0GYjNS70DdyZoWvwMFyVc5LzQEONq1AwBHPUMS/K6tdo9HFAr+h1CfSO6oRKb2Naf8a
         NuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735889865; x=1736494665;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDokplUOLSNRDCWRR0GNOYLE0BfDAYwk0z5ilhtQ+pA=;
        b=chOT7Ax5aSdQlrHQTrkCD/nE071N5Nn++pz2ZmcyqqKY/x2FmDWpDGvHSaP6rd4lMB
         9roCxoCER7BKJIUZtb/FuVZKHiqrFGBl8dxhrDz9Ope3glLyWRk9/bmAERYhwk2rJKy4
         GPZ/bxN6dxCHjdTLy6mXK/zlxobAYbINDL2ulX2RHOHW2mhVVViljUIJhhNKppR+wmpI
         ejFUPbZeTCM9U6AW5o8Qwl70m03gUEvqR3N53XLBO+vp4TjVUbincv5TqNTH2tr91ynf
         U4d+cSuEOfWgU8sEh0QnBKFL6AOpPM/OFYH3YSMySJoDz0VXfkCb/PMpJjDuOHWFv0yd
         oVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaaZ1QNDEH2j14o1Sk74ReZQFTmrJjvd/gja0N3YYyd9sWaI0yJ5km03CybTrO5e04HIH4l9p2En10Wb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyizNabsPwi67pvuVjHasjrd18auikbP+Kzj5YT88CgR2QUqBH
	jOcTG3OrOq3Zzr43neC52DsVD7Ufe9EZDhp2r4o5As50RKShb316awwpAAJEnhbFiPkDP7Txxg/
	/IHMLOZqz3s/tuneUpUvq+UDq53E=
X-Gm-Gg: ASbGncuPMSwrik74Hb9AU191QXRHdsojo7dU5nAQGUOd0qRSYKidCo0bedNedcp8cCP
	BLzx8UjxD+tE3bFP/OfxVkCmFEP36WUmZNakKfrU=
X-Google-Smtp-Source: AGHT+IFdt37p9Ama9/792KYFUhh8w+0Nh5mpIgJupROAiP+XRDXj0AUrbUhkGGD598EIlC6asAatEtTDvloj+zmJZms=
X-Received: by 2002:a17:907:704:b0:aa6:489e:5848 with SMTP id
 a640c23a62f3a-aac34695112mr4093534366b.25.1735889864604; Thu, 02 Jan 2025
 23:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:37:31 +0800
Message-ID: <CAKHoSAviexD6O+QuaNya4xsqaW6URLFWee7vgTGOiJO8x1mkJw@mail.gmail.com>
Subject: "possible deadlock in corrupted" in Linux kernel version 5.15.169
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 5.15.169. This issue was discovered using our
custom vulnerability discovery tool.

Affected File: fs/ext4/inode.c

File: fs/ext4/inode.c

Function: ext4_map_blocks

Detailed Call Stack:

------------[ cut here begin]------------

WARNING: possible circular locking dependency detected
------------------------------------------------------
the task is trying to acquire lock:
ffff888018a76428 (&dquot->dq_lock){+.+.}-{3:3}, at:
dquot_commit+0x4d/0x4c0 fs/quota/dquot.c:507

but other task is already holding lock:
ffff88800833a9b8 (&ei->i_data_sem/2){++++}-{3:3}, at:
ext4_map_blocks+0x686/0x1870 fs/ext4/inode.c:665

which lock already depends on the new lock.

Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
check_noncircular+0x263/0x2e0 kernel/locking/lockdep.c:2133
check_prev_add kernel/locking/lockdep.c:3053 [inline]
check_prevs_add kernel/locking/lockdep.c:3172 [inline]
validate_chain kernel/locking/lockdep.c:3788 [inline]
__lock_acquire+0x2b72/0x6070 kernel/locking/lockdep.c:5012
lock_acquire kernel/locking/lockdep.c:5623 [inline]
lock_acquire+0x194/0x470 kernel/locking/lockdep.c:5588
__mutex_lock_common kernel/locking/mutex.c:596 [inline]
__mutex_lock+0x135/0x12c0 kernel/locking/mutex.c:729
dquot_commit+0x4d/0x4c0 fs/quota/dquot.c:507
ext4_write_dquot+0x254/0x3f0 fs/ext4/super.c:6173
ext4_mark_dquot_dirty fs/ext4/super.c:6233 [inline]
ext4_mark_dquot_dirty+0x111/0x1b0 fs/ext4/super.c:6227
mark_dquot_dirty fs/quota/dquot.c:372 [inline]
mark_all_dquot_dirty fs/quota/dquot.c:412 [inline]
__dquot_free_space+0x829/0xbd0 fs/quota/dquot.c:1940
dquot_free_space_nodirty include/linux/quotaops.h:376 [inline]
dquot_free_space include/linux/quotaops.h:381 [inline]
dquot_free_block include/linux/quotaops.h:392 [inline]
ext4_mb_clear_bb fs/ext4/mballoc.c:6156 [inline]
ext4_free_blocks+0x1cc1/0x2200 fs/ext4/mballoc.c:6286
ext4_remove_blocks fs/ext4/extents.c:2523 [inline]
ext4_ext_rm_leaf fs/ext4/extents.c:2689 [inline]
ext4_ext_remove_space+0x1e96/0x3ce0 fs/ext4/extents.c:2937
ext4_ext_truncate+0x1ea/0x250 fs/ext4/extents.c:4471
ext4_truncate+0xc37/0x1160 fs/ext4/inode.c:4249
ext4_evict_inode+0xac2/0x1a50 fs/ext4/inode.c:289
evict+0x32c/0x820 fs/inode.c:622
iput_final fs/inode.c:1744 [inline]
iput.part.0+0x4b6/0x6d0 fs/inode.c:1770
iput+0x58/0x70 fs/inode.c:1760
ext4_orphan_cleanup+0x565/0xf80 fs/ext4/orphan.c:474
ext4_fill_super+0x8bb5/0xc920 fs/ext4/super.c:4975
mount_bdev+0x336/0x400 fs/super.c:1400
legacy_get_tree+0x106/0x220 fs/fs_context.c:611
vfs_get_tree+0x8e/0x300 fs/super.c:1530
do_new_mount fs/namespace.c:3012 [inline]
path_mount+0x138a/0x1ff0 fs/namespace.c:3342
do_mount fs/namespace.c:3355 [inline]
__do_sys_mount fs/namespace.c:3563 [inline]
__se_sys_mount fs/namespace.c:3540 [inline]
__x64_sys_mount+0x282/0x300 fs/namespace.c:3540
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x6c/0xd6
RIP: 0033:0x7fe399de916a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe3989b4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe3989b4ef0 RCX: 00007fe399de916a
RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007fe3989b4eb0
RBP: 0000000020000040 R08: 00007fe3989b4ef0 R09: 0000000000004500
R10: 0000000000004500 R11: 0000000000000246 R12: 0000000020000500
R13: 00007fe3989b4eb0 R14: 00000000000004b4 R15: 000000000000002c

------------[ cut here end]------------

Root Cause:

The crash is caused by a potential circular locking dependency
detected within the Linux kernel's Ext4 filesystem during quota
management operations. Specifically, the task is attempting to acquire
the dq_lock (&dquot->dq_lock) in the dquot_commit function
(fs/quota/dquot.c:507) while another task already holds the i_data_sem
lock (&ei->i_data_sem) in the ext4_map_blocks function
(fs/ext4/inode.c:665). This situation creates a circular dependency
where each lock is waiting for the other to be released, which can
lead to a deadlock. The call trace reveals that the issue arises
during the writeback process (wb_workfn) when the filesystem is trying
to commit quota information (dquot_commit) while simultaneously
handling inode data (ext4_map_blocks). The Kernel Lock Validator
(lockdep) has flagged this as a possible circular dependency because
the existing lock (i_data_sem) already depends on the new lock
(dq_lock), violating the expected lock acquisition order. This
improper lock ordering within the Ext4 quota handling and inode
management paths indicates a flaw in the synchronization mechanisms,
potentially caused by concurrent operations or incorrect lock
hierarchy implementation. As a result, the kernel emits a warning to
prevent a deadlock scenario, highlighting the need for revising the
locking strategy to ensure that locks are acquired in a consistent and
non-circular manner.

Thank you for your time and attention.

Best regards

Wall

