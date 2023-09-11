Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E179B26C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 01:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjIKVUb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjIKJuL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 05:50:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAAEE4A
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 02:49:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3c4eafe95so468795ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425783; x=1695030583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp6alE9W8p4SLI20jnJ2OSu/Y8SjbH33H7WP/Pdn6m8=;
        b=VoUZKMEDW2W414wGU1P6fbLrHCDwlQ7zD6cVoOO1ReMyScuMJPZYWLJaZqunxzzH9o
         /myjtS5oS/aULaqfc7UFkenGCiV4gXhX4asSdbOIP0LHeT/zkFQi2OXrm+jCWhEzuI76
         pqZmsfLI27L8B8c9etV0gyBXS8IxK9if2Ib2RuIy4e2YZJ9Ah7uJtwpM33s8aFUvgF0X
         BdGGFWXAit253oOVEoxizAybyAa46WDdKSp/gzuMnsmPr5qqq/VNOVi+wv/LGFJmwDcy
         V4+vHiEDRVFKfBcOgg9DqNl4C6xd2lc2iqvVFqKNfOJzTao/hKxVXW+tnrw8uUFwzsul
         I8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425783; x=1695030583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp6alE9W8p4SLI20jnJ2OSu/Y8SjbH33H7WP/Pdn6m8=;
        b=Wc506G/+nOHOJsUimBUo9oV/pW4TZ+tjVPlSGxcnoPX8cfdjP0urzsFljyREyAaTVA
         u6RhdXTp898EL7+hgjiCsGcNUhU3f1pKL8eMkjEHx12V1f5eTg9yOZb175noQ1knE+jJ
         29q782sTHRDYXMnQtvwOXZOSO5j9IHSlzrnaZNZb4OTXP7/hxcFR0pUi8zNb1ekORj+S
         G/RYN5y+y8012tJG8ADSQX2TEWAcvWtbiG9MLbihiGVBaz8w8HyUzG43wde61RYXdBIP
         0ukTX6F5yvvP88FD3DbxJIw2ygfbXDBeM3n6ZDZljjTgRlrHyfhI6Qv+SiLYEp9pmnxR
         dhcg==
X-Gm-Message-State: AOJu0Ywd2BAq1UukP+KUDcmC/aJ1kEEnLOh9DjuEZfK0Mr+7eg3NVS3z
        R800m87Tulz6ciXbUoNDxSgOig==
X-Google-Smtp-Source: AGHT+IEjw6f3kkK4YeAJ1yQh6xNTwLMG2bfCuz4XubHO4qI41qrhKwsBTZY5Hpn7PFnzgf8StICGRQ==
X-Received: by 2002:a17:902:d645:b0:1c3:c687:478a with SMTP id y5-20020a170902d64500b001c3c687478amr331484plh.2.1694425783678;
        Mon, 11 Sep 2023 02:49:43 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:49:43 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v6 30/45] ext4: dynamically allocate the ext4-es shrinker
Date:   Mon, 11 Sep 2023 17:44:29 +0800
Message-Id: <20230911094444.68966-31-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the ext4-es shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct ext4_sb_info.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: "Theodore Ts'o" <tytso@mit.edu>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h           |  2 +-
 fs/ext4/extents_status.c | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..8eeff770992c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1653,7 +1653,7 @@ struct ext4_sb_info {
 	__u32 s_csum_seed;
 
 	/* Reclaim extents from extent status tree */
-	struct shrinker s_es_shrinker;
+	struct shrinker *s_es_shrinker;
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6f7de14c0fa8..deec7d1f4e50 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1606,7 +1606,7 @@ static unsigned long ext4_es_count(struct shrinker *shrink,
 	unsigned long nr;
 	struct ext4_sb_info *sbi;
 
-	sbi = container_of(shrink, struct ext4_sb_info, s_es_shrinker);
+	sbi = shrink->private_data;
 	nr = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_count(sbi->s_sb, sc->nr_to_scan, nr);
 	return nr;
@@ -1615,8 +1615,7 @@ static unsigned long ext4_es_count(struct shrinker *shrink,
 static unsigned long ext4_es_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct ext4_sb_info *sbi = container_of(shrink,
-					struct ext4_sb_info, s_es_shrinker);
+	struct ext4_sb_info *sbi = shrink->private_data;
 	int nr_to_scan = sc->nr_to_scan;
 	int ret, nr_shrunk;
 
@@ -1700,13 +1699,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 	if (err)
 		goto err3;
 
-	sbi->s_es_shrinker.scan_objects = ext4_es_scan;
-	sbi->s_es_shrinker.count_objects = ext4_es_count;
-	sbi->s_es_shrinker.seeks = DEFAULT_SEEKS;
-	err = register_shrinker(&sbi->s_es_shrinker, "ext4-es:%s",
-				sbi->s_sb->s_id);
-	if (err)
+	sbi->s_es_shrinker = shrinker_alloc(0, "ext4-es:%s", sbi->s_sb->s_id);
+	if (!sbi->s_es_shrinker) {
+		err = -ENOMEM;
 		goto err4;
+	}
+
+	sbi->s_es_shrinker->scan_objects = ext4_es_scan;
+	sbi->s_es_shrinker->count_objects = ext4_es_count;
+	sbi->s_es_shrinker->private_data = sbi;
+
+	shrinker_register(sbi->s_es_shrinker);
 
 	return 0;
 err4:
@@ -1726,7 +1729,7 @@ void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-	unregister_shrinker(&sbi->s_es_shrinker);
+	shrinker_free(sbi->s_es_shrinker);
 }
 
 /*
-- 
2.30.2

