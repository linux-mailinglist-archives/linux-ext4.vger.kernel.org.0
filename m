Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08FE4D20A6
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiCHSwF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 13:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349115AbiCHSvo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 13:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E08532F0
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 10:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 831B2B81C77
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 18:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48373C340EB;
        Tue,  8 Mar 2022 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646765444;
        bh=U75RiYNjmWJ2ndhIby8P42M610ffChUEuGTir9XmmmY=;
        h=Date:From:To:Subject:From;
        b=VstISf5S1gD3mzjNHgcFOFqaP9FVe0CqvOSWPMJpohNPNkXir2s61xl7l2q40VfuF
         MUahksJjG1kQ31z71K8Wvc+0m+xBACXBAw/Ks3XErRC9MeN7zOhjFUTn4sn9kyKRK0
         H7R3vqoT1uHCjbKLJNmI7GD98Of4zXMh6SSxAWFhJ9CTHQZcQJSeVq2DVYFs6W5Rlt
         pNRhHF+gTPcQQAJj6GacYuVO7ji1+VLa5mTkmANiBDoFdeVoIGi2SIN3brb+6iIsKF
         80GBHclkyBuZCBTP1T1imV/ws+9o2WDJP/9L8iPIRodRs6COTQPEuNDLg4jCK2vlhL
         n3ngPFR9YhcJA==
Date:   Tue, 8 Mar 2022 10:50:43 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <20220308185043.GA117678@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Since the initial introduction of (posix) fallocate back at the turn of
the century, it has been possible to use this syscall to change the
user-visible contents of files.  This can happen by extending the file
size during a preallocation, or through any of the newer modes (punch,
zero, collapse, insert range).  Because the call can be used to change
file contents, we should treat it like we do any other modification to a
file -- update the mtime, and drop set[ug]id privileges/capabilities.

The VFS function file_modified() does all this for us if pass it a
locked inode, so let's make fallocate drop permissions correctly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/ext4.h    |    2 +-
 fs/ext4/extents.c |   32 +++++++++++++++++++++++++-------
 fs/ext4/inode.c   |    7 ++++++-
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bcd3b9bf8069..5a78a4c368fd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3030,7 +3030,7 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
-extern int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length);
+extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c0f3f83e0c1b..488d7c1de941 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4501,9 +4501,9 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	return ret > 0 ? ret2 : ret;
 }
 
-static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
+static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len);
 
-static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
+static int ext4_insert_range(struct file *file, loff_t offset, loff_t len);
 
 static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
@@ -4575,6 +4575,10 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out_mutex;
+
 	/* Preallocate the range including the unaligned edges */
 	if (partial_begin || partial_end) {
 		ret = ext4_alloc_file_blocks(file,
@@ -4691,7 +4695,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
-		ret = ext4_punch_hole(inode, offset, len);
+		ret = ext4_punch_hole(file, offset, len);
 		goto exit;
 	}
 
@@ -4700,12 +4704,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		goto exit;
 
 	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
-		ret = ext4_collapse_range(inode, offset, len);
+		ret = ext4_collapse_range(file, offset, len);
 		goto exit;
 	}
 
 	if (mode & FALLOC_FL_INSERT_RANGE) {
-		ret = ext4_insert_range(inode, offset, len);
+		ret = ext4_insert_range(file, offset, len);
 		goto exit;
 	}
 
@@ -4741,6 +4745,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out;
+
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
 	if (ret)
 		goto out;
@@ -5242,8 +5250,9 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
  * This implements the fallocate's collapse range functionality for ext4
  * Returns: 0 and non-zero on error.
  */
-static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
+static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
 	ext4_lblk_t punch_start, punch_stop;
@@ -5295,6 +5304,10 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out_mutex;
+
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
@@ -5388,8 +5401,9 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
  * by len bytes.
  * Returns 0 on success, error otherwise.
  */
-static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
+static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
@@ -5446,6 +5460,10 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out_mutex;
+
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..99979bc26eea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3919,8 +3919,9 @@ int ext4_break_layouts(struct inode *inode)
  * Returns: 0 on success or negative on failure
  */
 
-int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
+int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 {
+	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t first_block, stop_block;
 	struct address_space *mapping = inode->i_mapping;
@@ -3982,6 +3983,10 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out_mutex;
+
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
