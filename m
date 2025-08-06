Return-Path: <linux-ext4+bounces-9275-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D09B1C7DA
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5687F3A8177
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B41192B96;
	Wed,  6 Aug 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CDLnWMjo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AC15B135
	for <linux-ext4@vger.kernel.org>; Wed,  6 Aug 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491625; cv=none; b=tQBTuxULxMLjIZsVQLm2bS8hXN3TxARlx4ULqMSlvDYbCny2CX5qYMa/cWyAQi7S6gubExYMfe/ux0IXSMi8JRzeikiGE37iJjuM2CHwImmkIny/uSAx1w6c+FDBgxHpSIAeAju20351WcG0BC/G9V79gdmxiH8NsgRGraoAEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491625; c=relaxed/simple;
	bh=tk7QFLlbCCpvpyvzqueXNItxkyAFxMmXrih0EUxfmek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDNebtsT6k7bkO/6qlRYts5ElqGD0SAuDlLo4OlZOEwjZr/D9/kKkI5reOSiaUoyOdDDXPV2cjEoLjUc67A1+DrrwInRbalJMcXsZHcgnslZwJSAXxh9mrqDiYBvlB7Bn9dr3Ltoks0eKyZcwB+iapMAfAR0K7WoTYDdqHtrcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CDLnWMjo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-183.bstnma.fios.verizon.net [173.48.102.183])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 576EkovI012595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 10:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754491613; bh=2PgKc0s9udb6ac5tu3jB6ZKq8EjCsICaE/1T42AF0xA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CDLnWMjoCrRsM+YEy/l9TRoor0OC+bnsmkdxb+oozujDq84HdTrXmR+3xG/2V19Ot
	 tPoTSFhOF34oTn0x8C/81WHTJl09BL2zBuhhzzBXPGeqVXOBqZafQo5BIQ18sIuRmh
	 ndagDCv+hXZ+lG0GGWcS0xig9H+POfiS47on2hK0/eLOeonokT7Dn68wLrXvdCl4tz
	 ZnurL4djIgE6CtDmAJvBW/+jPJA0cokh5BLDFxS+v87lzxj0dcNBOkmezuOBtANCGJ
	 AqMjzUcKD2IDJ4BY0k5lzzZGkP7Dm09WcU7rjOJ6/Ax9wnRm2OfPwNbBlp/ljCHTz/
	 oxjQHm+BHwuWA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9FCFA2E00D6; Wed, 06 Aug 2025 10:46:50 -0400 (EDT)
Date: Wed, 6 Aug 2025 10:46:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mingyu He <mingyu.he@shopee.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] ext4: mballoctor issue observed in fs/ext4/mballoc.c
 ext4_mb_regular_allocator on kernel 6.6
Message-ID: <20250806144650.GA778805@mit.edu>
References: <CAAoBcuSk9j3kTAuH5uktd_FV8wryzFegZpFg_v3o94mbYPoA=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoBcuSk9j3kTAuH5uktd_FV8wryzFegZpFg_v3o94mbYPoA=A@mail.gmail.com>

On Wed, Aug 06, 2025 at 04:26:49PM +0800, Mingyu He wrote:
> Hi EXT4 maintainers,
> 
> I would like to report a potential bug related to the ext4 allocator
> implementation, specifically in the file `fs/ext4/mballoc.c`.

Yeah, this is a known issue with ext4's RAID support.  The problem is
that we're trying too hard to try to find a precise RAID stripe
alignment.  There are a couple of things that could be done to solve
the issue, but none of them are easy.

* Cache the number of stripe aligned regions in a particular block
  group, so we can skip the block groups where searching is for a
  stripe alignment is hopeless.  This will reduce the CPU time spent
  searching all of the block groups for each alignment, but on a
  freshly mounted disk, initial allocations will still be slow since
  we would need to read the block allocation bitmaps into memory and
  then process them.  We would also need to keep the cache of the
  number of stripe aligned regions to a minimum.

* Have a hard limit on the amount of time (either wall clock time or
  CPU time) spent searching for stripe aligned bitmaps.  If none are
  available, bail out early.

* Use a more efficient in-memory data structure for storing the free
  block information.  Today, we use a buddy bitmap, which is great if
  we are doing power of two allocations (which for non-RAID file
  systems, we try to do whenever possible, up to trying to allocate
  more space than what was asked for in case the user tries to append
  to the file later).  If the RAID stripe size is power-of-two
  aligned, the buddy bitmap would be fine, but very often, that isn't
  the case.  This still requires initially reading the block bitmap
  into memory in order to convert to that more efficient in-memory
  data structure, but it is simpler than...

* Use a more efficient on-disk data structure, such as a b-tree.  This
  requires an on-disk format change, which means we would need to
  update e2fsprogs, and we would have to worry about backwards
  compatibility in case the file system needs to be mounted on an
  older kernel.

If someone is interested in working on these options (which I view as
a new feature, not as a bug fix), please contact me and I'm happy to
discuss further.

Alternatively, a workaround is to simply disable the RAID stripe
information in the superblock.  You can do this via "tune2fs -E
stripe_width 0 /dev/sdXX".  For a file system which is fragmented such
that finding stripe aligned free space is hopeless, this isn't going
to hurt, and it will definitely help.  In the most recent version of
e2fsprogs, this is now the default in mke2fs for non-rotational (e.g.,
thin provisioned, or flash based) storage devices:

commit b61f182b2de1ea75cff935037883ba1a8c7db623
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun May 4 14:07:14 2025 -0400

    mke2fs: don't set the raid stripe for non-rotational devices by default
    
    The ext4 block allocator is not at all efficient when it is asked to
    enforce RAID alignment.  It is especially bad for flash-based devices,
    or when the file system is highly fragmented.  For non-rotational
    devices, it's fine to set the stride parameter (which controls
    spreading the allocation bitmaps across the RAID component devices,
    which always makessense); but for the stripe parameter (which asks the
    ext4 block alocator to try _very_ hard to find RAID stripe aligned
    devices) it's probably not a good idea.
    
    Add new mke2fs.conf parameters with the defaults:
    
    [defaults]
       set_raid_stride = always
       set_raid_stripe = disk
    
    Even for RAID arrays based on HDD's, we can still have problems for
    highly fragmented file systems.  This will need to solved in the
    kernel, probably by having some kind of wall clock or CPU time
    limitation for each block allocation or adding some kind of
    optimization which is faster than using our current buddy bitmap
    implementation, especially if the stripe size is not multiple of a
    power of two.  But for SSD's, it's much less likely to make sense even
    if we have an optimized block allocator, because if you've paid $$$
    for a flash-based RAID array, the cost/benefit tradeoffs of doing less
    optimized stripe RMW cycles versus the block allocator time and CPU
    overhead is harder to justify without a lot of optimization effort.
    
    If and when we can improve the ext4 kernel implementation (and it gets
    rolled out to users using LTS kernels), we can change the defaults.
    And of course, system administrators can always change
    /etc/mke2fs.conf settings.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Cheers,

						- Ted

