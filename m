Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD744DD6D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhKKWCE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Nov 2021 17:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKKWCD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Nov 2021 17:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636667954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y8cZELcdV5W0CoTP950HhsAxzikWq40LoJLfRYZpfw8=;
        b=eMIiP394sj9hWlIAIHyeuq6YY73fF4CUAlF79iwQex9wmOtCMgiSVBc2YXvzIZKgHDyfXa
        uJwXvifFv2IRfU0gh2s8n/B/HI9biY7kFvIic58RmmNeaMXTR59dTm3WTP4Tur7f5R5xZO
        yoArMbh5/RNhFe8uHCYQYT5fBZs5PHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-JvpmIdodOYuaZiFkCq1PLw-1; Thu, 11 Nov 2021 16:59:10 -0500
X-MC-Unique: JvpmIdodOYuaZiFkCq1PLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CA1F1030C20;
        Thu, 11 Nov 2021 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC9391980E;
        Thu, 11 Nov 2021 21:59:08 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: [PATCH] ext4: implement support for get/set fs label
Date:   Thu, 11 Nov 2021 22:59:04 +0100
Message-Id: <20211111215904.21237-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Implement suport for FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls for
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

Tested with generic/492 with various configurations. I also checked the
behavior with 'sb=' mount options, including very large file systems
with and without sparse_super/sparse_super2.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/ext4.h  |   6 +-
 fs/ext4/ioctl.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c |   4 +-
 3 files changed, 176 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3825195539d7..0856afb629e3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1297,6 +1297,8 @@ extern void ext4_set_bits(void *bm, int cur, int len);
 /* Metadata checksum algorithm codes */
 #define EXT4_CRC32C_CHKSUM		1
 
+#define EXT4_LABEL_MAX			16
+
 /*
  * Structure of the super block
  */
@@ -1346,7 +1348,7 @@ struct ext4_super_block {
 /*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
 	__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*78*/	char	s_volume_name[16];	/* volume name */
+/*78*/	char	s_volume_name[EXT4_LABEL_MAX];	/* volume name */
 /*88*/	char	s_last_mounted[64] __nonstring;	/* directory where last mounted */
 /*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
 	/*
@@ -3109,6 +3111,8 @@ extern int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
+extern __le32 ext4_superblock_csum(struct super_block *sb,
+				   struct ext4_super_block *es);
 extern void ext4_superblock_csum_set(struct super_block *sb);
 extern int ext4_alloc_flex_bg_array(struct super_block *sb,
 				    ext4_group_t ngroup);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..367aa80b050d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -850,6 +850,166 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	return err;
 }
 
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
+static int ext4_ioctl_setlabel(struct file *filp, const char __user *user_label)
+{
+	size_t len;
+	handle_t *handle;
+	ext4_group_t ngroups;
+	ext4_fsblk_t sb_block;
+	struct buffer_head *bh;
+	int ret = 0, ret2, grp;
+	unsigned long offset = 0;
+	char new_label[EXT4_LABEL_MAX + 1];
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+
+	/* Sanity check, this should never happen */
+	BUILD_BUG_ON(EXT4_LABEL_MAX > sizeof(es->s_volume_name));
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
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
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, EXT4_MAX_TRANS_DATA);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto err_out;
+	}
+	/* Update the primary superblock first */
+	ret = ext4_journal_get_write_access(handle, sb,
+					    sbi->s_sbh,
+					    EXT4_JTR_NONE);
+	if (ret)
+		goto err_journal;
+
+	lock_buffer(sbi->s_sbh);
+	memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
+	memcpy(es->s_volume_name, new_label, len);
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(sbi->s_sbh);
+
+	ret = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
+	if (ret)
+		goto err_journal;
+	sync_dirty_buffer(sbi->s_sbh);
+
+	/* Update backup superblocks */
+	ngroups = ext4_get_groups_count(sb);
+	for (grp = 0; grp < ngroups; grp++) {
+
+		if (!ext4_bg_has_super(sb, grp))
+			continue;
+
+		/*
+		 * For the group 0 there is always 1k padding, so we have
+		 * either adjust offset, or sb_block depending on blocksize
+		 */
+		if (grp == 0) {
+			sb_block = 1 * EXT4_MIN_BLOCK_SIZE;
+			offset = do_div(sb_block, sb->s_blocksize);
+		} else {
+			sb_block = ext4_group_first_block_no(sb, grp);
+			offset = 0;
+		}
+
+		/*
+		 * Skip primary superblock, it's already done. Note that the
+		 * primary superblock is not always at group 0
+		 */
+		if (sbi->s_sbh->b_blocknr == sb_block)
+			continue;
+
+		ret = ext4_journal_ensure_credits_fn(handle, 1,
+						     EXT4_MAX_TRANS_DATA,
+						     0, 0);
+		if (ret < 0)
+			break;
+
+		bh = ext4_sb_bread(sb, sb_block, 0);
+		if (IS_ERR(bh)) {
+			ret = PTR_ERR(bh);
+			break;
+		}
+
+		ext4_debug("update backup superblock %llu\n", sb_block);
+		BUFFER_TRACE(bh, "get_write_access");
+		ret = ext4_journal_get_write_access(handle, sb,
+						    bh,
+						    EXT4_JTR_NONE);
+		if (ret) {
+			brelse(bh);
+			break;
+		}
+
+		es = (struct ext4_super_block *) (bh->b_data + offset);
+		lock_buffer(bh);
+		if (ext4_has_metadata_csum(sb) &&
+		    es->s_checksum != ext4_superblock_csum(sb, es)) {
+			ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
+				 "superblock %llu\n", sb_block);
+			unlock_buffer(bh);
+			brelse(bh);
+			ret = -EFSBADCRC;
+			break;
+		}
+		memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
+		memcpy(es->s_volume_name, new_label, len);
+		if (ext4_has_metadata_csum(sb))
+			es->s_checksum = ext4_superblock_csum(sb, es);
+		unlock_buffer(bh);
+
+		ret = ext4_handle_dirty_metadata(handle, NULL, bh);
+		if (unlikely(ret))
+			ext4_std_error(sb, ret);
+		brelse(bh);
+	}
+
+err_journal:
+	ret2 = ext4_journal_stop(handle);
+	if (ret2 && !ret)
+		ret = ret2;
+err_out:
+	mnt_drop_write_file(filp);
+	ext4_std_error(sb, ret);
+	return ret;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1266,6 +1426,13 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -1347,6 +1514,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
 	case EXT4_IOC_CHECKPOINT:
+	case FS_IOC_GETFSLABEL:
+	case FS_IOC_SETFSLABEL:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a320c54202d9..f6c2f44ab221 100644
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
-- 
2.31.1

