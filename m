Return-Path: <linux-ext4+bounces-5607-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99E9F004A
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 00:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323781885148
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF211DED5B;
	Thu, 12 Dec 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="snCozPmv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD851DE8AA
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046848; cv=none; b=NlYmFMXuA6mOycBWslliXBNvKlUGrJqUltIQoi74KpQazKSaRmeC2dGs9+bgkfp14X8rzGgodBdNwI1tNgDCPNnhfqdz6k0WWn/7kGRc3zovicaXrff5XPq4gUPWXKliPQjhw2eoOBRi2pFyO2v7D5M4UQJsagoJfRqtIhhUg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046848; c=relaxed/simple;
	bh=lKtyB86TVcnf2xtPjY9K1wPTvUwz8WN+syPmpSv1ySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBmR1/9xlymE7elGMJEfHm8UR2VMXhkoUr6qPH8C6cr+7TUwzOAp1pQi9MgG+kQomoqE9fA1ejuTdfDKJBZNx60GXr1xi89WTA1idEwzYzQBHODSn1wTL2xsbn2OyQj1HZEMusErgscPZ0Sdcqp8hNSlObNk1FmxDU/dF5j3fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=snCozPmv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162c0f6a39so22063035ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734046846; x=1734651646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtPt+NGxaVThbCL864fM0RaS3IKqfIJPc9jpZV9yvm0=;
        b=snCozPmvjvXo9TbNFB63R/cStJPfCgZi6BSmtuY9Wrqz3hWEe8MKAwYT5UMz6Zg9lr
         cE7FDwu4SxzfFBWMkV5dr1AeA3lBJPzlUOnTAtdmDh04MyrNuXo8kVycr5Zft6OfakQG
         BL5zlPhQZ1I/UXqZr5xVrGtlvH7AdHS0Ji7/wql26qx9VgjM8UTiRyrB9afFIv2B1B9b
         vn2j876PRGMMXcjqOI08YCFRnuA8ZBxSBFo9+nprtK8ycmQhCvlAZDAaHG1KKAlZHnzI
         f+pz1R/DyBta3OkfzXYJ4ISyS46gAd94c4SYvUuhsN7koNn2yc/hJx+fNuKyOlyq1PJ3
         JQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046846; x=1734651646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtPt+NGxaVThbCL864fM0RaS3IKqfIJPc9jpZV9yvm0=;
        b=XuHwcmvKqSKq030Qm+Y6pK92CaOGK8G6+2fQj3zjgjoLobeu+IixBNxaSuZjrg+jwx
         yJ1B1oD4HQfseqK7XUA56O42Csqavy90gcfJ76W9hTXpEzFd5l27Cm2nUVlC3yDmH1+C
         2FPW0+qtnIyGwBUxu/jOFs0g+0s2LISzrWUmW2GvEzK8ixRmHB0Jr1x8/YJ9Qeu+QJmV
         J3gW5pmdNFvTfnlSdXbMnA3y3pFZpyEK7jcCPN8hy5AISGZUYJkDxetNKhpLf4kvdWk2
         tLef3X3JqDwh122l9LIZVJ4R60Pf/dOWUOcdFoy67Ti3Mmv0QTORMdyS3NCzInoeA5X8
         GhTw==
X-Forwarded-Encrypted: i=1; AJvYcCX6sMitu+3/ZGESPXY0pgbmUG13wQwdhaBQZHdYVDc5mk5gHqM9kaJn30gC/IBE2hpxDAHP4YaGjt8V@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyJq4Et8EE15Mwxj/K36TGaRHv5au+PwEM1Km8nwvzfVIKUA6
	P/YrnFfDO+FQyE18Qdtt/cZsbvQ1wBL6VFPbeKFFHTAiVHEcWwKOitT3O35eS/8=
X-Gm-Gg: ASbGnctXN3gDdJxCR4AfhlOwgi8IWrH3I1eT5fRIch26mdnPfk4MAx2a1mSuTz/uMGR
	ihx6lSmVErx4pcGEFESk0YzoB6HDransREwYvEsVfaZm3sCkXon7R3Dkir6tuEpUA/JZXTdw4wG
	qQe7BEF6fGoba11IOKBW/OWJ7HbzqV05/43ObPzcXnjJkHIlUzQqQXqcUSk6JqhDSeOYnIAyZFf
	7slhnL4E96UnouwmXXhuN2x1sNKB1pAgmlziP8biE2aYlR5rWfMefsTcxCIEh5SpTDdZdT8Ij/X
	UtoL7YokoQScraiItJw=
X-Google-Smtp-Source: AGHT+IHasvIGuxHUXI2NyJSeoDqwRZO/H70rSg+7Mp41+lgvY4Ep9Ye7L2+5hbUCBmQE3POzW4IyNA==
X-Received: by 2002:a17:903:2b03:b0:216:4b6f:dde5 with SMTP id d9443c01a7336-2178c7ff91amr81634355ad.13.1734046846496;
        Thu, 12 Dec 2024 15:40:46 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e66ba7sm128835425ad.100.2024.12.12.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:40:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLsnT-00000009zsS-3Zih;
	Fri, 13 Dec 2024 10:40:43 +1100
Date: Fri, 13 Dec 2024 10:40:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+449c80b8f4946f26184b@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate
Message-ID: <Z1t0ezKCaDF5kihd@dread.disaster.area>
References: <6753e03f.050a0220.a30f1.0152.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6753e03f.050a0220.a30f1.0152.GAE@google.com>

On Fri, Dec 06, 2024 at 09:42:23PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15898330580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=449c80b8f4946f26184b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/658bd206f462/disk-cdd30ebb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/12cb86080d87/vmlinux-cdd30ebb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5181aac6587a/bzImage-cdd30ebb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+449c80b8f4946f26184b@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0 Not tainted
> ------------------------------------------------------
> syz-executor/11503 is trying to acquire lock:
> ffff88807abcdbb0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4212
> 
> but task is already holding lock:
> ffff888034d3a610 (sb_internal){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
> ffff888034d3a610 (sb_internal){++++}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1908 [inline]
> ffff888034d3a610 (sb_internal){++++}-{0:0}, at: ext4_evict_inode+0x2f4/0xf50 fs/ext4/inode.c:217
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (sb_internal){++++}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        percpu_down_write+0x54/0x310 kernel/locking/percpu-rwsem.c:229
>        sb_wait_write fs/super.c:1910 [inline]
>        freeze_super+0x7cc/0xee0 fs/super.c:2118
>        fs_bdev_freeze+0x1ac/0x320 fs/super.c:1484
>        bdev_freeze+0xd8/0x220 block/bdev.c:257
>        ext4_force_shutdown+0x319/0x550 fs/ext4/ioctl.c:822
>        ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
>        __ext4_ioctl fs/ext4/ioctl.c:1580 [inline]
>        ext4_ioctl+0x2145/0x58d0 fs/ext4/ioctl.c:1619
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (sb_pagefaults){++++}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
>        __sb_start_write include/linux/fs.h:1725 [inline]
>        sb_start_pagefault include/linux/fs.h:1890 [inline]
>        ext4_page_mkwrite+0x1ef/0xdf0 fs/ext4/inode.c:6158
>        do_page_mkwrite+0x19a/0x480 mm/memory.c:3176
>        do_shared_fault mm/memory.c:5398 [inline]
>        do_fault mm/memory.c:5460 [inline]
>        do_pte_missing mm/memory.c:3979 [inline]
>        handle_pte_fault+0x1235/0x68a0 mm/memory.c:5801
>        __handle_mm_fault mm/memory.c:5944 [inline]
>        handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
>        do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
>        handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>        exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> 
> -> #5 (&mm->mmap_lock){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __might_fault+0xc6/0x120 mm/memory.c:6751
>        _inline_copy_from_user include/linux/uaccess.h:162 [inline]
>        _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:212 [inline]
>        __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
>        blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
>        blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f

#syz dup: possible deadlock in xfs_vn_update_time

-- 
Dave Chinner
david@fromorbit.com

