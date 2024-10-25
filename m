Return-Path: <linux-ext4+bounces-4753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D159AF8C3
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 06:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CC21C22157
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1818C01F;
	Fri, 25 Oct 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl0a8IwC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F33611B;
	Fri, 25 Oct 2024 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829224; cv=none; b=XyljwPusoxYkus9fCZnaGbLdVvxWKsprnVcw4+B28eoukDbvIRrCJlJDbE8ZairMrkBe7w97bwj+UlRg7za/Brio2knetqMJhrneEMWRk3ZlqgmUkiEBzrFDdVudt3+wbAPjQ66fqbDGTOXWrNl/FcJlzuwqSsQ8l1LJ6iawbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829224; c=relaxed/simple;
	bh=xXviWkWgcwUJDrDIhg9GmNgc4frx4cg84P5Tr6Kedm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1tMxdyjnuRf1ZKDFgyb3YDc1gbjihYvNh4VErDP6WiBrU3cYBQXz11EHgVZnanORIkjBwgwld1LH2vhUy05XOxUZTP94kTJjDGSOJjt7mOkgjZNaSUr1hYOfsg8ijF2BgxZxHypWAs9vpS/QSZFoin4nyw/qUIIvaLYAfrpGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl0a8IwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EDEC4CEC3;
	Fri, 25 Oct 2024 04:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729829223;
	bh=xXviWkWgcwUJDrDIhg9GmNgc4frx4cg84P5Tr6Kedm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bl0a8IwCZYV8sDK4nKMSWfOx8yqscqqf5LYmv9L5yCYDUvoTM1MWOTUWJLIGqDeZX
	 g0DpCAHtaGBDTPfzwCtzEWBh3mAt4NOGSv3Zglhcxkq9+j7h2pTlk1lLaCtDt/cLNU
	 YgFZoJIKxrJoUUOxlXEJ/u+DDomwzugpeHsYSzR9MyJho3zpFNP4v4ROV8dgEGuLp6
	 l1C+sX6CUIG7i7toSWCLsHvCOK1VCWQkkzCLYnB5hjeNXZlJdhSPRsPco8tNFA6f+9
	 3jcb2YdyBHOYJoS2k/+cV3th5Q8ZA57m4Kp5vAjK/Y1vG6nAL5Bs8N79hr30D50/Bh
	 8Hv28aEDADwXw==
Date: Thu, 24 Oct 2024 21:07:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Message-ID: <20241025040703.GQ2578692@frogsfrogsfrogs>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
 <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Oct 25, 2024 at 10:56:51AM +0800, Zorro Lang wrote:
> On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
> > This patch defines a common helper function to test whether any of
> > fsxattr xflags field is set or not. We will use this helper in the next
> > patch for checking extsize (e) flag.
> > 
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> > ---
> >  common/xfs    |  9 +++++++++
> >  tests/xfs/207 | 14 +++-----------
> >  2 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 62e3100e..7340ccbf 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
> >  	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
> >  }
> >  
> > +# Check whether a fsxattr xflags character field is set on a given file.
> 
> Better to explain the arguments, e.g.
> 
> # Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
> 
> > +# e.g. fsxattr.xflags = 0x0 [--------------C-]
> > +# Returns 0 if passed flag character is set, otherwise returns 1
> > +_test_xfs_xflags_field()
> > +{
> > +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
> > +        && return 0 || return 1
> 
> That's too complex. Those "return" aren't needed as Darrick metioned. About
> that two "grep", how about combine them, e.g.
> 
> _test_xfs_xflags_field()
> {
> 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
> }
> 
> 
> 
> > +}
> > +
> >  _setup_large_xfs_fs()
> >  {
> >  	fs_size=$1
> > diff --git a/tests/xfs/207 b/tests/xfs/207
> > index bbe21307..adb925df 100755
> > --- a/tests/xfs/207
> > +++ b/tests/xfs/207
> > @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/reflink
> > +. ./common/xfs
> 
> Is this really necessary? Will this test fail without this line?
> The common/$FSTYP file is imported automatically, if it's not, that a bug.

If the generic helper goes in common/rc instead then it's not necessary
at all.

--D

> Thanks,
> Zorro
> 
> >  
> >  _require_scratch_reflink
> >  _require_cp_reflink
> >  _require_xfs_io_command "fiemap"
> >  _require_xfs_io_command "cowextsize"
> >  
> > -# Takes the fsxattr.xflags line,
> > -# i.e. fsxattr.xflags = 0x0 [--------------C-]
> > -# and tests whether a flag character is set
> > -test_xflag()
> > -{
> > -    local flg=$1
> > -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> > -}
> > -
> >  echo "Format and mount"
> >  _scratch_mkfs > $seqres.full 2>&1
> >  _scratch_mount >> $seqres.full 2>&1
> > @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
> >  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
> >  _scratch_cycle_mount
> >  
> > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> >  
> >  echo "Unset cowextsize and check flag"
> >  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
> >  _scratch_cycle_mount
> >  
> > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> >  
> >  status=0
> > -- 
> > 2.43.5
> > 
> > 
> 

