Return-Path: <linux-ext4+bounces-7178-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9573AA82A54
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADD24A5280
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64642673A2;
	Wed,  9 Apr 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZALKpvOm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE311DFFD;
	Wed,  9 Apr 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212213; cv=none; b=epNu79Kggs0EUyPOC/gR5CLFz67boDy7r24JElQrbguiBFinxnSTP5XV7CXdEfAdSggqLXqdS9F7zApcUJoVGLxWJIr1GYs5cBC4REPjGOKQ1ISBTZaI1l3dOe8Uns2veHldy/TjhEYQfgPK/FAVPAHAR3YnbBnXoLSxkWtgVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212213; c=relaxed/simple;
	bh=0I/Nl/Y0852g0Ajn0suWENOu7sHo9+WjR97LX4ceWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9c4D1WyTC+8GVQngLgmyTqIekEAGbcubsnl8RWuCshQQ+XYXHrb9Qj7LmFlV0EMKPeo5aceCIFmsZc0cyAWfpmJPuvME0rgoCjQ2O45OG/yR0CRyt0BTbOfM8xBOfdyoSUVp9yGVX2tKBInzRWJeLiB0xjcua0gxiQJp47bQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZALKpvOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C8C4CEE2;
	Wed,  9 Apr 2025 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212212;
	bh=0I/Nl/Y0852g0Ajn0suWENOu7sHo9+WjR97LX4ceWF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZALKpvOmJniRP7fXkn5qPXXlpBlyzaUa4Mqj+KTMwCf8q5zPSLrBBvX9m5/WuYXhY
	 74kvw1uE8owfi3WjVhbX8SsBATDwLLoU/YlKFbtbKt8O9xCQlTq18fD6qkNLY34LZZ
	 gi02Jx4SbzVuzv4vprGEnfAnOf5L6m2rcIH4Rhi/hcABae754r8HNmFxkjuoQAZ1Z/
	 0WXPC0EZLG/e9JyLVI95fneEsXq+//CxtdUz9jpyQQ5m7aB0V2j2TgLrYxgWsIrtgL
	 y+9k179WDkeksHlLFG9GB+UWSDrfBbt/ha8T16iriE/MUmQGMBpP698Y88tbhnZjqU
	 xccaX+ZVm1gXQ==
Date: Wed, 9 Apr 2025 08:23:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v4 5/6] common/config: Introduce _exit wrapper around
 exit command
Message-ID: <20250409152332.GP6283@frogsfrogsfrogs>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
 <b7f56773095bea46c2b6d56c3d87197d900d9e2d.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f56773095bea46c2b6d56c3d87197d900d9e2d.1744181682.git.nirjhar.roy.lists@gmail.com>

On Wed, Apr 09, 2025 at 07:00:51AM +0000, Nirjhar Roy (IBM) wrote:
> We should always set the value of status correctly when we are exiting.
> Else, "$?" might not give us the correct value.
> If we see the following trap
> handler registration in the check script:
> 
> if $OPTIONS_HAVE_SECTIONS; then
>      trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
> else
>      trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
> fi
> 
> So, "exit 1" will exit the check script without setting the correct
> return value. I ran with the following local.config file:
> 
> [xfs_4k_valid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/test
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
> 
> [xfs_4k_invalid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/invalid_dir
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
> 
> This caused the init_rc() to catch the case of invalid _test_mount
> options. Although the check script correctly failed during the execution
> of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
> returned 0. This is because init_rc exits with "exit 1" without
> correctly setting the value of "status". IMO, the correct behavior
> should have been that "$?" should have been non-zero.
> 
> The next patch will replace exit with _exit.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Looks good now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/config | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 79bec87f..7dd78dbe 100644
> --- a/common/config
> +++ b/common/config
> @@ -96,6 +96,15 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
>  export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>  
> +# This functions sets the exit code to status and then exits. Don't use
> +# exit directly, as it might not set the value of "$status" correctly, which is
> +# used as an exit code in the trap handler routine set up by the check script.
> +_exit()
> +{
> +	test -n "$1" && status="$1"
> +	exit "$status"
> +}
> +
>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
>  {
> -- 
> 2.34.1
> 
> 

