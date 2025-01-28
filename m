Return-Path: <linux-ext4+bounces-6262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8CA21083
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 19:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406423A9AB1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5A1DE4D7;
	Tue, 28 Jan 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcbf1XD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1E19D8A3;
	Tue, 28 Jan 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087760; cv=none; b=KN6kyU8bRfXBZfEBuzBBmilRxvWXuZPAB2t4sNMikpLWEy8hshN87kwWFB8bAPox/zADQPTWYUcaJyH0MigSDBM5JO1X3apKBOhOLMFj1wp3oS3CkrDCRFB+u/2XSm4Zb5at1ib3+hpjaCWDYlmNPbtPg56VObCEYo8wOA9IU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087760; c=relaxed/simple;
	bh=SVuRAKrEYM0EwMU7+SMzQ47TKOh8QUlWlV+JksNN9Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTpoza02cJw/qIrrB+Rb5y8BEnYEVBZehNmBNOSIf7FXllVp8T9q+SvO5kDUN/lr8tZEnDq8SUI9g6qqxKwRknQgZ445Fi4FSwMW+MJ0R8MDLcxygOFBlQdxgeeT2W+tByiBm59kMhrgKGjMxpk3mU+d4J71o4A3GobgOkk4J88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcbf1XD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A13C4CED3;
	Tue, 28 Jan 2025 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738087757;
	bh=SVuRAKrEYM0EwMU7+SMzQ47TKOh8QUlWlV+JksNN9Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COcbf1XDAMwGgLLdNEdtsw1Fxy4XmM1yNA0PSDIH3EgPS4A5YZHxcrNplWIM+e0eZ
	 O7u2vZ0x0aeo7GfxmGljZ8TbdgXglqdTNV6HrjXcslib6uBehaQhVJJyIF89HV7Z4a
	 dY60fslABEy8KK0by+n+kQUpqFhmUt9SVXo5iZmJN8DIkdcdXGMaCtAen+lbr1w7tb
	 AqS6AId3xszA/B5TGE3bV1w6Axu1v51wyaGyCiP5lo2Ttpkdbdgq+4JVIuncZ2d9Te
	 W2yrVvKxunmwtUu/SNdBr85znv2IzrYAG949MVf1ECy7QQ0uFEyUnC6YwS2JyIQB7A
	 sx633M2nSSDVQ==
Date: Tue, 28 Jan 2025 10:09:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250128180917.GA3561257@frogsfrogsfrogs>
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>

On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
> Bug Description:
> 
> _test_mount function is failing with the following error:
> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> check: failed to mount /dev/loop0 on /mnt1/test
> 
> when the second section in local.config file is xfs and the first section
> is non-xfs.
> 
> It can be easily reproduced with the following local.config file
> 
> [s2]
> export FSTYP=ext4
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt1/test
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt1/scratch
> 
> [s1]
> export FSTYP=xfs
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt1/test
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt1/scratch
> 
> ./check selftest/001
> 
> Root cause:
> When _test_mount() is executed for the second section, the FSTYPE has
> already changed but the new fs specific common/$FSTYP has not yet
> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
> the test run fails.
> 
> Fix:
> Remove the additional _test_mount in check file just before ". commom/rc"
> since ". commom/rc" is already sourcing fs specific imports and doing a
> _test_mount.
> 
> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/check b/check
> index 607d2456..5cb4e7eb 100755
> --- a/check
> +++ b/check
> @@ -784,15 +784,9 @@ function run_section()
>  			status=1
>  			exit
>  		fi
> -		if ! _test_mount

Don't we want to _test_mount the newly created filesystem still?  But
perhaps after sourcing common/rc ?

--D

> -		then
> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> -			status=1
> -			exit
> -		fi
> -		# TEST_DEV has been recreated, previous FSTYP derived from
> -		# TEST_DEV could be changed, source common/rc again with
> -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
> +		# Previous FSTYP derived from TEST_DEV could be changed, source
> +		# common/rc again with correct FSTYP to get FSTYP specific configs,
> +		# e.g. common/xfs
>  		. common/rc
>  		_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> -- 
> 2.34.1
> 
> 

