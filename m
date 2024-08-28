Return-Path: <linux-ext4+bounces-3936-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A1962372
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24044284A08
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1D16132F;
	Wed, 28 Aug 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTnPSKSE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6CA48;
	Wed, 28 Aug 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837554; cv=none; b=HgcTuZSVt4TiIONWzVIsHYJACrGRmG8JzAh9wSKbIR7mcyfOg2/aoA+ygZ/IXcy3ZSXaEho4XDa0sT1ZjLzmI5TVbuypyqi8/O+bkkOBeZbfEVmcwzcHGt5APCw2Crd1QwccmzS6+4AXbeOdPKaz78IRj4XSs887hyVkqVO4GdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837554; c=relaxed/simple;
	bh=/HctWHzvd0ddz+rfeFtBVPSvliJolFnT3ErxLPZL+44=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UE2MVrKr74SWfVwQe3iCErH0+2xbagOQuXsZJDCHnrJymQkMCCnvSRfipTM3pEq0qTKihgMaRZafZitkGfhkXSRyZQkZRj+H8S/4BuNHKGaJ0eOEoSQTFazCtS62xiOGOMspMnx26pESb1TxsKY5bMMORmcnI9Wunb8grV+qfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTnPSKSE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4662117a12.2;
        Wed, 28 Aug 2024 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837551; x=1725442351; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=023J8mgyqdG6IUANIFzsRcXCN5r/fodW/lnr9X3fEyE=;
        b=gTnPSKSEQz6zACmxuKSplwXxss7y/vbkmSkwd9bhjC3vt925pdSa+8SW0x6DIN1DK9
         8zSZxfVUDpWhlfhRoKjMI13+wyOPQm3Uz8WQ+rXmw50CRWaVmlojvxH1QfTzm76FF4ly
         e9/grxjLcN2HFhiCIwtqKCNO7K10ztrnqS0BTNyHyKljZAx1j9g4ZgYEqZl7/7o5C8Q9
         WY0i+CPCJsfG3/korpw0T6h/kAvUu1cfKWPfGHVDWGL0nRw6WQPnodLKOFakbr2bNoF3
         nKTWRX9Us2qmWKMT2MgVvKVZbIYoicZhjJ+eHEUgO+vHvJjWGVsXvM8kkBqBh6Iju4e1
         iolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837551; x=1725442351;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=023J8mgyqdG6IUANIFzsRcXCN5r/fodW/lnr9X3fEyE=;
        b=pZ/XUuwY9aKj4Cc2viCGdjhupyalYC+tg+T7CG/YEhWI1+Y4Fkeo/dNVNqgNBMAgs5
         1w2Kx/KdebxLru4WOihgQsc4dVOHRnug/Tv6vjRRO3KobHF2JFSKTN6RMo42SjXeKD0v
         Trj0b5HDnq+3h5h2DhOw2J8Gtbiwhvdghd/aEWWX9G1LYtdiBPHZbR4xe5Yz7T4tT27Q
         90KhxEUNdjXHYlVz7q3IF0jGb0zv6uBaL0LUzb5pPHHe0Zwsn2caVsESt+Nsp2fabwr4
         ckNIpnxLpC/MKPcQrOfJ1pJrdSXjxpNQ32XTXxqkr9t7PfSjZsKUnuE3m2caTE4QmPtd
         vyTg==
X-Forwarded-Encrypted: i=1; AJvYcCVh9eIaBABC7MbuV92e+Z8Zqzc5mumeL9PFpH8ybjLZrEGdvjbTATylPzwCPe1RPntTs0F7hkvT89Ix@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8Xo01VFmeMCGVAXiZoA/VxMMJjKQGio2+WodkgVBAwZTDPRu
	Y0JGEOUTzeo5sU6hiOyjqDXiRgY8A2KmG5dLRWADp6nBR/NW26MQFk8Xwg==
X-Google-Smtp-Source: AGHT+IGuC0ClJ2O1/L/itoNnlmS+Kjq8qwaVynIht85Ig4j4aO7fkwtITDTiHqv7Le6oJGQ7L8DD8A==
X-Received: by 2002:a05:6a20:43a5:b0:1c4:b8a1:6d54 with SMTP id adf61e73a8af0-1cc8b5d88b1mr15943675637.36.1724837551192;
        Wed, 28 Aug 2024 02:32:31 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db5f5sm1241111a91.10.2024.08.28.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:32:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
In-Reply-To: <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
Date: Wed, 28 Aug 2024 14:58:13 +0530
Message-ID: <87wmk1q9n6.fsf@gmail.com>
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com> <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Although we have checks to make sure s_stripe is a multiple of cluster
> size, in case we accidentally end up with a scenario where this is not
> the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> cases where EXT4_B2C(stripe) becomes 0.

man page of strip=n mount options says...
       stripe=n
              Number of file system blocks that mballoc will try to use
              for allocation size and alignment. For RAID5/6 systems
              this should be the number of data disks * RAID chunk size
              in file system blocks.

... So stripe is anyways the no. of filesystem blocks. Making it
EXT4_NUM_B2C() make sense to me.

However, there is one more user that remains in ext4_mb_find_by_goal(),
right?

-ritesh

>
> Also make the is_stripe_aligned check in regular_allocator a bit more
> robust while we are at it. This should ideally have no functional change
> unless we have a bug somewhere causing (stripe % cluster_size != 0)
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

