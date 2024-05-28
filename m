Return-Path: <linux-ext4+bounces-2658-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE48D11B0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547EE1F2419D
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 02:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833C18037;
	Tue, 28 May 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/mNpgIq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D41799F;
	Tue, 28 May 2024 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862712; cv=none; b=T4beKljpX/5PEEgBf9herhubeVGDmM5fAuk1u31PNEVTAdN64XhunNK9bCh+aWicGB+j5KUFiXskdUOxVjxXOugjThqlMPdKjCYRQTmu003cJeFhFhfYRRDmBNSfTNct8iaD65Y2U5TfspyMaeQgfaQH/479eZ+RDaiikIz83XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862712; c=relaxed/simple;
	bh=BVUZR63uMYFekkdbKHBLByAAGhCVS4wR6xA4x1SYFHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQdR5n+QqJ8/sTT/6FbiBask5zQXCPBk7MIEB0AAQVUB0FQ/EpbgPuiXqNxaosskwlpQxzpWpazW7j3186XTIPhWR5xjTUWDq+jFGEasc4AeWa3HMkjM0xJPswK4m99dyAV97yucSlyStnRD/5ffNMoo1YrNdJhPRyTF2mAaPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/mNpgIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E11C32782;
	Tue, 28 May 2024 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862711;
	bh=BVUZR63uMYFekkdbKHBLByAAGhCVS4wR6xA4x1SYFHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/mNpgIqVbETzVXsX3jf4F7vJ362cY5wUUwwRUM9ggU9NhFWiIHNeagUKsdQ74C3i
	 emZSclXOGQuKPWrMQrOKBwZi+Esdwp//O+yhKLe1SOv78gG09Tn+lD3PIrtIBBG3LB
	 PiSvMjAlR3bo7SQqUeaR9JfOlFPBFLasoSXC/doNx/s2ugjQqkCdH50qGjkO/TAJsO
	 77zHIEas58wEH+XDc9+yCBBCL+fmVoQ3j1ugpGAp0v7S4TVf7I7zu276//CJCNHwr7
	 xzmqNe0Xp4K/2wvG6nZ05uwUvpOXMrSCPmIDmMiZJntLYRpKQO77Z1qR0HbZphaeIJ
	 YzJqom6wvM4NQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 3/5] ext4: do not create EA inode under buffer lock
Date: Mon, 27 May 2024 22:18:19 -0400
Message-ID: <20240528021823.3904980-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021823.3904980-1-sashal@kernel.org>
References: <20240528021823.3904980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 0a46ef234756dca04623b7591e8ebb3440622f0b ]

ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
on the external xattr block. This is problematic as it nests all the
allocation locking (which acquires locks on other buffers) under the
buffer lock. This can even deadlock when the filesystem is corrupted and
e.g. quota file is setup to contain xattr block as data block. Move the
allocation of EA inode out of ext4_xattr_set_entry() into the callers.

Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240321162657.27420-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 113 +++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9f..6f145e20a83fe 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1619,6 +1619,7 @@ static struct inode *ext4_xattr_inode_lookup_create(handle_t *handle,
 static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 				struct ext4_xattr_search *s,
 				handle_t *handle, struct inode *inode,
+				struct inode *new_ea_inode,
 				bool is_block)
 {
 	struct ext4_xattr_entry *last, *next;
@@ -1626,7 +1627,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
-	struct inode *new_ea_inode = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1711,38 +1711,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 			old_ea_inode = NULL;
 			goto out;
 		}
-	}
-	if (i->value && in_inode) {
-		WARN_ON_ONCE(!i->value_len);
-
-		new_ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
-					i->value, i->value_len);
-		if (IS_ERR(new_ea_inode)) {
-			ret = PTR_ERR(new_ea_inode);
-			new_ea_inode = NULL;
-			goto out;
-		}
-	}
 
-	if (old_ea_inode) {
 		/* We are ready to release ref count on the old_ea_inode. */
 		ret = ext4_xattr_inode_dec_ref(handle, old_ea_inode);
-		if (ret) {
-			/* Release newly required ref count on new_ea_inode. */
-			if (new_ea_inode) {
-				int err;
-
-				err = ext4_xattr_inode_dec_ref(handle,
-							       new_ea_inode);
-				if (err)
-					ext4_warning_inode(new_ea_inode,
-						  "dec ref new_ea_inode err=%d",
-						  err);
-				ext4_xattr_inode_free_quota(inode, new_ea_inode,
-							    i->value_len);
-			}
+		if (ret)
 			goto out;
-		}
 
 		ext4_xattr_inode_free_quota(inode, old_ea_inode,
 					    le32_to_cpu(here->e_value_size));
@@ -1866,7 +1839,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	ret = 0;
 out:
 	iput(old_ea_inode);
-	iput(new_ea_inode);
 	return ret;
 }
 
@@ -1929,9 +1901,21 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 	size_t old_ea_inode_quota = 0;
 	unsigned int ea_ino;
 
-
 #define header(x) ((struct ext4_xattr_header *)(x))
 
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode)) {
+			error = PTR_ERR(ea_inode);
+			ea_inode = NULL;
+			goto cleanup;
+		}
+	}
+
 	if (s->base) {
 		int offset = (char *)s->here - bs->bh->b_data;
 
@@ -1940,6 +1924,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 						      EXT4_JTR_NONE);
 		if (error)
 			goto cleanup;
+
 		lock_buffer(bs->bh);
 
 		if (header(s->base)->h_refcount == cpu_to_le32(1)) {
@@ -1966,7 +1951,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
 			error = ext4_xattr_set_entry(i, s, handle, inode,
-						     true /* is_block */);
+					     ea_inode, true /* is_block */);
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
 			if (error == -EFSCORRUPTED)
@@ -2034,29 +2019,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     true /* is_block */);
 	if (error == -EFSCORRUPTED)
 		goto bad_block;
 	if (error)
 		goto cleanup;
 
-	if (i->value && s->here->e_value_inum) {
-		/*
-		 * A ref count on ea_inode has been taken as part of the call to
-		 * ext4_xattr_set_entry() above. We would like to drop this
-		 * extra ref but we have to wait until the xattr block is
-		 * initialized and has its own ref count on the ea_inode.
-		 */
-		ea_ino = le32_to_cpu(s->here->e_value_inum);
-		error = ext4_xattr_inode_iget(inode, ea_ino,
-					      le32_to_cpu(s->here->e_hash),
-					      &ea_inode);
-		if (error) {
-			ea_inode = NULL;
-			goto cleanup;
-		}
-	}
-
 inserted:
 	if (!IS_LAST_ENTRY(s->first)) {
 		new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
@@ -2198,17 +2167,16 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 cleanup:
 	if (ea_inode) {
-		int error2;
-
-		error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
-		if (error2)
-			ext4_warning_inode(ea_inode, "dec ref error=%d",
-					   error2);
+		if (error) {
+			int error2;
 
-		/* If there was an error, revert the quota charge. */
-		if (error)
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
 			ext4_xattr_inode_free_quota(inode, ea_inode,
 						    i_size_read(ea_inode));
+		}
 		iput(ea_inode);
 	}
 	if (ce)
@@ -2266,14 +2234,38 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 {
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_search *s = &is->s;
+	struct inode *ea_inode = NULL;
 	int error;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return -ENOSPC;
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
-	if (error)
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode))
+			return PTR_ERR(ea_inode);
+	}
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     false /* is_block */);
+	if (error) {
+		if (ea_inode) {
+			int error2;
+
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
+
+			ext4_xattr_inode_free_quota(inode, ea_inode,
+						    i_size_read(ea_inode));
+			iput(ea_inode);
+		}
 		return error;
+	}
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
@@ -2282,6 +2274,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		header->h_magic = cpu_to_le32(0);
 		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
 	}
+	iput(ea_inode);
 	return 0;
 }
 
-- 
2.43.0


