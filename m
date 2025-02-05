Return-Path: <linux-ext4+bounces-6337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07284A2986D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 19:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14CA7A3546
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2025 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFC1FC7D5;
	Wed,  5 Feb 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu6XINbY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C513D897
	for <linux-ext4@vger.kernel.org>; Wed,  5 Feb 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778942; cv=none; b=hHbDWDkdmwsDOpFbsVLclt9znS41C+72YFGTFojAvOJoSdSx9hZUpZye59qypADXLAN+XacYaTu1H9/sXcxBI7Fze6kyr9BRLr1SArWxdVz3bT3XgxE/GCd0wr0CFAZihHPXyDS3/WFZTs+eHmGvbRtzEb3RPdnGY3oM2lCaxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778942; c=relaxed/simple;
	bh=1LeYxb0WCRHrgMGbHEId9/bugeRTGbgr5TL//a6Fvp0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=rB1DpuRYZYCuYd220mCVEBpTjshNQpOaFerakPktTg69m8x24mdc8D1zXm0KfsB+O/QXQxoveR9D9FrSz5XbCxCT1BlxjXw9KJ86pe5ZlZKNa5g49ykTxCWO8ZjKxYADJ0t2/3xzzcfRKLrVcJ3nKpy8UtFmhCgrareEImsj600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu6XINbY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so9642229a91.2
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2025 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738778939; x=1739383739; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ons5euMrFEIWudG+vtPF/N7c55WY9JLF8GA846lN3F4=;
        b=Pu6XINbYcotCSbpSUMs5UnzK1udR2QYu4MlwMSEpwQdtkU2dRKgUt3jd6IvaHaR+0D
         H/TS87i4E+X1uy1ut92/75AfT0P+jrrYPzwmtv0Md+lQFqOJjvXgpPmQn6zFegtX+rNb
         1krcOS9vCMg3Bt8vwkTMNjvYIXH3WY7wm5zmu2uvcJ2G6GVpg++XxwfkzZT3rTZpG74I
         oBvJB1rHClOZzK2Uuz5+pKUiuTNRKov4sQDdNyOVr2dtzT2M+/dkZPM/1GDwFeSmFPom
         Ih/ABgpczbxdffc3XcTk2cjqD0mMRh/RMmahkFlOErZrEEMmh5tBGmEmsbsDy4WH1HHL
         hlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778939; x=1739383739;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ons5euMrFEIWudG+vtPF/N7c55WY9JLF8GA846lN3F4=;
        b=I0AIZo33FCSviDkOh0VcWaUGH0wYRLaz7Z16YOlAc/IC++SgZ55C4Dm45uOUZyXaLx
         Rkoy89NzdPHvuzjmo65rQi3NPAw8Ju9W0G4EKMd78c4KTsLcF382vC6TgMcV/SWUnirx
         BGI28A3/TX8JO8OBxTgm5ZrUGul0Gp7WxlSBEEUKELis527VGnUInBu6b2hxse+Pfpg0
         0RsChl3GNObWEysLWKk+slmeB+B15H6MwBQehZq2AER7iYUDZQDRUT95siWs2lncSAih
         JilabBvDljLjfyx5ik5924HHo7iYN097aChWY/kh8wHbGRVD7R9qSay9HC3yx4jtk92s
         TQUQ==
X-Gm-Message-State: AOJu0YyJqsr7do7gVegjWz7gQULnloPxNuqEJAg1qAP9r0sjSop7US3y
	+RdzJcm42klgHQ0Ge3JvTH7M+qglk1FGh0uf0DYnDSweeHNNFpOkczIE4v3F
X-Gm-Gg: ASbGnctl8z0hegkl5paWAN5c9LuTLvyHrwQin4gVHFeGb5orpYdrJtzPTPHNv4PHz22
	+qm2fkaszrY+Nsx2bes1EaQV/HPpcS7HpBFGuiXRuWKwA18ZSkDC+olXPF8FyyAQm3oeAvSTApn
	tnP6n9U59kq7TpEpvFtzZNEPww2iPiN5SdmLEQCXtRg0z3WF5vKXz7xbpY04Yp/vTVBGQWBkU0Z
	zOVole0mvOYvFQYkVXYInIxd0zT9lbxjoIbHVKTuf+KzV8Rw+e6M7mK/jhXB0uI4z/w08zgKLq6
	ltz76oo=
X-Google-Smtp-Source: AGHT+IER57zH6HM1VNBFOYoK8RGkbwLXdlKwLGMs/SSQbj8Z4n+pgmY7CLHcuUl4p0ahqKvuHW/f/w==
X-Received: by 2002:a17:90b:1d87:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2f9e0793401mr6411055a91.15.1738778937823;
        Wed, 05 Feb 2025 10:08:57 -0800 (PST)
Received: from dw-tp ([171.76.81.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d77fe3sm1906382a91.19.2025.02.05.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:08:57 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "lilei.777@bytedance.com" <lilei.777@bytedance.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Inquiry about ext4 atomic write
In-Reply-To: <CAPbN7U6jP=J7Yb7aSsX-oObYeM1P39T0NERRsZ_fWUb_tc6v8w@mail.gmail.com>
Date: Wed, 05 Feb 2025 23:26:05 +0530
Message-ID: <87cyfws2bu.fsf@gmail.com>
References: <CAPbN7U6jP=J7Yb7aSsX-oObYeM1P39T0NERRsZ_fWUb_tc6v8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"lilei.777@bytedance.com" <lilei.777@bytedance.com> writes:

> Hi  Harjani,
>
> I tend to enable ext4 16kb atomic write on my X86 machine, and read your
> RFC.
> https://lwn.net/ml/linux-kernel/cover.1709356594.git.ritesh.list@gmail.com/

Hi Lei, 

This is the final version which got merged [1]
[1]: https://lore.kernel.org/all/cover.1730437365.git.ritesh.list@gmail.com/

On x86, we don't have bs > ps feature. And as of today iomap restricts
the atomic write to a single filesystem block. Hence for systems with 4k
pagesize, we can't have atomic write request of size 16k on a 4k
blocksize ext4. But on arm64 or powerpc (with 64k ps) we should be
able to enable this with 16k bs, because ext4 can work with bs < ps. 

>
> From the cover patch, it's seems that this feature will be successfully
> enabled
> if I enable bigalloc on ext4, and underlying device also supports 16kb
> write union.

Yes, there are still ongoing discussions around this in the community
[1][2]. 

[1]: https://lore.kernel.org/all/Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/
[2]: https://lore.kernel.org/linux-xfs/20241204154344.3034362-1-john.g.garry@oracle.com/


-ritesh

> However, after checking xstat result, i found atomic_write_unit_max was
> always 4096.
>
> This snippet below limits s_awu_max to 4096(bs) which is the max value on
> my platform.
>
> ```
> static void ext4_atomic_write_init(struct super_block *sb)
> {
> ...
> sbi->s_awu_min = max(sb->s_blocksize,
>      bdev_atomic_write_unit_min_bytes(bdev));
> sbi->s_awu_max = min(sb->s_blocksize,
>      bdev_atomic_write_unit_max_bytes(bdev));
> ...
> }
> ```
>
> I am wondering if I missed someting? Or if there any other ways could
> enable 16kb
> atomic write on my platform?
>
> Thanks!
> Li Lei

