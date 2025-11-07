Return-Path: <linux-ext4+bounces-11633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFAC3E33B
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 03:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E60188AD36
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA772E973C;
	Fri,  7 Nov 2025 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OYp4ubuT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56150219A86
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481221; cv=none; b=j11dFIX6+UYmKkpBbe2l6+H6VlO3dZBJCIxRQ2UP5Ne4Ds2vL3e7M9qdCILjH6kQK3HVz25b0X6YySxDw3XPyqwVjTxxgUQa0rutuNwAL2syEDeyzDGZWMrGiqblfu6LPAURVi0sanZgDCVeB0FVyTtWF3eryOxv6XTjsPYRc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481221; c=relaxed/simple;
	bh=5/T0SIm0UdNO/IdzRZZKEiu//zm3DFK1QFan+BlZfc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lD+SxPMoMoY+Qpr2r3FKkzhy6jaFeyu99c/fqAMP67Hn/n3fqRwBLqtQxEjszud5G+1LIWko5626aC8r/h2vpC9Sm1I2Hl0Uf0Wa6047y/PHSD1yjEgQP2TIA4tx23NxjDF2hYUsYUwHRz0Cqz23boO0VzyhweYGu9jTMtgUHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OYp4ubuT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-292fd52d527so2273945ad.2
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481219; x=1763086019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=OYp4ubuT3gFc60iNpOyqfZR5wKv5fjTWfjquldjj3yOmqwOqHhb+gL5tBGy1h6g19a
         mE9JKBplmSkVKkEn3gsbnssVeL3P2OnVme1LfIGDUWl5uwketcnYSSPYd40ovl+AAtli
         qK20UzYrZWuzXHfZvM8pZD6J1OS8frr4sUeuoh+AKkoH53mA0fbtfwSUkKSjloevMJ8H
         BKbPC7Ggm5NBb6iCHtS/VLhpM2bxPrrfQKV92pW54zrGq7nwYO5NHJQ/ZCweBAVuV4JQ
         X8QjrT3Jou7mvj0bxG/giBOc833ri2zbOH18PTI/qb3Ld1KMUxR3ET8eZjBe147luRUB
         lIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481219; x=1763086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=SGDZIs3haR5Kw9zLIhhLngxmL9x2xbDCP0uVH+B/3gnlBbPvELVJiuRLXNPS7DaFo/
         /bpRZBOA6zIJgyySKq5YnbE5N0jwpswLnbA4seIl6Rc5HbLTSVIebjNkrov/2VNg2GvZ
         Jd4Z3ckBoA8tte2kTnkJJTYKvQ6b9iHu9ajseI3tFYtpxWH9OzFelGzp2+3RN7IKgugx
         AA2tUyn1hcfYYR+2tRWS7l9+ZN5xrlL/mxCGqhPTFxRthJ8GXAxxq5JD6a+k/UuUf1g3
         ILFVt1nkJYIB9SKeJ2o6t7eKY+Ffcfd5Bm7h4tRmdGv1pK1f/GAWEH+CE9YnvFPFSozK
         2Uyg==
X-Forwarded-Encrypted: i=1; AJvYcCXIpmOUyFwf1oBwFdlD8YJrT35ImJxxQIvv4z2FA3hRvLAnToN5dnlo3aTnyEF7w5vXeX62Bai1EYOP@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmbAU8ElXgD3YmnUWuORiTU2bqmeDNnlEd4Lh0QTDhHOzpamG
	N3aIABG3INpxlwntbZA+md7BrKlTJr6j8yUISHWPYqosqmWCHgPkCLKoCr7mPpi7ogk=
X-Gm-Gg: ASbGncuJxlGv5s8kDC7xsQm3l6H58IvC6vj2hJ3MqVUDUzYyW4ps/7xiHOfeXUOoDrV
	2YJ/cNJNK51biBAqsj+VOBB/eF9wUpoXhgzzUCGHTMiEwSc7yAcvbw3R7weicrRGphBJLdIQYmL
	cKAySGwWNajHXDvmOQXWMNxlvu5tbxhSDstc6qXAIdscA9cB1JsICKxizcpS6IlcS9LvANHeyot
	51KYGVhemSLqs+Pz8MIF+UGSRiKB3NRTf46UDQYBeR3l4NY2ls5C2M5dXLVFDe6Ap4iw5//6vx+
	GwT/RwSZA+rTYnG7OD0cKZZ3rb5iOlkb2PXilGDPAVOHP1EjjyAcbtcUjHbkTmMfrMdH+cpNUwm
	XC2Gk2le3dpBDQvCtldHfE8VA4+sacf9CGubv5/PZ/9yEPq1SmpBrttO1h3Tc94keFStqdW/n+G
	GYT2Uig5iW4SMQlvxx
X-Google-Smtp-Source: AGHT+IEQ1r7AsblEW15F6NrWnCgQgZkngBPtkNTOIEI5NyInjWIPCo6YMVNtFNrYGdMqGrYdOjvVJw==
X-Received: by 2002:a17:903:1ca:b0:296:1beb:6776 with SMTP id d9443c01a7336-297c04aa6abmr21929025ad.58.1762481218563;
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.06.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
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
Subject: [PATCH v2 0/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:55 +0800
Message-Id: <20251107020557.10097-1-changfengnan@bytedance.com>
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

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/



Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++------
 block/blk-map.c           | 89 +++++++++++++++------------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 48 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


