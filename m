Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B424C9B6
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHUBzs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHUBzc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7FC061388
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so134934pjx.5
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vk5A4dTc4mGtA0JH1YwBNe7+/X0GksGGdREjv/oASNo=;
        b=ch+JWD65tF8gzfD+cLdhD1YcebtljUeW7WaFnqG16KaaMEFV9uHyjNRIR1a2EGSMn2
         emgnC+E7zNxTqzwJ0XW/vwWFCVu4dj0eGZ9ZoJb2CL/6haNO55Jz/UzSOSuEuDRipO9k
         rduAU8k7YOvRVj+i04zfrkWccoTM+bwWiw4sKG6XPZkTXhWZ2OPdaz+NLMtw8bAyKCex
         aUVXGjM6Qkvt9av44FcyxlWPbIA735fsBAMwiR6Y5J4dWjQhLVT8e89ekDyPDY8os8uB
         YeybOni12VjRyWopEfixy0eLraxMO1nafkQakPHeR3xOuX2jEr+lgdW3EWFcndJwRaQX
         HqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vk5A4dTc4mGtA0JH1YwBNe7+/X0GksGGdREjv/oASNo=;
        b=plQP/VrJrGRAsVTUJlMZAcwkzVmLLuOCpWsQkYAQ01bBebRNGOUmqPRBTT/QwoYUVX
         chQ0yQdtRa4Bnv6uRaTBwmerrdRqgrPsnxi2pCq6jVTv9bujocNQwuDY6+SHJuO0hcWG
         uCJ2tg7cQOtVpIa8eBb8Wfvnu4yqfZIe5rFyg+uDCEMScu22CNBhWeZg+cuAwOEGbDAQ
         oF168N03qSTvYX1oPXKQbpgxJDTJ8U6fJ4xGBwTURBHGxlD4fFu6k/YuYjrLW6OEbkQp
         Xlfk2Z/tP8sEy2y0XQxjFTGsrIhc/B4ou517px1p9YRZEqyUOpcd9nDY+/KE++ChxFX5
         HP1Q==
X-Gm-Message-State: AOAM533cHQb2JhSqWTFs7O1IOWlA6PEZYq7Ju/oWYVOMrcIHd0UM4lqw
        unrWcQNCxRa0qZk1j87IV4nbFjOoaVo=
X-Google-Smtp-Source: ABdhPJw0LvCRc1ez5V38PHqg2ogRaifj71mzcLXfidmF8+gDMDmQ1e05sz5Z0dsG7jJ/P+x8FonKKg==
X-Received: by 2002:a17:902:a70d:: with SMTP id w13mr606668plq.94.1597974930883;
        Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 2/9] ext4: rename ext4_mb_load_buddy to ext4_mb_load_allocator
Date:   Thu, 20 Aug 2020 18:55:16 -0700
Message-Id: <20200821015523.1698374-3-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
index 132c118d12e1..48d791304bf1 100644
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
@@ -1293,13 +1294,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
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
@@ -1859,7 +1860,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 	int err;
 
 	BUG_ON(ex.fe_len <= 0);
-	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
+	err = ext4_mb_load_allocator(ac->ac_sb, group, e4b, 0);
 	if (err)
 		return err;
 
@@ -1872,7 +1873,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 	}
 
 	ext4_unlock_group(ac->ac_sb, group);
-	ext4_mb_unload_buddy(e4b);
+	ext4_mb_unload_allocator(e4b);
 
 	return 0;
 }
@@ -1893,12 +1894,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
 
@@ -1936,7 +1937,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 	ext4_unlock_group(ac->ac_sb, group);
-	ext4_mb_unload_buddy(e4b);
+	ext4_mb_unload_allocator(e4b);
 
 	return 0;
 }
@@ -2417,7 +2418,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				continue;
 			}
 
-			err = ext4_mb_load_buddy(sb, group, &e4b);
+			err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 			if (err)
 				goto out;
 
@@ -2430,7 +2431,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ret = ext4_mb_good_group(ac, group, cr);
 			if (ret == 0) {
 				ext4_unlock_group(sb, group);
-				ext4_mb_unload_buddy(&e4b);
+				ext4_mb_unload_allocator(&e4b);
 				continue;
 			}
 
@@ -2444,7 +2445,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				ext4_mb_complex_scan_group(ac, &e4b);
 
 			ext4_unlock_group(sb, group);
-			ext4_mb_unload_buddy(&e4b);
+			ext4_mb_unload_allocator(&e4b);
 
 			if (ac->ac_status != AC_STATUS_CONTINUE)
 				break;
@@ -2543,7 +2544,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	grinfo = ext4_get_group_info(sb, group);
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
-		err = ext4_mb_load_buddy(sb, group, &e4b);
+		err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 		if (err) {
 			seq_printf(seq, "#%-5u: I/O error\n", group);
 			return 0;
@@ -2554,7 +2555,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	memcpy(&sg, ext4_get_group_info(sb, group), i);
 
 	if (buddy_loaded)
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 
 	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
 			sg.info.bb_fragments, sg.info.bb_first_free);
@@ -3049,7 +3050,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
 		 entry->efd_count, entry->efd_group, entry);
 
-	err = ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
+	err = ext4_mb_load_allocator(sb, entry->efd_group, &e4b, 0);
 	/* we expect to find existing buddy because it's pinned */
 	BUG_ON(err != 0);
 
@@ -3084,7 +3085,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	}
 	ext4_unlock_group(sb, entry->efd_group);
 	kmem_cache_free(ext4_free_data_cachep, entry);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	mb_debug(sb, "freed %d blocks in %d structures\n", count,
 		 count2);
@@ -3558,12 +3559,13 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
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
@@ -3572,7 +3574,7 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 		mb_free_blocks(ac->ac_inode, &e4b, ac->ac_f_ex.fe_start,
 			       ac->ac_f_ex.fe_len);
 		ext4_unlock_group(ac->ac_sb, ac->ac_f_ex.fe_group);
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		return;
 	}
 	if (pa->pa_type == MB_INODE_PA)
@@ -4175,7 +4177,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		goto out_dbg;
 	}
 
-	err = ext4_mb_load_buddy(sb, group, &e4b);
+	err = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (err) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
@@ -4250,7 +4252,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 
 out:
 	ext4_unlock_group(sb, group);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
 	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
@@ -4347,8 +4349,8 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_allocator_gfp(sb, group, &e4b,
+						GFP_NOFS|__GFP_NOFAIL, 0);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -4360,7 +4362,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 			err = PTR_ERR(bitmap_bh);
 			ext4_error_err(sb, -err, "Error %d reading block bitmap for %u",
 				       err, group);
-			ext4_mb_unload_buddy(&e4b);
+			ext4_mb_unload_allocator(&e4b);
 			continue;
 		}
 
@@ -4369,7 +4371,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		ext4_mb_release_inode_pa(&e4b, bitmap_bh, pa);
 		ext4_unlock_group(sb, group);
 
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		put_bh(bitmap_bh);
 
 		list_del(&pa->u.pa_tmp_list);
@@ -4642,8 +4644,8 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		int err;
 
 		group = ext4_get_group_number(sb, pa->pa_pstart);
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_allocator_gfp(sb, group, &e4b,
+						GFP_NOFS|__GFP_NOFAIL, 0);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -4654,7 +4656,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		ext4_mb_release_group_pa(&e4b, pa);
 		ext4_unlock_group(sb, group);
 
-		ext4_mb_unload_buddy(&e4b);
+		ext4_mb_unload_allocator(&e4b);
 		list_del(&pa->u.pa_tmp_list);
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
@@ -5241,8 +5243,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
 
 	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
-	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
-				     GFP_NOFS|__GFP_NOFAIL);
+	err = ext4_mb_load_allocator_gfp(sb, block_group, &e4b,
+					GFP_NOFS|__GFP_NOFAIL, 0);
 	if (err)
 		goto error_return;
 
@@ -5316,7 +5318,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 				   count_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -5434,7 +5436,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		}
 	}
 
-	err = ext4_mb_load_buddy(sb, block_group, &e4b);
+	err = ext4_mb_load_allocator(sb, block_group, &e4b, 0);
 	if (err)
 		goto error_return;
 
@@ -5462,7 +5464,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 						  flex_group)->free_clusters);
 	}
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -5550,7 +5552,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
-	ret = ext4_mb_load_buddy(sb, group, &e4b);
+	ret = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (ret) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     ret, group);
@@ -5604,7 +5606,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	}
 out:
 	ext4_unlock_group(sb, group);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
 		count, group);
@@ -5718,7 +5720,7 @@ ext4_mballoc_query_range(
 	struct ext4_buddy		e4b;
 	int				error;
 
-	error = ext4_mb_load_buddy(sb, group, &e4b);
+	error = ext4_mb_load_allocator(sb, group, &e4b, 0);
 	if (error)
 		return error;
 	bitmap = e4b.bd_bitmap;
@@ -5747,7 +5749,7 @@ ext4_mballoc_query_range(
 
 	ext4_unlock_group(sb, group);
 out_unload:
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_allocator(&e4b);
 
 	return error;
 }
-- 
2.28.0.297.g1956fa8f8d-goog

