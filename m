Return-Path: <linux-ext4+bounces-4015-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103F96AD67
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 02:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E61286A5A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6A1FBA;
	Wed,  4 Sep 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bcLOmTWQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317DD646
	for <linux-ext4@vger.kernel.org>; Wed,  4 Sep 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410148; cv=none; b=uY4rmPkaPGsk5pq1nPUO9gfUMB0y7rsqoWMni/96/DHWKUzKmb1AzzqLNkzC7fMmaj3qPlGxv5W4SaHw1h70eLLp6aOQ5JDI/+dNoK7qMZgyWqcdAJU05U1fXi2srQ3+e4RngC9oKn0tsChw3Emd9j9DifU/IgPr7v59pFTyJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410148; c=relaxed/simple;
	bh=EcEry7sj4uZHIlU9bQDtUoL7z30Ue66a1E6WzjoTlBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8RPvUKaqcDQCtdlxpg3qRSKQ9ZPPajzePIeGCg6Rbpui+0JZxHrWKdQlhAE2z3o7fQMk0LTmP4nCrmS0NiOZAv+5S5Epw6UBzr4rgwEv9j9pIk7OftN+1R1wQDoVQt6du0vSwc9b1uXTH7xW6g4CvpaN4sgQtOTgLRLCh5SUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bcLOmTWQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso170989a91.2
        for <linux-ext4@vger.kernel.org>; Tue, 03 Sep 2024 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725410146; x=1726014946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X09FZcsXHq5FRxLqb6QpBy2WSWRNXIIXcEnLXxsbJbE=;
        b=bcLOmTWQWzs2tkZjfFPS1dANwr2pwA3kcOtrB4xUzaWuJZgGX4djEurhO3/1zKINU+
         FymqsSD5NKmjyhqMH8+fzMQInWc9EJY/ewRuoVmUG+kCk4D+AYgtyEfl4lu6cjDJ9AEc
         j46OcWbrdqaboYL4jqSK2aV2X9ZoDpB6/3DcD+YuD9r0YklWfmaFJscAfrffqS4FPVha
         015LJ2hDB0ayp/Isbw9kAYxfCdVxHcApxgJbmm952PsBpo+Rv0KJulAsM4HkvN4OACAG
         jliqsrVlH8Eu793YRhGKJJ7hM4onNBGb0JQ5SqpjBOmw/NU3DwKX6bkbX+DJIp2TPa9f
         oAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410146; x=1726014946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X09FZcsXHq5FRxLqb6QpBy2WSWRNXIIXcEnLXxsbJbE=;
        b=bidIDHduNPmvaKx58BQ3ra6l3IC0da0ssuCvlpGOFeLQRtHV5B3GaPYQb/JVsG+GJk
         Wcmp/M3kcoRDN0noMabdWCOVbP6K3bBaTs3MzOUmXXaZJvTcLU4TfnJYjgbJTqE4l3lu
         xJ0FHcF0YOr6pXy6rWX19fKTC9jCr4WinprUQG330z+SxS8NYDPSHpHlo26lPQWr3lXf
         eTkdA73+Sz93cq2BTngkYtAFs/H2BUQBoZVcJ6bbWLEms7iXGNZ0tOmbRrWrTRy6PUzI
         LCLNUNRj7pikfyjhwds6IsHgBYJw/7vL2ile9a8oQSimk51f0FN3jRKQ+6E33ULThZ08
         OxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNph96HrWYyzHYJMpe00sVq6+XhgkvETpnD5peFk4y+wxLblxBEo6pNvgtSev6l8oYGDyixkZau03k@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjRYtNHWDUSz8DB6ZSh27vlBs0W/laZnBGxROiBgg9xrB7Pjr
	uQRwg8N+jU99RRv1l8Rp3gGRDGtM4eAWbpZiVXYxo8SKw1KWGFRaid3ECLlb21k=
X-Google-Smtp-Source: AGHT+IGVEY+9Dzsox6IDnQN6NMlVkr8M2M+by+5f76aPgUPj7uhILidXLiNGspq3pJuPnevQJPy1NQ==
X-Received: by 2002:a17:90a:3486:b0:2da:89ac:75b9 with SMTP id 98e67ed59e1d1-2da89ac7679mr897727a91.11.1725410146249;
        Tue, 03 Sep 2024 17:35:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8ebdf56c0sm4508476a91.23.2024.09.03.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:35:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sldzq-000Ueb-0E;
	Wed, 04 Sep 2024 10:35:42 +1000
Date: Wed, 4 Sep 2024 10:35:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: clean preallocated blocks in iomap_end() when 0
 bytes was written.
Message-ID: <ZterXrqAFi9knEbD@dread.disaster.area>
References: <20240903054808.126799-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903054808.126799-1-sunjunchao2870@gmail.com>

On Tue, Sep 03, 2024 at 01:48:08PM +0800, Julian Sun wrote:
> Hi, all.
> 
> Recently, syzbot reported a issue as following:
> 
> WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 __iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
> WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
> CPU: 1 UID: 0 PID: 5222 Comm: syz-executor247 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
> RIP: 0010:__iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
> RIP: 0010:iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
> Call Trace:
>  <TASK>
>  iomap_unshare_iter fs/iomap/buffered-io.c:1351 [inline]
>  iomap_file_unshare+0x460/0x780 fs/iomap/buffered-io.c:1391
>  xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1681
>  xfs_file_fallocate+0x6be/0xa50 fs/xfs/xfs_file.c:997
>  vfs_fallocate+0x553/0x6c0 fs/open.c:334
>  ksys_fallocate fs/open.c:357 [inline]
>  __do_sys_fallocate fs/open.c:365 [inline]
>  __se_sys_fallocate fs/open.c:363 [inline]
>  __x64_sys_fallocate+0xbd/0x110 fs/open.c:363
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2d716a6899
> 
> syzbot constructed the following scenario: syzbot called the write()
> system call, passed an illegal pointer, and attempted to write 0x1017
> bytes, resulting in 0 bytes written and returning EFAULT to user
> space. Then, it called the write() system call again, passed another
> illegal pointer, and attempted to write 0xfea7 bytes, resulting in
> 0xe00 bytes written. Finally called copy_file_range() sys call and
> fallocate() sys call with FALLOC_FL_UNSHARE_RANGE flag.
> 
> What happened here is: during the first write, xfs_buffered_write_iomap_begin()
> used preallocated 512 blocks, inserted an extent with a length of 512 and
> reserved 512 blocks in the quota, with the iomap length being 1M.

Why did XFS preallocate 512 blocks? The file was opened O_TRUNC, so
it should be zero length and a write of just over 4100 bytes will
not trigger speculative prealloc on a zero length file (threshold is
64kB). Indeed, the first speculative prealloc will only be 64kB in
size...

Hence it's not immediately obvious what precondition is causing this
behaviour to occur.

> However, when the write failed(0 byte was written), only 0x1017 bytes were
> passed to iomap_end() instead of the preallocated 1M bytes/512 blocks.
> This caused only 3 blocks to be unreserved for the quota in iomap_end(),
> instead of 512, and the corresponding extent information also only removed
> 3 blocks instead of 512.

Why 3 blocks? what was the filesystem block size? 2kB?

This also smells of delayed allocation, because if it were
-preallocation- it would be unwritten extents and we don't punch
them out on write failures. See my first question....

Regardless, the behaviour is perfectly fine. The remainder of the
blocks are beyond EOF, and so have no impact on anything at this
point in time.

> As a result, during the second write, the iomap length was 3 blocks
> instead of the expected 512 blocks,

What was the mapping? A new delalloc extent from 0 to 6kB? If so,
that is exactly as expected, because there's a hole in the file
there.

> which ultimately triggered the
> issue reported by syzbot in the fallocate() system call.

How? We wrote 3584 bytes, which means the first 2 blocks were
written and marked dirty, and the third block should have been
punched out by the same process that punched the delalloc blocks in
the first write. We end up with a file size of 3584 bytes, and
a delalloc mapping for those first two blocks followed by a hole,
followed by another delalloc extent beyond EOF.

There is absolutely nothing incorrect about this state - this is
exactly how we want delalloc beyond EOF to be handled. i.e. it
remains in place until it is explicitly removed. An normal
application would fix the write buffer and rewrite the data, thereby
using the space beyond EOF that we've already preallocated.

IOWs, this change in this patch is papering over the issue by
preventing short writes from leaving extents beyond EOF, rather than
working out why either CFR or UNSHARE is going wrong when there are
extents beyond EOF.

So, onto the copy_file_range() bit.

Then CFR was called with a length of 0xffffffffa003e45bul, which is
almost 16EB in size. This should result in -EOVERFLOW, because that
is out of the range that an loff_t can represent.

i.e. generic_copy_file_checks() does this:

	if (pos_in + count < pos_in || pos_out + count < pos_out)
                return -EOVERFLOW;

and pos_in is a loff_t which is signed. Hence (0 + 15EB) should
overflow to a large negative offset and be less than 0. Implicit
type casting rules always break my brain - this looks like it is
casting everything to unsigned, thereby not actually checking if
we're overflowing the max offset the kernel can operate on.

This oversize length is not caught by a check against max file size
supported by the superblock, either,, because the count gets
truncated to EOF before the generic checks against supported maximum
file sizes are done.

That seems ... wrong. Look at fallocate() - after checking for
overflow, it checks offset + len against inode->i_sb->s_maxbytes and
returns -EFBIG at that point.

IOWs, I think CFR should be doing nothing but returning either
-EOVERFLOW of -EFBIG here because the length is way longer than
maximum supported file offset for any file operation in Linux.  Then
unshare should do nothing because the file is not shared and should
not have the reflink flag set on it.....

However, the strace indicates that:

copy_file_range(6, [0], 5, NULL, 18446744072099193947, 0) = 3584

That it is copying 3584 bytes. i.e. the overflow check is broken.
It indicates, however, that the file size is as expected from the
the short writes that occurred.

Hence the unshare operation should only be operating on the range of
0-3584 bytes because that is the only possible range of the file
that is shared.

However, the fallocate() call is for offset 0, length 0x2000 bytes
(8kB), and these ranges are passed directly from XFS to
iomap_file_unshare().  iomap_file_unshare() never checks the range
against EOF, either, and so we've passed a range beyond EOF to
iomap_file_unshare() for it to process. That seems ... wrong.

Hence the unshare does:

first map:	 0 - 4k - unshare successfully.
second map:	4k - 6k - hole, skip. Beyond EOF.
third map:	6k - 8k - delalloc, beyond EOF so needs zeroing.
			  Fires warnings because UNSHARE.

IOWs, iomap_file_unshare() will walk beyond EOF blissfully unaware
it is trying to unshare blocks that cannot ever be shared first
place because reflink will not share blocks beyond EOF. And because
those blocks are beyond EOF, they will always trigger the "need
zeroing" case in __iomap_write_begin() and fire warnings.

So, yeah, either xfs_file_fallocate() or iomap_file_unshare() need
to clamp the range being unshared to EOF.

Hence this looks like a couple of contributing issues that need to
be fixed:

- The CFR overflow checks look broken.
- The unshare range is never trimmed to EOF.

but it's definitely not a bug caused by short writes leaving
delalloc extents beyond EOF. There are many, many ways that
we can create delalloc extents beyond EOF before running an UNSHARE
operation that can trip over them like this.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

