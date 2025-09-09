Return-Path: <linux-ext4+bounces-9884-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55166B5028F
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 18:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB9F169CC3
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D927345755;
	Tue,  9 Sep 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LMOUVrwI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CF33CEB7
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435246; cv=none; b=gw6rOLIqP4mhnwuJJGUOrGqIER87dn+JAzVcWrdx0zMv2TGOP57yKSE0YgQf1lu7Ds0w0WwqhLMvTt17fvlwSOcfLkfviBeGEIsPT9QBgwa/NsYstsuTxEHcYfC/qYwB3quGM3rnCYRRsbp6xJIN+m8QInwW8F3MsX1JYCHNCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435246; c=relaxed/simple;
	bh=iGkK0GZV0QqwpOYApQ22IsNCF1IiazNEA6d4iqI+BXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZkznYKB661PyItoUlEy8aUc5NkNieAIEq+uyUoYwWVKDmeO0GEl31cCnK6wxGqOsOeMWnd4A2+/2D/izehRgnabBkpoi8mHzSrjHl7neer1PALA8Wip/KhdUrO+9r5LX2w4I7L5H88NJJt3beyQVzHt4slZksyevEoYk9DXJeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LMOUVrwI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432e1af6dso406074839f.2
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757435243; x=1758040043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU5+1dfVb+0Q/QuEy8gW99WTOyajIvbAEwb6qaOWAkg=;
        b=LMOUVrwIKMmIZiL8VlEZdfg0wkzl8kehGhgg1JrkVkMcBfRwYnOyzgUBLBK+upWnYa
         30TKuHXeEn8OEeC7r+0cK6BhWWZIRv1fFEsrWCCQ6FepkfGkqnBu7zZdjBNj7VTDfEkd
         Epm0AlGkPbevVyL7ZChfIIRVpoTRZuR3xZS+g+/jU5whtvGaBReO894upp0jCpaBstV5
         vsqlI9UjH9FiBRhvBdrm6hJ/DaewVEXsx5CHRbMtU4bXCXIotuZnzweu9Ud0N1y2aGdC
         g878RgQUp2fddiJ6DpUYq/O29J95y6vXFKQiJszOg0/HneBPVcRVbBSBhgmi5iEKCUpA
         Fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435243; x=1758040043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU5+1dfVb+0Q/QuEy8gW99WTOyajIvbAEwb6qaOWAkg=;
        b=Oi2XTAOcdwSfpT5/Zc6Zh9AyrXMZcV3q4jkk1qF0q8nal4rijHYUYL3+cqwv4unpRo
         hN+EYtLIzzZEX9VJaUKut8UAez/1WNsNAy6yvsPj9mozN0/gzrEiDTN28WH69c51Isim
         0PN9/Ayd+JdtxgOvpVrvllaH8s6OHvvW+WqP7fcIYZAHpD57U13vzUXcdFcG22EtYqgG
         UDQKrYUejuKgJNmEotZBBZ/EfX1TmvDcmG48iz1/FER5AjwK7Zyljkm8nwVlhhVa5eik
         mJ10k/4D+ikzNBj3y348WiJtF9CQ5aCSLxVRqREM45XQ3YVoplXkg1QmLSb69MwT3FIs
         o7cg==
X-Forwarded-Encrypted: i=1; AJvYcCUr3MNG4frGQzSvArTkAB+4PtRNcF0A/BivWM6d46R46msaB7qEvrhia4qGLG10+4Uh6N2iI1iXQC86@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zFY4NZXRgxNhpfMyU34wDJeP0rsdC/dGmZnH+UI+E7ymvTLG
	M9OSAUiZTiTaocJSxMa5TS8ynfRdaEDyxlXx6NXTxReI1FVKoL2b6o5/1v2wflnq4Lw=
X-Gm-Gg: ASbGncvpIK7lVkFCr7cDHcukbcDmEcaBTnZBm9OsdvXGkPcSN58+NHNbPueXSZyoPXA
	lhe3IvNcJdACcSdVa1PEKydJxSJQhe0pSx19bJli0/4GJlLcybyPmTp/gD+KGaNkSuZp+Q2c2BL
	xySKLWOtgnyf572Ajeq/KTCAghxTcefBd+XL+IQE1zcVhxP0cRDO9cS7hWVJdwCI3kcMj0ahmMX
	NnMmCtkktKewCX+eGL+DCkzO/dKDUB6IJ2pL/3qrpVANONvkEwXSlhyOxZPVSLCWp16jAzM2EsN
	DOH9ijk1XjkEI4dJMjn3BD6g2l559jlxSgCn//nXFqyfEWv70U6X+x2nxYX3GiSrbdH+o5DDPiS
	Wdwme1Cy/BWaaoQ==
X-Google-Smtp-Source: AGHT+IGYb7REoxLIudhiD+LK09+Jxda+ni01YckmiZbSg941A5eJBO8ul/BNPsA8WuRBKs9N3iVw+A==
X-Received: by 2002:a05:6602:2cc1:b0:887:5799:7ab0 with SMTP id ca18e2360f4ac-887776aff72mr1950935739f.16.1757435243017;
        Tue, 09 Sep 2025 09:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31c66asm9636034173.44.2025.09.09.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:27:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Subject: Re: [PATCHv4 0/8]
Message-Id: <175743524234.117585.13836043498265714409.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 10:27:22 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 27 Aug 2025 07:12:50 -0700, Keith Busch wrote:
> Previous version:
> 
>   https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta.com/
> 
> This series removes the direct io requirement that io vector lengths
> align to the logical block size. There are two primary benefits from
> doing this:
> 
> [...]

Applied, thanks!

[1/8] block: check for valid bio while splitting
      commit: fec2e705729dc93de5399d8b139e4746805c3d81
[2/8] block: add size alignment to bio_iov_iter_get_pages
      commit: 743bf2e0c49c835cb7c4e4ac7d5a2610587047be
[3/8] block: align the bio after building it
      commit: 20a0e6276edba4318c13486df02c31e5f3c09431
[4/8] block: simplify direct io validity check
      commit: 5ff3f74e145adc79b49668adb8de276446acf6be
[5/8] iomap: simplify direct io validity check
      commit: 7eac331869575d81eaa2dd68b19e7468f8fa93cb
[6/8] block: remove bdev_iter_is_aligned
      commit: 9eab1d4e0d15b633adc170c458c51e8be3b1c553
[7/8] blk-integrity: use simpler alignment check
      commit: 69d7ed5b9ef661230264bfa0db4c96fa25b8efa4
[8/8] iov_iter: remove iov_iter_is_aligned
      commit: b475272f03ca5d0c437c8f899ff229b21010ec83

Best regards,
-- 
Jens Axboe




