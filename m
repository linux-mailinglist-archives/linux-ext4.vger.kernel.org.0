Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12191249778
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHSHb0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHSHbT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA97C061342
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so11224267pfl.11
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6moglGyrbbQvHUWa3UbkPor8/IRoDYRkAhaqQdhOwsM=;
        b=bAcMNkAOIH6lYUt98og3209p3PpIYYWRBFi8VmeOmpCxlot1Iwg2VgeLSezPCNg69c
         Os3pQJh3jbs2HluPXjkV+lYrPKlpCGN0VbWwcVJj3neb+n3ArtOpWWSDW9QfSQGsnemH
         VNEgw2qhNblGjPpbMbzFeIQ+KOta9WKaefZ4v8h0NZLEy3mTHT8t9Yp5n38KEC1pCyP6
         gRJpnVS/kPh3x10lvLUIfRvGEg3WqKzYLpIjz8oQbZWIGe5moT6g/pPWhdsCQQCYOEtq
         u7ACzqxOafG47eqzl2305ByAm//7/XO00vJ7Om+fZ3ih1e8mkna3q0VD4hB5zFs1ZN4w
         1dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6moglGyrbbQvHUWa3UbkPor8/IRoDYRkAhaqQdhOwsM=;
        b=CF7sb2Uyz6nLB+IXkkUMv61CSdvwJwqBjvpJHSwwTnqD11OwerheosaDdh3u/PUJuQ
         B3kqe9mKx51WHjNERxR9ZNmhN8LnPgWlP5kM/fTRPTQxLS2Uw1lioGD6kRGTXn1eEseS
         z5l/8K1MSytxwMhAYnqGgQNFT55FGZv72IjTRKOXfwW9Jei3pz15OVj5iM5amolL7wl0
         e6VXYKi2APpwX2IZhoSi2vywfbkce2Kp4mkO3wJjZBBM1PWY60x0RXS39PGbR7DB7LiE
         Wh8Z68a0rhWuSrW2dG41P07Oyg5qZ8/C2OzF8JHMDsIJ9KIhbYds0EhlPOPM2inepCiC
         SRPw==
X-Gm-Message-State: AOAM532NKb+IlN64R0ANKoYQhA1l+Uf6RUDvxyTend9ccS9LPSF7ng1N
        CTJbPyIc2U1IyQcVR39etzoe/GFaWak=
X-Google-Smtp-Source: ABdhPJy2PZYWT1TegFr27pFFQ5ko/JxRihAnneBgfCY5gVXCNcaPxaKIZda7qo9xXYQzDbmcxNxP1A==
X-Received: by 2002:aa7:97b7:: with SMTP id d23mr17894209pfq.264.1597822278268;
        Wed, 19 Aug 2020 00:31:18 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/9] ext4: rename ext4_mb_load_buddy to ext4_mb_load_allocator
Date:   Wed, 19 Aug 2020 00:30:57 -0700
Message-Id: <20200819073104.1141705-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch renames ext4_mb_load_buddy and ext4_mb_unload_buddy to
ext4_mb_load_allocator and ext4_mb_unload_allocator. Also, we add a
flag argument to ext4_mb_load_allocator function which is currently
unused. This patch helps reduce the size of the following patch "ext4:
add freespace tree allocator" significantly. In the interest of
keeping this patchset shorter, I have not renamed ext4_buddy structure
and e4b variable names. But have added that as a TODO item.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c | 86 ++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 47de61e44db2..2d8d3d9c7918 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -29,6 +29,7 @@
  *   - don't normalize tails
  *   - quota
  *   - reservation for superuser
+ *   - rename ext4_buddy to ext4_allocator and e4b variables to allocator
  *
  * TODO v3:
  *   - bitmap read-ahead (proposed by Oleg Drokin aka green)
@@ -92,7 +93,7 @@
  * mapped to the buddy and bitmap information regarding different
  * groups. The buddy information is attached to buddy cache inode so that
  * we can access them through the page cache. The information regarding
- * each group is loaded via ext4_mb_load_buddy.  The information involve
+ * each group is loaded via ext4_mb_load_allocator.  The information involve
  * block bitmap and buddy information. The information are stored in the
  * inode as:
  *
@@ -845,7 +846,7 @@ static void mb_regenerate_buddy(struct ext4_buddy *e4b)
 
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
- * is loaded via ext4_mb_load_buddy. The information involve
+ * is loaded via ext4_mb_load_allocator. The information involve
  * block bitmap and buddy information. The information are
  * stored in the inode as
  *
@@ -1105,7 +1106,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	 * This ensures that we don't reinit the buddy cache
 	 * page which map to the group from which we are already
 	 * allocating. If we are looking at the buddy cache we would
-	 * have taken a reference using ext4_mb_load_buddy and that
+	 * have taken a reference using ext4_mb_load_allocator and that
 	 * would have pinned buddy page to page cache.
 	 * The call to ext4_mb_get_buddy_page_lock will mark the
 	 * page accessed.
@@ -1157,8 +1158,8 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
  * calling this routine!
  */
 static noinline_for_stack int
-ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
-		       struct ext4_buddy *e4b, gfp_t gfp)
+ext4_mb_load_allocator_gfp(struct super_block *sb, ext4_group_t group,
+				struct ext4_buddy *e4b, gfp_t gfp, int flags)
 {
 	int blocks_per_page;
 	int block;
@@ -1296,13 +1297,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	return ret;
 }
 
-static int ext4_mb_load_buddy(struct super_block *sb, ext4_group_t group,
-			      struct ext4_buddy *e4b)
+static int ext4_mb_load_allocator(struct super_block *sb, ext4_group_t group,
+			      struct ext4_buddy *e4b, int flags)
 {
-	return ext4_mb_load_buddy_gfp(sb, group, e4b, GFP_NOFS);
+	return ext4_mb_load_allocator_gfp(sb, group, e4b, GFP_NOFS, flags);
 }
 
-static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
+static void ext4_mb_unload_allocator(struct ext4_buddy *e4b)
 {
 	if (e4b->bd_bitmap_page)
 		put_page(e4b->bd_bitmap_page);
@@ -1866,7 +1867,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 	int err;
 
 	BUG_ON(ex.fe_len <= 0);
-	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
+	err = ext4_mb_load_allocator(ac->ac_sb, group, e4b, 0);
 	if (err)
 		return err;
 
@@ -1879,7 +1880,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 	}
 
 	ext4_unlock_group(ac->ac_sb, group);
-	ext4_mb_unload_buddy(e4b);
+	ext4_mb_unload_allocator(e4b);
 
 	return 0;
 }
@@ -1900,12 +1901,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (grp->bb_free == 0)
 		return 0;
 
-	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
+	err = ext4_mb_load_allocator(ac->ac_sb, group, e4b, 0);
 	if (err)
 		return err;
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
-		ext4_mb_unload_buddy(e4b);
+		ext4_mb_unload_allocator(e4b);
 		return 0;
 	}
 
@@ -1943,7 +1944,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 	ext4_unlock_group(ac->ac_sb, group);
-	ext4_mb_unload_buddy(e4b);
+	ext4_mb_unload_allocator(e4b);
 
 	return 0;
 }
@@ -2424,7 +2425,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				continue;
 			}
 
-			err = ext4_mb_load_buddy(sb, group, &e4b);
+			err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 			if (err)
 				goto out;
 
@@ -2437,7 +2438,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ret = ext4_mb_good_group(ac, group, cr);
 			if (ret == 0) {
 				ext4_unlock_group(sb, group);
-				ext4_mb_unload_buddy(&e4b);
+				ext4_mb_unload_allocator(&e4b);
 				continue;
 			}
 
@@ -2451,7 +2452,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				ext4_mb_complex_scan_group(ac, &e4b);
 
 			ext4_unlock_group(sb, group);
-			ext4_mb_unload_buddy(&e4b);
+			ext4_mb_unload_allocator(&e4b);
 
 			if (ac->ac_status != AC_STATUS_CONTINUE)
 				break;
@@ -2548,7 +2549,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	grinfo = ext4_get_group_info(sb, group);
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
-		err = ext4_mb_load_buddy(sb, group, &e4b);
+		err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 		if (err) {
 			seq_printf(seq, "#%-5u: I/O error\n", group);
 			return 0;
@@ -2559,7 +2560,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	memcpy(&sg, ext4_get_group_info(sb, group), i);
 
 	if (buddy_loaded)
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 
 	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
 			sg.info.bb_fragments, sg.info.bb_first_free);
@@ -3053,7 +3054,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
 		 entry->efd_count, entry->efd_group, entry);
 
-	err = ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
+	err = ext4_mb_load_allocator(sb, entry->efd_group, &e4b, 0);
 	/* we expect to find existing buddy because it's pinned */
 	BUG_ON(err != 0);
 
@@ -3088,7 +3089,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	}
 	ext4_unlock_group(sb, entry->efd_group);
 	kmem_cache_free(ext4_free_data_cachep, entry);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	mb_debug(sb, "freed %d blocks in %d structures\n", count,
 		 count2);
@@ -3562,12 +3563,13 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 	if (pa == NULL) {
 		if (ac->ac_f_ex.fe_len == 0)
 			return;
-		err = ext4_mb_load_buddy(ac->ac_sb, ac->ac_f_ex.fe_group, &e4b);
+		err = ext4_mb_load_allocator(ac->ac_sb, ac->ac_f_ex.fe_group,
+						&e4b, 0);
 		if (err) {
 			/*
 			 * This should never happen since we pin the
 			 * pages in the ext4_allocation_context so
-			 * ext4_mb_load_buddy() should never fail.
+			 * ext4_mb_load_allocator() should never fail.
 			 */
 			WARN(1, "mb_load_buddy failed (%d)", err);
 			return;
@@ -3576,7 +3578,7 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 		mb_free_blocks(ac->ac_inode, &e4b, ac->ac_f_ex.fe_start,
 			       ac->ac_f_ex.fe_len);
 		ext4_unlock_group(ac->ac_sb, ac->ac_f_ex.fe_group);
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		return;
 	}
 	if (pa->pa_type == MB_INODE_PA)
@@ -4158,7 +4160,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		goto out_dbg;
 	}
 
-	err = ext4_mb_load_buddy(sb, group, &e4b);
+	err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (err) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
@@ -4233,7 +4235,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 
 out:
 	ext4_unlock_group(sb, group);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
 	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
@@ -4325,8 +4327,8 @@ void ext4_discard_preallocations(struct inode *inode)
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_allocator_gfp(sb, group, &e4b,
+						GFP_NOFS|__GFP_NOFAIL, 0);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -4338,7 +4340,7 @@ void ext4_discard_preallocations(struct inode *inode)
 			err = PTR_ERR(bitmap_bh);
 			ext4_error_err(sb, -err, "Error %d reading block bitmap for %u",
 				       err, group);
-			ext4_mb_unload_buddy(&e4b);
+			ext4_mb_unload_allocator(&e4b);
 			continue;
 		}
 
@@ -4347,7 +4349,7 @@ void ext4_discard_preallocations(struct inode *inode)
 		ext4_mb_release_inode_pa(&e4b, bitmap_bh, pa);
 		ext4_unlock_group(sb, group);
 
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		put_bh(bitmap_bh);
 
 		list_del(&pa->u.pa_tmp_list);
@@ -4620,8 +4622,8 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		int err;
 
 		group = ext4_get_group_number(sb, pa->pa_pstart);
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_allocator_gfp(sb, group, &e4b,
+						GFP_NOFS|__GFP_NOFAIL, 0);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -4632,7 +4634,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		ext4_mb_release_group_pa(&e4b, pa);
 		ext4_unlock_group(sb, group);
 
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		list_del(&pa->u.pa_tmp_list);
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
@@ -5189,8 +5191,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
 
 	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
-	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
-				     GFP_NOFS|__GFP_NOFAIL);
+	err = ext4_mb_load_allocator_gfp(sb, block_group, &e4b,
+					GFP_NOFS|__GFP_NOFAIL, 0);
 	if (err)
 		goto error_return;
 
@@ -5264,7 +5266,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 				   count_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -5382,7 +5384,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		}
 	}
 
-	err = ext4_mb_load_buddy(sb, block_group, &e4b);
+	err = ext4_mb_load_allocator(sb, block_group, &e4b, 0);
 	if (err)
 		goto error_return;
 
@@ -5410,7 +5412,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 						  flex_group)->free_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -5498,7 +5500,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
-	ret = ext4_mb_load_buddy(sb, group, &e4b);
+	ret = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (ret) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     ret, group);
@@ -5552,7 +5554,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	}
 out:
 	ext4_unlock_group(sb, group);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
 		count, group);
@@ -5666,7 +5668,7 @@ ext4_mballoc_query_range(
 	struct ext4_buddy		e4b;
 	int				error;
 
-	error = ext4_mb_load_buddy(sb, group, &e4b);
+	error = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (error)
 		return error;
 	bitmap = e4b.bd_bitmap;
@@ -5695,7 +5697,7 @@ ext4_mballoc_query_range(
 
 	ext4_unlock_group(sb, group);
 out_unload:
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	return error;
 }
-- 
2.28.0.220.ged08abb693-goog

