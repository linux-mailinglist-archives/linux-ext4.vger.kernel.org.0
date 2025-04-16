Return-Path: <linux-ext4+bounces-7307-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C0A8B243
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BDE189CB46
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3213AF2;
	Wed, 16 Apr 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuSBEBt4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26646161310;
	Wed, 16 Apr 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788954; cv=none; b=bZIH74lXkEy0n5jr5URTAXAQMypP9H3vLVQljJqnwRgX85geH1nAS9Fbp3ZGyBy66FnEboBlVR5V9qqqcZgEtTRnM/8H7n09VqVwb4Y8Nh0fKLWFBNJUX6SxISdt7kanVWE3nvJ3amM3o97fIixtTVKuARcgWXeFZePS69ST3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788954; c=relaxed/simple;
	bh=72yUJb7RdMsw4+VnjzHEvdX+ZprYqA99eCCrCzzrX7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2djKkzRc9CmTlscv5V/LI4C+Ppmei5V08xAFJGpCPsyQ8DeyIa8OIrbIcEj7s/nKzACyPHVoYaAt8RiRijE+ynS3M6URSvjHMr2Cc0u/R7t/m1AAwchNcgo9ApyUKDVo+TMFF9UY83rQ0ueGv8e9V2FKoaPX3KBinO6o1rqFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuSBEBt4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so78315385ad.1;
        Wed, 16 Apr 2025 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744788952; x=1745393752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDfwfDLF7UaEj/4Wi7KJzal6TyvbnmewVDjx4xgGdIU=;
        b=JuSBEBt46KeXEJ6PiC3i+Dl6PdlDaa+Q5kN4O0v9giLd3G7DWaQ6cxlQu6RlWVV99W
         uZrfNO+vXe30ZCDkc3UbFjbWbCUkA9mKEjwx8EPKAyykOI7I/944DQNE+Hw80+JqS1vd
         noRBHlul9mv3GzMSLlOApdpB1+ijRi4PJtutRombKNO7Xzq3eLn5C4l+FM8RFlP1P5fj
         eKqK3qkY5ldxJKJBFUZP1PhVPcdfT3ausW+i+0sL0SAmHcCXmxYeROr5AWcQO1Va90yM
         IFWlQQwjJ4uXes+U7oGAfeo5sGBuIpAlgZFGWjRqWtnAV/pXPoFM8oZhxEBFiC13tkV5
         1qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788952; x=1745393752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDfwfDLF7UaEj/4Wi7KJzal6TyvbnmewVDjx4xgGdIU=;
        b=Pxg1jHUXBvWlcw634PumrG1oOxlNyX7Q8inXvwjZtvpuiyyztpYIF6AasS37j/fnMK
         iLPJ26zQPsigPJQ6s5MRFuiqazmrDCjA/sp4FQVq5Fw6j+chu0eWtbLtuYpNb/IRo3gz
         QYQe8olzmtbovTjx4NrpPjw1hYG4bD6VX4qmDxTSxN5gsUXsDhmAvvRuTXrdtg5hDtrZ
         CPBhTuy7LvLtafwLq7LA90geXfUBSal/U0HLAZMJ9uz5vtVfx4JFsvyKlr+jpWGT6TcY
         I9EcQ9C6zmpWgtdsTB+W+4vAkx4fptENov9N/FciNJwApdjjVuf7BHWwLiLXMIjKxnIp
         rsKw==
X-Forwarded-Encrypted: i=1; AJvYcCUyk+6UvqwHd1y2z9phDK8JPBedUrTbV69d6ozSrzktUhBMN4g9Xwl28wR1rsDLCm+eVB8kBr+YshnDAw==@vger.kernel.org, AJvYcCWFaRfOr5LHO22Q3H3FIPFHAhN+OkUxPUP+RRfqCefJBgFoaa6mmznEZRqNDgym0zonvpq6Cs6w@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPrHptpMNI2ZAqKp4yRFshXOG0bE9GTqwzemcpjSO1SXikExG
	Y+MO9snkDrXCjcepd3cUhe79xpWoXbBnFeeRx6KNlMmNJRdNjBN4
X-Gm-Gg: ASbGncsFU96xvwiDxAPmHAMtC3ZjS8D/QtFcEhoGOHSK4bfFMPIfOBL8EpS4Jyl2/ds
	V7qS9Hr9hrmo437o5Lz9+NF0va5xyQA4wg0/qyeE/QfZ6Y5x8jOy8N3fHuOScgU9fF17F4EsO/K
	/Zv/rU6HWEjo58wu4uflGlvzamVSoafpCOvHpuOIE/Z4HOplBh6qAcWcQukTz60985piFpng16e
	2/auuBq0KiaUmCkMApCoftKRgOrcEbOAT8MHFEeGhvRS/KTOQcnsm0UGB2YnmyJuLwM0+Deph79
	+AO1KX6yJbrPwsyRFU5fUJBzR/lnCLcS6zuOijp5JdxFV5cBcOYQx8IxVpA=
X-Google-Smtp-Source: AGHT+IG1R9ZuXGRtn9Z22H8Rc1bNg7jkLlB5jiU1Zy7I9rarVH0DXscpO2o2xOzkatmQtCImX0vuhg==
X-Received: by 2002:a17:903:40c6:b0:224:f12:3746 with SMTP id d9443c01a7336-22c359172e3mr13791155ad.30.1744788952326;
        Wed, 16 Apr 2025 00:35:52 -0700 (PDT)
Received: from [192.168.1.13] ([60.243.3.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6e1dsm7380395ad.236.2025.04.16.00.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 00:35:51 -0700 (PDT)
Message-ID: <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
Date: Wed, 16 Apr 2025 13:05:46 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
 <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
 <Z_9JmaXJJVJFJ2Yl@infradead.org>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <Z_9JmaXJJVJFJ2Yl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/25 11:39, Christoph Hellwig wrote:
> On Tue, Apr 15, 2025 at 12:48:39PM +0530, Nirjhar Roy (IBM) wrote:
>> condition(noattr2 on v5) is not caught in xfs_fs_validate_params() because
>> the superblock isn't read yet and "struct xfs_mount    *mp" is still not
>> aware of whether the underlying filesystem is v5 or v4 (i.e, whether crc=0
>> or crc=1). So, even if the underlying filesystem is v5, xfs_has_attr2() will
>> return false, because the m_features isn't populated yet.
> Yes.
>
>> However, once
>> xfs_readsb() is done, m_features is populated (mp->m_features |=
>> xfs_sb_version_to_features(sbp); called at the end of xfs_readsb()). After
>> that, when xfs_finish_flags() is called, the invalid mount option (i.e,
>> noattr2 with crc=1) is caught, and the mount fails correctly. So, m_features
>> is partially populated while xfs_fs_validate_params() is getting executed, I
>> am not sure if that is done intentionally.
> As you pointed out above it can't be fully populated becaue we don't
> have all the information.  And that can't be fixed because some of the
> options are needed to even get to reading the superblock.
>
> So we do need a second pass of verification for everything that depends

Yes, we need a second pass and I think that is already being done by 
xfs_finish_flags() in xfs_fs_fill_super(). However, in 
xfs_fs_reconfigure(), we still need a check to make a transition from /* 
attr2 -> noattr2 */ and /* noattr2 -> attr2 */ (only if it is permitted 
to) and update mp->m_features accordingly, just like it is being done 
for inode32 <-> inode64, right? Also, in your previous reply[1], you did 
suggest moving the crc+noattr2 check to xfs_fs_validate_params() - Are 
you suggesting to add another optional (NULLable) parameter "new_mp" 
to xfs_fs_validate_params() and then moving the check to 
xfs_fs_validate_params()?

[1] https://lore.kernel.org/all/Z_yhpwBQz7Xs4WLI@infradead.org/

--NR

> on informationtion from the superblock.  The fact that m_features
> mixes user options and on-disk feature bits is unfortunately not very
> helpful for a clear structure here.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


