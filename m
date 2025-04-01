Return-Path: <linux-ext4+bounces-7023-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D087AA77393
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6FD188D5F0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 04:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7C1A2390;
	Tue,  1 Apr 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21sTt0u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A585C5E;
	Tue,  1 Apr 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743482437; cv=none; b=knyeE+4hA9mdWc0bnUmJGO+D64izIAK7tXkflZk2LavlI0vKk99ZnIcP4GMiuNtC9ux3O+veDSnQr/JyqfPFhagijnhloc17oUt8mOstMP46XGjtl/CDUdkVELcfNxgekrhx39XmAZXTEzTZcnCu0J5CMNCmfrHQVCvPtC3dZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743482437; c=relaxed/simple;
	bh=arekcMQaaF+N0rDC8tzRIfBPFHle1Bxxd24l+Vg7dms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7ygj5QFwa4ansHgHSZH35zUZVROiD4eScAERQRiMSQjQ8DWxG0pbzENXejnCIa8j4BJQM8tR5rbNJqBkGrL96c/4xvoqO7mOYD5+p9+OOTjzU05qswYrRRltKEe12nSJLkPk0+/pWHyVFXZWuCfyJQJKas8pbvGPN3JvGWoQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21sTt0u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2295d78b45cso7585365ad.0;
        Mon, 31 Mar 2025 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743482435; x=1744087235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJkFwWmRzcDGJZz1csRZFzzoSzvmOWpO/9ocKmyISGI=;
        b=C21sTt0u0Cc2wUC1MMUC7dBpcSMLlAKYo4cX/KcYPZ0NqQAsbfk9iyQ7j3e2IbUE/s
         gLjPyJPIg9DlQn8YSiD5G2Q/PQMd/3S8hO15kIFy68iHAe+ws/TiLsnWLC7TqN+FzUMS
         amimfX/O+Svh+ftNfRgtTWUW4V9s5b7JYJdHDHYdBxZ9X8jBzhJBxpQfkEDL0x/O8feH
         q4s3/ws/Y7ltMjv+/6RaCLng3b/2LGn37Awy2WcPsCYBO5rfgBNOw67XIfx7IBpmdVf4
         LY7ZJm4q6yas04sR7O7kmAR3D5pWPUsQwavp/HxPq6/v7UrixhhcwdTuppfpOP24x8jd
         23Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743482435; x=1744087235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJkFwWmRzcDGJZz1csRZFzzoSzvmOWpO/9ocKmyISGI=;
        b=go9TYIEK5eMiKOKswylEu4xr7z+kSRmSZyddVP9BZ2XPhcZ+hBCl1a4kcfosvrCIyr
         kQrQj566kDU2dz6mH1vFHrsVY326N+my1fT248WhIMcV3EG8ZifvmvHINc7KVFLIheWb
         bDDbb0jXujBCkbV+/lXQ/N82NfBPBfh17NguiTcNLpo5E7mTAH18MiLSf5IPZWdK2J5h
         n63xTyY47RgEdBdcG4HWJjPUa/gHhYXMOb7lGEko2Maxxc75Dy6rpL5mmb2FKXPlpRK6
         UMmk6xb56NmwwUJCkqw4uKnbkx+SerkHrxOzWcwEiOQ2Qvw8wYGQIsehlj9b6vhfy635
         n5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj2BY6uHqck5n9KfU5zEf572O9UJ121bbpY/wpHiDX2xXvd7r62WqxBNFF/cXAlEEU+BnAKCxiRZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RTaBJWSV0lSbjyLB8uz2HCEslkM0LUQWDFVDOfV4Ng5fewvp
	TJX+aAmQZak6Pz1W87AsWxdb8u7VdriyAC+DLj+e+Uxc9qt0Z9c0nmS0qw==
X-Gm-Gg: ASbGncuI87EGhjFygUeSwikKXvSZDBSZvwADdbifmxR9Wt9VwC8S9Q3cnP7oa1usdoX
	zd2iQdXXAHwf71/1025C6SbwKl5GuNFRpIrwFv60L+HL9b0efcW5R/D6jckziO03dQdpYM7jjf6
	9jD88kbOYNOf4tK0ppA2xPQq2jMQ1s9yDvu1Kus5VgTBizi1QcML4PNITsr7S6n+I1Tkg+krsHu
	ljvXjXVsoON7al2TMF07omjdqpl6p30lLaK1fWsdYceDjTBOesUDMnsYV7xmVyNWRamI9veXxXD
	1r1ZGAUnuKNZzxo5CMTLkhiWf6aRHuW7xqvDItsZwm1sGXRX5ZNS5vk=
X-Google-Smtp-Source: AGHT+IFzE3JrZTusGursAyudiJZbvaSPPU14NJ8ZZ43u62KIUT/sH5DfhURzmIZeXRcJPS0qHS+lsA==
X-Received: by 2002:a17:902:f64f:b0:224:1ef:1e00 with SMTP id d9443c01a7336-2292f95d075mr197426795ad.19.1743482434958;
        Mon, 31 Mar 2025 21:40:34 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee0bafsm78375005ad.90.2025.03.31.21.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 21:40:34 -0700 (PDT)
Message-ID: <7ff6d710-e102-465b-b0f8-b9fbed358aad@gmail.com>
Date: Tue, 1 Apr 2025 10:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xfs/539: Ignore remount failures on v5 xfs
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
 <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/4/25 19:18, Nirjhar Roy (IBM) wrote:
> Remount with noattr2 fails on a v5 filesystem, however the deprecation
> warnings still get printed and that is exactly what the test
> is checking. So ignore the mount failures in this case.

Hi,

Can I please get some review on this?

--NR

>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/xfs/539 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/xfs/539 b/tests/xfs/539
> index b9bb7cc1..5098be4a 100755
> --- a/tests/xfs/539
> +++ b/tests/xfs/539
> @@ -61,7 +61,7 @@ for VAR in {attr2,noikeep}; do
>   done
>   for VAR in {noattr2,ikeep}; do
>   	log_tag
> -	_scratch_remount $VAR
> +	_scratch_remount $VAR >> $seqres.full 2>&1
>   	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
>   		echo "Could not find deprecation warning for $VAR"
>   done

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


