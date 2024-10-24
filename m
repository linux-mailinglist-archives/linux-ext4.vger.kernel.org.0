Return-Path: <linux-ext4+bounces-4730-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796229AEF31
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262B61F2297E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0031FF7D9;
	Thu, 24 Oct 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqHJFl58"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61891FF608;
	Thu, 24 Oct 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793319; cv=none; b=eutlZm0LN5FaTcCbIcuWv7HmDNv1Gha/u0UAyM2h+LAdKNPJso4EPYuClSF7aW1Fn8lpITPuF8bhtRtaNccNOQ8jDcxiTlEdlCXDVEkSPq5Fg5dgqQykY85c9yBH6bHfqDjRwM/0wQ+JPeCcE72w61XZuqEflZlMOooKqBtSUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793319; c=relaxed/simple;
	bh=LD6W6zG0bcPUMKmzYcnwI2UvbtysSNWYk2y4KzAFI4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ4En3OySxoCy+ZM9zLqx83m11IJjWbD0sJapcBKV9zDQXSfsKfOE8n5y6yF21pOzu3hYhvBGaOTWDZUdGmhF3LVPh1MIEcPzE4Yu+rnbm3Wr61fOoRTUQMuO+TdDljBfpwFjsMEHNOdK+Nr5EXqpPaaiQaPbTZie2naJ5vdTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqHJFl58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1FC4CEC7;
	Thu, 24 Oct 2024 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793319;
	bh=LD6W6zG0bcPUMKmzYcnwI2UvbtysSNWYk2y4KzAFI4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqHJFl58Eibqfeam8kFCGV7m4QrFhu9sHZyme/KuGdNqGHl/8nqZAik8103ooFxxB
	 2vJ2mY913tgsikumKmnRkxRbY7aRjKYUsIxd9EaNXeDA5ha8YY1Ar+B1jPWhTAihTx
	 Xh7x3IMirNwEhBXIzg4oiunvyGysaz6ZvvMYCprLEX0VGHn4g1BV+s8gJBEltA/t5Q
	 jFutfaLrQG6lPvq8uunBmjs2HnuTZoiDuphh7PYZH/9Hzy+cl0g719zlD+2yZajI1W
	 QzHuFmyNQnqfs5Wmf/stbymIzFXUTitKvRgYWG1a1D+0lS0R9KMTei/poZi+behyCo
	 5iFS2NlQc9tzA==
Date: Thu, 24 Oct 2024 11:08:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Message-ID: <20241024180838.GD2386201@frogsfrogsfrogs>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>

On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
> This patch defines a common helper function to test whether any of
> fsxattr xflags field is set or not. We will use this helper in the next
> patch for checking extsize (e) flag.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> ---
>  common/xfs    |  9 +++++++++
>  tests/xfs/207 | 14 +++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 62e3100e..7340ccbf 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
>  	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
>  }
>  
> +# Check whether a fsxattr xflags character field is set on a given file.
> +# e.g. fsxattr.xflags = 0x0 [--------------C-]
> +# Returns 0 if passed flag character is set, otherwise returns 1
> +_test_xfs_xflags_field()

Seeing as fsxattr got added to ext4 and others, this probably should be
called _test_fsxattr_xflags() and live in common/rc.

> +{
> +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
> +        && return 0 || return 1

No need for this bit, the grep -q will set the return value to 0 or 1
and bash will leave that set for the caller.

--D

> +}
> +
>  _setup_large_xfs_fs()
>  {
>  	fs_size=$1
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index bbe21307..adb925df 100755
> --- a/tests/xfs/207
> +++ b/tests/xfs/207
> @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
>  # Import common functions.
>  . ./common/filter
>  . ./common/reflink
> +. ./common/xfs
>  
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "cowextsize"
>  
> -# Takes the fsxattr.xflags line,
> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
> -# and tests whether a flag character is set
> -test_xflag()
> -{
> -    local flg=$1
> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> -}
> -
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
> @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  echo "Unset cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  status=0
> -- 
> 2.43.5
> 
> 

