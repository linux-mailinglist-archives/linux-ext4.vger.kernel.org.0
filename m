Return-Path: <linux-ext4+bounces-5034-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C35549C46A9
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CF1F263BF
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C631AFB31;
	Mon, 11 Nov 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KsDTylkz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BA1C876F
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356378; cv=none; b=iIyYOY0YMB8PtlmDs1v+sFBXDrBcwnsUv2e6K48sns24KamOYzmwEpyxsN2040juUTl7zYRkZxWqAy9tBrtTdDIE43P2x4OKjSVQxdXT8PX1sLLYuQRqj8Yzy2vsEyGe9df55EPrw5t+yFg9fPS0AgX3ZyOZdiO/HH/1A/emT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356378; c=relaxed/simple;
	bh=ebiNpZYnvVnRivNXQB+8i4kmhiMBzkGPNaNaMTrbD18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcS8+xzzDA+f28/4A6YYu40CnRQ2k6MVSeXGxb2KhzGCXv+FTVD9nomhIwqEAbYZFtInbsz2cm14Y+lpJeXYwmZHROfl67+vE2/4WGyI065R03HMhggIGg70Hz31mgHCyD1hs7ygpaQEonQbe9muXcD/+4j2EZyoYwdTCPhOXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KsDTylkz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbe9914487so36180506d6.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356375; x=1731961175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K354FbH7N36y1HXaBsHf/k0mJrRSZmAsPpq48Ppw2zw=;
        b=KsDTylkzOgGiWbe4xY9fDmY/F7+0m5JC1Y4l7qPBaZeAv0ydV8vhzH+V9fHZ3NwPZf
         veb1C7wPnCqaG1gdsoVAkVG1FNVyhNSzDr9MO63p1F+rB/2jMR9b45XGdS4ANqDShUgS
         6EWwoOPpd4CiqUei5swGsFI1oYllzegAIbuaHT2JmArM8BAYM0ZX7RPsMDbwUj0Js6TM
         G1AT9ygGUe0T1yODjStHH+6+0V/waG7Y56iLa4d325OsIoS2SSFuf+9pUTjZrNUi4+ur
         nMHDjuGo5dxvE3I5i/hJMEXjWaKjhOPp/J+hMjtAMP/JDvyjtWlJVVa9M3Do10WfdbAl
         fqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356375; x=1731961175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K354FbH7N36y1HXaBsHf/k0mJrRSZmAsPpq48Ppw2zw=;
        b=LXPk74Dg/OWzC0aBJrPQjoq8KFil8ftGi38MPTQFO+9Mpv5s4iZVibIyS0qTfXBwoX
         L8V9FK3Hp//vod91mxIVqPjzeIkWDnnIaMHmL1l+KfMk0tF12mx/3oewoYmjycK3JpuH
         ikkLlWgVMQVq2lrsUkjm5WJqa751ctWYUo0f4vjQUqUU0NWT2d+QRADf1OytGz7CkhZY
         UIrLGwkVwuOaXXwc5zP89bVXVNGGPG6ZVeroNZv1kuzQCz6kfVbia3HOfpSL6vvBDPI9
         GGz5rOnLy0op4AlHgxyLqx87doKQEkmxHlGijSyCG8KGrXUanc7f3CwuMgdt1o3W8/JT
         33RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKGR2xpoqTJj/3gnhenTqOmyik7Dh7T68CZ47cBUcsfMR3WVnxfIkGjxnsDN2fiFufZ6PG0M45gScT@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpnYkHwghwCz3yDabHEcso66I4mMwgWd1zv/Iqt86iQ+sR6qS
	iKc2cNcA/CUnBHEf6JvdRBNK44R3g+B8gYY7laJzEwVWApqtqp/VOUYx/CAVQvA=
X-Google-Smtp-Source: AGHT+IHFQZuz+k/JoyCiK5HhS+saKZlDM8Ru8ImET04ZPdGlwroC1m2336uogkksO+jSLPZVucywhA==
X-Received: by 2002:a05:6214:4518:b0:6cb:5273:7265 with SMTP id 6a1803df08f44-6d39e1800c0mr180760506d6.20.1731356375457;
        Mon, 11 Nov 2024 12:19:35 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2d2sm63665716d6.25.2024.11.11.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:34 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 15/17] xfs: add pre-content fsnotify hook for write faults
Date: Mon, 11 Nov 2024 15:18:04 -0500
Message-ID: <339a520d48acf1c8dc736460d09fd240201d6e00.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..d1966f996c77 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1442,6 +1442,10 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	ret = filemap_fsnotify_fault(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.43.0


