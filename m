Return-Path: <linux-ext4+bounces-5387-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F161F9D6E53
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Nov 2024 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C00161CD2
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Nov 2024 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB511B2192;
	Sun, 24 Nov 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tazjR6S6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152251B2188;
	Sun, 24 Nov 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451993; cv=none; b=SYoUnBsrfsgXOcPESbQqUg/lmQFzaxauC0Mm/IQBXp84E2aThSJRoAU2K9oMlJsavvLyJc8Wi3SVvGDyuX9Z1rTbd9ys4asoq60colEJtvTXCjK4UptueXpIOWW6swo2V0ON+HwEievpciCEnSNWJfPlDRZNdh3KN8uaC/LFdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451993; c=relaxed/simple;
	bh=O6pyEqebRhGxepQOtkQ2gaMZjy/GN/sKSklbw1Udjc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lot8J1136INjPLEX/gdWlGA3CRgUPJ7qoOYl+KJk8dM69DUnOPMuNdHjYULlU5ALHKoNumyHwyuADs7I64XziPRbloPB61fxs8A4L6OtqNv6dP6bHrR8mnDZ1i6FU0keTDox9cCaGPp5qIIslvXf/sa8JAXGqe7N6dDpOV6X36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tazjR6S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E095C4CECC;
	Sun, 24 Nov 2024 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451993;
	bh=O6pyEqebRhGxepQOtkQ2gaMZjy/GN/sKSklbw1Udjc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tazjR6S6cWzN546Rs4JFIRUPtQU6w8jKXVkRgCdayq+EJzeC1uU+pYtUrbWiV/fXW
	 ZlC6T8Yilw/WdNrEiAfOq8TNYRUw/MUFf8biFToki//h6/dN6f1kgDb8F31JTPKo33
	 EB7TNd+4XBpHH2c4z1gkzspYNQzoEU6HiN43BF5qaXzMrU+iffv/ckJwby8GSgu4do
	 G1Mtjq2Sy6n3EykcJajUR16A+yB+yjJLEc9K21sKDqTEdm0xja8KuYuXE7cxsDRL7v
	 56OSe27d6WWXCvbMiM1QDshtfhyuGqg+nwhAIJeRWmY9ThK+WtqD6n3/SOhLx1cErz
	 DX4ckq+kCyF2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 19/19] ext4: partial zero eof block on unaligned inode size extension
Date: Sun, 24 Nov 2024 07:38:54 -0500
Message-ID: <20241124123912.3335344-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 34e25eee65219..20a0a5c0bfd93 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4482,7 +4482,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	int depth = 0;
 	struct ext4_map_blocks map;
 	unsigned int credits;
-	loff_t epos;
+	loff_t epos, old_size = i_size_read(inode);
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
@@ -4541,6 +4541,11 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
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
index 54bdd4884fe67..f460418e2bdae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1307,8 +1307,10 @@ static int ext4_write_end(struct file *file,
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
@@ -1423,8 +1425,10 @@ static int ext4_journalled_write_end(struct file *file,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
+		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+	}
 
 	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
@@ -2985,7 +2989,8 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool disksize_changed = false;
-	loff_t new_i_size;
+	loff_t new_i_size, zero_len = 0;
+	handle_t *handle;
 
 	if (unlikely(!folio_buffers(folio))) {
 		folio_unlock(folio);
@@ -3029,18 +3034,21 @@ static int ext4_da_do_write_end(struct address_space *mapping,
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
@@ -5426,6 +5434,14 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -5436,12 +5452,17 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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


