Return-Path: <linux-ext4+bounces-5217-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BD9CF206
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 17:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C0329604B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C61D5CF1;
	Fri, 15 Nov 2024 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs0OLyJk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7713AA3E;
	Fri, 15 Nov 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689150; cv=none; b=MphXg1+ympTE6grIm8EvyiG+CP6u5Ts499VZ0dLeurKVX16aBZbXzIailM29kY6ioaC6QSiBq076K8KhsCMULsNmz8J9OTihRof42SDrxVrygfoxYCxpe1V+SOBfiopxwrx8B90X4Pnjhw9xM45IZBI6/vPsaHQwSreMDoWKSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689150; c=relaxed/simple;
	bh=e50cVx2A1nY7atCYkybhbwvEmsBPVxbZ0bVfDZ473Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRt89tFEStcZyEqlNqK74oAFDf2ZSzGoB90SKbudVL0X2VD+1Oy/htRkiy3UJG7hMhWxPjvS+ZqYy2yIyp2DZBX37kVDPxKlf+UkeIEE4ZXGc4bMCX5ya0u3YB8gq+RCVB9L6sfWkwddBP9XNWXfyFuXwTrGXKPR1ZzDL4UNikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs0OLyJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B05C4CECF;
	Fri, 15 Nov 2024 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689149;
	bh=e50cVx2A1nY7atCYkybhbwvEmsBPVxbZ0bVfDZ473Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs0OLyJkL3VnxERlBWiHfrvY7y6BfHg6UWNhFOq9mAJW0ycc1/2rqEFNmGJVNWYvE
	 4SYE0kM9dN7s51b3oj+ztBuiYGXojHZXMRzKmVu5p3wYCKyLTLZwul5RIOpGMnyQt3
	 S9SJRjww0HXH4k7Z/PbsntgTDRhMrdHg2lK5iKlRQwfg47P2ZpN2PVMYh4Yhs/Dq4u
	 bE/c5CZIAHyxC7JMnex31BPzo/T6Zi1T6oebN6hi5XZyedtnyZpMbjn5wzJ1e3dKgF
	 rJ/aiWujkjwuBemRqoq/qmVR6dNtbDW8igEaoS+UZVZ3UPuAMEk5DryQet/FXilRWd
	 fof7KpmKQMVxw==
Date: Fri, 15 Nov 2024 08:45:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper
 function to check xflag bits on a given file
Message-ID: <20241115164548.GE9425@frogsfrogsfrogs>
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
 <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com>

On Fri, Nov 15, 2024 at 09:45:58AM +0530, Nirjhar Roy wrote:
> This patch defines a common helper function to test whether any of
> fsxattr xflags field is set or not. We will use this helper in the next
> patch for checking extsize (e) flag.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> ---
>  common/rc     |  7 +++++++
>  tests/xfs/207 | 13 ++-----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2af26f23..fc18fc94 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -41,6 +41,13 @@ _md5_checksum()
>  	md5sum $1 | cut -d ' ' -f1
>  }
>  
> +# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
> +# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
> +_test_fsx_xflags_field()

How about we call this "_test_fsxattr_xflag" instead?

fsx is already something else in fstests.

> +{
> +    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
> +}

Not sure why this lost the xfs_io | grep -q structure.  The return value
of the whole expression will always be the return value of the last
command in the pipeline.

(Correct?  I hate bash...)

--D

> +
>  # Write a byte into a range of a file
>  _pwrite_byte() {
>  	local pattern="$1"
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index bbe21307..4f6826f3 100755
> --- a/tests/xfs/207
> +++ b/tests/xfs/207
> @@ -21,15 +21,6 @@ _require_cp_reflink
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
> @@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  echo "Unset cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  status=0
> -- 
> 2.43.5
> 
> 

