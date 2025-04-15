Return-Path: <linux-ext4+bounces-7255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB1A894C0
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E817C17CB46
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BA279900;
	Tue, 15 Apr 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caIFBZyz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7110F2;
	Tue, 15 Apr 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701532; cv=none; b=IyT8sYlnXwt1zBSsPA/lq2EJeJI3MUn1UpA74oGWL0mm6fOyYwCnspYdnwJynLxNwvzAt6ybmPL5+/gLp8LJT5pNC6eocmAtML3YXlLyGot693Y+Rzmy5pyJhnzod3IYqikqhJwkeYpV0yFENXa81Punnv8mCzYntsAKvaL4RFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701532; c=relaxed/simple;
	bh=3/FoWHVKZh/yPaCYtvpJoxmmZ1q8bKtB9XiX+8j7Biw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeIq84wAk6Bf0KpmAmwOtXkZFuKaBjHkBtY0Hx8AKatwIrhnXf4A0+kBtPPt1Sd4UmsemSwMWJLtTvMRcsFtWtLiMvO5/faXlpAlrJGgMxDk6A7JvpODCd1y/oeCU4QoNiIl60TbGUfplT74jvSKa0ZCL/HPmo7I1TdYqSNpPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caIFBZyz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2260c91576aso43731915ad.3;
        Tue, 15 Apr 2025 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744701530; x=1745306330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XrxwBk8Ts1N+UMcqULEleYRY3IW8ZPJ/uHBTdCm0Uk=;
        b=caIFBZyzOdmtp9ajkZxiUQgAzwejHXxDm2W5yxTS70tEjvLlc7Nej3+LQ5woBE+xEF
         Y/8cppXRXuai5/lGlApjEid6iw2E47v6Cr3TfriDMbquJBW4A1gOkPUx4r0QOTXMwUKV
         yls/KZ+qkwKZlOgMgwaPNoAycZLZChZ5kfYory5zSvXYuJTQQP8cXX9A/gBnvkEwcHrx
         IRsdq0yIo45Ae2esBuHv9kHyi856J15X9uID+ydzOyRtjUwsgAe6J2xCNCnKXhFbwUDS
         cF638WgoYu6p6J9IN4YFQo4yZEJb//dOTfbPw62KgI8P/JSFzw9uDire5Gl9hCGCxVVl
         ApMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701530; x=1745306330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XrxwBk8Ts1N+UMcqULEleYRY3IW8ZPJ/uHBTdCm0Uk=;
        b=iG16u0dS+cPNzq34IEU8kW2XaflF06dFn2MWHcy0nIIUi4vVyqrUzJ4DY2IVtnEPlS
         NgmrrxrvXBSBOQtJr9FnlbbXcz3S5JmLRqW4T3H5+CJhi53smQUrLOXi874x4i1AAVgj
         bNjScywLFwz5z0MhSLJsi17BQr/2dQ+sfcOVVN4zDcBef/nF7lDa33pM7fGv8/IDLLAI
         rDQaOVeIxysQX3Dw2lcyM7gRuK5/3QhMuJm/4DkwTAIH2MoFu2OczzY74kvWsYDbPoLK
         kUejhldGIojpDSHkr+QJGndPy3zWCTN6W99hJ1EbsfFKsZKCYn9DFpodNXzIOTf7nRDT
         4jsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp+3ElEJcaUYpeQhOGBVJ6r9UDtGdZkHz9GsrzQXPyekQ8QWCPFvlLfesfVjrYFmA83uRjl3poiigxng==@vger.kernel.org, AJvYcCXioNJxzzWMA2fGV/NMSjUfot7V0yQjSdn9EuCob4/t8U3AdIAJ1zE2phYBn8vCtDPYpHJyPK2Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwLK1iDKUYbsMP5U7UMDIgYuVd/xhkcQ0V7mPj48hGR6swstOE2
	VMO7KossUH8aa1L10EVUhkAUZWpn4unfysVOX4zTgIqZx3hcR5dj
X-Gm-Gg: ASbGncsvqCSi156heU9yFN/xnhkgrre+v1Pu0rsYEvexZegqjfdBbZJ2YGSkXEIEzAi
	eAcxasRS1kLiZce5r9HMeYpxRaKT93Hg+kpYUoYwJsG1ag3whnQ+zF3fkJGMsyZXgyUAgfFPZV2
	OxRjfe/mmogd0XqdbFMs7n4tEygHPftTidqwI+spuTVX6xLbgAv1fgguRW0XeHm/VcOpEF7XqA1
	ppuiWMLmQOFE9tRgGXUcHmuRuYNlMaPvQuZkIKFmNwWDQQrj6qiy8wEoMc6A2M2BzeYQLuv/5D9
	0+00Y0gKokgRxZOyOwq3ahFwA7a1hFlH2bEdb0EuQULPvkVR
X-Google-Smtp-Source: AGHT+IGIAg+rcECIoc+F1984QEgUHOanUmc6wVHxPqhdy6TjnbASlhuQMTgSJo/ZepIgEJzy7h+DGw==
X-Received: by 2002:a17:902:ef03:b0:21f:2ded:76ea with SMTP id d9443c01a7336-22bea4effefmr231488005ad.36.1744701529728;
        Tue, 15 Apr 2025 00:18:49 -0700 (PDT)
Received: from [192.168.1.13] ([60.243.3.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8c60csm110536565ad.93.2025.04.15.00.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 00:18:49 -0700 (PDT)
Message-ID: <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
Date: Tue, 15 Apr 2025 12:48:39 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z_yhpwBQz7Xs4WLI@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/25 11:18, Christoph Hellwig wrote:
> On Fri, Apr 11, 2025 at 11:44:52PM +0530, Nirjhar Roy (IBM) wrote:
>> mkfs.xfs -f /dev/loop0
>> mount /dev/loop0 /mnt/scratch
>> mount -o remount,noattr2 /dev/loop0 /mnt/scratch # This should fail but it doesn't
> Please reflow your commit log to not exceed the standard 73 characters
Noted. I will update this in the next revision.
>
>> xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n and hence, the
>> the following if condition in xfs_fs_validate_params() succeeds and returns -EINVAL:
>>
>> /*
>>   * We have not read the superblock at this point, so only the attr2
>>   * mount option can set the attr2 feature by this stage.
>>   */
>>
>> if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
>> 	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
>> 	return -EINVAL;
>> }
>> With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return false and hence no error
>> is returned.
> But that also means the mount time check is wrong as well.

So during mount, xfs_fs_fill_super() calls the following functions are 
called in sequence :

xfs_fs_validate_params()

<...>

xfs_readsb()

xfs_finish_flags().

If I am trying to "mount -o noattr2 /dev/loop0 /mnt1/test", then the 
invalid condition(noattr2 on v5) is not caught in 
xfs_fs_validate_params() because the superblock isn't read yet and 
"struct xfs_mount    *mp" is still not aware of whether the underlying 
filesystem is v5 or v4 (i.e, whether crc=0 or crc=1). So, even if the 
underlying filesystem is v5, xfs_has_attr2() will return false, because 
the m_features isn't populated yet. However, once xfs_readsb() is done, 
m_features is populated (mp->m_features |= 
xfs_sb_version_to_features(sbp); called at the end of xfs_readsb()). 
After that, when xfs_finish_flags() is called, the invalid mount option 
(i.e, noattr2 with crc=1) is caught, and the mount fails correctly. So, 
m_features is partially populated while xfs_fs_validate_params() is 
getting executed, I am not sure if that is done intentionally. IMO, we 
should have read the superblock, made sure that the m_features is fully 
populated within xfs_fs_validate_params() with the existing 
configurations of the underlying disk/fs and the ones supplied the by 
mount program - this can avoid such false negatives. Can you please let 
me know if my understanding is correct?

>
>> +	/* attr2 -> noattr2 */
>> +	if (xfs_has_noattr2(new_mp)) {
>> +		if (xfs_has_crc(mp)) {
>> +			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
>> +			return -EINVAL;
>> +		}
> So this check should probably go into xfs_fs_validate_params, and
> also have a more useful warning like:
>
> 	if (xfs_has_crc(mp) && xfs_has_noattr2(new_mp)) {
> 		xfs_warn(mp,
> "noattr2 cannot be specified for v5 file systems.");
>                  return -EINVAL;
> 	}
xfs_fs_validate_params() takes only one parameter. Are you suggesting to 
add another optional (NULLable) parameter "new_mp" and add the above 
check there? In that case, all other remount related checks in 
xfs_fs_reconfigure() qualify to be moved to xfs_fs_validate_params(), 
right? Is my understanding correct?
>
>
>> +		else {
>> +			mp->m_features &= ~XFS_FEAT_ATTR2;
>> +			mp->m_features |= XFS_FEAT_NOATTR2;
>> +		}
>> +
>> +	} else if (xfs_has_attr2(new_mp)) {
>> +			/* noattr2 -> attr2 */
>> +			mp->m_features &= ~XFS_FEAT_NOATTR2;
>> +			mp->m_features |= XFS_FEAT_ATTR2;
>> +	}
> Some of the indentation here looks broken.  Please always use one
> tab per indentation level, places the closing brace before the else,
> and don't use else after a return statement.

Okay, I will fix this in the next revision. Thank you for pointing this 
out.

--NR

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


