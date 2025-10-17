Return-Path: <linux-ext4+bounces-10962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3794BEBFE2
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 01:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85B9F4E433F
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAE26FA5B;
	Fri, 17 Oct 2025 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbKVJdJG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2743354AE7
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743523; cv=none; b=ISKMAhQFpy4UXWF1t9aQ4xpLa2VLAQobmeiFjqrdoot8o949RpQpRjJTfQQU/5gTlUr8gYPYzbd2z7HLKs2D7w1KRajDhO8SFMG3voTthND9JkwK3Z888++JGegbU8I8t1C0P+6RzvTzfQzAA9AggO1FSlixV/sgwu6sEnwPY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743523; c=relaxed/simple;
	bh=DTShY8Tm9QhTeNiI9sFwXbPyf9k0XHIyCexMx/S57qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NasUxvH24YhEAWHPb3jydUomp2cjEB30lLbeNZCQqgbPcE1lGq1l6Kk0s/VXUI58OsEIMl+jyhw6sSuYRWpMDpcDqKeVtUBzUQ27deUocgG+f+C0BsLKmJ2cP6NHaq93/RWR4l16H04BQIADjIf4tXF+M+AHqSWE0LU5rwdQTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbKVJdJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114FC4CEE7;
	Fri, 17 Oct 2025 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743522;
	bh=DTShY8Tm9QhTeNiI9sFwXbPyf9k0XHIyCexMx/S57qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbKVJdJGw/f41tY0Zr6k6EgbnRJvTRYfIAy0znzH5A8W596Hxx/PgLhhov6O7Q3UY
	 weAc88b57dGakf2oSybQqgCw+BcD4uzVd4g2pEVbz2Ua5WZAnsNXyAu0AGGa+8UwuG
	 oAO8msaw+10NFkCdJt+dE0wJucFing50ZCftgDltljXYBB/FNkC49dg8B1Cxntpf9h
	 AXEyPV69Ionbxe0VvYbOQ6zcKjiDvTNEXAMnh+2qF5JzHBVXMdzn0QgeflfbcMpuY0
	 r0zNhCA0fL3wjRpNXv/9HGudmYEzn5wmrdGVRPTJB9V+P5kDpwlp+fv7sE6Vhuazzf
	 kBPuda5cyomsg==
Date: Fri, 17 Oct 2025 16:25:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <20251017232521.GI6170@frogsfrogsfrogs>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
 <aPKilSNCQRW9c6rl@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKilSNCQRW9c6rl@cern.ch>

On Fri, Oct 17, 2025 at 03:09:57PM -0500, Dave Dykstra wrote:
> On Fri, Oct 17, 2025 at 12:18:00PM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 16, 2025 at 03:09:03PM -0500, Dave Dykstra wrote:
> > > This makes two changes to the message that is shown saying that fuse2fs
> > > does not support the journal.  First is that it reverts the check to
> > > what it was before 3875380 to look at the ro option not being set
> > > instead of checking the RW flag.  That's because I don't think this
> > > message needs to be shown when the ro option is set even when it was
> > > opened RW; there should be nothing to corrupt when it is ro.
> > > 
> > > Second, it changes the message to say that writing is not supported
> > > rather than using the journal is not supported.  The current message is
> > > confusing because in fact the journal is used for recovery when needed
> > > and possible.
> > > 
> > > Also submitted as PR https://github.com/tytso/e2fsprogs/pull/251
> > > 
> > > Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
> > > ---
> > >  misc/fuse2fs.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> > > index cb5620c7..c46cc03b 100644
> > > --- a/misc/fuse2fs.c
> > > +++ b/misc/fuse2fs.c
> > > @@ -4774,10 +4774,10 @@ int main(int argc, char *argv[])
> > >  		}
> > >  	}
> > >  
> > > -	if (global_fs->flags & EXT2_FLAG_RW) {
> > > +	if (!fctx.ro) {
> > 
> > Again, rw != EXT2_FLAG_RW.
> > 
> > The ro and rw mount options specify if the filesystem mount is writable.
> > You can mount a filesystem in multiple places, and some of the mounts
> > can be ro and some can be rw.
> > 
> > EXT2_FLAG_RW specifies that the filesystem driver can write to the block
> > device.  fuse2fs should warn about incomplete journal support any time
> > the **filesystem** is writable, independent of the write state of the
> > mount.
> 
> Are you saying that is indeed possible for a read-only mount to cause
> file corruption or data loss if there's not a graceful unmount?  If so,

No, I'm saying that filesystem drivers can *themselves* write metadata
to a filesystem mounted ro.  ro means that user programs can't write to
the files under a particular mountpoint.  This has long been the case
for the kernel implementations of ext*, XFS, btrfs, etc.

I've said this three times now, and this is the last time I'm going to
say it.

> it sure seems like that should be avoided if possible!  Since fuse2fs
> does not support writing the journal, perhaps its behavior should be
> different than the kernel's behavior for this too.  Perhaps once the
> journal is recovered it should be remounted without EXT2_FLAG_RW.

No.  Ted and I are trying to minimize the differences between the kernel
and fuse2fs.

> In any case, during further testing I did find a serious problem with
> this change in that it changes more than just the message; it also skips
> reading in the inode bitmap, which causes a problem later.  So at
> minimum this patch should only affect the message, not the rest of the
> stuff in that if statement.

Are you running fstests QA on these patches before you send them out?

--D

> > Filesystems are allowed to write to the block device even if the mount
> > itself is readonly, e.g. kernel ext4 recovering the journal on an ro
> > mount.
> > 
> > NAK.
> > 
> > --D
> > 
> > >  		if (ext2fs_has_feature_journal(global_fs->super))
> > >  			log_printf(&fctx, "%s",
> > > - _("Warning: fuse2fs does not support using the journal.\n"
> > > + _("Warning: fuse2fs does not support writing the journal.\n"
> 
> What do you think about this message change?
> 
> Dave
> 
> > >     "There may be file system corruption or data loss if\n"
> > >     "the file system is not gracefully unmounted.\n"));
> > >  		err = ext2fs_read_inode_bitmap(global_fs);
> > > -- 
> > > 2.43.5
> > > 
> > > 
> > 
> 

