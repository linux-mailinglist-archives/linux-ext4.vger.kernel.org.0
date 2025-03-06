Return-Path: <linux-ext4+bounces-6695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9BA5535F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 18:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BA176E0B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315A1FC7F9;
	Thu,  6 Mar 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaO/GcFp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36002147FD;
	Thu,  6 Mar 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283215; cv=none; b=VLFZoFjnHq/UwAnH4H50A+4GE6uIoA3gIMntFAoKoYByFP0ACSOCt/JMdUC9fMME7yflp0b9TjsqNJYPml2KNYHGBDDxumWK2oMO4l4qUEvqDHPXz6FO5Q02/cUqcLFLRFJeTyGSok4yL/iCsWW7H8hZ2Zrgi2j8fU3KcbpdXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283215; c=relaxed/simple;
	bh=gRNy8gstzU6rMi1Md3Q70+e1jh4EDZE65Mvqj0Rex0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou9Ayq/qP36gk3YSTrFPFgilEw8i66pslRom6BRhlpnRUYTyWALaRGQaCIp+9LlkBtHSIxdNZhbze49nF2I7c1AqEpSdiz+W6Fu1juSk6WP2czsJ8UPx38zenHkuRbAerCCjZmVsY0gC0hMr2hxwa/TASy91GPXZygU0oLTMrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaO/GcFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25581C4CEE0;
	Thu,  6 Mar 2025 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283214;
	bh=gRNy8gstzU6rMi1Md3Q70+e1jh4EDZE65Mvqj0Rex0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaO/GcFpJYdZknDMNDSBwbqDfJewWF5EqrRuleeNzWo5avdtnBTlrZ46JUAHeMCB+
	 QAod3IUeAnndwjQnNTmZOHbkOHxupPNMV9hEKcQFTx+FBvxsOovHmarQKjc+QLc00P
	 y+AlV324f7sLCLOfu+JAiL5xKquhjP12nM1vRMUYE8cy6wjeAtB9NfSnI30+wbQUfw
	 mccf3FjvEbWTWJI776XP2Qy9gzSkGnnvKaETlgiBYYx4wUtKSw9JGvz7AaatIEo85I
	 bqDdvscWfIovBgWRECO4zd+kFsFn3wX7vkzl2Iuhv38p1xL5y2rPanscEELwtaQxI7
	 O8Wid5tyvij6Q==
Date: Thu, 6 Mar 2025 09:46:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <20250306174653.GP2803749@frogsfrogsfrogs>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>

On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> Silently executing scripts during sourcing common/rc doesn't look good
> and also causes unnecessary script execution. Decouple init_rc() call
> and call init_rc() explicitly where required.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check           | 10 ++--------
>  common/preamble |  1 +
>  common/rc       |  2 --
>  soak            |  1 +
>  4 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/check b/check
> index ea92b0d6..d30af1ba 100755
> --- a/check
> +++ b/check
> @@ -840,16 +840,8 @@ function run_section()
>  		_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>  		_test_unmount 2> /dev/null
> -		if ! _test_mount
> -		then
> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> -			status=1
> -			exit
> -		fi

Unrelated change?  I was expecting a mechanical ". ./common/rc" =>
". ./common/rc ; init_rc" change in this patch.

>  	fi
>  
> -	init_rc

Why remove init_rc here?

> -
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
>  
> @@ -870,6 +862,8 @@ function run_section()
>  	needwrap=true
>  
>  	if [ ! -z "$SCRATCH_DEV" ]; then
> +		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
> +		[ $? -le 1 ] || exit 1
>  	  _scratch_unmount 2> /dev/null
>  	  # call the overridden mkfs - make sure the FS is built
>  	  # the same as we'll create it later.
> diff --git a/common/preamble b/common/preamble
> index 0c9ee2e0..c92e55bb 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -50,6 +50,7 @@ _begin_fstest()
>  	_register_cleanup _cleanup
>  
>  	. ./common/rc
> +	init_rc
>  
>  	# remove previous $seqres.full before test
>  	rm -f $seqres.full $seqres.hints
> diff --git a/common/rc b/common/rc
> index d2de8588..f153ad81 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5754,8 +5754,6 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> -init_rc
> -
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> diff --git a/soak b/soak
> index d5c4229a..5734d854 100755
> --- a/soak
> +++ b/soak
> @@ -5,6 +5,7 @@
>  
>  # get standard environment, filters and checks
>  . ./common/rc
> +# ToDo: Do we need an init_rc() here? How is soak used?

I have no idea what soak does and have never used it, but I think for
continuity's sake you should call init_rc here.

--D

>  . ./common/filter
>  
>  tmp=/tmp/$$
> -- 
> 2.34.1
> 
> 

