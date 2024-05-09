Return-Path: <linux-ext4+bounces-2401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C28C0A31
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C5828477D
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D2147C6C;
	Thu,  9 May 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YPsFhRpT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF1D26D
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225757; cv=none; b=O2KX0IBQTFR1ivNeVKBwOixwqkp1+dQglYz3rlR9/WWV4KxSRNawlC90XrZT7HploSKtCkX6SWLP4SM6Cju0HHheweiAOZmyzJ35V6fFuwNziB4XOedoVWGRzApai5OXZXVdEkGZCHU3M1sZpZ0/GHAPb05MEy9Y9GCmMmvhRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225757; c=relaxed/simple;
	bh=9/MSgwCnW4npJMrnTLJysVqRBt+ZTy17FOClJpYgXOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQVmVCNbGOmLf7NR+z0fMnjPK/e9EVWHKEtw5UPcWLgszrY3/i829egLJn+RqZ0mUBdNNN6YO5bSjWXvJyAIOrv0QzmHEWbZSRLLNuMz1tDbQY1PlCMCRZ/NUvTeREIgEIV+VdgmVY2xYWWIHeWcgfAAGosV1FaEq5Wu32HG9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YPsFhRpT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4493Zftu003342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 23:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715225742; bh=ZljL32bdnUEBW3NfAl5RmsSp3oyrvscuLmD5hIa5+dc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YPsFhRpTdn31fKNjde5BC7TR8NfsqY8yy2K65Zln6MM72urTUNMZ9HzXKTbuqLaIG
	 hDGL16rfpqi4PDLPZtJ4P5za54yzPJI5PlNDrieFyd3PnSxS0+bV4qOJXRfHyudO8c
	 6iRLUFzJe28ei3Y8byQTzcgxgW9sMWkKYR9/ulBdVHk9xBaFFe8D4TXxpW08EHpieV
	 4Q45wIaSFd3F1k0jHyqT1RL5tCf+y/t9UwdWtQAEpfaATHEhR7/TjULnSO5b43X4z4
	 bo+/4JLz592oL+VV0mF9zHDpifEOAVRGH4EFaEuFckkt3EheonfWhMy/Y0kGl/sVbp
	 m3PgIvSDIbCdA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 48F4815C026D; Wed, 08 May 2024 23:35:41 -0400 (EDT)
Date: Wed, 8 May 2024 23:35:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: bugzilla-daemon@kernel.org
Cc: linux-ext4@vger.kernel.org
Subject: Re: [Bug 218820] New: The empty file occupies incorrect blocks
Message-ID: <20240509033541.GB3620298@mit.edu>
References: <bug-218820-13602@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-218820-13602@https.bugzilla.kernel.org/>

On Wed, May 08, 2024 at 01:33:56PM +0000, bugzilla-daemon@kernel.org wrote:
> 
> The following is the triggering script:
> ```
> dd if=/dev/zero of=ext4-0.img bs=1M count=120
> mkfs.ext4 ext4-0.img
> g++ -static reproduce.c
> losetup /dev/loop0 ext4-0.img
> mkdir /root/mnt
> ./a.out
> stat /root/mnt/a
> ```
> 
> After run the script, you will get the following outputs:
> ```
>   File: /root/mnt/a
>   Size: 0               Blocks: 82         IO Block: 1024   regular empty file
> Device: 700h/1792d      Inode: 12          Links: 1
> Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2024-05-08 11:47:48.000000000 +0000
> Modify: 2024-05-08 11:47:48.000000000 +0000
> Change: 2024-05-08 11:47:48.000000000 +0000
>  Birth: -
> ```

Thanks for the bug report.  What the reproducer script is doing is
opening a file for writing, and then remounting the file system to
disable delayhed allocations.  It then writes 40k to the file, and
then truncates the file, and close it.

The reproducer script leaves the file system mounted; if you unmount
the file system, the kernel will issue a warning message:

EXT4-fs (loop0): Inode 13 (0000000082f8ff6c): i_reserved_data_blocks (40) not cleared!

... and then if you examine the on-disk image, you'll see that the
i_blocks field is correct.


The root cause is that when the file is open, the address_operations
which is instaniated is one which is designed for delayed allocation.
So when 40k is written to the file, although we haven't allocated the
space yet, we *will* allocate the space, so we update in-memory
i_blocks to reflect the to-be-allocated disk space (although we don't
update the on-disk i_blocks until the allocation actually takes place,
so if we crash, the file system stays consistent).

However, some of the *other* logic is done based on whether the
delayed allocation flag is set in the struct super (as opposed to the
address_operations in the struct inode at the time that file is
opened).  This includes what happens when we truncate the file, where
in the nodelalloc case, the in-memory and on-disk i_blocks are in
sync, and when the blocks are delallocated, the i_blocks field is
dropped.  But since the blocks weren't actually allocated because the
file descriptor was in delalloc mode, there was nothing to
delallocate, so the in-memory i_blocks stayed elevanted.

There are a number ways of fixing this.  The simplest is to simply not
allow the delayed allocation mode to be changed on a remount.  Since
in the long term, once we fix some performance for some specialized
use case which has caused people to want to disable delayed
allocation, this is the one that probably makes the most sense.

The two other approaches involve a lot more complexity.  The first
alternate approach is to iterate over all open files, and resolve any
pending delayed allocations, and then update the address_operations to
use ext4_aops instead of ext4_da_aops, while avoiding the races
involving writes happening while we are trying to do the remount.
Yelch.

The second alternate approach is to treat the delayed allocation
status on a per-inode basis, with a per-inode flag indicating whether
delayed allocation is active, so that the truncate logic stays
consistent with the ext4_da_ops active on file descriptors associated
with the file.  But this gets super messy since subsequent file opens
on the inode also need to use the same delayed allocation mode until
the last file descriptor associated with the inode is closed.  Double
Yelch.

So preventing the "mount -o remount,nodelalloc" in the reproducer
program is how we'll address this issue.

					- Ted

