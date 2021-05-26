Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AE391297
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhEZIpK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhEZIpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:45:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EFC061760;
        Wed, 26 May 2021 01:43:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso5052pjb.0;
        Wed, 26 May 2021 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kis25+buAxmOPJmdbeTmrskSftALM8UjFJM551XPpXQ=;
        b=Gog1hNNtPhESMXt/cHypr8UAUtbI0JJ1dA8NY171oT+EgXYr99q+s+7MaO0Oi1AusK
         C3lswGj0/9jFqtRivQARXtNXW7W6F3iDySPtr0XZjTQOpidlPTQuI8JLYeDIc/OvNbGe
         ToRXA9QdbecaKtO5xvydIxUzu1KEDSHs5iFMTZduJxTELpPJ0XniSJJ3fTkdrLoDoGK3
         OUQ5S4Qws0Shm9eYhV42lfMMjHfGzKR/v1sxrxSr50Rpj04GliF+fsTRNTSMdtd157oe
         KeJ03nUSn8uHnXHfBgM50YY2veqFx7KKFCF0VqgtHMqJA9AlENN96SZi7cSe2gQtvuN4
         lMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kis25+buAxmOPJmdbeTmrskSftALM8UjFJM551XPpXQ=;
        b=iKwoJn2qYoih9EatwUN044cnlhj4jsSas1WMWvnDteWMuLPvd1JKnBSDjbT3j9iuQi
         iqqoWwnNdQNt6/AXXRHa6MuovK0VfT9HfFp6vUCssSHowhAL/ysf64lA4qn5g+xOlUPv
         jZN8T2MtC/z7u9ldLQtM8gMycf0TdAn7y7eHf3tojBpwTqP7mgeOkhHqNLemUxOizm5l
         H3us3VeKBx0zwObVVEqb6FOfH0qrb/BNf9JGfwNsOLOkO7qKylykw85r5Ae3EuD/Kcw3
         NsPDLdEOCyswekNIcKhhNNDHN+y/w/tV8+fhpIPxNayYSa+i38EmsUIi+OQfUjn2nOHL
         TnMA==
X-Gm-Message-State: AOAM533tqCvmv+k6Otgv9ORD9GaoLblXvaks+J2ph7JsRNu/M/A5bMME
        3ejpkIewj48V8SYRucdUfgA=
X-Google-Smtp-Source: ABdhPJyBHpgEGyFdxydmpVS7LlONsSH2wlaiyzyvm7xA3SgTC1ECHf2DMHzHfU67nCMAA2Lvta1BRQ==
X-Received: by 2002:a17:902:c406:b029:ef:7ba2:f308 with SMTP id k6-20020a170902c406b02900ef7ba2f308mr35220795plk.9.1622018616757;
        Wed, 26 May 2021 01:43:36 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id k186sm15747268pgk.82.2021.05.26.01.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:36 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 4/7] ext4: add new helper interface ext4_insert_free_data
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
Message-ID: <83fab578-b170-c515-d514-1ed366f07e8a@gmail.com>
Date:   Wed, 26 May 2021 16:43:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Split the codes that inserts and merges ext4_free_data structures
into a new interface ext4_insert_free_data. This is preparing for
following async background discard.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 96 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 85418cf..16f06d2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -350,6 +350,12 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
+static inline struct ext4_free_data *efd_entry(struct rb_node *n)
+{
+	return rb_entry_safe(n, struct ext4_free_data, efd_node);
+}
+static int ext4_insert_free_data(struct ext4_sb_info *sbi,
+		struct rb_root *root, struct ext4_free_data *nfd);
 
 /*
  * The algorithm using this percpu seq counter goes below:
@@ -5069,28 +5075,53 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 	kmem_cache_free(ext4_free_data_cachep, entry);
 }
 
+static int ext4_insert_free_data(struct ext4_sb_info *sbi,
+		struct rb_root *root, struct ext4_free_data *nfd)
+{
+	struct rb_node **n = &root->rb_node;
+	struct rb_node *p = NULL;
+	struct ext4_free_data *fd;
+
+	while (*n) {
+		p = *n;
+		fd = rb_entry(p, struct ext4_free_data, efd_node);
+		if (nfd->efd_start_cluster < fd->efd_start_cluster)
+			n = &(*n)->rb_left;
+		else if (nfd->efd_start_cluster >=
+			 (fd->efd_start_cluster + fd->efd_count))
+			n = &(*n)->rb_right;
+		else
+			return -EINVAL;
+	}
+
+	rb_link_node(&nfd->efd_node, p, n);
+	rb_insert_color(&nfd->efd_node, root);
+
+	/* Now try to see the extent can be merged to left and right */
+	fd = efd_entry(rb_prev(&nfd->efd_node));
+	if (fd)
+		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
+
+	fd = efd_entry(rb_next(&nfd->efd_node));
+	if (fd)
+		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
+
+	return 0;
+}
+
 static noinline_for_stack int
 ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
-		      struct ext4_free_data *new_entry)
+		      struct ext4_free_data *nfd)
 {
-	ext4_group_t group = e4b->bd_group;
-	ext4_grpblk_t cluster;
-	ext4_grpblk_t clusters = new_entry->efd_count;
-	struct ext4_free_data *entry;
 	struct ext4_group_info *db = e4b->bd_info;
 	struct super_block *sb = e4b->bd_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct rb_node **n = &db->bb_free_root.rb_node, *node;
-	struct rb_node *parent = NULL, *new_node;
 
 	BUG_ON(!ext4_handle_valid(handle));
 	BUG_ON(e4b->bd_bitmap_page == NULL);
 	BUG_ON(e4b->bd_buddy_page == NULL);
 
-	new_node = &new_entry->efd_node;
-	cluster = new_entry->efd_start_cluster;
-
-	if (!*n) {
+	if (!db->bb_free_root.rb_node) {
 		/* first free block exent. We need to
 		   protect buddy cache from being freed,
 		 * otherwise we'll refresh it from
@@ -5099,44 +5130,19 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 		get_page(e4b->bd_buddy_page);
 		get_page(e4b->bd_bitmap_page);
 	}
-	while (*n) {
-		parent = *n;
-		entry = rb_entry(parent, struct ext4_free_data, efd_node);
-		if (cluster < entry->efd_start_cluster)
-			n = &(*n)->rb_left;
-		else if (cluster >= (entry->efd_start_cluster + entry->efd_count))
-			n = &(*n)->rb_right;
-		else {
-			ext4_grp_locked_error(sb, group, 0,
-				ext4_group_first_block_no(sb, group) +
-				EXT4_C2B(sbi, cluster),
-				"Block already on to-be-freed list");
-			kmem_cache_free(ext4_free_data_cachep, new_entry);
-			return 0;
-		}
-	}
-
-	rb_link_node(new_node, parent, n);
-	rb_insert_color(new_node, &db->bb_free_root);
-
-	/* Now try to see the extent can be merged to left and right */
-	node = rb_prev(new_node);
-	if (node) {
-		entry = rb_entry(node, struct ext4_free_data, efd_node);
-		ext4_try_merge_freed_extent(sbi, entry, new_entry,
-					    &(db->bb_free_root));
-	}
 
-	node = rb_next(new_node);
-	if (node) {
-		entry = rb_entry(node, struct ext4_free_data, efd_node);
-		ext4_try_merge_freed_extent(sbi, entry, new_entry,
-					    &(db->bb_free_root));
+	if (ext4_insert_free_data(sbi, &db->bb_free_root, nfd)) {
+		ext4_grp_locked_error(sb, e4b->bd_group, 0,
+				ext4_group_first_block_no(sb, e4b->bd_group) +
+				EXT4_C2B(sbi, nfd->efd_start_cluster),
+				"Block already on to-be-freed list");
+		kmem_cache_free(ext4_free_data_cachep, nfd);
+		return 0;
 	}
 
 	spin_lock(&sbi->s_md_lock);
-	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
-	sbi->s_mb_free_pending += clusters;
+	list_add_tail(&nfd->efd_list, &sbi->s_freed_data_list);
+	sbi->s_mb_free_pending += nfd->efd_count;
 	spin_unlock(&sbi->s_md_lock);
 	return 0;
 }
-- 
1.8.3.1

