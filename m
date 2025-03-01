Return-Path: <linux-ext4+bounces-6632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73460A4AD28
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Mar 2025 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D0F3AAA00
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Mar 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A61E51EB;
	Sat,  1 Mar 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcKGZAvh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF71A841F;
	Sat,  1 Mar 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740851178; cv=none; b=NbErHgYWiCGmIZrxwZ4gNLXNchCbF/zrew1bJ+ZILOAXub1MjFe85iWnHLG/JgcbbBSuULJoIUcJ+mpBYwbUq4PoFhx3QFJxVzvGARuZfxZctF+TIhV0PiEgqFZ4s36P1y6zS9zdJ9Id0iLlNfJX4dAROJop3e0Woaam9R+YXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740851178; c=relaxed/simple;
	bh=Gtgm+HfkQpBAKcEGPTOlQARCrxJQv1VFX2vnqly2Bm8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=hk/BsK48srPuMbg73jRMx2ezjB1Zb+JVU1qxKACz78j7Lt7rkPaS6rCpHWmgoqhUr/hv2ruBVYTzb1iFvUDoZGN1nZXRdC77GDaXo7nL0lpOlN0RHb+Ke96GbVbmhK1eP3FWpktxD8LGo9k0rd1Zo5HSe7dnRZuNdl9NDG2PhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcKGZAvh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2238e884f72so5605805ad.3;
        Sat, 01 Mar 2025 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740851176; x=1741455976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5EMC4QTPsTfx7rf08ONLES150yxmA4ww7kM1gnGqK0=;
        b=IcKGZAvhn6LXqO3NJcSxthOfGSjpK6QdKEeb/QpX1iw3nIQ5T+RGXYExvfdLFmYuqE
         K8+09fk8P1Qvya+KeGIN1rkPjm0pSou/yT6LNvysXqeg35OHywppTNLE3DSIey85tLV5
         4U2LcyoeVXTwydm2XXo17mZNyTQVqbmVaRITLy7cOx/exijnKkOvfCThV8PJXsOKzkrk
         Mtr989ACDtgGdWlrO8onat/ziX8+znECzlVIk6SSqIq+BRqRRcaCK0QPw20LoA660Dwi
         5ZYj/MANc9dEQXnkYk4cnmdZq6vho7NDu8PN545QC/HM4JaibuxzVw7+bcUzbJh+bPWG
         uYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740851176; x=1741455976;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5EMC4QTPsTfx7rf08ONLES150yxmA4ww7kM1gnGqK0=;
        b=HcaM+NSHX2SmDdqz398UhXCNVztEQAo+FTFYR4YqLDwzQXeX2tEYHWPKqve52b8ysL
         ncINdcapJJ5mfmavqdbVcTBQPLWaORkkHWvW+W4NSPN0bNZHv6tH4UOzMcay15Ha5Q2M
         qCvfiJP/27TGdr0EG3exmTKv1EkqAs26TzHe9pJR0bj4YUjr0B9ttZknzL2qgWuEDAkZ
         kYiQG5D502m5V4tkQsKUdPWxbUtMMRoIaqGRw/KWJe+aTl659jswDiO9ElhmJjYpkPpF
         ov/j5FcFUiFxUO/+Zm2Pzlu+tzu3Qq8Tg8efnzFqzqt1MsXp5+dEtlsx6S8+p/FBRZr7
         KJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyjm/DlEL3R6AhR7eVS0nCCU+LXc+Qbz9rE/8ZnIXCo25AWveBxHgicNQkwn+Sf1c5/tijOz8jZDgP@vger.kernel.org, AJvYcCXWrlkOE1pOMWE6ycWwlSaMLC4u2SrqJwNFfv8pRWm0CsPpo9YhRFw6CiLofkPPobWyfuwr0ZLl@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOoD7//y7D8VMMMjzfV3oO3Ewv8xzrzddGp1kHzDO/TMP8pfF
	SkClx9PI+MZRGFEh6wBlcrfG3BBRWcVTG23KJncZ57QytWkQDSV7
X-Gm-Gg: ASbGncvcMlT38S9YrFK9/Ue1ipYxC+GQAz4TeWKIrGWnxFFfprr5Ji7l7tyDPDBuBwo
	k4l1/8gtWohe0PTXrEc9ZmLbCz1gt5b7KETNWbdIqV/h2ALONsuzoV/XtBGNfQ/Z6fYEmCu4RYw
	+t1L9AifLpiy5QSHS/ioAz2i9Ngnl2/qg+68jM1K/YSqX8pqo99GXfTNmrDFw3d16430H/bi6JU
	VExcGwUIFSqP/C4x+zDMLfjszNRDDGot8Yzutyu5c2O9gGFR6bOqNWlEf7++Vc0EX/pGrb/qod5
	9Tg/tycP0E0K/buh8X+nICFmKGp8Qdn01q0n8Q==
X-Google-Smtp-Source: AGHT+IGLYa1RZ5t0cuEAVsiCUoSiG35w5JXi8zPh4yvcaqsvxMkzNHS2n7S/luxzuvx7NMCDstghxw==
X-Received: by 2002:a17:902:fc8d:b0:223:44dc:3f36 with SMTP id d9443c01a7336-2236925eef4mr125123875ad.43.1740851176520;
        Sat, 01 Mar 2025 09:46:16 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22355773b58sm47985605ad.234.2025.03.01.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 09:46:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Anand Jain <anand.jain@oracle.com>, "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [RFC 4/5] check,common/config: Add support for central fsconfig
In-Reply-To: <4c951390-400a-48ce-824c-f075a37496a9@oracle.com>
Date: Sat, 01 Mar 2025 23:00:17 +0530
Message-ID: <87mse4hd5i.fsf@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com> <9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com> <4c951390-400a-48ce-824c-f075a37496a9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Anand Jain <anand.jain@oracle.com> writes:

> On 10/1/25 17:10, Nirjhar Roy (IBM) wrote:
>> This adds support to pick and use any existing FS config from
>> configs/<fstype>/<config>. e.g.
>> 
>> configs/xfs/1k
>> configs/xfs/4k
>> configs/ext4/4k
>> configs/ext4/64k
>> 
>> This should help us maintain and test different fs test
>> configurations from a central place. We also hope that
>> this will be useful for both developers and testers to
>> look into what is being actively maintained and tested
>> by FS Maintainers.
>> 
>> When we will have fsconfigs set, then will be another subdirectory created
>> in results/<section>. For example let's look at the following:
>> 
>> The directory tree structure on running
>> sudo ./check -q 2 -R xunit-quiet -c xfs/4k,configs/xfs/1k selftest/001 selftest/007
>> 
>
>
> The -c option check makes sense to me. Is it possible to get this
> feature implemented first while the -q option is still under discussion?

Hi Anand, 

Thanks for trying the patches. The design of -c option is still under
discussion [1]. But it will be helpful if you could help us understand
your reasons for finding -c option useful :) 

[1]: https://lore.kernel.org/linux-fsdevel/Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/

>
> That said, I have a suggestion for the -c option—
>   Global config variables should be overridden by file system-specific 
> config files.
>
> For example, if configs/localhost.config contains:
>
> MKFS_OPTIONS="--sectorsize 64K"
>
> but configs/<fstype>/some_config sets:
>
> MKFS_OPTIONS=""
>
> then the value from configs/<fstype>/some_config should take priority.
>
> I ran some tests with btrfs, and I don’t see this behavior happening yet.

I think that was intentional. I guess the reasoning was, we don't want to
break use cases for folks who still wanted to use local.config file
option.

However, in the new proposed design [2] we are thinking of having 1
large config per filesystem. e.g. configs/btrfs/config.btrfs which will
define all of the relevant sections e.g. btrfs_4k, btrfs_64k, ...  Then
on invokking "make", it will generate a single large fs config file i.e.
configs/.all-sections-configs which will club all filesystems section
configs together.

Now when someone invokes check script with different -s options, it will
first look into local.config file, if local.config not found, then it
will look into configs/.all-sections-configs to get the relevant section
defines.

This hopefully should address all the other concerns which were raised
on the current central fs config design.

[2]: https://lore.kernel.org/linux-fsdevel/87plj0hp7e.fsf@gmail.com/

-ritesh

>
> Thanks, Anand

