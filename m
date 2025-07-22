Return-Path: <linux-ext4+bounces-9155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F6B0E370
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 20:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648BC1C8212B
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E100927FD7D;
	Tue, 22 Jul 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKdlP6Vk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924226A0FD;
	Tue, 22 Jul 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208721; cv=none; b=EJNxXK8L8GI+KdnmefMkA9bQ+SJS/YB43uROY+NguuXAuGwISzjUWp+P8YjT0zibP70oeuUUeB6HjD61KjnHzCQChaaMUkyg+007Uv4ryNF8n+1xw21THYvdkon9WyyUxBXVnAaodYTaa5l1zuPKl4kYhD+fHtJeUIWiRzxEGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208721; c=relaxed/simple;
	bh=lw/PVNgk6JiADXNpaZ4RtDt4A9HvmY1ns/4gds2fZu8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YhxgWDHd9UFRp1cA7j/lFevEJwsJmUgQG3I9OlUjx2nWuE8HtrbcT2Hg/flOQLaONDfBsY/R3yasJym6oNQebWCAVbnwMg/5FZR+DIlIqyTnBYajQWuZB0FoSpcxKtKwAi0f9RAN3K28nXhsFGUETc4tNCXJshPP49SzpqNtfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKdlP6Vk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313756c602fso1097357a91.3;
        Tue, 22 Jul 2025 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208719; x=1753813519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLL4lEwI+mCKeYu22d0pbN3HCTluZ1yZGEhTKMhZHis=;
        b=JKdlP6VkP278SxNFeUoOUHK94osFHa+1qvNgejxWGTY56CtbvaWZEg9jLfDPfzpDfd
         rWdLFsdB447jxvx+20UOtKyK7gOiosBjIQrztObVi7I9Zbid/lTQcIkxTAsGJ5djTy9b
         NFkbF22sNEcLGB1xhQtBbsVgEohwNKCAykLTBVQcYmTZWZZe1XiUf3GcFn43FqwR3a59
         5+N73rBgwgJWFHf1F42+wGVyzYLWTgsp14E9tb7Q+r5Ok5UpFEHirXujznGlUmjN41x4
         LYp/9m+tKykxZBlHPCoIGU3uX07W/IvZk+8baQ9sY9tONXjcmeJprVm9olA+pTWtr7Za
         DPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208719; x=1753813519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLL4lEwI+mCKeYu22d0pbN3HCTluZ1yZGEhTKMhZHis=;
        b=c3zASOMvRr3MJh2iigiT60ywBGxeOhcy+AQk0raXRZvIyw7eOC+Jv+1Na0Mwdgb6bQ
         UUIm2odvMfMMOyuj0rtB89FYBpV4ZsJLUwnzhYUfCxkB4FaKbr0zkFyV+zXMGQUVzRSU
         IIis20jzWgC7co/h+7hLZ69AGDNAwDnyIVfQJoC9sJNdh+dWcjTeWWTVArS/7Ihc0c0l
         U5V+z+O5pmZ5bz2JpTXVMtm58+Hz0vEiwPGNvSK+etrz9nPY5tRSHJbJkTM5jaX3qxgf
         nci3QQ/RKYCYDvZdkGswIG2qTiB+IbgC2UczoJ92TWo49O+Qd8pMPHrPtWzjO2Cb40TC
         Daxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsP8tLs5+h4aLcZ6+R+xXETRqlwEnYII4Ys/fNP1VbvVmzEW8vvwIhWD9+revXmzTZJKS/gQXFCGhBg4aH@vger.kernel.org, AJvYcCWd4+wWp1CSLyucuVV/RJqfznNbrfEIlPRAz1LhnKX6hIbtEatiqSLbtuRLE06cDCCnpwXo4Mkc5Y81AGv++Q==@vger.kernel.org, AJvYcCXvnnSsN+/ehWVEUQCt962Eg7MkNdXJXZc8MQpXfop0KcpPzf3l+IjdZSgiUzutz+G9UVm699RVzLr29g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4ObjxoBV1+t0z4RndqtHkkzkqsYyHPwR7QcGN2uxWrBFXTbU
	+xSv1rwTZUS2X03tvBnQNcZDLaBtYEzwT6TQu7GOCKiVaCIexhmSGVonbQy8J7Uf
X-Gm-Gg: ASbGncsLfwGl3w0B6SGjnZGxDDRPM4jC913XjXDrVJxJlOmqXqZeWCdYcSlMsdUCvFB
	hxTAaXjXQ6E3xn9m3x8fbG6ji2qcW/mNVIkdpsvL2xSziZSRIX8YquupRxK1w+e3fukKUB40hb9
	NC0b9+8z5KibksYJC8t0tmXdtz7ugFGe4ZGwzb1wFIgQgI+iUv3hVGKeeyRm4Qgnh97ir+IYphR
	cS/SseQF7mv0kADLrZdbs1QvCAggyWMQMNnqtQARHchelLdpysGnrQ0ZEgOfet+8ggCtpD4cKt7
	wHddeM3SKjRHDD/JtPdf/pxvc83uWNqPx/u6/WwSm39my1tkOxjTTmqTVQIPJ0eYOPnKJhpm2Wy
	m+FZ+WEi5Dy9SkMBCttgl0WZCqRlMTvCOR30=
X-Google-Smtp-Source: AGHT+IEQwfCCDi1pU7VN85tIHudIY9zS4MCpivIFb9Xl3G9myZnDNIHwLBiUwmOcL5N000iJDTrt3g==
X-Received: by 2002:a17:90b:38cf:b0:311:9c9a:58e2 with SMTP id 98e67ed59e1d1-31e50857109mr127933a91.7.1753208718978;
        Tue, 22 Jul 2025 11:25:18 -0700 (PDT)
Received: from anindya-VirtualBox.. ([106.222.203.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff63376sm7391661a12.34.2025.07.22.11.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:25:18 -0700 (PDT)
From: anindya19@gmail.com
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH] bcachefs: remove extraneous ; after statements
Date: Tue, 22 Jul 2025 23:53:10 +0530
Message-ID: <20250722182310.11931-1-anindya19@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anindya Sundar Gayen <anindya19@gmail.com>

There are a couple of statements with two following semicolons, replace
these with just one semicolon.

Signed-off-by: Anindya Sundar Gayen <anindya19@gmail.com>
---
 fs/bcachefs/btree_cache.c | 2 +-
 fs/bcachefs/btree_io.c    | 2 +-
 fs/bcachefs/btree_iter.c  | 2 +-
 fs/bcachefs/btree_types.h | 2 +-
 fs/bcachefs/fast_list.h   | 2 +-
 fs/bcachefs/journal.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 83c9860e6b82..87f2d52426cc 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -517,7 +517,7 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 		if (btree_node_accessed(b)) {
 			clear_btree_node_accessed(b);
 			bc->not_freed[BCH_BTREE_CACHE_NOT_FREED_access_bit]++;
-			--touched;;
+			--touched;
 		} else if (!btree_node_reclaim(c, b)) {
 			__bch2_btree_node_hash_remove(bc, b);
 			__btree_node_data_free(b);
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 590cd29f3e86..3723c706a19a 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -2020,7 +2020,7 @@ static void btree_node_scrub_work(struct work_struct *work)
 	}
 
 	printbuf_exit(&err);
-	bch2_bkey_buf_exit(&scrub->key, c);;
+	bch2_bkey_buf_exit(&scrub->key, c);
 	btree_bounce_free(c, c->opts.btree_node_size, scrub->used_mempool, scrub->buf);
 	enumerated_ref_put(&scrub->ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scrub);
 	kfree(scrub);
diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index f8829b667ad3..4f7f7cb66c25 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -2746,7 +2746,7 @@ struct bkey_s_c bch2_btree_iter_peek_prev_min(struct btree_trans *trans, struct
 	}
 
 	/* Extents can straddle iter->pos: */
-	iter->pos = bpos_min(iter->pos, k.k->p);;
+	iter->pos = bpos_min(iter->pos, k.k->p);
 
 	if (iter->flags & BTREE_ITER_filter_snapshots)
 		iter->pos.snapshot = iter->snapshot;
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 112170fd9c8f..3e98b6e383ba 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -483,7 +483,7 @@ typedef DARRAY(struct trans_kmalloc_trace) darray_trans_kmalloc_trace;
 struct btree_trans_subbuf {
 	u16			base;
 	u16			u64s;
-	u16			size;;
+	u16			size;
 };
 
 struct btree_trans {
diff --git a/fs/bcachefs/fast_list.h b/fs/bcachefs/fast_list.h
index 73c9bf591fd6..f67df3f72ee2 100644
--- a/fs/bcachefs/fast_list.h
+++ b/fs/bcachefs/fast_list.h
@@ -9,7 +9,7 @@ struct fast_list_pcpu;
 
 struct fast_list {
 	GENRADIX(void *)	items;
-	struct ida		slots_allocated;;
+	struct ida		slots_allocated;
 	struct fast_list_pcpu __percpu
 				*buffer;
 };
diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index f22b05e02c1e..9b5fc538dc5a 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1321,7 +1321,7 @@ int bch2_dev_journal_bucket_delete(struct bch_dev *ca, u64 b)
 		return -EINVAL;
 	}
 
-	u64 *new_buckets = kcalloc(ja->nr, sizeof(u64), GFP_KERNEL);;
+	u64 *new_buckets = kcalloc(ja->nr, sizeof(u64), GFP_KERNEL);
 	if (!new_buckets)
 		return bch_err_throw(c, ENOMEM_set_nr_journal_buckets);
 
-- 
2.43.0


