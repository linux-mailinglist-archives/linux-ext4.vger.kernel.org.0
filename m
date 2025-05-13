Return-Path: <linux-ext4+bounces-7814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D446FAB4B13
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 07:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1AC7B06F4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C461E5B93;
	Tue, 13 May 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrfYZq8H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B761E5716
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114734; cv=none; b=d8jimu72u+wytDMpkKXST+Otsg26L9KSYsqJjG/1qW3e42wN6+08TZ90ztcXbNaqbBg9h+/et2lpy9Czn8PbgoxfkVQ+F+CKe8hMi2izxbVhP8wrDrP7MPt8UepemHg0KLNJcsxf75lRIiDJTXyKhf76NTzp95UxZt28UtPnjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114734; c=relaxed/simple;
	bh=3BCGv3mX1/8RsAyn7H9HRBOjMPAlJh6rovw7hXZT37g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBl0q8hXB4loC4bc18mheGyVFtFmXPVwoXamf3afJ05xPdz/hO3slKSAbDX0n1fQxt66sXM2RdTS9E05nlOzjCgjws6vIHMkjjXXXA3NOAAzGupL0ng2XkDiWJlCBaj89RlAmuAc7HvOxttdOIOriMuIse1OmH0wzi4aRnfSr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrfYZq8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3196AC4CEE9
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747114734;
	bh=3BCGv3mX1/8RsAyn7H9HRBOjMPAlJh6rovw7hXZT37g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QrfYZq8HDFxzWqM2v9QynL1u7Qoe+NvMPxADOWFuAyOxxUNEKnEOCrRclwJl1OawB
	 4pyUL9m/Wq7YrsdIAq6Ce/lj1VG5JlAfxeQMooOaxzfNiztVzPMAO/OtJXiz2sMVE4
	 cEdP/LKMJL3SUdMpI09/Tl4/C5hXyG5Di+tyzDOi9mPt+gIwLvm1oeUoKEhiHW22O+
	 JDf4iHLh1HDSohsxZg5fPL8iWZZdhf5zxAXHPuk5QrYHoWhAu0sWgZ68n07Xut8LmA
	 J9J3yrx7GjwLbdljTiZwRG4tQuyBII+Qe/7jG7mFYezMMn2WpkNQBE6AoIqsuz4+vT
	 bktBM+q/+WxhQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 2/4] ext4: remove sb argument from ext4_superblock_csum()
Date: Mon, 12 May 2025 22:38:07 -0700
Message-ID: <20250513053809.699974-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513053809.699974-1-ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since ext4_superblock_csum() no longer uses its sb argument, remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h   | 3 +--
 fs/ext4/ioctl.c  | 4 ++--
 fs/ext4/resize.c | 2 +-
 fs/ext4/super.c  | 9 ++++-----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5c7a86acbf79..25221c6693b0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3116,12 +3116,11 @@ extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 			bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
-extern __le32 ext4_superblock_csum(struct super_block *sb,
-				   struct ext4_super_block *es);
+extern __le32 ext4_superblock_csum(struct ext4_super_block *es);
 extern void ext4_superblock_csum_set(struct super_block *sb);
 extern int ext4_alloc_flex_bg_array(struct super_block *sb,
 				    ext4_group_t ngroup);
 extern const char *ext4_decode_error(struct super_block *sb, int errno,
 				     char nbuf[16]);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 6b99284095bf..c05eb0efbb95 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -141,19 +141,19 @@ static int ext4_update_backup_sb(struct super_block *sb,
 	}
 
 	es = (struct ext4_super_block *) (bh->b_data + offset);
 	lock_buffer(bh);
 	if (ext4_has_feature_metadata_csum(sb) &&
-	    es->s_checksum != ext4_superblock_csum(sb, es)) {
+	    es->s_checksum != ext4_superblock_csum(es)) {
 		ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
 		"superblock %llu", sb_block);
 		unlock_buffer(bh);
 		goto out_bh;
 	}
 	func(es, arg);
 	if (ext4_has_feature_metadata_csum(sb))
-		es->s_checksum = ext4_superblock_csum(sb, es);
+		es->s_checksum = ext4_superblock_csum(es);
 	set_buffer_uptodate(bh);
 	unlock_buffer(bh);
 
 	if (handle) {
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b7ff0d955f0d..050f26168d97 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1117,11 +1117,11 @@ static inline void ext4_set_block_group_nr(struct super_block *sb, char *data,
 {
 	struct ext4_super_block *es = (struct ext4_super_block *) data;
 
 	es->s_block_group_nr = cpu_to_le16(group);
 	if (ext4_has_feature_metadata_csum(sb))
-		es->s_checksum = ext4_superblock_csum(sb, es);
+		es->s_checksum = ext4_superblock_csum(es);
 }
 
 /*
  * Update the backup copies of the ext4 metadata.  These don't need to be part
  * of the main resize transaction, because e2fsck will re-write them if there
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d7780269b455..14e47cc2a5a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -284,12 +284,11 @@ static int ext4_verify_csum_type(struct super_block *sb,
 		return 1;
 
 	return es->s_checksum_type == EXT4_CRC32C_CHKSUM;
 }
 
-__le32 ext4_superblock_csum(struct super_block *sb,
-			    struct ext4_super_block *es)
+__le32 ext4_superblock_csum(struct ext4_super_block *es)
 {
 	int offset = offsetof(struct ext4_super_block, s_checksum);
 	__u32 csum;
 
 	csum = ext4_chksum(~0, (char *)es, offset);
@@ -301,21 +300,21 @@ static int ext4_superblock_csum_verify(struct super_block *sb,
 				       struct ext4_super_block *es)
 {
 	if (!ext4_has_feature_metadata_csum(sb))
 		return 1;
 
-	return es->s_checksum == ext4_superblock_csum(sb, es);
+	return es->s_checksum == ext4_superblock_csum(es);
 }
 
 void ext4_superblock_csum_set(struct super_block *sb)
 {
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 
 	if (!ext4_has_feature_metadata_csum(sb))
 		return;
 
-	es->s_checksum = ext4_superblock_csum(sb, es);
+	es->s_checksum = ext4_superblock_csum(es);
 }
 
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
@@ -5913,11 +5912,11 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 		goto out_bh;
 	}
 
 	if ((le32_to_cpu(es->s_feature_ro_compat) &
 	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
-	    es->s_checksum != ext4_superblock_csum(sb, es)) {
+	    es->s_checksum != ext4_superblock_csum(es)) {
 		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
 		errno = -EFSCORRUPTED;
 		goto out_bh;
 	}
 
-- 
2.49.0


