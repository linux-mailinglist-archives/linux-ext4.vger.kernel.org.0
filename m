Return-Path: <linux-ext4+bounces-8574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEAFAE219B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 19:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA4B4C1507
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED72E610E;
	Fri, 20 Jun 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUykt67A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BF2E6128
	for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442015; cv=none; b=ox3kmpcojp43BdfDxslpwVAGIku56YXmYtdlktPaCyMbaXH3dBRXG+ELqupYrzLIcoMBmNmBO8TJgokQXbYyOp2Bc6DdmazjNPweUjR/CR9aoBu1UM0wf80Mna0BxVVA3Q1D3visHpyBvDkKvZB8gDd06ZvA/q4Nenu592AuAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442015; c=relaxed/simple;
	bh=P4GssuY/lJRwBeU/r8xgj2f0Jz2JM6g82ZiHyvgA6mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOXgmJ+XobrGUgEMq7o0V1SmE85xCTbPXfAzBUKvQ8zSZbjpXv6mMXrcn2Moag7f5o1XgCp/jtFnbhYErdF6VlzcIPkzrhhi2FnkUsnl1l1KbhYC2dTCv/wUuSel6zvOGjvHlECksyWJXfn8vn9QCf3lZridq1pRy5/QDMryEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUykt67A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmVr62zHeiFyZ5PIOfEG/VEY8NtaiLO4PmPOTd/TeYQ=;
	b=TUykt67AnT/LrGoq9L5w0fFbpwveYJiRjDJ43JCCxvsHfuQoeVoz18kbfK00KJVWmOCXMX
	fwfUPeyaIVgHjwAo7utacHePLXJzgiLhNUPfgK5RmbZmKseRb6wGH+Y9DF23f2ZGBzVn+l
	aHejxWHG6wVvSBXG1rl2HzoBFj8oDRo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-i2ndxX2NMZmBx1fuN1CLTg-1; Fri, 20 Jun 2025 13:53:30 -0400
X-MC-Unique: i2ndxX2NMZmBx1fuN1CLTg-1
X-Mimecast-MFC-AGG-ID: i2ndxX2NMZmBx1fuN1CLTg_1750442009
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31814efd1cso1361471a12.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 10:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442009; x=1751046809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVr62zHeiFyZ5PIOfEG/VEY8NtaiLO4PmPOTd/TeYQ=;
        b=OER+b7XfTxw7xcTwAsZpG6W41LgnW/2/kCyOS+9kudK8LvIqkByGmGk4qkWrLFZm/p
         UiQZiTE77jLqSs62ybnQp/aEp01S+ZCGjGGMFj+8ebrsI27EfLMT2vmx4IxQsEvhG7lG
         hKiiJkcilOBJQrGQv1/EpR0vritEWc8qcllDg4SLU9eSR8/3RObEfP2GeA50KWbC/U8u
         Gl0H8w1UPtNGOT9td+QsW+3ouGgCXVntkON/zuEBPtQhoy2zQk2iKK23sLcSUW3IvIWi
         L1h8HL5UHq7YvcyPXM4WhJAoa52k2Ja527D3fUiJXx6LnQZArz9SLzZSlP50jK8u4Wgb
         SLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPrdlgPLcd+bsVENC3vGtbLTxJKBhKsJsnV7wYL1hbXWW+a9p6Sg/Lb0E5EpJDOjWwOt0mxp3L3ak@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8dLCHdWpPk6TinrIBv7HaPKfJ4CMLnYaVAGo0pvw9FjKk3W2
	Jy6GebBD9U+azvH606YPmRMiVn6bSdGUpV1WhCnYWZ8qlAHPx7Ph2Ue4I1eUnzRTBUK+Fw8kLZ6
	qgxO4fZS7bet1JEzi2qJwOZ/p5Wr9yLLKga14ZlFEcyJa76U/VWogESqLbgw8VY46QlZ6I6Q=
X-Gm-Gg: ASbGncviGnBCm61+N+Kuw3ZaE5i8q3oaohRFHY0m9Nm7IWOlemOe7wYqRbBV4pE9yo4
	6lL59dJlYPJIp3KoEzS0pQQqLndgdDze6cI5CD0UZuq/X/f/sOdDx0aC9jNhiVdbukn6e99L3QJ
	C2lxPO0/FKqLODSnmDLUVvE86YalhEL0Bvy8HKQ+jy8wH1OMPF8C0YyzBd10B0u5bto1SiM6pDv
	ywzFVjUtdL6YZxbgvA+6urYiixMrHBhX1sRepWkfbeHXc7YPB37isu/OorP728oe9oKsiI2sMzO
	oBsvIk0Rs3fknYTU6ZXJFV/ZdLAhDPWZCfUbQ/0Vwk+Z+U8gRDQ2aHIFnASPrQ4=
X-Received: by 2002:a05:6a21:6d98:b0:216:5fa9:55ad with SMTP id adf61e73a8af0-22026e9d0f1mr5517345637.39.1750442008680;
        Fri, 20 Jun 2025 10:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEStXPkBhSplwryrT8owmYybNJQqkhlLLia/kHBX2zM7mompliT7DCOU8lHLZHnqtfAevqMsw==
X-Received: by 2002:a05:6a21:6d98:b0:216:5fa9:55ad with SMTP id adf61e73a8af0-22026e9d0f1mr5517328637.39.1750442008367;
        Fri, 20 Jun 2025 10:53:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a621cafsm2600290b3a.101.2025.06.20.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:53:27 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:53:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250620175324.tyx4s4dxdslv7hqx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250530192712.2643365-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530192712.2643365-1-leah.rumancik@gmail.com>

On Fri, May 30, 2025 at 12:27:11PM -0700, Leah Rumancik wrote:
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

CC ext4 list to get more review points.

>  common/rc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index daf62c92..042f6c36 100644
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
> +	if [ $FSTYP = "ext4" ]; then

What if ext2 and ext3?

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
> +		if [ $FSTYP = "ext4" ]; then
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
> 2.49.0.1204.g71687c7c1d-goog
> 
> 


