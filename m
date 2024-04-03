Return-Path: <linux-ext4+bounces-1837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F084689630A
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 05:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7CB1F246CC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07B3D56F;
	Wed,  3 Apr 2024 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="F0VyB+cH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6D1BC58
	for <linux-ext4@vger.kernel.org>; Wed,  3 Apr 2024 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115488; cv=none; b=N/0gJ8TftyF94QWeU/vaMhpBDzqKaG9i8EwBlpKe3/AydL3fdCJ8CeamjvbMzEI4NyJj/Vjcbuuhug0nLUqSyuqoYCTI+y1HR3Vpidv2nkjlHh+nlKRMhDldgnNm4WEP6VG4kcGPtmhFeHP4nSUrKIqJvRFHfN6xjsRoJGg7ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115488; c=relaxed/simple;
	bh=h2KBn6COuC+a+lZnAC+WoFUNhwv2mEiIoMJLVGwD9KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8NW6vJTVGWD38tSWMAxYMb0NZweiXjybpLnAcN3XyKExEj7rAOGjl1pg8rzH0M1Dd+OKC9S43GkdB1EhBHXgdzaSMus3kKtWLGtt98BH3xZoUtB1/lw3a4OWXJ0426o2Bibx4zHWokX5aB4uqfgHqqAqFB8jeQwwjLA1mXHzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=F0VyB+cH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-121-146.bstnma.fios.verizon.net [173.48.121.146])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4333bgjv013728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 23:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712115464; bh=7sksg0d76P8rv/WBwhXUF0FN8DiW7fT49Z3kblGeoRs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=F0VyB+cH4zjNwFe/cxk7bQz/0Yjl5G+50skICAhImWbv8C+A02ukOOD28vC2LsPMT
	 bLngvyxYmfHkbLDrV6qoKA+d4ke7CkQiG6FuP/zCzWI9tT+xVOxyHM1s82FxlIdJA9
	 zp+9ASrtlvupkS7DC4iWozJwbt1oM9wA7KhdhNeZc4VuIu0dZ65lWwyl0LRjEDA+bL
	 CLNCjPamFI57CDXy+rUluwjdLsfhXXiBGEhMpmAD7R3gMdx2FKjTWFKkPt/faFrv1U
	 PVCFjQPN6TgXYl0f7SIf/OLtmaGxPB7o9NpwasO0PA0z4F82oRizaKzBwzlUZ0JYDM
	 iPYOy+Dqe7bnQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9A55915C00DC; Tue,  2 Apr 2024 23:37:42 -0400 (EDT)
Date: Tue, 2 Apr 2024 23:37:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240403033742.GE1189142@mit.edu>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402134240.5he4mxei3nvzolb3@quack3>

On Tue, Apr 02, 2024 at 03:42:40PM +0200, Jan Kara wrote:
> On Tue 02-04-24 17:09:51, Ye Bin wrote:
> > We encountered a problem that the file system could not be mounted in
> > the power-off scenario. The analysis of the file system mirror shows that
> > only part of the data is written to the last commit block.
> > To solve above issue, if commit block checksum is incorrect, check the next
> > block if has valid magic and transaction ID. If next block hasn't valid
> > magic or transaction ID then just drop the last transaction ignore checksum
> > error. Theoretically, the transaction ID maybe occur loopback, which may cause
> > the mounting failure.
> > 
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> So this is curious. The commit block data is fully within one sector and
> the expectation of the journaling is that either full sector or nothing is
> written. So what kind of storage were you using that it breaks these
> expectations?

I suppose if the physical sector size is 512 bytes, and the file
system block is 4k, I suppose it's possible that on a crash, that part
of the 4k commit block could be written.  In *practice* though, this
is super rare.  That's because on many modern HDD's, the physical
sector size is 4k (because the ECC overhead is much lower), even if
the logical sector size is 512 byte (for Windows 98 compatibility).
And even on HDD's where the physical sector size is really 512 bytes,
the way the sectors are laid out in a serpentine fashion, it is
*highly* likely that 4k write won't get torn.

And while this is *possible*, it's also possible that some kind of I/O
transfer error --- such as some bit flips which breaks the checksum on
the commit block, but also trashes the tid of the subsequent block,
such that your patch gets tricked into thinking that this is the
partial last commit, when in fact it's not the last commit, thus
causing the journal replay abort early.  If that's case, it's much
safer to force fsck to be run to detect any inconsistency that might
result.

In general, I strongly recommend that fsck be run on the file system
before you try to mount it.  Yeah, historically the root file system
gets mounted read-only, and then fsck gets run on it, and if
necessary, fsck will fix it up and then force a reboot.  Ye, I'm
assuming that this is what you're doing, and so that's why you really
don't want the mount to fail?

If so, the better way to address this is to use an initramfs which can
run fsck on the real root file system, and then mount it, and then use
pivot_root and then exec'ing the real init program.  That way, even
the journal is corrupted in that way, fsck will attempt to replay the
journal, fail, and you can have fsck do a forced fsck to fix up the
file system.

						- Ted

