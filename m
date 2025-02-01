Return-Path: <linux-ext4+bounces-6283-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A583AA24764
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 08:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174E91888974
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1461FDF;
	Sat,  1 Feb 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0/23swq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D3224CC
	for <linux-ext4@vger.kernel.org>; Sat,  1 Feb 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738393548; cv=none; b=sCRJNT5iEKibIEhobz307pQhVL52oGwyLf2sYM80zI1CnYzYZnpUyiTq4hjzuUazhLX6j/szti3IcNvrlIB6WFSlDgpbupfr03Y9hW+v+jOHd1eH/Bd7IDjPK5ZiScMwnPk/ZTsicnyh0jG/5hi8fdJMWKn1BxDrcHMYOeJfWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738393548; c=relaxed/simple;
	bh=V8oRhT2/qocvP7c7/6x9lh4o/5vuxcRma/3A7IjW3QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmeunePOOHKj/Yoa6xdWCdUUPiMR7nwSN9HN8dfUGZ/wk8TSebClo9EW8aaB0sFs5xM6TJKSLbnbyHNuLi9AhpF4rP1hj3OJGUQp7eJ1O8hjRb44lKaYQmdkzYJYcOrcrX6B95Klo6ZpeNG/QpnN/i0qgxr6VTywrcs7hug+R98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0/23swq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738393545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOil50X7To4Izr3XMF3C3ToTpCATFupGxfJXHGENw+4=;
	b=C0/23swq283kRlpImGdaeOH2TPnXWG3z2nPe1k8rt7xlcckcp/8tGDO9E41w3KnqcXqU0D
	dLphoGTwjRSIKx7I1JpezGAFGAhRD82oI/CWttnLjSmRig9ja7JOSYPRLeFRvzlHRn1W18
	lvWs+deD8RHHZwHElOuTPTnZLanJBRo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-F8MPyRjZPeW7gZfK2etKKA-1; Sat, 01 Feb 2025 02:05:43 -0500
X-MC-Unique: F8MPyRjZPeW7gZfK2etKKA-1
X-Mimecast-MFC-AGG-ID: F8MPyRjZPeW7gZfK2etKKA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2efc3292021so7715900a91.1
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 23:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738393543; x=1738998343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOil50X7To4Izr3XMF3C3ToTpCATFupGxfJXHGENw+4=;
        b=clFn7h8X8pNCRacS4WLeEEvVL04KBtuUG3rlc7rh+vR2p8E6DHdVBMshPgDLxWmsoA
         p/y8uu/8k45yASPvLRt4fr/7gQ2/rO8Ktl8n1E8d4rnjd/Mj9G3XBd/GrF5luz+PUg9C
         hxpdGqz3Y+Zoiwg71sDtr914YgPz+3Xj/SGzWrTzsaKBwIcARlt5s8vfMiu8WLgtFN6e
         YJPxc+O+1QkSKhLcDbca/F+gXOUXOaX+NLZH8fv60BuRLclI39M5s4Zgvu0hmTYXQdKS
         3JI/LoyiDF7+qaK6EsgiJGHRd059YphOLbCFwsAe4L1LUd82lxkXmSqwkjLAwXz18lXk
         e9ag==
X-Forwarded-Encrypted: i=1; AJvYcCWsKZHaEUt73nV0GgRZ+5h4YV2evAmeeJZy9yCd4WeGGkaPyRXSY2gnjP1U74XguEoWe2Q5TqVyEBUe@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKF5zZbNz13NlZaxsYXPom47eIqdCaXNdik9KxLlL29/fVWZv
	kaBO6nXeSOZpYPbYEkRjUdtAZQAp/J8CtIUeh+jDIpuceL0033Nm9y3MrogsznQk367/nRuAryV
	PuaXkegAmot/nuwMpWEyB70QVso0SaxxNnGziy6/NuRNtTGpDbdr29DKmXPE=
X-Gm-Gg: ASbGnctea8gEjHokWg6EaoH+BcbpVVHWM1acKa4IRtKZY1gc2c/R4aQU+q50n3G4kau
	841rvNzlprNZ5NLWrzd2Y80VJ20/krtMj3s10YfwVLfP0td3FmtIOsP0bXXPcWoHYxWxvAHgjI1
	KFvWrTf4SqvTYufNHwnht/bi1r1bw0JIZMSCDW2d4/sc7dCPIBjG//QLU8CgCNZXywysHRsEfid
	TScXWX5FBg7ZSkFtpZq+4rX7jDDQh1/r/wGXT9HjXHLDVhIlHbeBlxs8BSptvYbo0++adFIG/7K
	WzqHKLYuHuKlmqwVuyYQfTDnufHa134jrqhRmyLZmSR4+A==
X-Received: by 2002:a05:6a00:278e:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72fd0c1487fmr19169752b3a.12.1738393542914;
        Fri, 31 Jan 2025 23:05:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEovbZRZDUPyRjBsMSwhtkSDtYrYfFiTSCzeACcsV4AytoO+dqNEf4OG9wges0H9ELPqkxUqQ==
X-Received: by 2002:a05:6a00:278e:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72fd0c1487fmr19169723b3a.12.1738393542581;
        Fri, 31 Jan 2025 23:05:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631be61sm4528747b3a.19.2025.01.31.23.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 23:05:42 -0800 (PST)
Date: Sat, 1 Feb 2025 15:05:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250201070538.u2o2n6znswbvhsdf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
                                                                 common


> since ". commom/rc" is already sourcing fs specific imports and doing a
           common

> _test_mount.

This version looks good to me, I'll merge it with above changes.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I'll push this patch (if it's passed the regression test) to fix current
problem at first.

About the common/rc:init_rc we're talking about, I think we can keep
talking, and change that in another patch if need. Thanks for fixing this.

Thanks,
Zorro

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


