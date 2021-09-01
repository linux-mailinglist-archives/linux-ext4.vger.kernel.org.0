Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F103FD0FD
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Sep 2021 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhIACBD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 22:01:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18995 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbhIACBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 22:01:02 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GznGH43zSzbl55;
        Wed,  1 Sep 2021 09:56:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 1 Sep
 2021 10:00:02 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v5 2/3] ext4: move ext4_fill_raw_inode() related functions
Date:   Wed, 1 Sep 2021 10:09:54 +0800
Message-ID: <20210901020955.1657340-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901020955.1657340-1-yi.zhang@huawei.com>
References: <20210901020955.1657340-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for calling ext4_fill_raw_inode() in
__ext4_get_inode_loc(), move three related functions before
__ext4_get_inode_loc(), no logical change.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 293 ++++++++++++++++++++++++------------------------
 1 file changed, 147 insertions(+), 146 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c7186460c14d..3c36e701e30e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4292,6 +4292,153 @@ int ext4_truncate(struct inode *inode)
 	return err;
 }
 
+static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
+{
+	if (unlikely(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+		return inode_peek_iversion_raw(inode);
+	else
+		return inode_peek_iversion(inode);
+}
+
+static int ext4_inode_blocks_set(struct ext4_inode *raw_inode,
+				 struct ext4_inode_info *ei)
+{
+	struct inode *inode = &(ei->vfs_inode);
+	u64 i_blocks = READ_ONCE(inode->i_blocks);
+	struct super_block *sb = inode->i_sb;
+
+	if (i_blocks <= ~0U) {
+		/*
+		 * i_blocks can be represented in a 32 bit variable
+		 * as multiple of 512 bytes
+		 */
+		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
+		raw_inode->i_blocks_high = 0;
+		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
+		return 0;
+	}
+
+	/*
+	 * This should never happen since sb->s_maxbytes should not have
+	 * allowed this, sb->s_maxbytes was set according to the huge_file
+	 * feature in ext4_fill_super().
+	 */
+	if (!ext4_has_feature_huge_file(sb))
+		return -EFSCORRUPTED;
+
+	if (i_blocks <= 0xffffffffffffULL) {
+		/*
+		 * i_blocks can be represented in a 48 bit variable
+		 * as multiple of 512 bytes
+		 */
+		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
+		raw_inode->i_blocks_high = cpu_to_le16(i_blocks >> 32);
+		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
+	} else {
+		ext4_set_inode_flag(inode, EXT4_INODE_HUGE_FILE);
+		/* i_block is stored in file system block size */
+		i_blocks = i_blocks >> (inode->i_blkbits - 9);
+		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
+		raw_inode->i_blocks_high = cpu_to_le16(i_blocks >> 32);
+	}
+	return 0;
+}
+
+static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	uid_t i_uid;
+	gid_t i_gid;
+	projid_t i_projid;
+	int block;
+	int err;
+
+	err = ext4_inode_blocks_set(raw_inode, ei);
+
+	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
+	i_uid = i_uid_read(inode);
+	i_gid = i_gid_read(inode);
+	i_projid = from_kprojid(&init_user_ns, ei->i_projid);
+	if (!(test_opt(inode->i_sb, NO_UID32))) {
+		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(i_uid));
+		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(i_gid));
+		/*
+		 * Fix up interoperability with old kernels. Otherwise,
+		 * old inodes get re-used with the upper 16 bits of the
+		 * uid/gid intact.
+		 */
+		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
+			raw_inode->i_uid_high = 0;
+			raw_inode->i_gid_high = 0;
+		} else {
+			raw_inode->i_uid_high =
+				cpu_to_le16(high_16_bits(i_uid));
+			raw_inode->i_gid_high =
+				cpu_to_le16(high_16_bits(i_gid));
+		}
+	} else {
+		raw_inode->i_uid_low = cpu_to_le16(fs_high2lowuid(i_uid));
+		raw_inode->i_gid_low = cpu_to_le16(fs_high2lowgid(i_gid));
+		raw_inode->i_uid_high = 0;
+		raw_inode->i_gid_high = 0;
+	}
+	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
+
+	EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
+	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
+
+	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
+	raw_inode->i_flags = cpu_to_le32(ei->i_flags & 0xFFFFFFFF);
+	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT)))
+		raw_inode->i_file_acl_high =
+			cpu_to_le16(ei->i_file_acl >> 32);
+	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
+	ext4_isize_set(raw_inode, ei->i_disksize);
+
+	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		if (old_valid_dev(inode->i_rdev)) {
+			raw_inode->i_block[0] =
+				cpu_to_le32(old_encode_dev(inode->i_rdev));
+			raw_inode->i_block[1] = 0;
+		} else {
+			raw_inode->i_block[0] = 0;
+			raw_inode->i_block[1] =
+				cpu_to_le32(new_encode_dev(inode->i_rdev));
+			raw_inode->i_block[2] = 0;
+		}
+	} else if (!ext4_has_inline_data(inode)) {
+		for (block = 0; block < EXT4_N_BLOCKS; block++)
+			raw_inode->i_block[block] = ei->i_data[block];
+	}
+
+	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
+		u64 ivers = ext4_inode_peek_iversion(inode);
+
+		raw_inode->i_disk_version = cpu_to_le32(ivers);
+		if (ei->i_extra_isize) {
+			if (EXT4_FITS_IN_INODE(raw_inode, ei, i_version_hi))
+				raw_inode->i_version_hi =
+					cpu_to_le32(ivers >> 32);
+			raw_inode->i_extra_isize =
+				cpu_to_le16(ei->i_extra_isize);
+		}
+	}
+
+	if (i_projid != EXT4_DEF_PROJID &&
+	    !ext4_has_feature_project(inode->i_sb))
+		err = err ?: -EFSCORRUPTED;
+
+	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
+	    EXT4_FITS_IN_INODE(raw_inode, ei, i_projid))
+		raw_inode->i_projid = cpu_to_le32(i_projid);
+
+	ext4_inode_csum_set(inode, raw_inode, ei);
+	return err;
+}
+
 /*
  * ext4_get_inode_loc returns with an extra refcount against the inode's
  * underlying buffer_head on success. If 'in_mem' is true, we have all
@@ -4580,13 +4727,6 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 	else
 		inode_set_iversion_queried(inode, val);
 }
-static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
-{
-	if (unlikely(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-		return inode_peek_iversion_raw(inode);
-	else
-		return inode_peek_iversion(inode);
-}
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
@@ -4902,50 +5042,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	return ERR_PTR(ret);
 }
 
-static int ext4_inode_blocks_set(struct ext4_inode *raw_inode,
-				 struct ext4_inode_info *ei)
-{
-	struct inode *inode = &(ei->vfs_inode);
-	u64 i_blocks = READ_ONCE(inode->i_blocks);
-	struct super_block *sb = inode->i_sb;
-
-	if (i_blocks <= ~0U) {
-		/*
-		 * i_blocks can be represented in a 32 bit variable
-		 * as multiple of 512 bytes
-		 */
-		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
-		raw_inode->i_blocks_high = 0;
-		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
-		return 0;
-	}
-
-	/*
-	 * This should never happen since sb->s_maxbytes should not have
-	 * allowed this, sb->s_maxbytes was set according to the huge_file
-	 * feature in ext4_fill_super().
-	 */
-	if (!ext4_has_feature_huge_file(sb))
-		return -EFSCORRUPTED;
-
-	if (i_blocks <= 0xffffffffffffULL) {
-		/*
-		 * i_blocks can be represented in a 48 bit variable
-		 * as multiple of 512 bytes
-		 */
-		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
-		raw_inode->i_blocks_high = cpu_to_le16(i_blocks >> 32);
-		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
-	} else {
-		ext4_set_inode_flag(inode, EXT4_INODE_HUGE_FILE);
-		/* i_block is stored in file system block size */
-		i_blocks = i_blocks >> (inode->i_blkbits - 9);
-		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
-		raw_inode->i_blocks_high = cpu_to_le16(i_blocks >> 32);
-	}
-	return 0;
-}
-
 static void __ext4_update_other_inode_time(struct super_block *sb,
 					   unsigned long orig_ino,
 					   unsigned long ino,
@@ -5006,101 +5102,6 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 	rcu_read_unlock();
 }
 
-static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	uid_t i_uid;
-	gid_t i_gid;
-	projid_t i_projid;
-	int block;
-	int err;
-
-	err = ext4_inode_blocks_set(raw_inode, ei);
-
-	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
-	i_uid = i_uid_read(inode);
-	i_gid = i_gid_read(inode);
-	i_projid = from_kprojid(&init_user_ns, ei->i_projid);
-	if (!(test_opt(inode->i_sb, NO_UID32))) {
-		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(i_uid));
-		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(i_gid));
-		/*
-		 * Fix up interoperability with old kernels. Otherwise,
-		 * old inodes get re-used with the upper 16 bits of the
-		 * uid/gid intact.
-		 */
-		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
-			raw_inode->i_uid_high = 0;
-			raw_inode->i_gid_high = 0;
-		} else {
-			raw_inode->i_uid_high =
-				cpu_to_le16(high_16_bits(i_uid));
-			raw_inode->i_gid_high =
-				cpu_to_le16(high_16_bits(i_gid));
-		}
-	} else {
-		raw_inode->i_uid_low = cpu_to_le16(fs_high2lowuid(i_uid));
-		raw_inode->i_gid_low = cpu_to_le16(fs_high2lowgid(i_gid));
-		raw_inode->i_uid_high = 0;
-		raw_inode->i_gid_high = 0;
-	}
-	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
-
-	EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
-	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
-
-	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags & 0xFFFFFFFF);
-	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT)))
-		raw_inode->i_file_acl_high =
-			cpu_to_le16(ei->i_file_acl >> 32);
-	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
-	ext4_isize_set(raw_inode, ei->i_disksize);
-
-	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
-	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
-		if (old_valid_dev(inode->i_rdev)) {
-			raw_inode->i_block[0] =
-				cpu_to_le32(old_encode_dev(inode->i_rdev));
-			raw_inode->i_block[1] = 0;
-		} else {
-			raw_inode->i_block[0] = 0;
-			raw_inode->i_block[1] =
-				cpu_to_le32(new_encode_dev(inode->i_rdev));
-			raw_inode->i_block[2] = 0;
-		}
-	} else if (!ext4_has_inline_data(inode)) {
-		for (block = 0; block < EXT4_N_BLOCKS; block++)
-			raw_inode->i_block[block] = ei->i_data[block];
-	}
-
-	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
-		u64 ivers = ext4_inode_peek_iversion(inode);
-
-		raw_inode->i_disk_version = cpu_to_le32(ivers);
-		if (ei->i_extra_isize) {
-			if (EXT4_FITS_IN_INODE(raw_inode, ei, i_version_hi))
-				raw_inode->i_version_hi =
-					cpu_to_le32(ivers >> 32);
-			raw_inode->i_extra_isize =
-				cpu_to_le16(ei->i_extra_isize);
-		}
-	}
-
-	if (i_projid != EXT4_DEF_PROJID &&
-	    !ext4_has_feature_project(inode->i_sb))
-		err = err ?: -EFSCORRUPTED;
-
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
-	    EXT4_FITS_IN_INODE(raw_inode, ei, i_projid))
-		raw_inode->i_projid = cpu_to_le32(i_projid);
-
-	ext4_inode_csum_set(inode, raw_inode, ei);
-	return err;
-}
-
 /*
  * Post the struct inode info into an on-disk inode location in the
  * buffer-cache.  This gobbles the caller's reference to the
-- 
2.31.1

