Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE21121CF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 04:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLDDXq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 22:23:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40519 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726763AbfLDDXp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Dec 2019 22:23:45 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB43Ne3w017898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Dec 2019 22:23:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 50473421A49; Tue,  3 Dec 2019 22:23:40 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 2/2] ext4: simulate various I/O and checksum errors when reading metadata
Date:   Tue,  3 Dec 2019 22:23:35 -0500
Message-Id: <20191204032335.7683-2-tytso@mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191204032335.7683-1-tytso@mit.edu>
References: <20191204032335.7683-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This allows us to test various error handling code paths

Previous-Version-Link: https://lore.kernel.org/r/20191121183036.29385-2-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Notes:
    v2: change ext4_simulate_fail() to return a bool instead of an int

 fs/ext4/balloc.c |  4 +++-
 fs/ext4/ext4.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ialloc.c |  4 +++-
 fs/ext4/inode.c  |  6 +++++-
 fs/ext4/namei.c  | 11 ++++++++---
 fs/ext4/sysfs.c  | 23 +++++++++++++++++++++++
 6 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 102c38527a10..5f993a411251 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -371,7 +371,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 	if (buffer_verified(bh))
 		goto verified;
 	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
-			desc, bh))) {
+						    desc, bh) ||
+		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "bg %u: bad block bitmap checksum", block_group);
 		ext4_mark_group_bitmap_corrupted(sb, block_group,
@@ -505,6 +506,7 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 	if (!desc)
 		return -EFSCORRUPTED;
 	wait_on_buffer(bh);
+	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		ext4_set_errno(sb, EIO);
 		ext4_error(sb, "Cannot read block bitmap - "
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1c9ac0fc8715..7cbd7575f114 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1557,6 +1557,9 @@ struct ext4_sb_info {
 	/* Barrier between changing inodes' journal flags and writepages ops. */
 	struct percpu_rw_semaphore s_journal_flag_rwsem;
 	struct dax_device *s_daxdev;
+#ifdef CONFIG_EXT4_DEBUG
+	unsigned long s_simulate_fail;
+#endif
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
@@ -1575,6 +1578,45 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
 
+static inline bool ext4_simulate_fail(struct super_block *sb,
+				     unsigned long flag)
+{
+#ifdef CONFIG_EXT4_DEBUG
+	unsigned long old, new;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	do {
+		old = READ_ONCE(sbi->s_simulate_fail);
+		if (likely((old & flag) == 0))
+			return false;
+		new = old & ~flag;
+	} while (unlikely(cmpxchg(&sbi->s_simulate_fail, old, new) != old));
+	return true;
+#else
+	return false;
+#endif
+}
+
+static inline void ext4_simulate_fail_bh(struct super_block *sb,
+					 struct buffer_head *bh,
+					 unsigned long flag)
+{
+	if (!IS_ERR(bh) && ext4_simulate_fail(sb, flag))
+		clear_buffer_uptodate(bh);
+}
+
+/*
+ * Simulate_fail flags
+ */
+#define EXT4_SIM_BBITMAP_EIO	0x00000001
+#define EXT4_SIM_BBITMAP_CRC	0x00000002
+#define EXT4_SIM_IBITMAP_EIO	0x00000004
+#define EXT4_SIM_IBITMAP_CRC	0x00000008
+#define EXT4_SIM_INODE_EIO	0x00000010
+#define EXT4_SIM_INODE_CRC	0x00000020
+#define EXT4_SIM_DIRBLOCK_EIO	0x00000040
+#define EXT4_SIM_DIRBLOCK_CRC	0x00000080
+
 /*
  * Error number codes for s_{first,last}_error_errno
  *
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9979e1a55be5..8e5bb8a3f151 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -94,7 +94,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
 	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
-					   EXT4_INODES_PER_GROUP(sb) / 8)) {
+					   EXT4_INODES_PER_GROUP(sb) / 8) ||
+	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "Corrupt inode bitmap - block_group = %u, "
 			   "inode_bitmap = %llu", block_group, blk);
@@ -192,6 +193,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	get_bh(bh);
 	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
+	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
 		ext4_set_errno(sb, EIO);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1aed7c653b42..128e51c37b93 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4243,6 +4243,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
+	if (ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO))
+		goto simulate_eio;
 	if (!buffer_uptodate(bh)) {
 		lock_buffer(bh);
 
@@ -4341,6 +4343,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
+		simulate_eio:
 			ext4_set_errno(inode->i_sb, EIO);
 			EXT4_ERROR_INODE_BLOCK(inode, block,
 					       "unable to read itable block");
@@ -4555,7 +4558,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 					      sizeof(gen));
 	}
 
-	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
+	if (!ext4_inode_csum_verify(inode, raw_inode, ei) ||
+	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) {
 		ext4_set_errno(inode->i_sb, EFSBADCRC);
 		ext4_error_inode(inode, function, line, 0,
 				 "iget: checksum invalid");
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c74ed04d6781..3a0f65e21e8f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -109,7 +109,10 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 	struct ext4_dir_entry *dirent;
 	int is_dx_block = 0;
 
-	bh = ext4_bread(NULL, inode, block, 0);
+	if (ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_EIO))
+		bh = ERR_PTR(-EIO);
+	else
+		bh = ext4_bread(NULL, inode, block, 0);
 	if (IS_ERR(bh)) {
 		__ext4_warning(inode->i_sb, func, line,
 			       "inode #%lu: lblock %lu: comm %s: "
@@ -153,7 +156,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 	 * caller is sure it should be an index block.
 	 */
 	if (is_dx_block && type == INDEX) {
-		if (ext4_dx_csum_verify(inode, dirent))
+		if (ext4_dx_csum_verify(inode, dirent) &&
+		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
 			set_buffer_verified(bh);
 		else {
 			ext4_set_errno(inode->i_sb, EFSBADCRC);
@@ -164,7 +168,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		}
 	}
 	if (!is_dx_block) {
-		if (ext4_dirblock_csum_verify(inode, bh))
+		if (ext4_dirblock_csum_verify(inode, bh) &&
+		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
 			set_buffer_verified(bh);
 		else {
 			ext4_set_errno(inode->i_sb, EFSBADCRC);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index eb1efad0e20a..a990d28d191b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -29,6 +29,7 @@ typedef enum {
 	attr_last_error_time,
 	attr_feature,
 	attr_pointer_ui,
+	attr_pointer_ul,
 	attr_pointer_atomic,
 	attr_journal_task,
 } attr_id_t;
@@ -160,6 +161,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
 #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
 	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
 
+#define EXT4_RW_ATTR_SBI_UL(_name,_elname)	\
+	EXT4_ATTR_OFFSET(_name, 0644, pointer_ul, ext4_sb_info, _elname)
+
 #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
 static struct ext4_attr ext4_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
@@ -194,6 +198,9 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
+#ifdef CONFIG_EXT4_DEBUG
+EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
+#endif
 EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
 EXT4_ATTR(first_error_time, 0444, first_error_time);
 EXT4_ATTR(last_error_time, 0444, last_error_time);
@@ -228,6 +235,9 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(first_error_time),
 	ATTR_LIST(last_error_time),
 	ATTR_LIST(journal_task),
+#ifdef CONFIG_EXT4_DEBUG
+	ATTR_LIST(simulate_fail),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
@@ -318,6 +328,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		else
 			return snprintf(buf, PAGE_SIZE, "%u\n",
 					*((unsigned int *) ptr));
+	case attr_pointer_ul:
+		if (!ptr)
+			return 0;
+		return snprintf(buf, PAGE_SIZE, "%lu\n",
+				*((unsigned long *) ptr));
 	case attr_pointer_atomic:
 		if (!ptr)
 			return 0;
@@ -361,6 +376,14 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 		else
 			*((unsigned int *) ptr) = t;
 		return len;
+	case attr_pointer_ul:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		*((unsigned long *) ptr) = t;
+		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
 	case attr_trigger_test_error:
-- 
2.23.0

