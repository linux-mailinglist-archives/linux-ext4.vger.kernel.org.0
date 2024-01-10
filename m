Return-Path: <linux-ext4+bounces-767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456B82A00E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB94F1F2467B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907EE4D129;
	Wed, 10 Jan 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6ka1H7N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76D4D114
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 18:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AC8C433C7;
	Wed, 10 Jan 2024 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704909974;
	bh=Ki0ye71mL+mWfgYrJDO/8qoMH4/Ku9BhdBnSzja6Hws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6ka1H7NaHvWQvzpk8lpPMOzc2K2y5Ax51C/2NLHYqVLP8D0PIUxx5L7DhSKn3QYS
	 0K+q1p6POHG7qp2OSfenpSm1+D4IxkpEphIf+54rjbxYxlge7Kxy4UBq9DrRkFBFsq
	 mM9i5YSXW0/aS+0VkxXoMjz25EMVnjO13Zr5wyQmLats/T00ix8xY2o6W9SttZ1J+R
	 a6a2iE1X3H2dSMZAxXn8bW5q/O0nKqByIQdxe3Au6Qpbgyr4InIikQdcoJeIYPy7hW
	 53VFydO5AyWEg/l6s5CNF4G67j0X/vza4AL65e4OKq5P/5v2jL9NTdI6QAMkJynkOn
	 i2pHcbLaYjyyg==
Date: Wed, 10 Jan 2024 10:06:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: e2scrub finds corruption immediately after mounting
Message-ID: <20240110180614.GE722946@frogsfrogsfrogs>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
 <20240104045540.GD36164@frogsfrogsfrogs>
 <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
 <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>
 <20240109060629.GA722946@frogsfrogsfrogs>
 <20240110053135.GB722946@frogsfrogsfrogs>
 <36ab91c95ce476cdf38977c8f2a8ca4c4fdf2a47.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36ab91c95ce476cdf38977c8f2a8ca4c4fdf2a47.camel@interlinx.bc.ca>

On Wed, Jan 10, 2024 at 08:44:31AM -0500, Brian J. Murrell wrote:
> On Tue, 2024-01-09 at 21:31 -0800, Darrick J. Wong wrote:
> > 
> > AHA!  This is an ext2 filesystem, since it doesn't have the
> > "has_journal" or "extents" features turned on:
> 
> This is very odd.  I haven't (intentionally) created a ext2 filesystem
> since ext3 became available.  :-)

Huh.  Do you remember the exact command that was used to format this
filesystem?  "mke2fs" still formats ext2 filesystems unless you pass
-T ext4 or call its cousin mkfs.ext4.

> Moreover /proc/mounts says it's an ext4 filesystem:
> 
> /dev/mapper/rootvol_tmp-almalinux8_opt /opt ext4 rw,seclabel,relatime 0 0

Check /etc/fstab -- if the type is specified as ext4, then that's what
ends up in /proc/mounts, even if it's an ext2 filesystem.

> Do ext2 filesystems actually mount successfully and quietly when
> mounted as ext4?

Yes.  Most distros enable ext4.ko and do not enable ext2.ko, and the
ext4 driver is happy to mount ext2 filesystems but report them as ext4.

> Surely if one asks to mount an ext2 filesystem as ext4 mount should
> fail and complain, yes?

Nope.  ext4 is really just ext2 plus a bunch of new features (journal,
extents, uninit_bg, dir_index).  Or another way to look at it is that
ext2 is really just ext4 minus a bunch of features.

Muddying the water here is the fact that you're allowed to turn /off/
all these new features from the past 20 years, which means that the
integer after "ext" is not actually a gestalt id.

> Is https://ext4.wiki.kernel.org/index.php/UpgradeToExt4 still
> considered accurate, in terms of an in-place upgrade of ext2 to ext4
> being sub-optimal?

Yes, that's accurate.  It's suboptimal in the sense that you ought to
back up the directory tree before running any of those commands in case
something goes wrong (program bug, power outage, etc) but if you have a
backup, you might as well format fresh and restore the backup.

> Is metadata locality the only thing you don't get with an in-place
> upgrade?  If so, how important is that, really?

IIRC I think you don't get flex_bg, which means that the bitmaps are
every 128M instead of every 1G or so, which leads to more seeking.

> > Thanks for the
> > metadump, it was very useful for root cause analysis.
> 
> NPAA.  Thank-you very much for your time and analysis on this issue.

No problem.  It's always fun to do a bit of Why, Tho? ;)

--D

> 
> Cheers,
> b.
> 



