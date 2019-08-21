Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AABD982BE
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfHUS1z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Aug 2019 14:27:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33682 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUS1z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Aug 2019 14:27:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so1988677pfq.0
        for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2019 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z74yv8OGqv7VJEDtHnMjhKuHn5ry1jgkfRjACCAW4Yo=;
        b=gRxxIojHE/d889lWDPGEyPgO4K6llnuZ2EtVJZJUV4AfnEi1+thBvAW6XyN2CBObCf
         g/8KA/aVxmXQTyoUe8JbI7PJo9I9o3RXCkhUgW9+j7bix0PY18Z0Nbz1/g5O9SAQ+hP8
         i/Da8gUxtXsfKflq7jT5sBGTTDPNcTKudOvqgOIbO0ji4yrV0pXuoL3mj1RNqIWXQk/U
         ZvZzxLV4k486OTaRF9D8mxPy+U3eLH9qel0OiP785pQxOJe4RupNXhMbrDCjFKXW6MRp
         3nU9jp0mx+abzd4uXnm8ljF/Z9PhhiknFXu/42ML8yKjZHHj9zsZVZACEkOq6dEPUOGP
         cfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z74yv8OGqv7VJEDtHnMjhKuHn5ry1jgkfRjACCAW4Yo=;
        b=c9h0aUAhygY1aiy3rDiffbvEZFSabCm66oK7ulmMJOVklPto7S69nxpKs9HXaHd6Fw
         BVRYv5SYcN7iAxmmYrq0JlQjKr3FPK9KGVciROtEAn21Dl1rbAnUv7gxhSPkltfUkqVp
         QFgBPeZlgOQwceCzSrfQe4aOduKoD4cfArXRg1IIZLRjMlUl1ybQQw3EeA5+g01STUMd
         nYY1H/GA9AaFExKI3xMSryBsIMFsUQqC38xkAwFWPDCq17vfqaWrl0C7/I6dYQKbnLFj
         tKdK95RpWQUMBkAFOi99IHzNIMgrzXW+OAUVKL1bjoWBcd0ZXv5HP3PBV7MXQUSAej4U
         +gGw==
X-Gm-Message-State: APjAAAXD7vc6zWwt2h52Pz8HYAzz4R+Gs50uMZP8Y30QwWMLcrnA8cRx
        aFGTt7oBQ++xPRUnZrqbypfPUVhV
X-Google-Smtp-Source: APXvYqw5ykQr61ScvLsOzwp4+w81Rk9VgxWrsSpir0XxTbi7boo+lDV5FaFtjrO1eIBWmPC93VPzfw==
X-Received: by 2002:a63:784c:: with SMTP id t73mr31313437pgc.268.1566412073026;
        Wed, 21 Aug 2019 11:27:53 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j187sm34182074pfg.178.2019.08.21.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:27:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: attempt to shrink directory on dentry removal
Date:   Wed, 21 Aug 2019 11:27:40 -0700
Message-Id: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On every dentry deletion, this patch traverses directory inode in
reverse direction and frees up empty dirent blocks until it finds a
non-empty dirent block. We leverage the fact that we never clear
dentry name when we delete dentrys by merging them with the previous
one. So, even though the dirent block has only fake dentry which spans
across the entire block, we can use the name in this dead entry to
perform dx lookup and find intermediate dx node blocks as well as
offset inside these blocks.

As of now, we only support non-indexed directories and indexed
directories with no intermediate dx nodes. This technique can also be
used to remove intermediate dx nodes. But it needs a little more
interesting logic to make that happen since we don't store directory
entry name in intermediate nodes.

Ran kvm-xfstests smoke test-suite and verified that there are no
failures. Also, verified that when all the files are deleted in a
directory, directory shrinks to either 4k for non-indexed directories
or 8k for indexed directories with 1 level.

This patch is an improvement over previous patch that I sent out
earlier this month. So, if this patch looks alright, then we can drop
the other shrinking patch.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

---
This patch supersedes the other directory shrinking patch sent in Aug
2019 ("ext4: shrink directory when last block is empty").

 fs/ext4/namei.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129029534075..00a6602605ab 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -882,6 +882,60 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	return ret_err;
 }
 
+/*
+ * This function tries to remove the entry of a dirent block (which was just
+ * emptied by the caller) from the dx frame. It does so by reducing the count by
+ * 1 and left shifting all the entries after the deleted entry.
+ */
+int
+ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
+		     struct dx_frame *dx_frame)
+{
+	struct dx_entry *entries;
+	unsigned int count;
+	unsigned int limit;
+	int err, i;
+
+	entries = dx_frame->entries;
+	count = dx_get_count(entries);
+	limit = dx_get_limit(entries);
+
+	if (count == 1)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++)
+		if (entries[i].block == cpu_to_le64(dx_get_block(dx_frame->at)))
+			break;
+
+	if (i >= count)
+		return -EINVAL;
+
+	err = ext4_journal_get_write_access(handle, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return -EINVAL;
+	}
+
+	for (; i < count - 1; i++)
+		entries[i] = entries[i + 1];
+
+	/*
+	 * If i was 0 when we began above loop, we would have overwritten count
+	 * and limit values sin ce those values live in dx_entry->hash of the
+	 * first entry. We need to update count but we should set limit as well.
+	 */
+	dx_set_count(entries, count - 1);
+	dx_set_limit(entries, limit);
+
+	err = ext4_handle_dirty_dx_node(handle, dir, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
@@ -1409,6 +1463,19 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 	return 0;
 }
 
+static inline bool is_empty_dirent_block(struct inode *dir,
+					 struct buffer_head *bh)
+{
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
+	int	csum_size = 0;
+
+	if (ext4_has_metadata_csum(dir->i_sb))
+		csum_size = sizeof(struct ext4_dir_entry_tail);
+
+	return ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize) ==
+			dir->i_sb->s_blocksize - csum_size && de->inode == 0;
+}
+
 static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 			       struct ext4_dir_entry *de)
 {
@@ -2476,6 +2543,113 @@ int ext4_generic_delete_entry(handle_t *handle,
 	return -ENOENT;
 }
 
+int ext4_try_dir_shrink(handle_t *handle, struct inode *dir)
+{
+	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame_ptr;
+	struct dx_root_info *info;
+	struct dx_hash_info hinfo;
+	struct ext4_dir_entry_2 *dead_de;
+	struct buffer_head *bh;
+	int err;
+	ext4_lblk_t lblk, min_lblk;
+
+	hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	if (hinfo.hash_version <= DX_HASH_TEA)
+		hinfo.hash_version +=
+				EXT4_SB(dir->i_sb)->s_hash_unsigned;
+	hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+
+	if (is_dx(dir))
+		min_lblk = 2;
+	else
+		min_lblk = 1;
+	/*
+	 * Read blocks from directory in reverse orders and clean them up one by
+	 * one!
+	 */
+	for (lblk = dir->i_size >> dir->i_sb->s_blocksize_bits;
+	     lblk > min_lblk; lblk--) {
+		bh = ext4_bread(handle, dir, lblk - 1, 0);
+		if (IS_ERR(bh))
+			return -EIO;
+
+		if (!is_empty_dirent_block(dir, bh))
+			break;
+
+		if (!is_dx(dir))
+			continue;
+
+		dead_de = (struct ext4_dir_entry_2 *)bh->b_data;
+		ext4fs_dirhash(dir, dead_de->name, dead_de->name_len, &hinfo);
+
+		frame_ptr = dx_probe(NULL, dir, &hinfo, frames);
+		if (IS_ERR(frame_ptr)) {
+			dx_release(frames);
+			break;
+		}
+
+		/*
+		 * Cross-check if the dead de helped us find the block that we
+		 * are looking to delete.
+		 */
+		if (unlikely(dx_get_block(frames[0].at) != lblk - 1)) {
+			dx_release(frames);
+			break;
+		}
+
+		info = &((struct dx_root *)frames[0].bh->b_data)->info;
+		if (info->indirect_levels > 0) {
+			/*
+			 * We don't shrink in this case. That's because the
+			 * block that we just read could very well be an index
+			 * block. If it's an index block, we need to do special
+			 * handling to delete the block. Couple of options:
+			 *
+			 * (1) After deleting any dentry, if the dirent block
+			 *     becomes emtpy, we can remove the entry of the
+			 *     dirent block from its index node. If we do that
+			 *     then after enough deletions, index block could
+			 *     become empty. The problem with this approach is
+			 *     that after removing entry of a particular hash
+			 *     value from an index block, if a new dentry maps
+			 *     to same hash value, we probably will end up
+			 *     allocating one more block. Now our initial dirent
+			 *     block becomes orphan.
+			 *
+			 * (2) If the last block in the directory inode is an
+			 *     index block, then we could check all the leaf
+			 *     dirent blocks that are part of this dirent
+			 *     block. If all of them are empty, then we can
+			 *     remove the entry of this index block from its
+			 *     parent block and truncate this index block off.
+			 *
+			 *  In both the options though, we need a way to look-up
+			 *  the parent of an index block. Since we don't store
+			 *  any dirent name in an index block, it's not easy to
+			 *  lookup the parent of an index block. But if we want
+			 *  to implement this, then we can very well store a
+			 *  dead dirent which has a name and which maps to the
+			 *  index block in question. We could then use that dead
+			 *  entry to lookup parents for the index block.
+			 */
+			dx_release(frames);
+			return -EOPNOTSUPP;
+		}
+
+		err = ext4_remove_dx_entry(handle, dir, &frames[0]);
+		dx_release(frames);
+		if (err)
+			break;
+	}
+
+	if (lblk < dir->i_size >> dir->i_sb->s_blocksize_bits) {
+		dir->i_size = lblk * dir->i_sb->s_blocksize;
+		ext4_truncate(dir);
+	}
+
+	return 0;
+}
+
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
@@ -2510,6 +2684,8 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
+	ext4_try_dir_shrink(handle, dir);
+
 	return 0;
 out:
 	if (err != -ENOENT)
-- 
2.23.0.rc1.153.gdeed80330f-goog

