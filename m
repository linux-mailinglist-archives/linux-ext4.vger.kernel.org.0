Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31493FF082
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbhIBPwY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 11:52:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36500 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345939AbhIBPwY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 11:52:24 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 182FpJ3h027037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Sep 2021 11:51:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 12F3115C33F9; Thu,  2 Sep 2021 11:51:19 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: add error checking to ext4_ext_replay_set_iblocks()
Date:   Thu,  2 Sep 2021 11:51:08 -0400
Message-Id: <20210902155108.381962-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the call to ext4_map_blocks() fails due to an corrupted file
system, ext4_ext_replay_set_iblocks() can get stuck in an infinite
loop.  This could be reproduced by running generic/526 with a file
system that has inline_data and fast_commit enabled.  The system will
repeatedly log to the console:

EXT4-fs warning (device dm-3): ext4_block_to_path:105: block 1074800922 > max in inode 131076

and the stack that it gets stuck in is:

   ext4_block_to_path+0xe3/0x130
   ext4_ind_map_blocks+0x93/0x690
   ext4_map_blocks+0x100/0x660
   skip_hole+0x47/0x70
   ext4_ext_replay_set_iblocks+0x223/0x440
   ext4_fc_replay_inode+0x29e/0x3b0
   ext4_fc_replay+0x278/0x550
   do_one_pass+0x646/0xc10
   jbd2_journal_recover+0x14a/0x270
   jbd2_journal_load+0xc4/0x150
   ext4_load_journal+0x1f3/0x490
   ext4_fill_super+0x22d4/0x2c00

With this patch, generic/526 still fails, but system is no longer
locking up in a tight loop.  It's likely the root casue is that
fast_commit replay is corrupting file systems with inline_data, and we
probably need to add better error handling in the fast commit replay
code path beyond what is done here, which essentially just breaks the
infinite loop without reporting the to the higher levels of the code.

Fixes: 8016E29F4362 ("ext4: fast commit recovery path")
Cc: stable@kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index eb1dd4f024f2..e57019cc3601 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5913,7 +5913,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
 }
 
 /* Check if *cur is a hole and if it is, skip it */
-static void skip_hole(struct inode *inode, ext4_lblk_t *cur)
+static int skip_hole(struct inode *inode, ext4_lblk_t *cur)
 {
 	int ret;
 	struct ext4_map_blocks map;
@@ -5922,9 +5922,12 @@ static void skip_hole(struct inode *inode, ext4_lblk_t *cur)
 	map.m_len = ((inode->i_size) >> inode->i_sb->s_blocksize_bits) - *cur;
 
 	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
 	if (ret != 0)
-		return;
+		return 0;
 	*cur = *cur + map.m_len;
+	return 0;
 }
 
 /* Count number of blocks used by this inode and update i_blocks */
@@ -5973,7 +5976,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	 * iblocks by total number of differences found.
 	 */
 	cur = 0;
-	skip_hole(inode, &cur);
+	ret = skip_hole(inode, &cur);
+	if (ret < 0)
+		goto out;
 	path = ext4_find_extent(inode, cur, NULL, 0);
 	if (IS_ERR(path))
 		goto out;
@@ -5992,8 +5997,12 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 		}
 		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
 					ext4_ext_get_actual_len(ex));
-		skip_hole(inode, &cur);
-
+		ret = skip_hole(inode, &cur);
+		if (ret < 0) {
+			ext4_ext_drop_refs(path);
+			kfree(path);
+			break;
+		}
 		path2 = ext4_find_extent(inode, cur, NULL, 0);
 		if (IS_ERR(path2)) {
 			ext4_ext_drop_refs(path);
-- 
2.31.0

