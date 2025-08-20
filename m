Return-Path: <linux-ext4+bounces-9408-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B1B2E8F9
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501E17BE773
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF042E1722;
	Wed, 20 Aug 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgAgp5Zl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32052E173E
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733347; cv=none; b=qF1dcr/0HEGPyhossCmvfi+ZxUsaRn1xAe7hQfQq0jR0MNUi7Hfgyuh+1TixGxEV4oz/PWAoAVjinCTks3XlpBV4sFd3VtNK09/hXJKbutKugrIE1tsxVGuA+51F60Kakb3xRsmqi8xd8XkpuLpzo3glrXP7ezsM1gxarDm5bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733347; c=relaxed/simple;
	bh=QRzI8HI6K8oRbXZFVlgsD6URRqZreKeKmE4VAtMkUmc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGvwRU5tR2p6+Vm0B5j5tlApYJ17gVHjTrzyP/V5tn/i9qeIaLG0eUPWJdWrhSPkVaJl0MxSMMVQqReKfyXKGftISsnvbk2uKf6SzepzMgBPg697hSpjgy1HYZTHtxYUSFGloJlbiEHfpECniOvF7gm8XnSSBdfNR6hy9KAYaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgAgp5Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B9BC4CEE7;
	Wed, 20 Aug 2025 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733346;
	bh=QRzI8HI6K8oRbXZFVlgsD6URRqZreKeKmE4VAtMkUmc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qgAgp5ZlxCAR/Fy37I7tHNvDANpygp4MVpRZwpOmjeF1gkAQuknQB97bNqFCdIF2z
	 Ld0WnZ5MLb7AFbA05XN6NKJFAAH21L8W+NPNBKmmBudStSRrsKfvJoiJXVE1HSerkL
	 TP9DNAU48dv2RRt+9PWcJRk2aHMSEmHCaqSYHwAhmJ3aOUn8ohO8SuAAY/RfNyjVhQ
	 YzRg53Xdxn2pfL26iSLkCXtubri0G1PCNrsH27vyiPsAqN0JHpa03CG0KxvqTEbfkM
	 LWV0hXKKK4jNimJkNGR3u1TsAnjTHzXiIO/EZBzMcvA5UGue8RhcdQWen1bmumVVlx
	 2GOt55fKcCN8A==
Date: Wed, 20 Aug 2025 16:42:26 -0700
Subject: [PATCH 06/12] fuse2fs: don't run fallible operations in op_init
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318710.4130038.12855424911697688360.stgit@frogsfrogsfrogs>
In-Reply-To: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
References: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

There's no way to return an error from the op_init function and have
libfuse tear down the mount, aside from calling fuse_session_exit and
aborting the program.  Even that's not useful, because libfuse has
already daemonized us at that point, so the error messages are screamed
into a void.

Move the code that clears the VALID_FS bit to main() so that we can
abort the mount with a useful error message if that write fails.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d670c5db1206f2..c201f95e771b85 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -907,7 +907,6 @@ static void *op_init(struct fuse_conn_info *conn
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
-	errcode_t err;
 
 	if (ff->magic != FUSE2FS_MAGIC) {
 		translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC);
@@ -939,15 +938,6 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->debug)
 		cfg->debug = 1;
 #endif
-	if (fs->flags & EXT2_FLAG_RW) {
-		fs->super->s_mnt_count++;
-		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
-		fs->super->s_state &= ~EXT2_VALID_FS;
-		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_flush2(fs, 0);
-		if (err)
-			translate_error(fs, 0, err);
-	}
 
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
@@ -4733,6 +4723,10 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	/*
+	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
+	 * we must force ro mode.
+	 */
 	if (ext2fs_has_feature_shared_blocks(global_fs->super))
 		fctx.ro = 1;
 
@@ -4796,6 +4790,20 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	/* Clear the valid flag so that an unclean shutdown forces a fsck */
+	if (global_fs->flags & EXT2_FLAG_RW) {
+		global_fs->super->s_mnt_count++;
+		ext2fs_set_tstamp(global_fs->super, s_mtime, time(NULL));
+		global_fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(global_fs);
+		err = ext2fs_flush2(global_fs, 0);
+		if (err) {
+			translate_error(global_fs, 0, err);
+			ret |= 32;
+			goto out;
+		}
+	}
+
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 


