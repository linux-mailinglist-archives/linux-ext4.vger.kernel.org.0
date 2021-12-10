Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B284703A1
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 16:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbhLJPUU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 10:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242712AbhLJPUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Dec 2021 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639149405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGD0ISFtwAmWkVgjFZK2lNpDsjqu/or2DgsHGWQRSA4=;
        b=h0f5Jzg1xlbZTd2xoE2VvfoB8qeT+QyOnJ5J9qbD7R6vkhqdDcz8HivoTNgMDW+TJggfUg
        2TitKDiVOEN2jcCbcR+hHlk91fMjuRBC858iv4W9p/dhYKyCCRceiWk4j7lU8KYDIlSrg7
        1UZkoT5257WvbXN/udtBcPdAHcPMa2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-7uvxFtDFOiO_6hxlBwOUlQ-1; Fri, 10 Dec 2021 10:16:41 -0500
X-MC-Unique: 7uvxFtDFOiO_6hxlBwOUlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A13100DFC4;
        Fri, 10 Dec 2021 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56B7460BF4;
        Fri, 10 Dec 2021 15:16:39 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger@dilger.ca
Subject: [PATCH v3] ext4: implement support for get/set fs label
Date:   Fri, 10 Dec 2021 16:16:24 +0100
Message-Id: <20211210151624.36414-1-lczerner@redhat.com>
In-Reply-To: <20211112082019.22078-1-lczerner@redhat.com>
References: <20211112082019.22078-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Implement support for FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls for
online reading and setting of file system label.

ext4_ioctl_getlabel() is simple, just get the label from the primary
superblock bh. This might not be the first sb on the file system if
'sb=' mount option is used.

In ext4_ioctl_setlabel() we update what ext4 currently views as a
primary superblock and then proceed to update backup superblocks. There
are two caveats:
 - the primary superblock might not be the first superblock and so it
   might not be the one used by userspace tools if read directly
   off the disk.
 - because the primary superblock might not be the first superblock we
   potentialy have to update it as part of backup superblock update.
   However the first sb location is a bit more complicated than the rest
   so we have to account for that.

The superblock modification is created generic enough so the infrastructure
can be used for other potential superblock modification operations
operations, such as chaning UUID.

Tested with generic/492 with various configurations. I also checked the
behavior with 'sb=' mount options, including very large file systems
with and without sparse_super/sparse_super2.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
V2: Fix typo. Place constant in BUILD_BUG_ON comparison on the right side
V3: Setlabel completely reworked

 fs/ext4/ext4.h              |   9 +-
 fs/ext4/ioctl.c             | 292 ++++++++++++++++++++++++++++++++++++
 fs/ext4/resize.c            |  19 ++-
 fs/ext4/super.c             |   4 +-
 include/trace/events/ext4.h |  22 +++
 5 files changed, 339 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5..f355deb619a2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1298,6 +1298,8 @@ extern void ext4_set_bits(void *bm, int cur, int len);
 /* Metadata checksum algorithm codes */
 #define EXT4_CRC32C_CHKSUM		1
 
+#define EXT4_LABEL_MAX			16
+
 /*
  * Structure of the super block
  */
@@ -1347,7 +1349,7 @@ struct ext4_super_block {
 /*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
 	__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*78*/	char	s_volume_name[16];	/* volume name */
+/*78*/	char	s_volume_name[EXT4_LABEL_MAX];	/* volume name */
 /*88*/	char	s_last_mounted[64] __nonstring;	/* directory where last mounted */
 /*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
 	/*
@@ -3096,6 +3098,9 @@ extern int ext4_group_extend(struct super_block *sb,
 				struct ext4_super_block *es,
 				ext4_fsblk_t n_blocks_count);
 extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
+extern unsigned int ext4_list_backups(struct super_block *sb,
+				      unsigned int *three, unsigned int *five,
+				      unsigned int *seven);
 
 /* super.c */
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
@@ -3110,6 +3115,8 @@ extern int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
+extern __le32 ext4_superblock_csum(struct super_block *sb,
+				   struct ext4_super_block *es);
 extern void ext4_superblock_csum_set(struct super_block *sb);
 extern int ext4_alloc_flex_bg_array(struct super_block *sb,
 				    ext4_group_t ngroup);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..285862288ecb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -27,6 +27,231 @@
 #include "fsmap.h"
 #include <trace/events/ext4.h>
 
+typedef void ext4_modify_sb_callback(struct ext4_super_block *es,
+				       const void *arg);
+
+/*
+ * Superblock modification callback function for changing file system
+ * label
+ */
+static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
+{
+	/* Sanity check, this should never happen */
+	BUILD_BUG_ON(sizeof(es->s_volume_name) < EXT4_LABEL_MAX);
+
+	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
+}
+
+int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
+			   ext4_modify_sb_callback func,
+			   const void *arg)
+{
+	int err = 0;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct buffer_head *bh = sbi->s_sbh;
+	struct ext4_super_block *es = sbi->s_es;
+
+	trace_ext4_modify_sb(sb, bh->b_blocknr, 1);
+
+	BUFFER_TRACE(bh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, sb,
+					    bh,
+					    EXT4_JTR_NONE);
+	if (err)
+		goto out_err;
+
+	lock_buffer(bh);
+	func(es, arg);
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(bh);
+
+	if (buffer_write_io_error(bh) || !buffer_uptodate(bh)) {
+		ext4_msg(sbi->s_sb, KERN_ERR, "previous I/O error to "
+			 "superblock detected");
+		clear_buffer_write_io_error(bh);
+		set_buffer_uptodate(bh);
+	}
+
+	err = ext4_handle_dirty_metadata(handle, NULL, bh);
+	if (err)
+		goto out_err;
+	err = sync_dirty_buffer(bh);
+out_err:
+	ext4_std_error(sb, err);
+	return err;
+}
+
+/*
+ * Update one backup superblcok in the group 'grp' using the primary
+ * superblock data. If the handle is NULL the modification is not
+ * journalled.
+ *
+ * Returns: 0 when no modification was done (no superblock in the group)
+ *	    1 when the modification was successful
+ *	   <0 on error
+ */
+static int ext4_update_backup_sb(struct super_block *sb, handle_t *handle,
+				 ext4_group_t grp)
+{
+	int err = 0;
+	ext4_fsblk_t sb_block;
+	struct buffer_head *bh;
+	unsigned long offset = 0;
+
+	if (!ext4_bg_has_super(sb, grp))
+		return 0;
+
+	/*
+	 * For the group 0 there is always 1k padding, so we have
+	 * either adjust offset, or sb_block depending on blocksize
+	 */
+	if (grp == 0) {
+		sb_block = 1 * EXT4_MIN_BLOCK_SIZE;
+		offset = do_div(sb_block, sb->s_blocksize);
+	} else {
+		sb_block = ext4_group_first_block_no(sb, grp);
+		offset = 0;
+	}
+
+	trace_ext4_modify_sb(sb, sb_block, handle ? 1 : 0);
+
+	bh = sb_getblk(sb, sb_block);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	if (handle) {
+		BUFFER_TRACE(bh, "get_write_access");
+		err = ext4_journal_get_write_access(handle, sb,
+						    bh,
+						    EXT4_JTR_NONE);
+		if (err)
+			goto out_bh;
+	}
+
+	lock_buffer(bh);
+	memcpy(bh->b_data + offset, EXT4_SB(sb)->s_es,
+	       sizeof(struct ext4_super_block));
+	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
+
+	if (err)
+		goto out_bh;
+
+	if (handle) {
+		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		if (err)
+			goto out_bh;
+	} else {
+		BUFFER_TRACE(bh, "marking dirty");
+		mark_buffer_dirty(bh);
+	}
+	err = sync_dirty_buffer(bh);
+
+out_bh:
+	brelse(bh);
+	ext4_std_error(sb, err);
+	return (err) ? err : 1;
+}
+
+/*
+ * Modify primary and backup superblocks using the provided function
+ * func and argument arg.
+ *
+ * Only the primary superblock and at most two backup superblock
+ * modifications are journalled; the rest is modified without journal.
+ * This is safe because e2fsck will re-write them if there is a problem,
+ * and we're very unlikely to ever need more than two backups.
+ */
+int ext4_modify_superblocks_fn(struct super_block *sb,
+			       ext4_modify_sb_callback func,
+			       const void *arg)
+{
+	handle_t *handle;
+	ext4_group_t ngroups;
+	unsigned int three = 1;
+	unsigned int five = 5;
+	unsigned int seven = 7;
+	int err = 0, ret, i;
+	ext4_group_t grp, primary_grp;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	/*
+	 * We can't modify superblocks while the online resize is running
+	 */
+	if (test_and_set_bit_lock(EXT4_FLAGS_RESIZING,
+				  &sbi->s_ext4_flags)) {
+		ext4_msg(sb, KERN_ERR, "Can't modify superblock while"
+			 "performing online resize");
+		return -EBUSY;
+	}
+
+	/*
+	 * We're only going to modify primary superblock and two
+	 * backup superblocks in this transaction.
+	 */
+	handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, 3);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto out;
+	}
+
+	/* Modify primary superblock */
+	err = ext4_modify_primary_sb(sb, handle, func, arg);
+	if (err) {
+		ext4_msg(sb, KERN_ERR, "Failed to modify primary "
+			 "superblock");
+		goto out_journal;
+	}
+
+	primary_grp = ext4_get_group_number(sb, sbi->s_sbh->b_blocknr);
+	ngroups = ext4_get_groups_count(sb);
+
+	/*
+	 * Update backup superblocks. We have to start from group 0
+	 * because it might not be where the primary superblock is
+	 * if the fs is mounted with -o sb=<backup_sb_block>
+	 */
+	i = 0;
+	grp = 0;
+	while (grp < ngroups) {
+		/* Skip primary superblock */
+		if (grp == primary_grp)
+			goto next_grp;
+
+		ret = ext4_update_backup_sb(sb, handle, grp);
+		if (ret < 0) {
+			err = ret;
+			goto out_journal;
+		}
+
+		i += ret;
+		if (handle && i > 1) {
+			/*
+			 * We're only journalling primary superblock and
+			 * two backup superblocks; the rest is not
+			 * journalled.
+			 */
+			err = ext4_journal_stop(handle);
+			if (err)
+				goto out;
+			handle = NULL;
+		}
+next_grp:
+		grp = ext4_list_backups(sb, &three, &five, &seven);
+	}
+
+out_journal:
+	if (handle) {
+		ret = ext4_journal_stop(handle);
+		if (ret && !err)
+			err = ret;
+	}
+out:
+	clear_bit_unlock(EXT4_FLAGS_RESIZING, &sbi->s_ext4_flags);
+	smp_mb__after_atomic();
+	return err ? err : 0;
+}
+
 /**
  * Swap memory between @a and @b for @len bytes.
  *
@@ -850,6 +1075,64 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	return err;
 }
 
+static int ext4_ioctl_setlabel(struct file *filp, const char __user *user_label)
+{
+	size_t len;
+	int ret = 0;
+	char new_label[EXT4_LABEL_MAX + 1];
+	struct super_block *sb = file_inode(filp)->i_sb;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * Copy the maximum length allowed for ext4 label with one more to
+	 * find the required terminating null byte in order to test the
+	 * label length. The on disk label doesn't need to be null terminated.
+	 */
+	if (copy_from_user(new_label, user_label, EXT4_LABEL_MAX + 1))
+		return -EFAULT;
+
+	len = strnlen(new_label, EXT4_LABEL_MAX + 1);
+	if (len > EXT4_LABEL_MAX)
+		return -EINVAL;
+
+	/*
+	 * Clear the buffer after the new label
+	 */
+	memset(new_label + len, 0, EXT4_LABEL_MAX - len);
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	ret = ext4_modify_superblocks_fn(sb, ext4_sb_setlabel, new_label);
+
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
+static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label)
+{
+	char label[EXT4_LABEL_MAX + 1];
+
+	/*
+	 * EXT4_LABEL_MAX must always be smaller than FSLABEL_MAX because
+	 * FSLABEL_MAX must include terminating null byte, while s_volume_name
+	 * does not have to.
+	 */
+	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
+
+	memset(label, 0, sizeof(label));
+	lock_buffer(sbi->s_sbh);
+	strncpy(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
+	unlock_buffer(sbi->s_sbh);
+
+	if (copy_to_user(user_label, label, sizeof(label)))
+		return -EFAULT;
+	return 0;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1266,6 +1549,13 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CHECKPOINT:
 		return ext4_ioctl_checkpoint(filp, arg);
 
+	case FS_IOC_GETFSLABEL:
+		return ext4_ioctl_getlabel(EXT4_SB(sb), (void __user *)arg);
+
+	case FS_IOC_SETFSLABEL:
+		return ext4_ioctl_setlabel(filp,
+					   (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -1347,6 +1637,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
 	case EXT4_IOC_CHECKPOINT:
+	case FS_IOC_GETFSLABEL:
+	case FS_IOC_SETFSLABEL:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b63cb88ccdae..ee8f02f406cb 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -717,12 +717,23 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
  * sequence of powers of 3, 5, and 7: 1, 3, 5, 7, 9, 25, 27, 49, 81, ...
  * For a non-sparse filesystem it will be every group: 1, 2, 3, 4, ...
  */
-static unsigned ext4_list_backups(struct super_block *sb, unsigned *three,
-				  unsigned *five, unsigned *seven)
+unsigned int ext4_list_backups(struct super_block *sb, unsigned int *three,
+			       unsigned int *five, unsigned int *seven)
 {
-	unsigned *min = three;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	unsigned int *min = three;
 	int mult = 3;
-	unsigned ret;
+	unsigned int ret;
+
+	if (ext4_has_feature_sparse_super2(sb)) {
+		do {
+			if (*min > 2)
+				return UINT_MAX;
+			ret = le32_to_cpu(es->s_backup_bgs[*min - 1]);
+			*min += 1;
+		} while (!ret);
+		return ret;
+	}
 
 	if (!ext4_has_feature_sparse_super(sb)) {
 		ret = *min;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4e33b5eca694..d79182793675 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -260,8 +260,8 @@ static int ext4_verify_csum_type(struct super_block *sb,
 	return es->s_checksum_type == EXT4_CRC32C_CHKSUM;
 }
 
-static __le32 ext4_superblock_csum(struct super_block *sb,
-				   struct ext4_super_block *es)
+__le32 ext4_superblock_csum(struct super_block *sb,
+			    struct ext4_super_block *es)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int offset = offsetof(struct ext4_super_block, s_checksum);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 0ea36b2b0662..17d5a8d0fbfd 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2837,6 +2837,28 @@ TRACE_EVENT(ext4_fc_track_range,
 		      __entry->end)
 	);
 
+TRACE_EVENT(ext4_modify_sb,
+	TP_PROTO(struct super_block *sb, ext4_fsblk_t fsblk, unsigned flags),
+
+	TP_ARGS(sb, fsblk, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ext4_fsblk_t,	fsblk)
+		__field(unsigned int,	flags)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->fsblk	= fsblk;
+		__entry->flags	= flags;
+	),
+
+	TP_printk("dev %d,%d fsblk %llu flags %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->fsblk, __entry->flags)
+);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.31.1

