Return-Path: <linux-ext4+bounces-1736-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED0886FEA
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D8A1F22D58
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4B535A8;
	Fri, 22 Mar 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWBIYBOg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212453395;
	Fri, 22 Mar 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122190; cv=none; b=X7qn1yhXwRp6+p3EMg1cgHMDV/ioWzSBR2GvjuC4D1Xgmi/Irnob1UKF8qRSF8JKHym4KSUVBExyL2V2bdcP3LptgnSxuy233mECgzbvzDGiqppRWA+lkLK9zvUSRWuFp4YH02ocfOPJXgouoOPsODa2Pk4r9HLU8Z1tzIM5+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122190; c=relaxed/simple;
	bh=Weycm4kqEPwh63+mxtksApHa+dqQabudom9GeH64K0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7LBsMKCqE5c7F29iRGxkd+m1SntfPVWtBf6Q6OWANesnNT1fmX40bAFlEn7qrFy2W0csX4ce7t8Wz4SuDzXgD3Q62cdqXsEAIxzjbiYKWu0SdC4e/xNPngjSc3zbMOVNL5ums03senK4ETpRnA4zYtxFoXr93k8upj9L5p6dL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWBIYBOg; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d026c0a08aso73732639f.1;
        Fri, 22 Mar 2024 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122187; x=1711726987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxRAWuLAmkBRUhkW64V55k5e3EH9DGdSK68BU70KiTs=;
        b=BWBIYBOgWOBOMmqolmOQ2C1QO144sjn+Sju4Ga1G5MD4bnRFkxxIK4bbnDLuBdZUr0
         /oRA4LN7Glu292htol9nh+lJgRKqftMjxYLkBizBcLBwvnZt7r8itv7Y5/uaj+v+DBos
         EIK2erxCLnl0YwFDspc10XPjeUWc23aLccZRgCqrFqoMJFBlfT8d1FqfudzWLgtzScC4
         WJ/7Xghe0NCfjP8YZ9bk2DrrOwjrWNZaAf15qUfCIjDkCS/osjcrQ+JYsqOR8xPb0Cc1
         0gw0injEytIyyZ5nW1Z5AI7C6utkDushBaZjX3ubMHrd2hlN1wxps0lnX7/0Ao4m06l5
         IVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122187; x=1711726987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxRAWuLAmkBRUhkW64V55k5e3EH9DGdSK68BU70KiTs=;
        b=Nt7k0MY39i7xiVspcmDfcb5cZyaL+cM3Xk4xQA/KXB15G8RqdvAlo5YhX+LwzfOmTq
         LGAr3ufM89gJZVpn826OWYDe3M9e8zrTHKJ6sOZjJXOk/sifLVCWLF6/9/Bcu/ATpyey
         MglIQzbuFbs7L2c+0TIZR7JwiWQ8kxTXGAyhuClUm4SlREbwwlkiGBS2inMsy/SzS5Qy
         fVe7TkzGk1R8QXlQu9yePYcu3UjDwtd5VdVVcvdiHlzw0AFEuLbfnTdi+RS1ssWH9Qaw
         winIJiDlh9yrtIDed5cmYx3rDnzPQaHoRLO04kg5uNjnakyf5CiwyAvrXjPfU7SkWdhE
         W2xg==
X-Forwarded-Encrypted: i=1; AJvYcCXQq4MWBJ7Qs8K4BE1cB0sAdSGyxOzW+98vU+PTZcenl7Zdj4hTZUmWZwVsl1WiSfQXYUsYB4XCwWMSme+RuylM3Xad3lPPTyfsViNfEHi9npxTvE0QNlvxezw+S9KTqHcVI1UdNb6qjg==
X-Gm-Message-State: AOJu0Yx8LqAGXHIpAL0unE1aYtBCvsl+dEHvb0ief2C9OnVPcNBrh+wp
	tH59zgtf06iBbyET2BEGrkOGfej6fGuRnjQHIQIrzDAyIKlVI8ntgPQhiknA
X-Google-Smtp-Source: AGHT+IFzk9z5MujRXMni5Ei3qd9UMZrhATLBX0KZNoNgLLoyCg4V3O1H+oYkUD62bAfsx7CtdQJefQ==
X-Received: by 2002:a05:6358:7f1c:b0:17e:c5b9:5f6d with SMTP id p28-20020a0563587f1c00b0017ec5b95f6dmr3479648rwn.14.1711121872997;
        Fri, 22 Mar 2024 08:37:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 31-20020a63185f000000b005dc389409c1sm1688906pgy.93.2024.03.22.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:37:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 08:37:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: implement filesystem specific alloc_inode in unit
 test
Message-ID: <8725e7d8-722e-43de-9458-dc9a48b93481@roeck-us.net>
References: <20240322165518.8147-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322165518.8147-1-shikemeng@huaweicloud.com>

On Sat, Mar 23, 2024 at 12:55:18AM +0800, Kemeng Shi wrote:
> We expect inode with ext4_info_info type as following:
> mbt_kunit_init
>   mbt_mb_init
>     ext4_mb_init
>       ext4_mb_init_backend
>         sbi->s_buddy_cache = new_inode(sb);
>         EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
> 
> Implement alloc_inode ionde with ext4_inode_info type to avoid
> out-of-bounds write.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

