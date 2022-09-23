Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9545E7158
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIWBWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 21:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIWBWM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 21:22:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D20F8C0F;
        Thu, 22 Sep 2022 18:22:10 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYZ5h0LtQz1P6nG;
        Fri, 23 Sep 2022 09:18:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 09:22:08 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: factor out ext4_free_ext_path()
Date:   Fri, 23 Sep 2022 09:32:54 +0800
Message-ID: <20220923013254.3581264-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_free_ext_path(). No functional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4.h           |  6 ++++
 fs/ext4/extents.c        | 75 ++++++++++++++--------------------------
 fs/ext4/extents_status.c |  3 +-
 fs/ext4/fast_commit.c    |  6 ++--
 fs/ext4/migrate.c        |  3 +-
 fs/ext4/move_extent.c    |  9 ++---
 fs/ext4/verity.c         |  6 ++--
 7 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e6674504ca2a..0583e5c8d395 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3786,6 +3786,12 @@ extern void ext4_orphan_file_block_trigger(
 				struct buffer_head *bh,
 				void *data, size_t size);
 
+static inline void ext4_free_ext_path(struct ext4_ext_path *path)
+{
+	ext4_ext_drop_refs(path);
+	kfree(path);
+}
+
 /*
  * Add new method to test whether block and inode bitmaps are properly
  * initialized. With uninit_bg reading the block from disk is not enough
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..60ff1a764f52 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -632,8 +632,7 @@ int ext4_ext_precache(struct inode *inode)
 	ext4_set_inode_state(inode, EXT4_STATE_EXT_PRECACHED);
 out:
 	up_read(&ei->i_data_sem);
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	return ret;
 }
 
@@ -951,8 +950,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	return path;
 
 err:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	if (orig_path)
 		*orig_path = NULL;
 	return ERR_PTR(ret);
@@ -2170,8 +2168,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
 
 cleanup:
-	ext4_ext_drop_refs(npath);
-	kfree(npath);
+	ext4_free_ext_path(npath);
 	return err;
 }
 
@@ -3057,8 +3054,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		}
 	}
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	path = NULL;
 	if (err == -EAGAIN)
 		goto again;
@@ -4371,8 +4367,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 
 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
 				       err ? err : allocated);
@@ -5241,8 +5236,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 			break;
 	}
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	return ret;
 }
 
@@ -5534,15 +5528,13 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		}
 
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 		if (ret < 0) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			goto out_stop;
 		}
 	} else {
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 	}
 
 	ret = ext4_es_remove_extent(inode, offset_lblk,
@@ -5762,10 +5754,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		count -= len;
 
 	repeat:
-		ext4_ext_drop_refs(path1);
-		kfree(path1);
-		ext4_ext_drop_refs(path2);
-		kfree(path2);
+		ext4_free_ext_path(path1);
+		ext4_free_ext_path(path2);
 		path1 = path2 = NULL;
 	}
 	return replaced_count;
@@ -5844,8 +5834,7 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	}
 
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 
 	return err ? err : mapped;
 }
@@ -5912,8 +5901,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 	ret = ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
 	up_write(&EXT4_I(inode)->i_data_sem);
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	ext4_mark_inode_dirty(NULL, inode);
 	return ret;
 }
@@ -5931,8 +5919,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
 			return;
 		ex = path[path->p_depth].p_ext;
 		if (!ex) {
-			ext4_ext_drop_refs(path);
-			kfree(path);
+			ext4_free_ext_path(path);
 			ext4_mark_inode_dirty(NULL, inode);
 			return;
 		}
@@ -5945,8 +5932,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
 		ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
 		up_write(&EXT4_I(inode)->i_data_sem);
 		ext4_mark_inode_dirty(NULL, inode);
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 	}
 }
 
@@ -5985,13 +5971,11 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
 	if (!ex) {
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 		goto out;
 	}
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 
 	/* Count the number of data blocks */
 	cur = 0;
@@ -6021,30 +6005,26 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	if (IS_ERR(path))
 		goto out;
 	numblks += path->p_depth;
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	while (cur < end) {
 		path = ext4_find_extent(inode, cur, NULL, 0);
 		if (IS_ERR(path))
 			break;
 		ex = path[path->p_depth].p_ext;
 		if (!ex) {
-			ext4_ext_drop_refs(path);
-			kfree(path);
+			ext4_free_ext_path(path);
 			return 0;
 		}
 		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
 					ext4_ext_get_actual_len(ex));
 		ret = skip_hole(inode, &cur);
 		if (ret < 0) {
-			ext4_ext_drop_refs(path);
-			kfree(path);
+			ext4_free_ext_path(path);
 			break;
 		}
 		path2 = ext4_find_extent(inode, cur, NULL, 0);
 		if (IS_ERR(path2)) {
-			ext4_ext_drop_refs(path);
-			kfree(path);
+			ext4_free_ext_path(path);
 			break;
 		}
 		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
@@ -6058,10 +6038,8 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 			if (cmp1 != cmp2 && cmp2 != 0)
 				numblks++;
 		}
-		ext4_ext_drop_refs(path);
-		ext4_ext_drop_refs(path2);
-		kfree(path);
-		kfree(path2);
+		ext4_free_ext_path(path);
+		ext4_free_ext_path(path2);
 	}
 
 out:
@@ -6088,13 +6066,11 @@ int ext4_ext_clear_bb(struct inode *inode)
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
 	if (!ex) {
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 		return 0;
 	}
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 
 	cur = 0;
 	while (cur < end) {
@@ -6113,8 +6089,7 @@ int ext4_ext_clear_bb(struct inode *inode)
 					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 							0, path[j].p_block, 1, 1);
 				}
-				ext4_ext_drop_refs(path);
-				kfree(path);
+				ext4_free_ext_path(path);
 			}
 			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
 			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 23167efda95e..cd0a861853e3 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -667,8 +667,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
 		}
 	}
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 }
 
 static void ext4_es_insert_extent_ind_check(struct inode *inode,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 9549d89b3519..54ccc61c713a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1770,8 +1770,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			ret = ext4_ext_insert_extent(
 				NULL, inode, &path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			ext4_ext_drop_refs(path);
-			kfree(path);
+			ext4_free_ext_path(path);
 			if (ret)
 				goto out;
 			goto next;
@@ -1926,8 +1925,7 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 					for (j = 0; j < path->p_depth; j++)
 						ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, 1);
-					ext4_ext_drop_refs(path);
-					kfree(path);
+					ext4_free_ext_path(path);
 				}
 				cur += ret;
 				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 54e7d3c95fd7..0a220ec9862d 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -56,8 +56,7 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
 err_out:
 	up_write((&EXT4_I(inode)->i_data_sem));
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	lb->first_pblock = 0;
 	return retval;
 }
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 701f1d6a217f..69e5e6a639cc 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -32,8 +32,7 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	if (path[ext_depth(inode)].p_ext == NULL) {
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 		*ppath = NULL;
 		return -ENODATA;
 	}
@@ -107,8 +106,7 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
 	}
 	ret = 1;
 out:
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	return ret;
 }
 
@@ -694,8 +692,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		ext4_discard_preallocations(donor_inode, 0);
 	}
 
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 	ext4_double_up_write_data_sem(orig_inode, donor_inode);
 	unlock_two_nondirectories(orig_inode, donor_inode);
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index b051d19b5c8a..20cadfb740dc 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -298,16 +298,14 @@ static int ext4_get_verity_descriptor_location(struct inode *inode,
 	last_extent = path[path->p_depth].p_ext;
 	if (!last_extent) {
 		EXT4_ERROR_INODE(inode, "verity file has no extents");
-		ext4_ext_drop_refs(path);
-		kfree(path);
+		ext4_free_ext_path(path);
 		return -EFSCORRUPTED;
 	}
 
 	end_lblk = le32_to_cpu(last_extent->ee_block) +
 		   ext4_ext_get_actual_len(last_extent);
 	desc_size_pos = (u64)end_lblk << inode->i_blkbits;
-	ext4_ext_drop_refs(path);
-	kfree(path);
+	ext4_free_ext_path(path);
 
 	if (desc_size_pos < sizeof(desc_size_disk))
 		goto bad;
-- 
2.31.1

