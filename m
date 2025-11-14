Return-Path: <linux-ext4+bounces-11862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CAC5C5F8
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1E854F7AF1
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6C306481;
	Fri, 14 Nov 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gWiJTWmL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD12FBE02
	for <linux-ext4@vger.kernel.org>; Fri, 14 Nov 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112136; cv=none; b=lxM71UaZosSVM5sDbFPBcQdRgY7MQwYDolHGjgZ3lwtVB/h9FvQh3/+HIDVAOgiNyF7AixxlS7wOGWwnY1HNnbDaRJm1bzua7P714y0LS+UlKeA8UC1dFhPdbKKt70j4OeiXbyax5VYRXOJkzg+Nr1lUWVITrT5sIU9GoxrEoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112136; c=relaxed/simple;
	bh=3yKmCrbAdSfO2k3GcxeDVFzxOqz5BImDvVOtgCC29lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mBaQ2Q3LXqnYOvIxyE60gTIc2H9UNYD2yswmulAQZE54X2q+0hGPpLWg/BAcfZ8Neb4glXYkpA08huXxjqdHqWCpxXBMrFkR2HQ8piv0XCXqck8ovP+EXYg9Hy0aLGzeWBVKA5j+sRRtHRptTzRI1JMbnGGTy/jWAZvflhLwrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gWiJTWmL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29808a9a96aso17146175ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 14 Nov 2025 01:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112134; x=1763716934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=gWiJTWmLtdQIWFQHCwMr0MALv3DOAjBXwweAYwQisiMu+EluR9hC4Iq/X+29XvqO29
         gY+5xerWTOX2nQTWUhDQF5hP4ONOLDiSlXwxz718jWn9y/nS/gZj268nYk6MUEJuRlzZ
         Mmo+BqxHa1U6NHva/Yj3ESZRk4inOXI90KCQ1sSh60Hs4q7TwijMvXQtcQ+1+xc7e1hO
         nMGPMYGtYDnFcHnuwdLEfccHYNSqUaJjq8F7EOtnxtIyDyEKC2h70wDPrgD9zF2/pCw/
         /xLmXSBXnMkpy8oGQ0LClb/0HlV9LQ6O2sBdNGblSV3ePwjC0UcNf4KavWc3HMckp1zY
         ZVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112134; x=1763716934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=YBDvgyjaDTVjsuaHVhuKLsZ9E76CRpmzRpm2sHwlkMLe4HP2PUEvRJYownouxgjSXC
         z+zwxwciw080YiMQxEt64pQezL6iiPAtNQ7Bm+eBJr2cuUY2mzWcmaZV7GCVJvUsVg2y
         IFmRYh7zGYwTeTUmUHf1KEdT0XT7pIrp5bPRcde6NtOZ/qWA9xgGwVBQxZuQKZn7aDXc
         sCb/qMBB17i9loKLOEvWyraflSb4D+2i/n8T7CfqWLkas+BcQBcTKdXb5QKGNow+notR
         TL8zMIcbC8XB1sF79EXoJqautcRkiBmzxRDvek88LUkJRwAcag7lwQM3sFxQhW3istr0
         6g/g==
X-Forwarded-Encrypted: i=1; AJvYcCUPZr+f9kF8MsmfZJNuZ5AbbYhelZk0Siw0yxUofzNteh0XsVnkYmG52+w1oxfCAhOlyw6W6lXJcpbh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vZbe7474t6I77iq9aIlg07pk+jlBbCZ8Yg4bQKfhH5geznkz
	cDIfMysssjI3KsCSrkRnqPHEMi2GKpcvt9EZpc0BgCgJDdJRtSPJ7jR6Tl5UJVdiHm8=
X-Gm-Gg: ASbGnctEHxQo5yKTBwJdSp4We82MYWuojxEFcWNjQgg6ttqcJ0OGF1HQsFMhR6jS20u
	ImZB63GFQQLOfnG/ViydlIwH4Kp8kIGDXYXEcNOzvrPR/yWFKpQ1gpvuoSJkP+5nJ5vMS/dSSZS
	46AortIfYpp8vCgMGbnCOZf3ZgCO4lK7rWeMxZY8FwCPXPOYeZe3nEnzA6IVcunqzuxPLnnbahc
	AMBCzUoe/bKIGHr1/EJJEHeo4449AQisTehB9EJQoKTNr7698c8e6n8WpkU3MSb22F5ElSOVTXC
	NxJaUgqGIiAuwTkRUQexacDMOHA2IlVifYApj3Laa9byRRxop8BOB9RlHTHBLeUnRJmpTYOBhMI
	oU58eE2TjZi6ZwPnD3Dgtm6Z25Tp8Mdoa+IgXexvKj25HrZTwEiveNdGUqwXE/tHh2eRpIWNh3z
	X1Fl3VqodvFp6YasJyuBJgYeODuRTQRl4n2w==
X-Google-Smtp-Source: AGHT+IF+L62VoDL311ziY3WGmIGqOUF1aAOhbYoj7EpJUNyw6PsD2tlvnXHX5j5jjprmk+4XNcS2IQ==
X-Received: by 2002:a17:903:198b:b0:267:a95d:7164 with SMTP id d9443c01a7336-2986a76b6c5mr23867635ad.60.1763112133120;
        Fri, 14 Nov 2025 01:22:13 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:12 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:47 +0800
Message-Id: <20251114092149.40116-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v3:
fix some build warnings.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/


Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++-----
 block/blk-map.c           | 90 ++++++++++++++++-----------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 49 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


