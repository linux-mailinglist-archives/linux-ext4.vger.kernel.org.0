Return-Path: <linux-ext4+bounces-5606-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB919F0048
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 00:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A041883FFB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB71DED64;
	Thu, 12 Dec 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZPuku1p1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF441547F5
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046811; cv=none; b=gBfiAvjVyZGX3QhLiy4/bspRGPEMHJiWyvoAYbfXYQOqrRrYF79XcVG68IIa6J7QyGlOjsTjcgPFomQKKl/m+mv9K7lpvnwrynoil1MjOWAEUliZ0RQp5jwOEh1JHoz1YWIFYr3MpzNwasD9hmTM4gde5ZmhTABYQw21nA+7Mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046811; c=relaxed/simple;
	bh=VpM1KuXvsaXeqE4X7+jYLZq8lPUHybZbBaDZVdr2Ngs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msqO2HgXm5//QPZ45EacCaH7rWv1usLqK7tUFnjq6TJC/BmNSk6atDWpB+pBG2oo2G8WmoHJVc0sZekUHfEYEvUlH6F7at6uFAvFHB9FlTGmXoZDwLmksbzxj29nMh+/MZ9k6m4RF1FiPoO6HbkWpNdia/PmFCgXP37LbsCzlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZPuku1p1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1029998b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734046809; x=1734651609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ut2NdVyfqDfrSUBP+LM4gv0HVcISGPIE6hkI+7uG05U=;
        b=ZPuku1p1WWHKprMefBfqb3sr2p5L4NFHF8AXa+wExMNP6J8PpP9/wu4xmxBLhA/ks1
         OISJFf0eK+IrYUXgKTNSkcovOwJgFouHWqgxf4WrQIE+mC6r+oB0/kGYjAGDAIlX/RmG
         15SYdNDfKg2ZB5K+vmhX+ygSDAxOq8pGoknWYdpu+0AndHoRvbuo3Ux6aCc/Uhk3z+gk
         wk1MhQXwQ7nsWpmXJJWFZgHpp9NF5FAOAR41sm0Ki1tKoQAlTXy9ANqUuPI2FHXJUDTo
         C6fkvEH3Y8lJcHe/c30wkT8xY+Gv4dawJT88SQTGEjwXc7IqaeIrrIhaTDjVs4rN1njq
         BvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046809; x=1734651609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut2NdVyfqDfrSUBP+LM4gv0HVcISGPIE6hkI+7uG05U=;
        b=lUXFz5AD+QdVZJku5vVMT1CvAIgPIMELtapSUQZ9AVPB8A9AxqJwkXVzdvxdNVoNzT
         LsC8j7gmKxUOq7/jC/NkgWV470pyLJ0I10M1asv/Dwy43nqfUoB48DPbI8UlYwsPVVDc
         1tYk9Ufrhc3YxJh8bUT7ovF6CsN9cvw56PIqn5NisWNSJfdak6XcUg4k02lg4B4LVLQA
         MrGOHzC+nmDIIk588r4h48GWRtISjwGUQ/swnOncal/BLmfJ0cCT0wqYp2EwEc8xFp9v
         7LmL7n2icVwWlWu3mIlh3IuoMK8eysepeEiUkxAPEXSU05Qm0JQIMHJxFNX79VpTtxk6
         jHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMz9AXmQJC9E14brr87PVmz/WR1NUfx+NzHirrvrlFEJhfv/oRSNBrT8jnhHDAKKAol6RZwsar9+HB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi04FYCT/NGo1yCwLFgXHaeDrm25BYAzpY3JQ5aktp7Z5FHeiJ
	MKr8B6w2gO7W37zcrZKQgrDBamjDArg1665dL5Rvwk3L115BOk0J/O+ruFyn+3s=
X-Gm-Gg: ASbGncslCyDLnRoUHsYEPxAsnD1pirp4ptZStnFFLB5gbmFwJOBuX2gq5k3kWUS2Noy
	KMHXwL9H2ttYIEhkUk7ASZq7FbIEqVoT6OZ72skGzjFzMuAlczj3OE0r36GyTSnAgxPjCTaCGew
	sJIz3mGxIpJnT7FlLmEEcZVJ578keAbQdWbL6MDOzOtEBqzewo/uOylDdt0GQ9TApDWZofSlL6p
	oyZ0lbnQ+2iPdbUVR0mMB4AeV1E+GD9/qWGZTGDIDTZ/n6FFbsyPMQ5vqhJSDnThbQWIasNgYtV
	6LE5UXzGP7ypeHXPnw6ulRYNncN1tA==
X-Google-Smtp-Source: AGHT+IEluMoT3eIBWnlrxyiDFTBrfKO9gjh/OfF42m0UDrGQrytFUgm9xpmZZaXXJJA5yM88W+Xmow==
X-Received: by 2002:a05:6a20:b598:b0:1e0:d2f5:6eca with SMTP id adf61e73a8af0-1e1dfec94admr590326637.46.1734046808840;
        Thu, 12 Dec 2024 15:40:08 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd48c5216fsm7905016a12.77.2024.12.12.15.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:40:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLsmq-00000009zsG-16tl;
	Fri, 13 Dec 2024 10:40:04 +1100
Date: Fri, 13 Dec 2024 10:40:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+cbcad0f3b7646f8653ee@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_da_get_block_prep (2)
Message-ID: <Z1t0VJRWuW-tMhf4@dread.disaster.area>
References: <6759e8c7.050a0220.17f54a.0042.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6759e8c7.050a0220.17f54a.0042.GAE@google.com>

On Wed, Dec 11, 2024 at 11:32:23AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164170f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
> dashboard link: https://syzkaller.appspot.com/bug?extid=cbcad0f3b7646f8653ee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4000132d9d47/disk-b5f21708.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/85cadac2b6fb/vmlinux-b5f21708.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0321667f4cf4/bzImage-b5f21708.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cbcad0f3b7646f8653ee@syzkaller.appspotmail.com
> 
> loop4: detected capacity change from 0 to 2048
> EXT4-fs (loop4): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
> ======================================================
> WARNING: yossible circular locking dependency detected
> 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0 Not tainted
> ------------------------------------------------------
> syz.4.1456/13188 is trying to acquire lock:
> ffff888040d89658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_da_map_blocks fs/ext4/inode.c:1799 [inline]
> ffff888040d89658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_da_get_block_prep+0x428/0x1900 fs/ext4/inode.c:1873
> 
> but task is already holding lock:
> ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:846 [inline]
> ffff888040d89498 (&ei->xattr_sem){++++}-{4:4}, at: ext4_da_write_inline_data_begin+0x2d3/0x1090 fs/ext4/inline.c:921
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (&ei->xattr_sem){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
>        ext4_readpage_inline+0x36/0x6b0 fs/ext4/inline.c:518
>        ext4_read_folio+0x174/0x340 fs/ext4/inode.c:3185
>        filemap_read_folio+0x14d/0x630 mm/filemap.c:2366
>        filemap_create_folio mm/filemap.c:2497 [inline]
>        filemap_get_pages+0x100a/0x2540 mm/filemap.c:2555
>        filemap_read+0x45c/0xf50 mm/filemap.c:2646
>        __kernel_read+0x515/0x9d0 fs/read_write.c:523
>        integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
>        ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>        ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>        ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:568
>        ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:293
>        process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:372
>        ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
>        security_file_post_open+0xb9/0x280 security/security.c:3121
>        do_open fs/namei.c:3830 [inline]
>        path_openat+0x2ccd/0x3590 fs/namei.c:3987
>        do_filp_open+0x27f/0x4e0 fs/namei.c:4014
>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
>        do_sys_open fs/open.c:1417 [inline]
>        __do_sys_openat fs/open.c:1433 [inline]
>        __se_sys_openat fs/open.c:1428 [inline]
>        __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (mapping.invalidate_lock){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
>        filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
>        page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226
>        do_async_mmap_readahead mm/filemap.c:3231 [inline]
>        filemap_fault+0x82a/0x1950 mm/filemap.c:3330
>        __do_fault+0x137/0x460 mm/memory.c:4907
>        do_read_fault mm/memory.c:5322 [inline]
>        do_fault mm/memory.c:5456 [inline]
>        do_pte_missing mm/memory.c:3979 [inline]
>        handle_pte_fault+0x335a/0x68a0 mm/memory.c:5801
>        __handle_mm_fault mm/memory.c:5944 [inline]
>        handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
>        faultin_page mm/gup.c:1187 [inline]
>        __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
>        __get_user_pages_locked mm/gup.c:1751 [inline]
>        get_dump_page+0x155/0x2f0 mm/gup.c:2269
>        dump_user_range+0x14d/0x970 fs/coredump.c:943
>        elf_core_dump+0x3e9f/0x4790 fs/binfmt_elf.c:2129
>        do_coredump+0x229d/0x3100 fs/coredump.c:758
>        get_signal+0x140b/0x1750 kernel/signal.c:3002
>        arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
>        exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>        exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>        irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
>        exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1542
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

