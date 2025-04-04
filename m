Return-Path: <linux-ext4+bounces-7073-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFFA7B6C8
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 06:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B293B30E1
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 04:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9F15990C;
	Fri,  4 Apr 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJec7uCx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B653C38;
	Fri,  4 Apr 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739718; cv=none; b=NfWz+XVt0e9vj1eVqkubl34PD8uRbq+thnLsQLmIqXjrGeT607c6RpjZv8+ca4WhXQiYrc2470TN2GCCp/GirnMoqKykA68+zvjztXwGJdx4ETKswueS3JcYO3P5jhhBaiGtLaiRcq7+FqjuyDdm2k6s+1O6iALKu6NRQ/0IGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739718; c=relaxed/simple;
	bh=1pNs0F7mL1R0ijVvUb60CJU5LrOl8C8jdUyC8qS9fAQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=omlnevZgwXdtA/EEnts0xHnxY31peO3fj06qnn2UuiEKTXbvf5s8pVq3va0K27HG+XPAzMWe60NvYGjSN/ge2YYCq0gjT9EN4tFO2CvtCksbgdodwd7UfxMjAK90vj9Hw8ew8zHMmg1mq/TTnHEK/sdbGbDTMZED7inuC3RSIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJec7uCx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af59c920d32so1158769a12.0;
        Thu, 03 Apr 2025 21:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743739716; x=1744344516; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pZubhrK4ZJYb1ku3qE3gWfaagRKF5AiEsHmDX4WofDE=;
        b=LJec7uCxLJQmhPfFRESzEFLldUaPmKhnv3gw6qPGlPVvMsu7eMkxm3hv8WNvNhyHcO
         ma+0uTSpovzo0V1OOlBo0+Yv7yEKkECqfj0G5MaeFzzCaXhHyQzjGIx6Eo7G3Mc++K8x
         Nhyy9/jzAQC31YVXXrOEB3f2hwOiisNnypkv5Q8Mu/B4UZN6tzC9ig3OaK6zLtLbyYuS
         4ZO2FXoFoj0O4g+0/jtOW2F9OhVp227GMwaEJfG4XYHql6yjT0DhibX7Oi8e9AEUxWUc
         QUVH2/GAh8/g6noZk4MxVckSU68XEXFQbX0CJCBnBDbbWbvIjL5TjJdUk5qIB9aqqPYK
         IlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743739716; x=1744344516;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZubhrK4ZJYb1ku3qE3gWfaagRKF5AiEsHmDX4WofDE=;
        b=WCWIoA03fQVDB9bPj6RgonYP3iRO/taaf9sERPsbsKs/uWc0ce/ZFu0FjHE1eHoBwX
         8lUSYGZqIv0bnbQ5NbxKNBU15CY083sHl4dUXNWVLuRYb75YXQIZ+yYB+IfYDHdEFDW3
         rKeAsKqdpiFwKpEGUSZYQYWYcEkr28Eo7Rv3KbVut0ZnbTaVc7q+4XfUeARWRssqJuHf
         YE/n6nvvHc0HtJbphXolEKQrJi9bl//qfXwKCCu8e8BDqIMf7R4b8s0xrYqLkg+tKU0i
         B9PFvv1DDZSe2gK66eBBtKhCg/OqILupybVUhtBZZUsfRPHBDUkIza4nuJyGaFr9+qWG
         tqSA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3OfS8G7q+ByzY3gn1X0bEvlpM7zmEt4sdZGHwVYS4xIQJMDyj9xp7jEsW3lh9/fESTGe8XSS@vger.kernel.org, AJvYcCX1GiQxh3k6L6ddw479MOES1ZYRH5iNJJMUGQKV9Q4XiHyORYF/gCuHJ00SKUfY7F3th9Oo64FigY9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUUaIqpG7jCmn9Uhof0Td6i6Oe76dCILJ0z/p4ewn76WEdwF6
	XqKHaEic32E2o6GOhd6z9oe4f6AF2N6aVYGstcsm3aeBTHzAsFG6
X-Gm-Gg: ASbGncukdJPA/JUkdeZnwVLaJ5kKpCvz4Z7UnHDwavCOVY4OSb5Nw9qH0KJhFZqdiY0
	gl5G2tND9wviTdM2iZ/XRi7X+vEdpzC3WXZjvUyMEt5sLSDtdxoGX+CnN/q3M84Rehxo2ezrhp6
	GRFzKaZWee04GD8JMWf7k91yyIt7uMBKUbajXckzmYL1Bfu8hsdhuBpqdt4MI5wpTuxGvlpDAd4
	RTQEe8Z2XyYQTLcpU+ihvFwvbaBPjnxOTxkP/NRz6AfKl9UhBtNW7iNdfWwMG0dBAyARvgbSRpg
	o46dPchbqOpcrh7aThj6rPxz3OXCOmwZd1vRZvo9QWoClbo=
X-Google-Smtp-Source: AGHT+IHLVZJHDTQqwBZG6xSY7VE9gR6ASzDCrXx2+UkyERLcYTgxJvdkLz9qWDh2Orb1/P1nDC5lVQ==
X-Received: by 2002:a17:90b:2749:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-306a6125ab2mr1680267a91.11.1743739715750;
        Thu, 03 Apr 2025 21:08:35 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9752sm2651467a91.36.2025.04.03.21.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 21:08:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 3/5] check,common{rc,preamble}: Decouple init_rc() call from sourcing common/rc
In-Reply-To: <ad86fdf39bfac1862960fb159bb2757e100db898.1743487913.git.nirjhar.roy.lists@gmail.com>
Date: Fri, 04 Apr 2025 09:30:48 +0530
Message-ID: <87r028vamn.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <ad86fdf39bfac1862960fb159bb2757e100db898.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> Silently executing scripts during sourcing common/rc isn't good practice
> and also causes unnecessary script execution. Decouple init_rc() call
> and call init_rc() explicitly where required.

This patch looks good to me. Please feel free to add:
     Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


While reviewing this patch, I also noticed couple of related cleanups
which you might be interested in:

1. common/rc sources common/config which executes a function
_canonicalize_devices()

2. tests/generic/367 sources common/config which is not really
required since _begin_fstests() will anyways source common/rc and
common/config will get sourced automatically.

-ritesh

>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check           | 2 ++
>  common/preamble | 1 +
>  common/rc       | 2 --
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/check b/check
> index 16bf1586..2d2c82ac 100755
> --- a/check
> +++ b/check
> @@ -364,6 +364,8 @@ if ! . ./common/rc; then
>  	exit 1
>  fi
>  
> +init_rc
> +
>  # If the test config specified a soak test duration, see if there are any
>  # unit suffixes that need converting to an integer seconds count.
>  if [ -n "$SOAK_DURATION" ]; then
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
> index 16d627e1..038c22f6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5817,8 +5817,6 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> -init_rc
> -
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.34.1

