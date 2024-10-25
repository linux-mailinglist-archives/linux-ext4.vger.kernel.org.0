Return-Path: <linux-ext4+bounces-4756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71449AF926
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 07:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3511F22FCF
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6D18DF6E;
	Fri, 25 Oct 2024 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppCg6bZQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096015B13D;
	Fri, 25 Oct 2024 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834066; cv=none; b=nhs3I1q/S4SMMZ9XtlKQl2QqAb0p+FrGeh2uJt0EWxIJhRU7eRYXGyZs/OuWWIqQe0VbQ5mjYIS28ZEFue6NVaYucXp7GNf6m3XRLbSByctN53QWSCPX1GOCB81EWhzeywzZhuO9nuFJIaMyxHo5AFnUR3x+hrRqLTR9LkhQO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834066; c=relaxed/simple;
	bh=MXpuubODSd79ThAPMN4CuRiLlrM5zlmsIwbCsCmq3+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8pOf/osdxb9Mtt8WlaJKRvCKgmcJrExLlTwxAoFbndMONc0ry8YX6Nc7fOihsciBBiJ6akuJ9LJper8DbJjn9zfrh0GE2tUWaIK6x1O+fnvBKNwUEBNQWv8mabs+oahfl/NHJI12RHJA2w4Vqx/HE1z7ryz1Wn16xJdCdmd6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppCg6bZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9563CC4CEC3;
	Fri, 25 Oct 2024 05:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729834065;
	bh=MXpuubODSd79ThAPMN4CuRiLlrM5zlmsIwbCsCmq3+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppCg6bZQczk7xIIucljCppL+E2pjL38WLqaCJHnMZLCRid+4Kiy3niaTuacPln02A
	 iSvyw2SrlSl/Fr8L7nMydDEs5985ku/FXaiPTFsD+CJzIRffYmgWOfnI0pnbUUVKUh
	 JuCas8ilpyZTa4K9C35L8uFlTq7MonsQmsp25lumIHE0YylWuG/RxsjRQ15dTGV2kf
	 WAPdZQmHvGeejK8zloFqOUpSPnFHIbqC6iwXQXTOJ763F6uusU8/qu7Yip4rbFVPyM
	 XbPiJEuMjKn1zWvPFwAhIq4uchxSGIE3OrlEZ9yEJDwKfVoGBb9DVXdW0kBPhyABxz
	 f33SYA/5Y7+Tw==
Date: Thu, 24 Oct 2024 22:27:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Message-ID: <20241025052744.GR21840@frogsfrogsfrogs>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
 <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241025040703.GQ2578692@frogsfrogsfrogs>
 <20241025041501.jzj7b2ensn6lvpep@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025041501.jzj7b2ensn6lvpep@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Oct 25, 2024 at 12:15:01PM +0800, Zorro Lang wrote:
> On Thu, Oct 24, 2024 at 09:07:03PM -0700, Darrick J. Wong wrote:
> > On Fri, Oct 25, 2024 at 10:56:51AM +0800, Zorro Lang wrote:
> > > On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
> > > > This patch defines a common helper function to test whether any of
> > > > fsxattr xflags field is set or not. We will use this helper in the next
> > > > patch for checking extsize (e) flag.
> > > > 
> > > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> > > > ---
> > > >  common/xfs    |  9 +++++++++
> > > >  tests/xfs/207 | 14 +++-----------
> > > >  2 files changed, 12 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/common/xfs b/common/xfs
> > > > index 62e3100e..7340ccbf 100644
> > > > --- a/common/xfs
> > > > +++ b/common/xfs
> > > > @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
> > > >  	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
> > > >  }
> > > >  
> > > > +# Check whether a fsxattr xflags character field is set on a given file.
> > > 
> > > Better to explain the arguments, e.g.
> > > 
> > > # Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
> > > 
> > > > +# e.g. fsxattr.xflags = 0x0 [--------------C-]
> > > > +# Returns 0 if passed flag character is set, otherwise returns 1
> > > > +_test_xfs_xflags_field()
> > > > +{
> > > > +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
> > > > +        && return 0 || return 1
> > > 
> > > That's too complex. Those "return" aren't needed as Darrick metioned. About
> > > that two "grep", how about combine them, e.g.
> > > 
> > > _test_xfs_xflags_field()
> > > {
> > > 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
> > > }
> > > 
> > > 
> > > 
> > > > +}
> > > > +
> > > >  _setup_large_xfs_fs()
> > > >  {
> > > >  	fs_size=$1
> > > > diff --git a/tests/xfs/207 b/tests/xfs/207
> > > > index bbe21307..adb925df 100755
> > > > --- a/tests/xfs/207
> > > > +++ b/tests/xfs/207
> > > > @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
> > > >  # Import common functions.
> > > >  . ./common/filter
> > > >  . ./common/reflink
> > > > +. ./common/xfs
> > > 
> > > Is this really necessary? Will this test fail without this line?
> > > The common/$FSTYP file is imported automatically, if it's not, that a bug.
> > 
> > If the generic helper goes in common/rc instead then it's not necessary
> > at all.
> 
> Won't the "_source_specific_fs $FSTYP" in common/rc helps to import common/xfs?

Yeah, that too.

--D

> > 
> > --D
> > 
> > > Thanks,
> > > Zorro
> > > 
> > > >  
> > > >  _require_scratch_reflink
> > > >  _require_cp_reflink
> > > >  _require_xfs_io_command "fiemap"
> > > >  _require_xfs_io_command "cowextsize"
> > > >  
> > > > -# Takes the fsxattr.xflags line,
> > > > -# i.e. fsxattr.xflags = 0x0 [--------------C-]
> > > > -# and tests whether a flag character is set
> > > > -test_xflag()
> > > > -{
> > > > -    local flg=$1
> > > > -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> > > > -}
> > > > -
> > > >  echo "Format and mount"
> > > >  _scratch_mkfs > $seqres.full 2>&1
> > > >  _scratch_mount >> $seqres.full 2>&1
> > > > @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
> > > >  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
> > > >  _scratch_cycle_mount
> > > >  
> > > > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > > > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> > > >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> > > >  
> > > >  echo "Unset cowextsize and check flag"
> > > >  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
> > > >  _scratch_cycle_mount
> > > >  
> > > > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > > > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> > > >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> > > >  
> > > >  status=0
> > > > -- 
> > > > 2.43.5
> > > > 
> > > > 
> > > 
> > 
> 
> 

