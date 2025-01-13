Return-Path: <linux-ext4+bounces-6055-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E11A0AF07
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 06:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5821885BE0
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCD231A2D;
	Mon, 13 Jan 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jqydhjss"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE951C3306
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747951; cv=none; b=p3xpi3JNEg+YkObEeLWMGPg98a4mL+lj0FyKXEJlzlAmqHFgdKYlEEtayRtVNB6j8ssqMd0Xc0gNu6axsfCR9ewXVRgbB68kFEQIh+Pcrevb7QrIHO+ZMUgj+RQMm6pNl4doi9rjA34yhkbia7ykOyNNA2HVu6Jwk0mMipw+uOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747951; c=relaxed/simple;
	bh=C39mN0AGKam4fPZkuskbkFWMDrHUCVwNm3cApZ7vd1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVxzPEgB+4Aa2Y8wUvRTrfcmypJ66rIfU3wX+jIytWqFFh/EARgS2pUPfHC42qfPcQMW8oisOWqCChmprhgRXra4wPipK0w1TVkDnHmj75EXPbaZTPviJ6LcAap6Lix4C6OAAvCxQUsMvwJJwyCJ5Q2wjktws1wGa0kXqTJzEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jqydhjss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736747948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oL+5vUlgz5yLIb+gwcjM7Mbg/85PRr0b1Vaj0WPDgvc=;
	b=Jqydhjss5w358iO2HDUM1Y//nYOobIvMpIVmpkO5rCgb111DAMY6Kut9I7zGLP05fp/gMQ
	pn9teYQKj4oYnmmEon753W2Of0kUKPloTz7OTB5+INkVTNaYSaIaZ3Ym2HSU9CpLOvkTrj
	LTxb63UW3PXCDk9fVo0AFyMp/+VzCkw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-ysoBAmr3PEevJ4AyF4yOGA-1; Mon, 13 Jan 2025 00:59:07 -0500
X-MC-Unique: ysoBAmr3PEevJ4AyF4yOGA-1
X-Mimecast-MFC-AGG-ID: ysoBAmr3PEevJ4AyF4yOGA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-218ad674181so87525145ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 12 Jan 2025 21:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747946; x=1737352746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL+5vUlgz5yLIb+gwcjM7Mbg/85PRr0b1Vaj0WPDgvc=;
        b=nBgdmb4P/MayF6Dk9jwyYAZeVJU73CBliBqD6vtooOAPqMUHt6SsuF013uH8PS0sIF
         Jw6ivI8pHEMgDxQppFV9C66fkD0rlr1J07fGmzLfE4C6rd6zwSG2FSdwYXY5kBNfEJxF
         OZobNo3EfBlumnXc2SOl8dayaP4ILZp5c7l4X/AdsOPBAOOypNUz6DYWNUVPhl19kQKX
         hn10qzJnnpNzcmUMxhZK/LfLWVy8Qv8MOtMVcGh3ugqDR3p4+ZT/WVhSUhScMq66EeIW
         piYClp4dhmhdju5Kff6SktEvMw2oacWfyB2joXq8vSwIam5WztnWXtmCRQGNSa0DnEay
         gwfg==
X-Forwarded-Encrypted: i=1; AJvYcCVmAGVGfg6LGmGL42woxZWwDHP6ZW8KD55oAtY57/rd7JM/HHoHBiKWUxG4uO+qAg9SrIwa0AE1rVrM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZbmXr4+Iy/X+lO0fde77Ev9McIzxpEYaKt5oy0lyMFKtT1sZ
	1q67T0bLxxqep1NAsjydnvjMEqVkrjJvn/9key5A/y78sgu+BUs0mUVgkNGS8UyVSl+cIvF+/uv
	v1r7Im+bc1Wv3GXU2aW3e+t+1iNE0mP7wM7MylAhERIPeaelZDD49IzvzZe8=
X-Gm-Gg: ASbGncutpZtE3xdgM+QakN8BBClY2NR39afKoINRc+Mzd23fEH7N5RWALi5s8ZQd4Ag
	ZbvVSX2lyDNYJgMw67GqGks3wv9f2HEHz9J5eLqpleKrVaE2TxXMyzMag2RQCKyjKO4GZySQiP2
	Tol+JAiEtuDGHYQ+Nn7+OLqrUFT9wEMHZ+oy9h9+G/E1TnCGO1bq3/aYrbta4t6dhleNVIjD+Cs
	8WyD39H1ut6OI4u6PNHSa1Qhv//GBmNGxlB3otqHRYj/xywC/7uU839hEEgQB8G3lqIzdBYhFPW
	EGF79QQmgdVmQkpuJC9K7w==
X-Received: by 2002:a17:903:234d:b0:215:58be:3349 with SMTP id d9443c01a7336-21ad9f4635dmr136645175ad.14.1736747946088;
        Sun, 12 Jan 2025 21:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDmm6ZZRVjFPKHhHKrndw/vlyb3LQJwyethFxWNNB4Va9jGuBtbjvc15JP6Ne39lGPrLRA7Q==
X-Received: by 2002:a17:903:234d:b0:215:58be:3349 with SMTP id d9443c01a7336-21ad9f4635dmr136644875ad.14.1736747945787;
        Sun, 12 Jan 2025 21:59:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22f6d1sm46855395ad.202.2025.01.12.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:59:05 -0800 (PST)
Date: Mon, 13 Jan 2025 13:59:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>

On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
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
> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/check b/check
> index 607d2456..8cdbb68f 100755
> --- a/check
> +++ b/check
> @@ -776,6 +776,7 @@ function run_section()
>  	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>  		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>  		_test_unmount 2> /dev/null
> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP

The _source_specific_fs is called when importing common/rc file:

  # check for correct setup and source the $FSTYP specific functions now
  _source_specific_fs $FSTYP

From the code logic of check script:

        if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
                echo "RECREATING    -- $FSTYP on $TEST_DEV"
                _test_unmount 2> /dev/null
                if ! _test_mkfs >$tmp.err 2>&1
                then
                        echo "our local _test_mkfs routine ..."
                        cat $tmp.err
                        echo "check: failed to mkfs \$TEST_DEV using specified options"
                        status=1
                        exit
                fi
                if ! _test_mount
                then
                        echo "check: failed to mount $TEST_DEV on $TEST_DIR"
                        status=1
                        exit
                fi
                # TEST_DEV has been recreated, previous FSTYP derived from
                # TEST_DEV could be changed, source common/rc again with
                # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
                . common/rc
                ^^^^^^^^^^^
we import common/rc at here. 

So I'm wondering if we can move this line upward, to fix the problem you
hit (and don't bring in regression :) Does that help?

Thanks,
Zorro


>  		if ! _test_mkfs >$tmp.err 2>&1
>  		then
>  			echo "our local _test_mkfs routine ..."
> -- 
> 2.34.1
> 
> 


