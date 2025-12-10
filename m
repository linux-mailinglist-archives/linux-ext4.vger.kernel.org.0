Return-Path: <linux-ext4+bounces-12276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0791CB42C5
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682A230124E2
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED32DC767;
	Wed, 10 Dec 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeY66NyB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8F2C236B;
	Wed, 10 Dec 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407045; cv=none; b=aPKZ4aiEHIFAkD5dqPXplcHr5agociYPdO3FcO6xk6oxEtO4V2NjmeZ194DF/v0TmboDeBXpMunp+E8SVBqJweJeJUd2p6hctmUDMRqUnK193/XVD1bvMyUEtG031b7AbfkhmSpVUvimGxFBRGqM+uxc+NFHIaTlyMJne2xs0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407045; c=relaxed/simple;
	bh=/vJAD7coR7PBGj/1dOV7wwbutqvm1ihVpTuS65fVEBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlpUAEPs61uIoV2jdbsp5OmqTuh84KZQ4NvUDxHNXd87tx4S7OvjqnL4pevOFtC9J6m6FAFNUXIQ93EcoVgATvpa9xlZPnLy4gNT7TJZYcQIlwrM7jaAlnAzi9m3q+VHNzT1eM99kG8yB/SVntBBIZh7BK2TXZ9ZL53JO6NItL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeY66NyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C04C4CEF1;
	Wed, 10 Dec 2025 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407044;
	bh=/vJAD7coR7PBGj/1dOV7wwbutqvm1ihVpTuS65fVEBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeY66NyBroC9uYk/FqQbp0jcT0gsBlxwIH91czZi4cdOOHqcaAElWaFV8Rpk/ebrJ
	 4neDOTVD+JnMpEkIRN9aMJsZv96QWo6Q0BfwAx/fXYFTo8T85ypcH4HII9Afgb351m
	 QDuC479W49JKGGR0QuXEQzqAEy7yYZ6syq9BlpDcoX2ZPq6H3kbfSzRtS+DJ+flH4h
	 7Dq6j0W/XJXJDg7vElY4TJpxxA0IVnhYwJXYQr9/wzXuyaYFwCRM5L7eI3cJg7CgU/
	 MlPifUa5Znn2CcgBS/dAE/TJpEjE7S19dJPPhqEtJH1qSc+2NRN7j+CkZpT7y5nGGj
	 lVqIwLsXYqoig==
Date: Wed, 10 Dec 2025 14:50:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] xfs/650:  require a real SCRATCH_RTDEV
Message-ID: <20251210225043.GI94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-13-hch@lst.de>
 <20251210194549.GB94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210194549.GB94594@frogsfrogsfrogs>

On Wed, Dec 10, 2025 at 11:45:49AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 10, 2025 at 06:46:58AM +0100, Christoph Hellwig wrote:
> > Require a real SCRATCH_RTDEV instead of faking one up using a loop
> > device, as otherwise the options specified in MKFS_OPTIONS might
> > not actually work the configuration.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/xfs/650 | 63 +++++----------------------------------------------
> 
> Er... what test is xfs/650?  There isn't one in for-next.

Aha, I missed that an earlier patch created it. :(

The one downside to not injecting a rt device here is that now the only
testing for the actual bug is if you happen to have rt enabled.  That
used to be a concern of mine, but maybe between you, me, Meta, and the
kdevops folks there's enough now.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> >  1 file changed, 6 insertions(+), 57 deletions(-)
> > 
> > diff --git a/tests/xfs/650 b/tests/xfs/650
> > index d8f70539665f..418a1e7aae7c 100755
> > --- a/tests/xfs/650
> > +++ b/tests/xfs/650
> > @@ -9,21 +9,11 @@
> >  # bunmapi"). On XFS without the fixes, truncate will hang forever.
> >  #
> >  . ./common/preamble
> > -_begin_fstest auto prealloc preallocrw
> > -
> > -# Override the default cleanup function.
> > -_cleanup()
> > -{
> > -	_scratch_unmount &>/dev/null
> > -	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> > -	cd /
> > -	rm -f $tmp.*
> > -	rm -f "$TEST_DIR/$seq"
> > -}
> > +_begin_fstest auto prealloc preallocrw realtime
> >  
> >  . ./common/filter
> >  
> > -_require_scratch_nocheck
> > +_require_realtime
> >  _require_xfs_io_command "falloc"
> >  
> >  maxextlen=$((0x1fffff))
> > @@ -31,51 +21,11 @@ bs=4096
> >  rextsize=4
> >  filesz=$(((maxextlen + 1) * bs))
> >  
> > -must_disable_feature() {
> > -	local feat="$1"
> > -
> > -	# If mkfs doesn't know about the feature, we don't need to disable it
> > -	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
> > -
> > -	# If turning the feature on works, we don't need to disable it
> > -	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
> > -		> /dev/null 2>&1 && return 1
> > -
> > -	# Otherwise mkfs knows of the feature and formatting with it failed,
> > -	# so we do need to mask it.
> > -	return 0
> > -}
> > -
> > -extra_options=""
> > -# Set up the realtime device to reproduce the bug.
> > +_scratch_mkfs \
> > +	-d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1 \
> > +	-r extsize=$((bs * rextsize)) \
> > +	>>$seqres.full 2>&1
> >  
> > -# If we don't have a realtime device, set up a loop device on the test
> > -# filesystem.
> > -if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> > -	_require_test
> > -	loopsz="$((filesz + (1 << 26)))"
> > -	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> > -	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> > -	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> > -	USE_EXTERNAL=yes
> > -	SCRATCH_RTDEV="$loop_dev"
> > -	disabled_features=()
> > -
> > -	# disable reflink if not supported by realtime devices
> > -	must_disable_feature reflink &&
> > -		disabled_features=(-m reflink=0)
> > -
> > -	# disable rmap if not supported by realtime devices
> > -	must_disable_feature rmapbt &&
> > -		disabled_features+=(-m rmapbt=0)
> > -fi
> > -extra_options="$extra_options -r extsize=$((bs * rextsize))"
> > -extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> > -
> > -_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> > -_try_scratch_mount >>$seqres.full 2>&1 || \
> > -	_notrun "mount failed, kernel doesn't support realtime?"
> > -_scratch_unmount
> >  _scratch_mount
> >  _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
> >  
> > @@ -108,7 +58,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
> >  # Truncate the extents.
> >  $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
> >  
> > -# We need to do this before the loop device gets torn down.
> >  _scratch_unmount
> >  _check_scratch_fs
> >  
> > -- 
> > 2.47.3
> > 
> > 
> 

