Return-Path: <linux-ext4+bounces-7176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF5A82A33
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71702189F519
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB2267393;
	Wed,  9 Apr 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfmJlLxZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAB18A6A5;
	Wed,  9 Apr 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212107; cv=none; b=d7MOzb/Ilb+MYjBf161dgMWQwDs2n3i4+4OwWUl4R8xUpaEGA/ad5wEaZuY4H4hc8t3P0Rt6adfI5q0wHerxCY+KtREgfMBfH7f7IbJcf/uJAKsP4BS4trHytuhv5wqH8qk90p4Hq26kMAXL3pPZoJ353a3E+ip2LIfmoDed4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212107; c=relaxed/simple;
	bh=WhxV21gKRIXKaH0Wmhi1NxF+GZ+fej5qGTGNQRLipN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSFMqAYmyo8eK7Y/k3ZQusqQsRjG+mAEPpwZ//1XCl8ESKXK0HDleI9J1zGyCHuNo6tYSz/ngJJKN95m3SQ0BE3bSZcELmBdEYGEFY8m/RICrad5iKeLhGkG3JPxLF55LKd1gChAqyTzJUKcSFFxS1cRNWDsNWSrtyVV8FpSLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfmJlLxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8E4C4CEE2;
	Wed,  9 Apr 2025 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212106;
	bh=WhxV21gKRIXKaH0Wmhi1NxF+GZ+fej5qGTGNQRLipN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfmJlLxZf/BNuaALpqNodXfpJPrLHrsPpmVdj5oz9RNcBYyHuPJg9gnE0holPhVmm
	 KWx5C897gVX7HQWT9xwwX43z3dbQA2QaLN3MxW/gUDzIqPcNRiYo5ze0vPlFeutrYO
	 DQgsQAObv6oj2/UtR6e6Q+8+zjy6fBVJmNjDU1vaZYEnwK5bSFmblLp5V61Ys02Y6x
	 hRBQSFHF0B3wrAZhlskYXbmynTSNvzsfLEs82ooV5RT62PZiVX3busozimmYZZe/MB
	 yCHYMLwVuL0BfAz3jhhBkluXqXUr5owag9MYG/6gUrv2ECB4Ch05mNdIpMmptLeABV
	 AtjIJFIUDmmTg==
Date: Wed, 9 Apr 2025 08:21:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v4 3/6] check: Remove redundant _test_mount in check
Message-ID: <20250409152146.GN6283@frogsfrogsfrogs>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
 <a9c490ad00b6a441ec991306b22c2fd9d6565de3.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c490ad00b6a441ec991306b22c2fd9d6565de3.1744181682.git.nirjhar.roy.lists@gmail.com>

On Wed, Apr 09, 2025 at 07:00:49AM +0000, Nirjhar Roy (IBM) wrote:
> init_rc already does a _test_mount. Hence removing the additional
> _test_mount call when OLD_TEST_FS_MOUNT_OPTS != TEST_FS_MOUNT_OPTS.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  check | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/check b/check
> index 32890470..3d621210 100755
> --- a/check
> +++ b/check
> @@ -791,13 +791,9 @@ function run_section()
>  		. common/rc
>  		_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> +		# Unmount TEST_DEV to apply the updated mount options.
> +		# It will be mounted again by init_rc(), called shortly after.

Thanks for adding this comment!  Future me will probably appreciate this
breadcrumb. :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		_test_unmount 2> /dev/null
> -		if ! _test_mount
> -		then
> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> -			status=1
> -			exit
> -		fi
>  	fi
>  
>  	init_rc
> -- 
> 2.34.1
> 
> 

