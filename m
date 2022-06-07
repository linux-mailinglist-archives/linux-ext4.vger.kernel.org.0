Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246E53F51D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiFGEZr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiFGEZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169CB82C9
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PTaj005600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575931; bh=Z7uA8uljUpAaa3vPWD6QYj1ZJ0uxM8jJ9A1iG1DO0ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BkMknYXR9LXeHTxLG/CWRrBDvRe31mhwLuMMQ1sF8Wg0XTfjf8FE8CAw13N2FXKUe
         /j/17u9xAQBt740tCItb2BldulHHol55hj3U8on4ug1AnMe59NeR6brUykYmPHeXzb
         rYw7HA2V1II25Q1/9p80Qx3NE7mMPssnE4VkDcChcjH+Qs483WHc7uMpuXkjOlNIOh
         czd/xUbA1efzmwT4pu+Cfiswvx1OOR+fFjxAWgkztfFUFWdVOl1y/tWL0FyXENR8rx
         lX9CIMUrWNnnyEMDJsdb2zHvbZds/8GYD+gu02GcT8tW3+YWvAhsVHi2QHW1XQXVIg
         Bz11Z5AXP6i0w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C6B3A15C3E2B; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 5/7] e2fsck: avoid out-of-bounds write for very deep extent trees
Date:   Tue,  7 Jun 2022 00:24:42 -0400
Message-Id: <20220607042444.1798015-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220607042444.1798015-1-tytso@mit.edu>
References: <20220607042444.1798015-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The kernel doesn't support extent trees deeper than 5
(EXT4_MAX_EXTENT_DEPTH).  For this reason we only maintain the extent
tree statistics for 5 levels.  Avoid out-of-bounds writes and reads if
the extent tree is deeper than this.

We keep these statistics to determine whether we should rebuild the
extent tree.  If the extent tree is too deep, we don't need the
statistics because we should always rebuild the it.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/extents.c | 10 +++++++++-
 e2fsck/pass1.c   |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 01879f56..86fe00e7 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -526,7 +526,8 @@ errcode_t e2fsck_check_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino,
 		 */
 		if (info.curr_entry == 1 &&
 		    !(extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT) &&
-		    !eti.force_rebuild) {
+		    !eti.force_rebuild &&
+		    info.curr_level < MAX_EXTENT_DEPTH_COUNT) {
 			struct extent_tree_level *etl;
 
 			etl = eti.ext_info + info.curr_level;
@@ -580,6 +581,13 @@ errcode_t e2fsck_should_rebuild_extents(e2fsck_t ctx,
 	extents_per_block = (ctx->fs->blocksize -
 			     sizeof(struct ext3_extent_header)) /
 			    sizeof(struct ext3_extent);
+
+	/* If the extent tree is too deep, then rebuild it. */
+	if (info->max_depth > MAX_EXTENT_DEPTH_COUNT) {
+		pctx->blk = info->max_depth;
+		op = PR_1E_CAN_COLLAPSE_EXTENT_TREE;
+		goto rebuild;
+	}
 	/*
 	 * If we can consolidate a level or shorten the tree, schedule the
 	 * extent tree to be rebuilt.
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 11d7ce93..43972e7c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2842,7 +2842,8 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
 	if (pctx->errcode)
 		return;
 	if (!(ctx->options & E2F_OPT_FIXES_ONLY) &&
-	    !pb->eti.force_rebuild) {
+	    !pb->eti.force_rebuild &&
+	    info.curr_level < MAX_EXTENT_DEPTH_COUNT) {
 		struct extent_tree_level *etl;
 
 		etl = pb->eti.ext_info + info.curr_level;
-- 
2.31.0

