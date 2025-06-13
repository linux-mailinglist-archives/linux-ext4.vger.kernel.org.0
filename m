Return-Path: <linux-ext4+bounces-8406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD4AD80C5
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 04:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BD11E1D12
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF81DF742;
	Fri, 13 Jun 2025 02:04:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622E2F4317
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780263; cv=none; b=COdb4D30WUD/5ItQpvmMlb75NMx8cS408RF84LGF2/V+p2S3StXFJuToWxQf+E3UUgRHqF8DdDsmqC/Gpu2CbBdvI7UFJz7d/8ikmPCCTNpRJx/FLf7geZGqcbinOc5rF6vDIj5a6PhVLAeU08IOlWlBGJsBS7eSS8SW34Aqk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780263; c=relaxed/simple;
	bh=B0yJphM+E4U/1RSlojz8rIvAgF3yzuMeApHZwxrV5+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd08BYY76+seRZmMrqQPvAwOIVY+55bCsEfV6MXIc6vxEMwBH54oslmC0yITvjqAN8DKcpbU/WtWusRu7P41aJMbXJKViYVGpKb8iHfZUXJDegQCjapj+m5qWfYwUdShUVJ0fc+a1X+WcQlNGP2E/dFZME5ojqbiXiaFtreduOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.150.107])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55D24DfP009420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 22:04:15 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8C85D34107C; Thu, 12 Jun 2025 22:04:12 -0400 (EDT)
Date: Thu, 12 Jun 2025 23:34:12 -0230
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse2fs: catch positive errnos coming from libext2fs
Message-ID: <20250613020412.GA5819@mit.edu>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
 <174966018106.3972888.12154557537002504919.stgit@frogsfrogsfrogs>
 <20250612164304.GQ784455@mit.edu>
 <20250612221552.GO6179@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612221552.GO6179@frogsfrogsfrogs>

On Thu, Jun 12, 2025 at 03:15:52PM -0700, Darrick J. Wong wrote:
> 
> I.... had no idea that errcode_t's were actually segmented numbers.  Is
> there a way to figure out the subsystem from one of them?

Sure, you can take the high 24-bits, and group them into 4 chunks of
6-bit numbers, and then apply the lookup table found in
lib/et/et_c.awk:

## "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
c2n["A"]=1
c2n["B"]=2
c2n["C"]=3
 ...
c2n["7"]=60
c2n["8"]=61
c2n["9"]=62
c2n["_"]=63

> Or will fuse2fs just have to "know" that !(errcode & 0xFFFFFF00)
> means "errno"?

How error codes get translated into strings is implemented by
lib/et/error_message.c.  If the high 24-bits are zero, then
error_message.c will call strerror(code), because it's assumed that
it's an errno.

Fuse2fs's __translate_error() function is also trying to interpret
error codes, and normally, most code paths just either (a) call
error_message(code) or (b) compare the code for equality against a
specific code point.  But __translate_error() needs to know the
internal underlying structure of the error code so it can do its own
translation, so it has to peer behimd the abstraction barrier
implemented by the com_err library.

I'll note that this scheme is a little fragile, because POSIX does not
guarantee that errno's have to be small integers that fit in the low 8
bits of an integer.  In practice this is true, but there is nothing
stopping a confirming POSIX implementation of some OS to use, say, to
have errnos between 0 and 1024.  Or perhaps some OS might try to
implement their own segmented error code space for errno's.  But in
practice, this has worked out for all the various subsystems that use
the com_err infrastructure, and like libext2fs, the krb5 library has
been ported to zillions of environments.

> Hrm -- if MMP fails, that implies that we might not be the owner of
> this filesystem, right?  Doesn't that means we should be careful about
> not scribbling on the superblock?

Well, the only time we check against MMP is when the file system is
opened.  That's because e2fsprogs doesn't implemented the full MMP
protocol as is found in the kernel.  In order to do that, we'd have to
spawn a separate thread which is periodically checking the superblock
to make sure no other node on the shared block file system has tried
to modify the file system out from under us.

Since historically e2fsprogs is single-threaded, what we do instead is
we write a magic value into the MMP sequence number,
EXT4_MMP_SEQ_FSCK, and if you are unfortunate enough to crash while
fsck.ext4 (or fuse2fs or other e2fsprogs program) is operating on a
file system, then a system adminsitrator would have to recover the
system manually using debugfs -c ("catastrophic recovery" mode) and
its set_super_value command to manually clear the MMP fields.

If we really care about trying to use fuse2fs in a primary/secondary
failover setup using a shared block device, we probably should put a
first class MMP implementation into libext2fs if threading is enabled.
However, the use of MMP is rare enough that it's probably not a high
priority to implement, at least not immediately.

					- Ted

