Return-Path: <linux-ext4+bounces-5336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085209D5185
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2456282049
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A119D881;
	Thu, 21 Nov 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv8IiQRl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0113E898;
	Thu, 21 Nov 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209630; cv=none; b=H1fmPRybGfUBzDySZ9nFAHTE4okN3aPQv2wK36HKakvFP9mBpt+Vb9zSLLOjkAxGfuBiHYkP6W5pcJSevQaTZRjx2Cjq0Pnp1aZAIxMFqjRAatEEiLlsyCtJqH37AQzTI0VawBp/GisvZI13im2w9aGsDEIR5qf5ahEjdru9Ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209630; c=relaxed/simple;
	bh=1N2gBzTdSNiyQl6TcEZxOCE5voh4npAXxSu72FyYolU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFNTiLuZ/kvhLUPLAIs4INtu4+BhWymW25B+mgLawmO7hBABnrCC91fQ79X4s+sE7uTmqis3/h+I/Y6VwQk6Wk5Xy3/J+R9bngl61XQHUfUgPpjswTy+dMiSq+0XSmp6UElw6Jd15YR+ruQVUsM50rHB3+2cSPH/aYYIxvPcj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv8IiQRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE28EC4CECC;
	Thu, 21 Nov 2024 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732209629;
	bh=1N2gBzTdSNiyQl6TcEZxOCE5voh4npAXxSu72FyYolU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cv8IiQRlfDDpapdfbDXDoO1jaTNulLXV98WPGvrvah6C8SjqCxN1LPKcXpUCaM3Oz
	 WflxnwLP7uFUP5xOVQWrb/lLGLRxl1AbLJBpU4jcW7GwnYblgT++gtluzCjKu5JcBm
	 EEONr4E5IIASqeFseXxaLCKIWkGOOmDS0eF5RGNTPw2Rye3QrRMq3rGwERKDCs2qMd
	 bEabmFGs+hazw02Gin7InRq1DJVe2P82nLsTGe3abqWAkEgvkt13s2szmzkbo9MOmt
	 W/bXlMQ6E+A/PZG5sxjMa3tivqQnGMTLoSNXX1IFw7sE/OlB7YbXoRhLe136Yb2mu8
	 Rpw1G7H6N8EuQ==
Date: Thu, 21 Nov 2024 09:20:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v3 1/3] common/rc,xfs/207: Add a common helper function
 to check xflag bits
Message-ID: <20241121172029.GX9425@frogsfrogsfrogs>
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <e3fe55386a702d34147612b2ce46698b6257e821.1732126365.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fe55386a702d34147612b2ce46698b6257e821.1732126365.git.nirjhar@linux.ibm.com>

On Thu, Nov 21, 2024 at 10:39:10AM +0530, Nirjhar Roy wrote:
> This patch defines a common helper function to test whether any of
> fsxattr xflags field is set or not. We will use this helper in
> an upcoming patch for checking extsize (e) flag.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc     |  7 +++++++
>  tests/xfs/207 | 15 ++++-----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2af26f23..cccc98f5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -41,6 +41,13 @@ _md5_checksum()
>  	md5sum $1 | cut -d ' ' -f1
>  }
>  
> +# Check whether a fsxattr xflags name ($2) field is set on a given file ($1).
> +# e.g, fsxattr.xflags =  0x80000800 [extsize, has-xattr]
> +_test_fsxattr_xflag()
> +{
> +	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
> +}
> +
>  # Write a byte into a range of a file
>  _pwrite_byte() {
>  	local pattern="$1"
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index bbe21307..394e7e55 100755
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
> @@ -65,14 +56,16 @@ echo "Set cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
> +	echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  echo "Unset cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>  
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> +_test_fsxattr_xflag "$testdir/file3" "cowextsize" && echo "C flag set" || \
> +	echo "C flag unset"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>  
>  status=0
> -- 
> 2.43.5
> 
> 

