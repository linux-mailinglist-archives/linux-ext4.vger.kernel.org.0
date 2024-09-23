Return-Path: <linux-ext4+bounces-4273-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FC97EA28
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC981F2181F
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D8198830;
	Mon, 23 Sep 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9zgBXGN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57984197A98
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088570; cv=none; b=nDxbAhg/QJlg0+fFxJEOsWJ0j047hisr8De9ktyfghj4pa0m0GR8Du2nCLFosNYwJFG3ifxqF11cUWQ76Y6NGaxUFNXBK9bA9rxWwtB+Sj/R8Bm1AjXxoutMqca+KkQ6cvuK039w3oWeMrF2oizldEn+L1xVYtzKUzx5MbP4tYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088570; c=relaxed/simple;
	bh=7KWMRCfLshJan+v1YjbxtnHR81BOQimjwuapGh0YCt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch9CgTGpVXqMKK2gG7uAd1TJ+P/9HL3R4SC6iaNRHgVzNWcQJ+gCgFh5g4/Mg7tS+CuZb+ayljVmh/JtcvemoF8Vu98unHpVBvhqUOVbj0TbzmT8pCX0pbtgc4EyPpsP+EMWogv3BITlU37IqwJ1fMfefG7Mh4UbS2zr56+qc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9zgBXGN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727088566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0el6xdbuEtFnFMlbAu4zA1Zhc8E2Sw9sLTTq195ArnA=;
	b=C9zgBXGNgF11TSAoOFJbOP+73/afONE/qTKlc1UrkNi021PD0EtS6ADpQ357pnNFob4yuv
	6xBNnk4v06C6Pocy8zCH/tkVf1c/jZsSHq0Hrb+WHDmQR7phPJZ8r3X6d6LWqpQt6GyEPE
	SLEyKBVFeZ31eu6/IpOVZIjbLRyMTHU=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 1/2] ext4: use handle to mark fc as ineligible in __track_dentry_update()
Date: Mon, 23 Sep 2024 11:49:08 +0100
Message-ID: <20240923104909.18342-2-luis.henriques@linux.dev>
In-Reply-To: <20240923104909.18342-1-luis.henriques@linux.dev>
References: <20240923104909.18342-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
in a fast-commit being done before the filesystem is effectively marked as
ineligible.  This patch fixes the calls to this function in
__track_dentry_update() by adding an extra parameter to the callback used in
ext4_fc_track_template().

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/fast_commit.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..c330efd771d1 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -372,7 +372,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
  */
 static int ext4_fc_track_template(
 	handle_t *handle, struct inode *inode,
-	int (*__fc_track_fn)(struct inode *, void *, bool),
+	int (*__fc_track_fn)(handle_t *handle, struct inode *, void *, bool),
 	void *args, int enqueue)
 {
 	bool update = false;
@@ -389,7 +389,7 @@ static int ext4_fc_track_template(
 		ext4_fc_reset_inode(inode);
 		ei->i_sync_tid = tid;
 	}
-	ret = __fc_track_fn(inode, args, update);
+	ret = __fc_track_fn(handle, inode, args, update);
 	mutex_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
@@ -413,7 +413,8 @@ struct __track_dentry_update_args {
 };
 
 /* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
-static int __track_dentry_update(struct inode *inode, void *arg, bool update)
+static int __track_dentry_update(handle_t *handle, struct inode *inode,
+				 void *arg, bool update)
 {
 	struct ext4_fc_dentry_update *node;
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -428,14 +429,14 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 
 	if (IS_ENCRYPTED(dir)) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
-					NULL);
+					handle);
 		mutex_lock(&ei->i_fc_lock);
 		return -EOPNOTSUPP;
 	}
 
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
+		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -447,7 +448,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
-			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
@@ -569,7 +570,8 @@ void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 }
 
 /* __track_fn for inode tracking */
-static int __track_inode(struct inode *inode, void *arg, bool update)
+static int __track_inode(handle_t *handle, struct inode *inode, void *arg,
+			 bool update)
 {
 	if (update)
 		return -EEXIST;
@@ -607,7 +609,8 @@ struct __track_range_args {
 };
 
 /* __track_fn for tracking data updates */
-static int __track_range(struct inode *inode, void *arg, bool update)
+static int __track_range(handle_t *handle, struct inode *inode, void *arg,
+			 bool update)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	ext4_lblk_t oldstart;

