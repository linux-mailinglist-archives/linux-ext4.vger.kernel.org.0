Return-Path: <linux-ext4+bounces-4405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CF198B68D
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF011F22825
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9351BDABD;
	Tue,  1 Oct 2024 08:09:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50611BCA15
	for <linux-ext4@vger.kernel.org>; Tue,  1 Oct 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770170; cv=none; b=NkvpzBQf2mrhaT5JrG2jPVm8YeuiJ5NLj+NkOZLskziYfZR6UXlZBZdd8raoVgkhPMD2or2nkuqaKMEtBKPsdH6YF8dRyCwMrQeSoKKgmv50w+khospNRRcR2VjAs+seHGOhLw04w6AWYoz9FKy9H/9AxR7WeMEn8n79KSxT14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770170; c=relaxed/simple;
	bh=xtmyZuBqCBC0i0tR8oZQDnXcWxqMqU3l/173ehpquCU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AKYOqoroKzepfAF77sFvQyEoOYMJphHB86GhjAsSZNuNyxtkh+mNnnQpY/JJEtV1Sv9nW5F9h8gbtej6DXW3K2l5axxBfLQqYUlBBKj4f3o6fZVWOoiSHbxJLrX0WvscZcjWTAnQBiPd7abE9nOLXY5aS2IWap9Xo9l6aSdd+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a363981933so669415ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2024 01:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770168; x=1728374968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBdcj9v/sV0syPuosSLvrG9+cUJAQ/PDg0I/A2H+IA4=;
        b=UQyneLpOzKQ8NAFhxxU67Rt8c67Lhwn686VDPS0YM6sq5FENK8kGvqGzwiSa4qg/bD
         VIPC8CM35SKOUYdtsyZsDUQtwW3N5VO06F6w+JzIKR2WwOQsumaNnNzuxDqHsOQLywMg
         Jq0YoYrW5/g7nhZRrzc8k1SuI191/jEPq/G+ynP+D0hwcPBwbQCoImxwIficTOWQwBJs
         Mrt0AGLidYYeA3yyY7J8BU9Hf/SGRfz9MYTRMJbJL0fXDuq3eHgdSD5Fets3ObzBMdlm
         Q0KTVAVtZTCNW+4kTupNteFn5JeutpQehjhdUD5ZESh+xMVGt8O0ugTuEbad3afh5YXI
         NWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy5VaJoxuubJ6fGXA2WzLX1rz1ZoclF8laLY2BJ/sly+tZK9mt7hsnKjpcbJO1Mu39DpxeF4N6EOZs@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWPSA634oYdQK+aj9nwghIphXuleG6OiAD1QehkpqZzvUwFZa
	J3VG5XaYZLZkmAiMZofwFkA8w76GkX/YObqk6Lyahnr/1R4/tDlwBwBfMSDqVQG9WTpXPf9ougF
	0V1ioThWr0UlH1mIlTvov8DHy1jSV52PgaqJx6EfjAADswxGkLp76tXo=
X-Google-Smtp-Source: AGHT+IE2pqJax/4KVuqFmQkRFyFSPSc4sYLo2FQh5arDbRxTZwfg9/C9coDN2RnCseXMkxRGL8pYzUsfRuZQqIB+pLRVa1cxd/iG
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a345174631mr125437615ab.13.1727770168004; Tue, 01 Oct 2024
 01:09:28 -0700 (PDT)
Date: Tue, 01 Oct 2024 01:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbae37.050a0220.6bad9.0050.GAE@google.com>
Subject: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
From: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=104a559f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d3de27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f786a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/23ae94668485/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/942e4e36cd02/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
------------------------------------------------------
syz-executor334/6555 is trying to acquire lock:
ffff0000e436e0a8 (&dquot->dq_lock){+.+.}-{3:3}, at: wait_on_dquot fs/quota/dquot.c:356 [inline]
ffff0000e436e0a8 (&dquot->dq_lock){+.+.}-{3:3}, at: dqget+0x5f0/0xcec fs/quota/dquot.c:972

but task is already holding lock:
ffff0000dcbec690 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff0000dcbec690 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x1dc/0x12d0 fs/ext4/xattr.c:2373

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x1dc/0x12d0 fs/ext4/xattr.c:2373
       ext4_initxattrs+0xa4/0x11c fs/ext4/xattr_security.c:44
       security_inode_init_security+0x210/0x3fc security/security.c:1744
       ext4_init_security+0x44/0x58 fs/ext4/xattr_security.c:58
       __ext4_new_inode+0x2a80/0x376c fs/ext4/ialloc.c:1326
       ext4_create+0x234/0x480 fs/ext4/namei.c:2832
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0xfb4/0x29f8 fs/namei.c:3883
       do_filp_open+0x1bc/0x3cc fs/namei.c:3913
       do_sys_openat2+0x124/0x1b8 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __arm64_sys_openat+0x1f0/0x240 fs/open.c:1442
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #4 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xf34/0x11c4 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x298/0x544 fs/jbd2/transaction.c:505
       jbd2_journal_start+0x3c/0x4c fs/jbd2/transaction.c:544
       ocfs2_start_trans+0x3d0/0x71c fs/ocfs2/journal.c:352
       ocfs2_modify_bh+0xe4/0x484 fs/ocfs2/quota_local.c:101
       ocfs2_local_read_info+0xec8/0x1550 fs/ocfs2/quota_local.c:769
       dquot_load_quota_sb+0x700/0xb48 fs/quota/dquot.c:2460
       dquot_load_quota_inode+0x280/0x4f4 fs/quota/dquot.c:2497
       ocfs2_enable_quotas+0x17c/0x3cc fs/ocfs2/super.c:926
       ocfs2_fill_super+0x3c80/0x4740 fs/ocfs2/super.c:1141
       mount_bdev+0x1d4/0x2a0 fs/super.c:1679
       ocfs2_mount+0x44/0x58 fs/ocfs2/super.c:1188
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
       vfs_get_tree+0x90/0x28c fs/super.c:1800
       do_new_mount+0x278/0x900 fs/namespace.c:3472
       path_mount+0x590/0xe04 fs/namespace.c:3799
       do_mount fs/namespace.c:3812 [inline]
       __do_sys_mount fs/namespace.c:4020 [inline]
       __se_sys_mount fs/namespace.c:3997 [inline]
       __arm64_sys_mount+0x45c/0x5a8 fs/namespace.c:3997
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #3 (&journal->j_trans_barrier){.+.+}-{3:3}:
       down_read+0x58/0x2fc kernel/locking/rwsem.c:1526
       ocfs2_start_trans+0x3c4/0x71c fs/ocfs2/journal.c:350
       ocfs2_modify_bh+0xe4/0x484 fs/ocfs2/quota_local.c:101
       ocfs2_local_read_info+0xec8/0x1550 fs/ocfs2/quota_local.c:769
       dquot_load_quota_sb+0x700/0xb48 fs/quota/dquot.c:2460
       dquot_load_quota_inode+0x280/0x4f4 fs/quota/dquot.c:2497
       ocfs2_enable_quotas+0x17c/0x3cc fs/ocfs2/super.c:926
       ocfs2_fill_super+0x3c80/0x4740 fs/ocfs2/super.c:1141
       mount_bdev+0x1d4/0x2a0 fs/super.c:1679
       ocfs2_mount+0x44/0x58 fs/ocfs2/super.c:1188
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
       vfs_get_tree+0x90/0x28c fs/super.c:1800
       do_new_mount+0x278/0x900 fs/namespace.c:3472
       path_mount+0x590/0xe04 fs/namespace.c:3799
       do_mount fs/namespace.c:3812 [inline]
       __do_sys_mount fs/namespace.c:4020 [inline]
       __se_sys_mount fs/namespace.c:3997 [inline]
       __arm64_sys_mount+0x45c/0x5a8 fs/namespace.c:3997
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #2 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1676 [inline]
       sb_start_intwrite include/linux/fs.h:1859 [inline]
       ocfs2_start_trans+0x244/0x71c fs/ocfs2/journal.c:348
       ocfs2_acquire_dquot+0x3c4/0xa8c fs/ocfs2/quota_global.c:852
       dqget+0x660/0xcec fs/quota/dquot.c:977
       __dquot_initialize+0x344/0xc04 fs/quota/dquot.c:1505
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1567
       ocfs2_get_init_inode+0x14c/0x1b8 fs/ocfs2/namei.c:202
       ocfs2_mknod+0x878/0x243c fs/ocfs2/namei.c:308
       ocfs2_create+0x194/0x4e0 fs/ocfs2/namei.c:672
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0xfb4/0x29f8 fs/namei.c:3883
       do_filp_open+0x1bc/0x3cc fs/namei.c:3913
       do_sys_openat2+0x124/0x1b8 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __arm64_sys_openat+0x1f0/0x240 fs/open.c:1442
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (&ocfs2_quota_ip_alloc_sem_key){++++}-{3:3}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
       ocfs2_create_local_dquot+0x1a0/0x1778 fs/ocfs2/quota_local.c:1227
       ocfs2_acquire_dquot+0x6fc/0xa8c fs/ocfs2/quota_global.c:875
       dqget+0x660/0xcec fs/quota/dquot.c:977
       __dquot_initialize+0x344/0xc04 fs/quota/dquot.c:1505
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1567
       ocfs2_get_init_inode+0x14c/0x1b8 fs/ocfs2/namei.c:202
       ocfs2_mknod+0x878/0x243c fs/ocfs2/namei.c:308
       ocfs2_create+0x194/0x4e0 fs/ocfs2/namei.c:672
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0xfb4/0x29f8 fs/namei.c:3883
       do_filp_open+0x1bc/0x3cc fs/namei.c:3913
       do_sys_openat2+0x124/0x1b8 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __arm64_sys_openat+0x1f0/0x240 fs/open.c:1442
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       wait_on_dquot fs/quota/dquot.c:356 [inline]
       dqget+0x5f0/0xcec fs/quota/dquot.c:972
       __dquot_initialize+0x344/0xc04 fs/quota/dquot.c:1505
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1567
       __ext4_new_inode+0x664/0x376c fs/ext4/ialloc.c:991
       ext4_xattr_inode_create fs/ext4/xattr.c:1486 [inline]
       ext4_xattr_inode_lookup_create+0x9a4/0x19e4 fs/ext4/xattr.c:1596
       ext4_xattr_block_set+0x224/0x2e08 fs/ext4/xattr.c:1916
       ext4_xattr_set_handle+0xc68/0x12d0 fs/ext4/xattr.c:2458
       ext4_xattr_set+0x1e0/0x354 fs/ext4/xattr.c:2560
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x3d8/0x400 fs/xattr.c:200
       __vfs_setxattr_noperm+0x110/0x578 fs/xattr.c:234
       __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
       vfs_setxattr+0x1a8/0x344 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x30c/0x428 fs/xattr.c:658
       __do_sys_setxattr fs/xattr.c:676 [inline]
       __se_sys_setxattr fs/xattr.c:672 [inline]
       __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:672
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

Chain exists of:
  &dquot->dq_lock --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  lock(&dquot->dq_lock);

 *** DEADLOCK ***

3 locks held by syz-executor334/6555:
 #0: ffff0000d7c00420 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:515
 #1: ffff0000dcbec9c0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
 #1: ffff0000dcbec9c0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x17c/0x344 fs/xattr.c:320
 #2: ffff0000dcbec690 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff0000dcbec690 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x1dc/0x12d0 fs/ext4/xattr.c:2373

stack backtrace:
CPU: 0 UID: 0 PID: 6555 Comm: syz-executor334 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 wait_on_dquot fs/quota/dquot.c:356 [inline]
 dqget+0x5f0/0xcec fs/quota/dquot.c:972
 __dquot_initialize+0x344/0xc04 fs/quota/dquot.c:1505
 dquot_initialize+0x24/0x34 fs/quota/dquot.c:1567
 __ext4_new_inode+0x664/0x376c fs/ext4/ialloc.c:991
 ext4_xattr_inode_create fs/ext4/xattr.c:1486 [inline]
 ext4_xattr_inode_lookup_create+0x9a4/0x19e4 fs/ext4/xattr.c:1596
 ext4_xattr_block_set+0x224/0x2e08 fs/ext4/xattr.c:1916
 ext4_xattr_set_handle+0xc68/0x12d0 fs/ext4/xattr.c:2458
 ext4_xattr_set+0x1e0/0x354 fs/ext4/xattr.c:2560
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x3d8/0x400 fs/xattr.c:200
 __vfs_setxattr_noperm+0x110/0x578 fs/xattr.c:234
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x1a8/0x344 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x30c/0x428 fs/xattr.c:658
 __do_sys_setxattr fs/xattr.c:676 [inline]
 __se_sys_setxattr fs/xattr.c:672 [inline]
 __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:672
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

