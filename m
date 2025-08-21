Return-Path: <linux-ext4+bounces-9545-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE2B306FF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186CA1D26E97
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC2392A63;
	Thu, 21 Aug 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KvXv2mkc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAE3921A6
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807687; cv=none; b=tpSPjzD+uwRLmuEl272asY/6ZKwx8cr5xxE8q9rCade+o18/IXhfz5YKaYV9yCu8v7D24cqV4iG3PIIZq9yTLxBGXeS1+n2Wzn/A7Sgb8eekCggQDv8FG/ot09YCoIantuC9brLDhlLQ1Q/cVE7geOOn7AMZxfdccmgej7xo67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807687; c=relaxed/simple;
	bh=i4hePIMWRF5Mzc731oRxQkAAktt67HnoQ6nCM1aZbyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwJdH94vtgoxvgNyfsqQMBZ20BvRSYJuEUdVqhelxq9LhFMlU5emswYnesOnNc5tUfVWKiF+Iap7fuBGx2GklHiAOOJG3SwYdDDABeYNZqx6Gg6ZPUwrXpckR6oQaHmQVl5JmlQVAE6dUjPjmhVL02NQ5Y/6JeQMe2obU6UBJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KvXv2mkc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e95026b33eeso1473747276.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807685; x=1756412485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=KvXv2mkcwwtjYomjJXpU7AH9jjeFpZ+w4rnpP2bRduLCuMXcWm7ON3fJpdvhkPRdz6
         nXDB/vfXkpukTP9Vz2l+YEqtf//LPg12OIgaOAMSgpYC4yfXj9drbE+ByoZLXGEQjYFU
         WmIDh1nWva4SitZVFIh7z5wJvQn4b9K79CQtgVwQgCOD3n31Ke3A7hcZhJikZgdQdFWa
         OYuEFMithHzKj9RuH6okpoxgbWMuwiBr8Kd6gaqPnY0guii9GuoZ72B4rWoQhAVVFq+J
         salYIDUSGGCrwhQ3utJg6MTnbg5Gl6tAstLrwHUOleXUh9E9T//WfShqX2at3ggNX0BP
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807685; x=1756412485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=ob5FHlRD0vnAJfx/s4hY68iOYQ3Yqib8Sg6YOAeC86fcLZVgc5tmdEqDXQS8W+qC2F
         mfaDM1GP/YP8uO8LCZFTwGsFNazkQfG4GXEm5INU8bOfbHecSb5cKwxHl3ZQRW/ynVzm
         bzfk6cITaOYQUdjan6MHU1ZvbpbUq0yHRxE6hBcGTZLCu9fCYPHT/yEvCJlL+HpLl/Zh
         DinpG23GtE8jeLnJZsDtPhK/zW5HM1pmkdscAAl4b9K5PSpHRYEJrVMGCvqmlGu+wYZt
         nJU89nltvua18KF7Kq6bYwXsDbddmMj5W/P5QNRkXjtQ4Zv7EnznNUWcZ3C6EP+qcbOc
         lpqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXhM7EcnsTkaUVgsrPGL/+U8SMvQcoEy8p6zkVxdiPXAl9eyNS0q4HCYSKyq+nEsYLfjxlpLgJArAu@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJ1Bbt/Xso6/2Rpn0y5VVBPff6an6lQJKmhLcFlQsTHZ4qbin
	2KJHhhI5KPCIo0LxdPljkZXpD7AkfaEH4zc5zvn29oEdLEW8rZe4VSRLMy7Wrd/EUc870CM0Ozm
	rI4KusNDDBg==
X-Gm-Gg: ASbGnctVamHeMrSa0JRel4NsYgPiFhp2AZ7bgdDeqLWNriVZ4Co8f9D6ah97IKq269V
	XsjzVslVkmplRkRy+O+uQ/0fYkebeNu60AO03Qy45FSPtPdxdnV3e38mJgEk4y1lr3oLEgM5Swo
	QXEo0VRQ6o7yzpFVHJQDp9OJpGWJW5qKFzM7MAW71hOcF5a1ku3N5JnP8EwLBEUPOmwjfgT5VZj
	ND6dj+BVsOcRwQ+RToNbencF6LbCmVOCTM6JQ3jzhMgMW2Wr1xBWmecJStxqIoqAViexs6fncfx
	LPVZPAHxh8pv3qyy0gWAaV+vPrg0oBWumnH/99NddskeT/GflaPufjtZwGMEuo55X+Ov/aPpAme
	0Y5uTvP+e86boG7aRUqk1nDbxB13khFApkfYI2crteOF5SAfidY+sdShit+xuKvbuQgx+ViBAth
	q2onj0
X-Google-Smtp-Source: AGHT+IEBylvc7AHp4BniCBq5Q1DyNIynT9BLRz0rP2zm0l1TKcTJo/hsMPaTkP6ZgkuFyU8mOePjTg==
X-Received: by 2002:a05:6902:701:b0:e95:1521:3d93 with SMTP id 3f1490d57ef6-e951d08e7c5mr623429276.15.1755807684641;
        Thu, 21 Aug 2025 13:21:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9348b2c51fsm4962060276.7.2025.08.21.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 45/50] pnfs: use i_count refcount to determine if the inode is going away
Date: Thu, 21 Aug 2025 16:18:56 -0400
Message-ID: <8b63d783e7896e857380857ec4c40a00e17d8d73.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..042a5f152068 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (refcount_read(&inode->i_count) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


