Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7CD5D8B3
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGCA1g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbfGCA1g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62LTWOr020348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:29:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 463F3420031; Tue,  2 Jul 2019 17:29:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] ext4: rename htree_inline_dir_to_tree() to ext4_inlinedir_to_tree()
Date:   Tue,  2 Jul 2019 17:29:25 -0400
Message-Id: <20190702212925.29989-3-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702212925.29989-1-tytso@mit.edu>
References: <20190702212925.29989-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clean up namespace pollution by the inline_data code.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   | 10 +++++-----
 fs/ext4/inline.c | 10 +++++-----
 fs/ext4/namei.c  |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 83128bdd7abb..bf660aa7a9e0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3104,11 +3104,11 @@ extern int ext4_try_create_inline_dir(handle_t *handle,
 extern int ext4_read_inline_dir(struct file *filp,
 				struct dir_context *ctx,
 				int *has_inline_data);
-extern int htree_inlinedir_to_tree(struct file *dir_file,
-				   struct inode *dir, ext4_lblk_t block,
-				   struct dx_hash_info *hinfo,
-				   __u32 start_hash, __u32 start_minor_hash,
-				   int *has_inline_data);
+extern int ext4_inlinedir_to_tree(struct file *dir_file,
+				  struct inode *dir, ext4_lblk_t block,
+				  struct dx_hash_info *hinfo,
+				  __u32 start_hash, __u32 start_minor_hash,
+				  int *has_inline_data);
 extern struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 					struct ext4_filename *fname,
 					struct ext4_dir_entry_2 **res_dir,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 796137bb7dfa..88cdf3c90bd1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1324,11 +1324,11 @@ int ext4_try_add_inline_entry(handle_t *handle, struct ext4_filename *fname,
  * inlined dir.  It returns the number directory entries loaded
  * into the tree.  If there is an error it is returned in err.
  */
-int htree_inlinedir_to_tree(struct file *dir_file,
-			    struct inode *dir, ext4_lblk_t block,
-			    struct dx_hash_info *hinfo,
-			    __u32 start_hash, __u32 start_minor_hash,
-			    int *has_inline_data)
+int ext4_inlinedir_to_tree(struct file *dir_file,
+			   struct inode *dir, ext4_lblk_t block,
+			   struct dx_hash_info *hinfo,
+			   __u32 start_hash, __u32 start_minor_hash,
+			   int *has_inline_data)
 {
 	int err = 0, count = 0;
 	unsigned int parent_ino;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 183ad614ae3d..c9568fee9e11 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1104,10 +1104,10 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 		hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 		if (ext4_has_inline_data(dir)) {
 			int has_inline_data = 1;
-			count = htree_inlinedir_to_tree(dir_file, dir, 0,
-							&hinfo, start_hash,
-							start_minor_hash,
-							&has_inline_data);
+			count = ext4_inlinedir_to_tree(dir_file, dir, 0,
+						       &hinfo, start_hash,
+						       start_minor_hash,
+						       &has_inline_data);
 			if (has_inline_data) {
 				*next_hash = ~0;
 				return count;
-- 
2.22.0

