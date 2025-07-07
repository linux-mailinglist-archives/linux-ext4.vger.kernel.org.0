Return-Path: <linux-ext4+bounces-8853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35344AFB32B
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823484A1A20
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458129AB1D;
	Mon,  7 Jul 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tah3ong+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31529ACE5
	for <linux-ext4@vger.kernel.org>; Mon,  7 Jul 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891126; cv=none; b=PSUHnVxV8Ih0+yQW8nhSQpvSPbxNM80+kr3j8naCxlIITqw0/8Crc9AcEwoOW1sGrwCZko0vugWEAZeXcxPw92FBWQExZN7+G3ECO5N/tsTE1KWLqxdgCu5CYu/aWfaNyKGnYZNhRRbYaL2qmbHDmXGACReEjxO4Tx1QdkK0ULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891126; c=relaxed/simple;
	bh=r0ywKhD1zzPbHpwm7XhIigSzl4bJSYLNf0V7lPf/Tvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN4pihOqg1MjYyxJ9fTRtqmkcOpofTQkvnuTDnLBM7u1CiPv9ha/s21eVQvBOwu6EQvC8gbmO+E+gaeo2kwStHGtOZUDjOxaICc1q7L5dW0/spg0cEf3X1sJYo4gXJLzr4jk1mQYhAeRPjVIw9JKgoYkxi0O90EW3r9H3m30BKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tah3ong+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d402c901cbso276331785a.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Jul 2025 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751891123; x=1752495923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk7zODb6r+CvoF3Uc5AdcAYjSQq+0kgMZjiUpLnUyy8=;
        b=Tah3ong+wSTNkYZ4pUmwBlw85aBwxps3U+jDxDvm3FQHHJetinAzfVE3hBzvI5paPG
         /B+v3RJRV//H5HyjN+fRRabjZI6M9mD/nxNcO4rUa0Zw94af1O4cQpMzVLYsCbpOmngD
         eZwynSeXX8x5QejmXe+LyZ6z48+R+iaRtW7bkwficxn0ybxifZ/b6H3mUmmUec49bdc0
         xjyxbmyRCUssVdJ2UH4SZ/TP3MM78iWQXCT9FejHy3dzJGIWugQwvo/cB/f5ixA9XAZX
         qMhEqwD5XDXgIK/nIqezhG52h3uExnB6o9BsljKZo7AxrsbNi/D7hdUN7tiI/5E9Nf0T
         9AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891123; x=1752495923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tk7zODb6r+CvoF3Uc5AdcAYjSQq+0kgMZjiUpLnUyy8=;
        b=S6Gv1kTzYVr1kypv1Lcjiyy+vm9ZHq1MaU1oInoCD5o8uc+GZUy2dKUOKGsDO5ppf3
         i4PdIQLfgRj4uwMK8dNITTTk6M/RWmUbIwbpP/Y0V/SmXBIrQOPPHloMTuvKibGlAic6
         IAV9FEcUToEozUSFci64JEyoAZO5rbzkngjGhpAPqbgxb6CDtbb5qghEN3ABeMiFCr6m
         nGy2+CPXltkFtjDzXr7iIAPOOjoxE5Wa096FAAjancqYkNMG4Taaw8qowAh1mBNV2ZWF
         cp0aYB1zOM0clfmZVDvwfF4L5AMFyo09coVL6uZeq7fiIawMltdipGUBjPvfescigh/E
         q7xg==
X-Forwarded-Encrypted: i=1; AJvYcCW/iIvtKUZtBBK8IpwRAftAoqLTMYI+QEoxFMdeVIPcc2llAX/zPz1KvInFExchfmlzr4/1iOCHa84w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02ywASyzk83qsQOqsUMyvK0qCpYM5p3JsbadKS3o6Hefm8wDz
	jkCnUA+E+Xf9jlTUktz+60CzTtLd0p5yBsIXY0POpnkrUES43rqW3INVHjMohTbdd9dfrLIazWU
	WepvGEZxs+YP14YznpsqDKIV10qojDd77OOGGY6X+fcBO7U8O5TtrMyqt0rE=
X-Gm-Gg: ASbGncucfDcRey7DOrNF6U6ApCZWZYSDHxbmW+qRvUn3Vl4K0B3f++UKnWq0XJiNFAo
	h7srInMcmu0wrPk5UyK1zURxUDKFjOlm/aQ6TDGRLfOx+ABwT75k5r2+eqyLr0e+qM3jPBwxooI
	v+z++Uw/frFoQzKAqSm65j8sg2vDfhq488pAe7ItqDYNOOzBANoaempgculwGh/0TghOaFbsq2o
	w==
X-Google-Smtp-Source: AGHT+IFpJrnVfq32LwEz/fLxzycyPStuWhBeaIyZVCTiwiK3Yl7DKGmkHXuciOv91u5htAi+T05ahWsbppifaLUGLyk=
X-Received: by 2002:a05:620a:a807:b0:7d7:71e:5283 with SMTP id
 af79cd13be357-7d7071e52b6mr760240285a.43.1751891122495; Mon, 07 Jul 2025
 05:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686b54a6.a00a0220.c7b3.0075.GAE@google.com> <20250707075400.2690-1-hdanton@sina.com>
In-Reply-To: <20250707075400.2690-1-hdanton@sina.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 7 Jul 2025 14:24:44 +0200
X-Gm-Features: Ac12FXwdYasEnAZzFjvajmw8f_tyPhlA5RTScUDjNXMjoxNuw9qYORa_-659700
Message-ID: <CAG_fn=W1a7jX_7WJoE3ZrnX5qgsnmSfSBhiSX6Kwt-fSQyTdaQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_evict_inode (4)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+1a921ddeed254c00100d@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:54=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> > Date: Sun, 06 Jul 2025 22:01:26 -0700
> > syzbot found the following issue on:
> >
> > HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D3D14234bd45=
80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3D72aa0474e=
3c3b9a=3D
> > c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3D1a921ddeed2=
54c001=3D
> > 00d
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-=3D
> > 1~exp1~20250616065826.132), Debian LLD 20.1.7
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/d=
isk-=3D
> > d7b8f8e2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmli=
nux-=3D
> > d7b8f8e2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926=
/bzI=3D
> > mage-d7b8f8e2.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit=3D
> > :
> > Reported-by: syzbot+1a921ddeed254c00100d@syzkaller.appspotmail.com
> >
> > ext4 filesystem being mounted at /31/file0aaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaa=3D
> > aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaa=3D
> > aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaa=3D
> > aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa supports=
 tim=3D
> > estamps until 2038-01-19 (0x7fffffff)
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D
> > WARNING: possible circular locking dependency detected
> > 6.16.0-rc5-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz.5.282/7960 is trying to acquire lock:
> > ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: percpu_down_read_freeza=
ble =3D
> > include/linux/percpu-rwsem.h:83 [inline]
> > ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: __sb_start_write includ=
e/li=3D
> > nux/fs.h:1795 [inline]
> > ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite inclu=
de/l=3D
> > inux/fs.h:1978 [inline]
> > ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2d6/=
0xee=3D
> > 0 fs/ext4/inode.c:215
> >
> > but task is already holding lock:
> > ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_write=
page=3D
> > s_down_write fs/ext4/ext4.h:1816 [inline]
> > ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_m=
igra=3D
> > te+0x2f3/0x1010 fs/ext4/migrate.c:438
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #5 (&sbi->s_writepages_rwsem){++++}-{0:0}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >        percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.=
h:53
> >        percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
> >        ext4_writepages_down_read fs/ext4/ext4.h:1804 [inline]
> >        ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:2952
> >        do_writepages+0x32b/0x550 mm/page-writeback.c:2636
> >        filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
> >        __filemap_fdatawrite_range mm/filemap.c:419 [inline]
> >        filemap_write_and_wait_range+0x217/0x310 mm/filemap.c:691
> >        ext4_collapse_range+0x2da/0x950 fs/ext4/extents.c:5426
> >        ext4_fallocate+0x58d/0xcd0 fs/ext4/extents.c:4786
> >        vfs_fallocate+0x6a3/0x830 fs/open.c:341
> >        ksys_fallocate fs/open.c:365 [inline]
> >        __do_sys_fallocate fs/open.c:370 [inline]
> >        __se_sys_fallocate fs/open.c:368 [inline]
> >        __x64_sys_fallocate+0xc0/0x110 fs/open.c:368
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #4 (mapping.invalidate_lock#2){++++}-{4:4}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >        down_read+0x46/0x2e0 kernel/locking/rwsem.c:1524
> >        filemap_invalidate_lock_shared include/linux/fs.h:934 [inline]
> >        filemap_fault+0x546/0x1200 mm/filemap.c:3400
> >        __do_fault+0x138/0x390 mm/memory.c:5169
> >        do_read_fault mm/memory.c:5590 [inline]
> >        do_fault mm/memory.c:5724 [inline]
> >        do_pte_missing mm/memory.c:4251 [inline]
> >        handle_pte_fault mm/memory.c:6069 [inline]
> >        __handle_mm_fault+0x37ed/0x5620 mm/memory.c:6212
> >        handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
> >        do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
> >        handle_page_fault arch/x86/mm/fault.c:1476 [inline]
> >        exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >        fault_in_readable+0x8e/0x130 mm/gup.c:-1
> >        fault_in_iov_iter_readable+0x1b4/0x2f0 lib/iov_iter.c:94
> >        generic_perform_write+0x7cc/0x910 mm/filemap.c:4161
> >        ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
> >        ext4_dio_write_iter fs/ext4/file.c:613 [inline]
> >        ext4_file_write_iter+0x182a/0x1bc0 fs/ext4/file.c:721
> >        do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
> >        vfs_writev+0x31a/0x960 fs/read_write.c:1057
> >        do_pwritev fs/read_write.c:1153 [inline]
> >        __do_sys_pwritev2 fs/read_write.c:1211 [inline]
> >        __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #3 (&mm->mmap_lock){++++}-{4:4}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >        __might_fault+0xcc/0x130 mm/memory.c:6971
> >        _inline_copy_to_user include/linux/uaccess.h:192 [inline]
> >        _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
> >        copy_to_user include/linux/uaccess.h:225 [inline]
> >        fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
> >        ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
> >        ioctl_fiemap fs/ioctl.c:220 [inline]
> >        do_vfs_ioctl+0x16d0/0x1990 fs/ioctl.c:841
> >        __do_sys_ioctl fs/ioctl.c:905 [inline]
> >        __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
> >        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >        down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
> >        ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:122=
7
> >        ocfs2_acquire_dquot+0x80f/0xb30 fs/ocfs2/quota_global.c:883
> >        dqget+0x7b1/0xf10 fs/quota/dquot.c:977
> >        __dquot_initialize+0x3b3/0xcb0 fs/quota/dquot.c:1505
> >        ocfs2_get_init_inode+0x13b/0x1b0 fs/ocfs2/namei.c:202
> >        ocfs2_mknod+0x863/0x2050 fs/ocfs2/namei.c:310
> >        ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
> >        lookup_open fs/namei.c:3717 [inline]
> >        open_last_lookups fs/namei.c:3816 [inline]
> >        path_openat+0x14f1/0x3830 fs/namei.c:4052
> >        do_filp_open+0x1fa/0x410 fs/namei.c:4082
> >        do_sys_openat2+0x121/0x1c0 fs/open.c:1437
> >        do_sys_open fs/open.c:1452 [inline]
> >        __do_sys_openat fs/open.c:1468 [inline]
> >        __se_sys_openat fs/open.c:1463 [inline]
> >        __x64_sys_openat+0x138/0x170 fs/open.c:1463
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> What is difficult to understand is the ext4 filesystem shares quota with
> ocfs2. Is that true? As per the report, no deadlock could be triggered
> without running both ext4 and ocfs2 filesystems.

There aren't any good reproducers, but the existing logs:
 - https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D14234bd4580000
(search for "id=3D282")
 - https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D1010748c580000
(search for "id=3D297")
 - https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D1367228c580000
(search for "id=3D1041")

suggest that the crashing process is not mounting the ocfs2
filesystem, but at the same time other fuzzing processes may be using
that filesystem in parallel.

