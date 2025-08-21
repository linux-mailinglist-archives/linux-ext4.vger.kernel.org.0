Return-Path: <linux-ext4+bounces-9514-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED37B30658
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C50188F5ED
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404C3128CC;
	Thu, 21 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T8JgXSD/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A0372183
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807637; cv=none; b=UvOqPqx1ChtOPW1kwbDAXYUJRCIUlGxkrYTdf4aW5YVPq7k+A/UpocBXL2dfo89nw8ldHAfmbipb3HYhxGuRO9wuE1I6FAjo/1HwKIKR9R+blC77I3bDbmY4RvkxQjzAgbRNuMGuijOWEvwxykW1lJ1mp2374OhP20eW8PNca04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807637; c=relaxed/simple;
	bh=VctpFBGHU9fl50Cab/W04C4aV+TEyk9wQpprZfPFgXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSayZXCzydWL8Dwfi8UodDxoJ07tEvTalNzgI+BkHyMGmndjQ9ZotSLeLjQSrHXniqP9NPY24DBHnjiAxZeqJ67/dXeYObXEIcPNJdlKCgtqMpM1nTC8+0wyIegViRhNHPONWo0NGPLhfvspX31tFGi8dc7APXsiqQTEZClye9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T8JgXSD/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60157747so12168207b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807635; x=1756412435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0oLPRCL+kdVKzhAc+n1SeA8IVQ5ey7MG0Wg13YWNIA=;
        b=T8JgXSD/o2VK0weC7b1D3uiTxvOfmJve1MLg2r5DoJ+tk/FJ7MkhB+4uDjCgMjM4Ie
         zzhTzZyy9F9gTA8Dt5Q0+wNqkgv7haP4VTKAzAG4ubOQqR31MilZnOIegBZoBdo0KSwC
         C9rfz7vp4EHdllshZ9suAmPLDVqBqRUvrstyxYmmgecuy/ETXwtd8uQVRS7Lp8d4PkOs
         gbX8v1BqE72gjr3ulTLV+u6wpyFcYOTSSEJC6LoUWlAcW2PMXtEvaRfEPQCByDXajyf6
         hhF0PV76iuRcNdAD8uS8Bi9WDcLI/zKcIYm/oFgldP/6ZRJgQK1XLkbmsJ6gBIdrpdpS
         te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807635; x=1756412435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0oLPRCL+kdVKzhAc+n1SeA8IVQ5ey7MG0Wg13YWNIA=;
        b=eUlauUuir0QHzgGiGW+2lyHp/BZOG67ecgGmZatw7iz4LfAu2NldbcX/xRaLvr4VzC
         ovRc/4nqu25thvwFPFkyPAccilprm446apat1Aae+9YPMpF5mIji7OR/w5+VPMxefQNo
         d+8EYnAUX22stPIP2KIsR6gVLPM9P6sYq7igsZcLYZnu7jyUK+ATrOr4qNtRL18Y04tM
         GT8s86x8/bGf66eOgWoXqc+48URa1Z/TWONCvs2tT0PFeIJnEK9jZE2DnHbJgwZSet3/
         HD8bH6olmJ7YFq2rE0xyGoUOvL8o7z0vItSOvpF8pxM5rYvlxkW5Y0IUZiYf3qzZ98zR
         Y0CA==
X-Forwarded-Encrypted: i=1; AJvYcCXTZnfFVy2D7OhYM9d65zrTVbCVToZelup1deejkDmueZpXlQg+khiksbWgxjC06J9vqc07pLdi8RcT@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEOA/r8CgAFPT0bWqZcNawxFeQy4kFaCBlKiUJXhjZxxMSVZI
	bMuyXjHhlGQ30r5HRnZni/b/8EpB0V9YPx8RIwAqGM2UzR6CNcMTX9OceN14CXg49TQ=
X-Gm-Gg: ASbGnctqp0KyvVEXfr2aB4x9UI+o+uqCC5Hfc7tE9/sbvt3CGn4TIjyyK/K1GEFjCKG
	AsqQP69qbEzyJVAe8eDfOIR6R+fr5rioZ5yu0g/vlQREdQ6Llx/OVXALAuysi8t52SRcRm748Df
	MgBM39cmUDf4vna+68EQQaXtk+/eDQ/dx6DTBhpNg0EaDQTTfhuTL7RqrIe/D2K4cHLqdbGITdd
	MBmw3d0EYTUikGOjg0Bpi0w2XM3KbC++h5eGWinmb4OSL9dJPIcOh3/htjKt14IX/42Ivmm2T/u
	9gHUQrny0ToeRkNvWkXTc2ZW5SFqM3JC5ETgONJm972rzeW9+ih4RDUz9in8o3KudJcPYj7Kd8B
	BIPD7K1m6K+xUJSHPXD4mua3YkQFIcPQ85w2JoYksKAOoSljNf2ka5tWtv5axOBV5vRxGLQ==
X-Google-Smtp-Source: AGHT+IELGOXi/q8OA+QNnctJTP5cMeQZFEV3W0NZvU/VyAsp5aF1Tkq9N/xrCeUTy6X6MIsWCpH29A==
X-Received: by 2002:a05:690c:6413:b0:71f:c7ae:fb80 with SMTP id 00721157ae682-71fdc3cf564mr6421167b3.30.1755807634852;
        Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c1dda5fsm58714d50.4.2025.08.21.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 13/50] fs: add an I_LRU flag to the inode
Date: Thu, 21 Aug 2025 16:18:24 -0400
Message-ID: <16c9c4ffea05cdf819d002eb0f65a90a23cb019b.1755806649.git.josef@toxicpanda.com>
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

We will be adding another list for the inode to keep track of inodes
that are being cached for other reasons. This is necessary to make sure
we know which list the inode is on, and to differentiate it from the
private dispose lists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 7 +++++++
 include/linux/fs.h               | 6 ++++++
 include/trace/events/writeback.h | 3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 814c03f5dbb1..94769b356224 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -545,6 +545,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		iobj_get(inode);
+		inode->i_state |= I_LRU;
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -574,7 +575,11 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (!(inode->i_state & I_LRU))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		inode->i_state &= ~I_LRU;
 		iobj_put(inode);
 		this_cpu_dec(nr_unused);
 	}
@@ -955,6 +960,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	    (inode->i_state & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
+		inode->i_state &= ~I_LRU;
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -991,6 +997,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode->i_state & I_NEW);
 	inode->i_state |= I_FREEING;
+	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b2048fd9c300..509e696a4df0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,11 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_LRU		Inode is on the LRU list and has an associated LRU
+ *			reference count. Used to distinguish inodes where
+ *			->i_lru is on the LRU and those that are using ->i_lru
+ *			for some other means.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -780,6 +785,7 @@ enum inode_state_bits {
 	INODE_BIT(I_DONTCACHE),
 	INODE_BIT(I_SYNC_QUEUED),
 	INODE_BIT(I_PINNING_NETFS_WB),
+	INODE_BIT(I_LRU),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..486f85aca84d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_LRU,			"I_LRU"}		\
 	)
 
 /* enums need to be exported to user space */
-- 
2.49.0


