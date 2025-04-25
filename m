Return-Path: <linux-ext4+bounces-7491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0BA9BE30
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 07:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8153B6ADF
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F022A800;
	Fri, 25 Apr 2025 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx27qjsP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A610957;
	Fri, 25 Apr 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560380; cv=none; b=cWU/xNM6AIX70BiQVUut7V+zWMvSVzpY3iN+gwUGPnBIf02BtYMGMWmP98NNFs++H81XeS87xfCvjjehcdZDmacrHLWrp99WptC4p4scXgU8FEJFDtFTwnUIEVStT7nEH/8ez9bz2l8Uc9Q/EjsYgkaGiwf9nVlcz+hgDw1NhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560380; c=relaxed/simple;
	bh=kREjJtQlCCa6Oh3328sWRGNVTzx04U00wSvYU1bmzv8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XAdUtbIIHbZG4C/rnOMMaOCqPcgh+vDzur+BvQw0vSqROjwIgtX3rCyYYEg12qCck8qwH0669fSsTOZIZGDr4LWs19zXxD+HLzl0+1+WaS6lm17CcW8cWe9O9oqiDLIoFeZoWjuzbhPtd4Lcj5NzxTq/Jtvib9hvAGPoqjGVz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx27qjsP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240b4de12bso28880755ad.2;
        Thu, 24 Apr 2025 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745560379; x=1746165179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=idGJQmah+lTWW6tMJmwiLqsoATMo87mq2QKCqZgsTK8=;
        b=kx27qjsP36D2jexobVFNswVohK7IS5yMkqDTbpVkMEqW7vq6fHHAMY/liiyx96gib0
         vF6DgGFOpSqq5FOPFlv843iacnCCiTRpZZ+JHJBAUMxeU40vCoBBmtxJ+QYmQR/68vyg
         j30mqd1YJOmKFe7Seb0JDh9dqd6+Yq7iMpuqGsqQvHNAjpxaBnxcnHP5Ogkr0/6+N2SA
         gygTDC6AVg1hkxMo9eeOyvM5lSpiBQvC5QFoZg+Lc4/TRU9hk4pckAQWu3H+goDz7i5Z
         BdPXrklR2jH6IXtqKspjTYLpPBwQcFfjARaAxbO5LZuCIeWsX2Dv2pnyis+U72D4lqnm
         UqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745560379; x=1746165179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idGJQmah+lTWW6tMJmwiLqsoATMo87mq2QKCqZgsTK8=;
        b=GVbbQdStw60XMmXjoymKqRnRrtUkzNhMHerufR99aaNcqI3Ns6BcjCwSwpiglP9v26
         RxS0cdRRa2O44nM8ZqNNE5CBpZ5gIu7yH+UoY1qLlPUvZaDeaXXrlFPyerqPx3by0vLI
         czyoNbn1aFqwRTlfDVByRQS2IblLtWdcxyICUUuwmPluMDdbbvBqwwe44XoVg8yCigjs
         EbNdbN6OoxLoyfQ+y/iy5iwRJbMSMlDzKvP/u5h2yVKqNSc9ekjkK6wypWSP4mQ2hp8g
         tLmfISM+DsTa5nnZBL7YEZ5kgowv6M+pT9KooWEuQYvv5vXDg2OsOlmurpaoVSflDWFQ
         8HLA==
X-Forwarded-Encrypted: i=1; AJvYcCUyzXUY8I5rACwBb/HzJgB8+FKn2CjMocgcKwVI8iOYuyGfyd0umN6NWAh7+J6Gmg6EqbMb+jkS@vger.kernel.org, AJvYcCVsS6g12ey9PtTNHHEGV1ZMfS7aLXLS9/VY3OQSpRk+NIaD+Jd4iSJLfURu0mAE1N5vOgKcYX9B1QsIPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DMfm4UNIFs9yarxtyOflsd4k3vEa7Ah+8H5c1e5HJ43Z7zlp
	Hef+MCIT6cUu8Vq9gG7VXIC5FvagxcZAgIc4hVQOhi2n6RNPBeL476j70w==
X-Gm-Gg: ASbGncvcDbt0mne3AgGqnqK0suTzWowNWy0l+t3GEOv7vE7O4vzH3yVTde5djZRoISf
	vaEbPcwUywdOQp25+uTf+Zeygh0EfdfwB3hCN6HV6Aqb7gSVEEb2nweQ6IkevaZfN89+XOXOjlU
	HZE03VuRZ6Vgn5Y7ZT+vRvP6TJRl9rgd6xZWJXDARh8ceZxz0fc11Vipb908wPAeaD18m2A8mX4
	VI7XAVyH+Qau1hnDgwMUbZazMhTFt63T6klK0ibFNinFfbFrr838cTjPgLM0A/TwsxKAuq3u+bh
	+hZxBYGC6IqC+knu1hDTjIdJiEnywj5sRSivUoW61JcOtOoprww=
X-Google-Smtp-Source: AGHT+IERg3O2/AjrVTi0BaENjTFP7mUD8M5c3065Ifk+AIlh1wTEACUHvfA5pcoKVyGMOoz95zng6A==
X-Received: by 2002:a17:902:f68a:b0:224:1609:a74a with SMTP id d9443c01a7336-22dbf62d8aemr16653825ad.34.1745560378485;
        Thu, 24 Apr 2025 22:52:58 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7aadsm23913395ad.138.2025.04.24.22.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 22:52:58 -0700 (PDT)
Message-ID: <6d1f2cf1-2097-492e-a36e-43a3fd865c4a@gmail.com>
Date: Fri, 25 Apr 2025 11:22:52 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
 <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
 <Z_9JmaXJJVJFJ2Yl@infradead.org>
 <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
Content-Language: en-US
In-Reply-To: <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/25 13:05, Nirjhar Roy (IBM) wrote:
>
> On 4/16/25 11:39, Christoph Hellwig wrote:
>> On Tue, Apr 15, 2025 at 12:48:39PM +0530, Nirjhar Roy (IBM) wrote:
>>> condition(noattr2 on v5) is not caught in xfs_fs_validate_params() 
>>> because
>>> the superblock isn't read yet and "struct xfs_mount    *mp" is still 
>>> not
>>> aware of whether the underlying filesystem is v5 or v4 (i.e, whether 
>>> crc=0
>>> or crc=1). So, even if the underlying filesystem is v5, 
>>> xfs_has_attr2() will
>>> return false, because the m_features isn't populated yet.
>> Yes.
>>
>>> However, once
>>> xfs_readsb() is done, m_features is populated (mp->m_features |=
>>> xfs_sb_version_to_features(sbp); called at the end of xfs_readsb()). 
>>> After
>>> that, when xfs_finish_flags() is called, the invalid mount option (i.e,
>>> noattr2 with crc=1) is caught, and the mount fails correctly. So, 
>>> m_features
>>> is partially populated while xfs_fs_validate_params() is getting 
>>> executed, I
>>> am not sure if that is done intentionally.
>> As you pointed out above it can't be fully populated becaue we don't
>> have all the information.  And that can't be fixed because some of the
>> options are needed to even get to reading the superblock.
>>
>> So we do need a second pass of verification for everything that depends
>
> Yes, we need a second pass and I think that is already being done by 
> xfs_finish_flags() in xfs_fs_fill_super(). However, in 
> xfs_fs_reconfigure(), we still need a check to make a transition from 
> /* attr2 -> noattr2 */ and /* noattr2 -> attr2 */ (only if it is 
> permitted to) and update mp->m_features accordingly, just like it is 
> being done for inode32 <-> inode64, right? Also, in your previous 
> reply[1], you did suggest moving the crc+noattr2 check to 
> xfs_fs_validate_params() - Are you suggesting to add another optional 
> (NULLable) parameter "new_mp" to xfs_fs_validate_params() and then 
> moving the check to xfs_fs_validate_params()?
>
> [1] https://lore.kernel.org/all/Z_yhpwBQz7Xs4WLI@infradead.org/
>
> --NR
>
Hi Christoph,

Any further feedback on the above and the overall patch? Can you please 
suggest the changes you want me to do for the patch?

--NR

>> on informationtion from the superblock. The fact that m_features
>> mixes user options and on-disk feature bits is unfortunately not very
>> helpful for a clear structure here.
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


