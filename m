Return-Path: <linux-ext4+bounces-10478-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F39BA8CA5
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 11:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DF1884B04
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E592EF671;
	Mon, 29 Sep 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GjaPRWdO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEB2EBB84
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139749; cv=none; b=QaVqa310LaYqVVUHHQt57Dfga0b4ouxvq8pvF62VkXwbK6HBwJ70FWUD+tda1mfl11UmR0nPoMfnuwMI2qEQVGQIZGG8aUUqG3JjfYf7nEZWLWlKxsv6AHDx8nHZXyFcDDmm+LJvs/CQpIlur64GtP/72kYt7E/BEWBBFlEaLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139749; c=relaxed/simple;
	bh=aeeL5WqtwEO8tAubElV3jVgXBbqfv61evZxCWIpXnzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXTg2aDGagvgjPWHgdWP0d6Ff2MJKPmA5Wil+GgQugxMYeAX5qTOGMD2CyHJDDAKkfhdmsYF8qGs1qReMHlWzUSxE0ZxfHogUeHgFeGObfijJBNVTNV/4Cz4EyCKu1o1dY8OHt6KhewFzRkzPGMoqnIDpP7fnoBUqfUmvnCwnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GjaPRWdO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-273a0aeed57so61671695ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759139747; x=1759744547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLANQMIWJTPxhp0UxI/MYcM22Jdt4bQPda2xSN2U3BU=;
        b=GjaPRWdO7dwf/WgYapQHRG0M/XvwCQP5/6vIQCngkbVFL3V1FO/i93O740xh7aeiyZ
         QS9vb6RQZfTuM+OUeaGkzqUUbFLPLM6Cuun43JJXLlC0Z9yEDrvmFM+irSRHltPUAOGD
         wfcHaDbOUesS/G39Z3iGqwrtXm2fQ6YY7JdFPnoo9eorhSC7kkxUuOnQZXySz3jPYsvw
         WMKjSom0nLB+1l5jttbCLCwUwJ72wtq0KM4qAPCksdE/Mq4B2Z3L5CgByQNf9ExiVq67
         ntGx7T20afYNh/v0lMHubufAnLFQ9KOflDYo+sOiF+/S47q+8uBFIneCMyNfOkdAje/o
         vXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759139747; x=1759744547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLANQMIWJTPxhp0UxI/MYcM22Jdt4bQPda2xSN2U3BU=;
        b=YgynxiDoQM8hojyTGmJG3CWXQxs+UMbTwX2J6LwZJXPreZxy6wSGJqU1pGPEGetUlS
         5WV3XS1r55oYzznrG8e17gqc0XMxU9neA6VrDxTIZaEnSzrj0MlbifIXbDxqhHv898hR
         AqesYf8Y4uFlpqRzYFlyyaGx4XdUmtt/Q4zIFxlL6R9JULtm6HDgmrjEYdlG9A5TLpRB
         EnbSrdSXhAHBNJxkFdXbc1NQroZ4qrLVng5kry3/OIimDE69cQclLYtNxTdDR1QuKfso
         gfXYcTCXphY8vPDIIPQnDHFkXMuXEiTK6VhOtmGmkWRKl06GL92dOdyK1fLAGJ/1VXsJ
         yRew==
X-Forwarded-Encrypted: i=1; AJvYcCU41NSUKscEJ1Ey6X4Vo6u0Ahu1IS/raOhyRwjWdVcxOS3Xli0ZxIzAwHXwihnUS/H8eh3OoIBhK2wP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0/jk+AVaM0s8b3fZHB5DcNj54zPhK8vb+Hu4Zy5B9KVMnT+n
	gbP7RRco2Ip8jh6b5cpzkBQzhiMrg3Yj+FOZgvqxkgm/68yn1a7qf6rosZdiLvkb6/Y=
X-Gm-Gg: ASbGncvl9zxT2ZCV2YswB+PnO94p7enkWAstupp30IiK4dmaMbm4Hjk3sQGvYyVCtov
	csrtWMrtWXJ/Fhh1xgXj5uKTYnb0EfXqeZNaUms/VLsCygo35Hi9zQX1yXJWlTrEckupcEscmJM
	giyK05/iou+0hK7pAXyFLip4b7G3m++P246NkIvWXuUTH8oarNyvAO7SlH90ZoLaZVVrldsUlyZ
	S0H3DTlkUL9BrssoLaeQSnerAO+HjcslxX/NWuOO00XbeaDOpsa24iwR4iMHy7k37uD0KLH9+AG
	OPCVIoY0G/L3w/145tEzBT4BhJaUzdlABhnu7WkIwrIDiJ2F9cWbTy6fmQWFGazyHJLOmpGN1n5
	G5Ft1tBdM1yLvqugDR6TG7kfLpqZAWteS1Q==
X-Google-Smtp-Source: AGHT+IGeeirzmmNucPpJRQY6OaCfZcWNOwMOpAFnjpyd+Ec/bpOStvzlr/XHiA7xXQcwxFRBs/UP5Q==
X-Received: by 2002:a17:902:dad0:b0:27e:d66e:8729 with SMTP id d9443c01a7336-27ed6799205mr136594755ad.0.1759139747281;
        Mon, 29 Sep 2025 02:55:47 -0700 (PDT)
Received: from localhost ([106.38.226.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab640esm126029965ad.128.2025.09.29.02.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:55:46 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	brauner@kernel.org,
	agruenba@redhat.com
Subject: [PATCH] fs: Make wbc_to_tag() extern and use it in fs.
Date: Mon, 29 Sep 2025 17:55:44 +0800
Message-Id: <20250929095544.308392-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in wbc_to_tag() is widely used in file systems, so modify this
function to be extern and use it in file systems.

This patch has only passed compilation tests, but it should be fine.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/btrfs/extent_io.c      | 5 +----
 fs/ceph/addr.c            | 6 +-----
 fs/ext4/inode.c           | 5 +----
 fs/f2fs/data.c            | 5 +----
 fs/gfs2/aops.c            | 5 +----
 include/linux/writeback.h | 1 +
 mm/page-writeback.c       | 2 +-
 7 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b21cb72835cc..0fea58287175 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			       &BTRFS_I(inode)->runtime_flags))
 		wbc->tagged_writepages = 1;
 
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag_pages_for_writeback(mapping, index, end);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 322ed268f14a..63b75d214210 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 	ceph_wbc->index = ceph_wbc->start_index;
 	ceph_wbc->end = -1;
 
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
-	}
+	ceph_wbc->tag = wbc_to_tag(wbc);
 
 	ceph_wbc->op_idx = -1;
 	ceph_wbc->num_ops = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..196eba7fa39c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	handle_t *handle = NULL;
 	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
 
-	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(mpd->wbc);
 
 	mpd->map.m_len = 0;
 	mpd->next_pos = mpd->start_pos;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..101e962845db 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			range_whole = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 retry:
 	retry = 0;
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..12394fc5dd29 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 			range_whole = 1;
 		cycled = 1; /* ignore range_cyclic tests */
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag = PAGECACHE_TAG_TOWRITE;
-	else
-		tag = PAGECACHE_TAG_DIRTY;
+	tag = wbc_to_tag(wbc);
 
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..884811596e10 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -370,6 +370,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
+xa_mark_t wbc_to_tag(struct writeback_control *wbc);
 
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
 bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..243808e19445 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,7 +2434,7 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	return true;
 }
 
-static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+xa_mark_t wbc_to_tag(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		return PAGECACHE_TAG_TOWRITE;
-- 
2.39.5


