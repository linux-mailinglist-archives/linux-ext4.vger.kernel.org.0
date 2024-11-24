Return-Path: <linux-ext4+bounces-5388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFF9D6E89
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Nov 2024 13:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A8161E15
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Nov 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4BD1CDA01;
	Sun, 24 Nov 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGeXciXj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8781C8FD7;
	Sun, 24 Nov 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452047; cv=none; b=C+zLtZs4T4VmYdGksDpuNIsVpi9+QW3ThKExyrUb9zbxjFk1dAySdjuuZD9A67ecUNBDU4QUPvxjAqouyq+YNYTyS8R6MkNqhV3xTSSQWC9U6bUBlZ6wHvT37nOKOzeK80GR1l+1wtGvDkpq5NZfX9y3JEGG42f4AbAjtwoLBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452047; c=relaxed/simple;
	bh=gRlotTQuQuNQ1VGeNNOsOld5oPweg1xGEC2VdmzXEtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbG8c+VOcigPoHE+r79nVbonRHd4Bps+2MRPAzbFHFDDfA7fBw5VxeDkjy/EEytA2M06ypAXUQNFjdmndghM/KdjIbOl85g5qGh+a1NzEgIX3O0PpoA6Oxn6hUsOYvXaK7P0runH+IVY1cnOmt6ZK+hci7tDZq2ZfFJFnJF1xZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGeXciXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2B1C4CED1;
	Sun, 24 Nov 2024 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452046;
	bh=gRlotTQuQuNQ1VGeNNOsOld5oPweg1xGEC2VdmzXEtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGeXciXjMhcXqpJ6+lSjvnwmN6Fn41+EhrvDHnWVOYc67yzc+smZM2jaj7T3HAGzM
	 UOQROgWnV0anaT3WY7a/Cw3V1WtW/UeZ5SRAMsQWcQU+OnBpbnShVuOPU+p5sGGPxG
	 VuS523GXTj17Qmuk3DSy6K5ExOLHJ9NyxBS2bTV4GQLdyV4tCXCIeXPR5wxJw4CQIc
	 RPD1SXDI870UTHXIQqyziLixPHP7/HWly7ThgENs5GByE2J9WxD/TJo1tmTkQngWKz
	 HMRc1onP6Gj154uwswsbTZRLXSjRRiiE296nGEEb52ATwDgu0nDuPLlh8elAa+voFn
	 2QKgVN6hxXsfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 16/16] ext4: partial zero eof block on unaligned inode size extension
Date: Sun, 24 Nov 2024 07:39:53 -0500
Message-ID: <20241124124009.3336072-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit c7fc0366c65628fd69bfc310affec4918199aae2 ]

Using mapped writes, it's technically possible to expose stale
post-eof data on a truncate up operation. Consider the following
example:

$ xfs_io -fc "pwrite 0 2k" -c "mmap 0 4k" -c "mwrite 2k 2k" \
	-c "truncate 8k" -c "pread -v 2k 16" <file>
...
00000800:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
...

This shows that the post-eof data written via mwrite lands within
EOF after a truncate up. While this is deliberate of the test case,
behavior is somewhat unpredictable because writeback does post-eof
zeroing, and writeback can occur at any time in the background. For
example, an fsync inserted between the mwrite and truncate causes
the subsequent read to instead return zeroes. This basically means
that there is a race window in this situation between any subsequent
extending operation and writeback that dictates whether post-eof
data is exposed to the file or zeroed.

To prevent this problem, perform partial block zeroing as part of
the various inode size extending operations that are susceptible to
it. For truncate extension, zero around the original eof similar to
how truncate down does partial zeroing of the new eof. For extension
via writes and fallocate related operations, zero the newly exposed
range of the file to cover any partial zeroing that must occur at
the original and new eof blocks.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Link: https://patch.msgid.link/20240919160741.208162-2-bfoster@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c |  7 ++++++-
 fs/ext4/inode.c   | 51 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c64f7c1b1d908..b03081ab8beee 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4478,7 +4478,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	int depth = 0;
 	struct ext4_map_blocks map;
 	unsigned int credits;
-	loff_t epos;
+	loff_t epos, old_size = i_size_read(inode);
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
@@ -4537,6 +4537,11 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			if (ext4_update_inode_size(inode, epos) & 0x1)
 				inode_set_mtime_to_ts(inode,
 						      inode_get_ctime(inode));
+			if (epos > old_size) {
+				pagecache_isize_extended(inode, old_size, epos);
+				ext4_zero_partial_blocks(handle, inode,
+						     old_size, epos - old_size);
+			}
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a0fa5192db8ed..4a273d83187e8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1328,8 +1328,10 @@ static int ext4_write_end(struct file *file,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
+		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+	}
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
 	 * makes the holding time of folio lock longer. Second, it forces lock
@@ -1445,8 +1447,10 @@ static int ext4_journalled_write_end(struct file *file,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
+		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+	}
 
 	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
@@ -3017,7 +3021,8 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool disksize_changed = false;
-	loff_t new_i_size;
+	loff_t new_i_size, zero_len = 0;
+	handle_t *handle;
 
 	if (unlikely(!folio_buffers(folio))) {
 		folio_unlock(folio);
@@ -3061,18 +3066,21 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos)
+	if (pos > old_size) {
 		pagecache_isize_extended(inode, old_size, pos);
+		zero_len = pos - old_size;
+	}
 
-	if (disksize_changed) {
-		handle_t *handle;
+	if (!disksize_changed && !zero_len)
+		return copied;
 
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-		ext4_mark_inode_dirty(handle, inode);
-		ext4_journal_stop(handle);
-	}
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (zero_len)
+		ext4_zero_partial_blocks(handle, inode, old_size, zero_len);
+	ext4_mark_inode_dirty(handle, inode);
+	ext4_journal_stop(handle);
 
 	return copied;
 }
@@ -5459,6 +5467,14 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		}
 
 		if (attr->ia_size != inode->i_size) {
+			/* attach jbd2 jinode for EOF folio tail zeroing */
+			if (attr->ia_size & (inode->i_sb->s_blocksize - 1) ||
+			    oldsize & (inode->i_sb->s_blocksize - 1)) {
+				error = ext4_inode_attach_jinode(inode);
+				if (error)
+					goto err_out;
+			}
+
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
 			if (IS_ERR(handle)) {
 				error = PTR_ERR(handle);
@@ -5469,12 +5485,17 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				orphan = 1;
 			}
 			/*
-			 * Update c/mtime on truncate up, ext4_truncate() will
-			 * update c/mtime in shrink case below
+			 * Update c/mtime and tail zero the EOF folio on
+			 * truncate up. ext4_truncate() handles the shrink case
+			 * below.
 			 */
-			if (!shrink)
+			if (!shrink) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
+				if (oldsize & (inode->i_sb->s_blocksize - 1))
+					ext4_block_truncate_page(handle,
+							inode->i_mapping, oldsize);
+			}
 
 			if (shrink)
 				ext4_fc_track_range(handle, inode,
-- 
2.43.0


