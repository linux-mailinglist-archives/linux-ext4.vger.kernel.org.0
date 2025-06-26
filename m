Return-Path: <linux-ext4+bounces-8663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81FAEA762
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8B54A2CB8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391832EF675;
	Thu, 26 Jun 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivFrDiuL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59416243946
	for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967594; cv=none; b=InGqBm+yE6bVyzg/JCdi4WJ9OLzg80FvZw5VB7/UsIyirAUTm6qj9KCUO1Q1DrfF6Qs1pn3ez8o3A5RIz3wbwDjaefilXPRIcjHRVc6VbRsK/xb16xY61Y/LYKANf1/+RFJYeZ2rXU1zIbrU0c1D3rpgwD26hwyk8u2QsG9X1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967594; c=relaxed/simple;
	bh=6Oz/Vp4XihYNIA7/hldZOE7g6IVGeOgv+UEBtoU5pNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUyahOkL/U14KCRn3fDeVeBlekN0uphuBB+UxPfbpeFTr6yL9jR7kqq2XPphYN5mInkIdDv5N+NpKlIMQuM08Qrahb2DdgOUlBXMBKByoNrpdoh2zPWh3BhaWh/ZjPQa/xhvO5RV+doCxLIgyV1FPNPU8EjiOb8gn9wP4wuvIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivFrDiuL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750967591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xpz/THuTS0+Q/TXsAAUp1e6P1pUcBiJM6CLJwNjR/Nk=;
	b=ivFrDiuLRaUBeRYf1iyj1cpI9Qf0U3GrhPa3D1DUy2cEkYGHGeu+w+3BkajU5da2yabfVU
	dZkHDujyM9LjjCkBMTHds8xxuoxxmQpLETqNV9sH78AohXdKjQ+95cEJSSx7bz52TrNCsa
	dh43Yt1THmPtsHqADRj/PADOsT5LUiY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-aDGdO1IsM8GOok6ImpWVSw-1; Thu, 26 Jun 2025 15:53:10 -0400
X-MC-Unique: aDGdO1IsM8GOok6ImpWVSw-1
X-Mimecast-MFC-AGG-ID: aDGdO1IsM8GOok6ImpWVSw_1750967589
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748cf01de06so2894407b3a.3
        for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 12:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967589; x=1751572389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpz/THuTS0+Q/TXsAAUp1e6P1pUcBiJM6CLJwNjR/Nk=;
        b=OIfK7ZOtSg40qjt2B2GCMe8lsaWFj9CfSX1DF/HiBmYPK+1whpdGrvvndrv0/KQhwN
         QOusUij2/2XgHcnk5OKpMKKWmKOgaBCkE72bVcZR3bqxpMzpe3+vLZtyO68U0jaYyf5P
         OmsWTuObpIcdpecJZDYktQDWjY3/XNDmLUSsxN6oVwlWZfHLi0mNpMS9L1v/7gc2q/uh
         ZKm/cA/y6UsYPCirnoslKBCg+AIzoL6f1LIvoLDPq2MAF8MdqOGqqYFtj6Z4vBJp1K0G
         qfv/ck8tONMkbg4SuWEZ+f0b/HZC8dbHPTGEnTHjW4lTDiX9jHxiNt1yIxBUH58eo9QR
         ZnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQOCwOTj3szl5+749eLqp6abnzy4Up4D68oAsOQfm8gttRKNZ5r5foH/923MhO5PW8xGJcBwRsRCtZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgtx7VQAr4VsoOk3ZTgMWkiILZBL7x1f2OsaSSIwAcs0Sgw1N
	wqiH7CVVIxtF+mJQGBt18+q+YDedjSGtU54/zRac7BiVkclFVqWxWoaA+gLUKeu5P1vvEYVYpIs
	ZRzjO5d1P2bA5vk+OptUzMTDYPnqfyFyzuqAIQHtoFnksu2oVRIjxGhyf6wqoUyDfV0B2BN19vQ
	==
X-Gm-Gg: ASbGnctmz3RfL/N/GRfa4AoXy1B4tZdH/SoadPndDfsPNGM1mKmPJja7/vCXo8y4ww1
	l9yEwut+ZzkTAwsIQGpj0ieZsJobv+oOYv1NjPNzerFNuGMj7yAeGKV4FnUirilgpnw7P/V8JrW
	5pP0G1dj62ln/jYF5SN0PlrPMC/ZUyEuMelOpQJ5bBlpJSK3XBwe1Y1Np7V8eY8fyafKxSCIt2+
	NlwkG3ubwnTwwEQYEsvxbfztnJmXwhzYxFGccOuv4OLTPqvszMfZggkSQNpTqQAPc2ScSz06CHJ
	PjNKkApWqnlWIk5lVdcXkNVhaZaMTl7qL/Io5LWqYR3dkjYGuFh4plcITx3D4LY=
X-Received: by 2002:a05:6a00:2282:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-74af6c9de08mr590331b3a.0.1750967588671;
        Thu, 26 Jun 2025 12:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1efrU88B/QgzLV5fch4WCQuyIEw8tNFsD1T1guTLrTAayWYMJ0AhXCXjhKXgm96j9kRLAJw==
X-Received: by 2002:a05:6a00:2282:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-74af6c9de08mr590316b3a.0.1750967588338;
        Thu, 26 Jun 2025 12:53:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5806380sm453859b3a.172.2025.06.26.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:53:08 -0700 (PDT)
Date: Fri, 27 Jun 2025 03:53:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250626195304.7ug4jersezhiw5j2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250625212022.35111-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625212022.35111-1-leah.rumancik@gmail.com>

On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> There is a descrepancy between the fsck flags for ext4 during
> filesystem repair and filesystem checking which causes occasional test
> failures. In particular, _check_generic_filesystems uses -f for force
> checking, but _repair_scratch_fs does not. In some tests, such as
> generic/441, we sometimes exit fsck repair early with the filesystem
> being deemed "clean" but then _check_generic_filesystems finds issues
> during the forced full check. Bringing these flags in sync fixes the
> flakes.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
> 
> v2: update to fix for ext2/3 as well
> 
>  common/rc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index daf62c92..ddced1b7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1496,19 +1496,24 @@ _repair_scratch_fs()
>  	_check_scratch_fs
>  	;;
>      *)
>  	local dev=$SCRATCH_DEV
>  	local fstyp=$FSTYP
> +	local fsopts=
>  	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
>  		_repair_overlay_scratch_fs
>  		# Fall through to repair base fs
>  		dev=$OVL_BASE_SCRATCH_DEV
>  		fstyp=$OVL_BASE_FSTYP
>  		_unmount $OVL_BASE_SCRATCH_MNT
>  	fi
> +	if [ $FSTYP = "ext4" ] || [ $FSTYP = "ext3" ] || [ $FSTYP = "ext2" ]; then

I think you can use [[ "$FSTYP" == ext[234] ]] directly.

> +		fsopts="-f"
> +	fi
> +
>  	# Let's hope fsck -y suffices...
> -	fsck -t $fstyp -y $dev 2>&1
> +	fsck -t $fstyp -y ${fsopts} $dev 2>&1
>  	local res=$?
>  	case $res in
>  	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
>  		res=0
>  		;;
> @@ -1548,12 +1553,16 @@ _repair_test_fs()
>  	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
>  								$tmp.repair 2>&1
>  		res=$?
>  		;;
>  	*)
> +		local fsopts=
> +		if [ $FSTYP = "ext4" ] || [ $FSTYP = "ext3" ] || [ $FSTYP = "ext2" ]; then

Same here

Others look good to me. If you agree, I can help to do this change
when I merge it :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +			fsopts="-f"
> +		fi
>  		# Let's hope fsck -y suffices...
> -		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> +		fsck -t $FSTYP -y ${fsopts} $TEST_DEV >$tmp.repair 2>&1
>  		res=$?
>  		if test "$res" -lt 4 ; then
>  			res=0
>  		fi
>  		;;
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
> 


