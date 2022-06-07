Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355753F51F
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiFGEZu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiFGEZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC6B82C6
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PRnn005549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575929; bh=7r+itS1oy7jZETpFcWRiPlJxL7altPm35gza+YB/8Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fg6ExvNiuOdCxtyduj2G/Dy4GRYEgqIFEEYq4PyiffscVwPfe0bOpMST0tOcizGTB
         1hi8U+c2nwMi8SxfZKy9oOWkVFuUVf8ieSiZg2LssJ7RNa0ylRXaNdea+1J8zQsH9s
         917GoAi69fi/F7vz5B8lqzj+HhF48p7d/Ku+ia1U12WokH5s9P7aunrccvvpsQOIVW
         pL5kEF5lYLjFX0KC5BBbpCKRdOwW8NyJwhHx2Gxguex8OdGL7qWtdFYOrM3466C+at
         IHz9AmGwOBSV9JGpx7zTnKoTEYvquYkvUZTohB9Px2KcKOtFrkkqXpr/drZlQ13P8O
         lzqjBiRcec0Cw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C498815C3E2A; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/7] e2fsck: check for xattr value size integer wraparound
Date:   Tue,  7 Jun 2022 00:24:41 -0400
Message-Id: <20220607042444.1798015-5-tytso@mit.edu>
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

When checking an extended attrbiute block for correctness, we check if
the starting offset plus the value size exceeds the end of the block.
However, we weren't checking if the size was too large, and if it is
so large that it triggers a wraparound when we added the starting
offset, we won't notice the problem.  Add the missing check.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/pass1.c             |  5 +++--
 lib/ext2fs/ext2_ext_attr.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2a17bb8a..11d7ce93 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2556,8 +2556,9 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 			break;
 		}
 		if (entry->e_value_inum == 0) {
-			if (entry->e_value_offs + entry->e_value_size >
-			    fs->blocksize) {
+			if (entry->e_value_size > EXT2_XATTR_SIZE_MAX ||
+			    (entry->e_value_offs + entry->e_value_size >
+			     fs->blocksize)) {
 				if (fix_problem(ctx, PR_1_EA_BAD_VALUE, pctx))
 					goto clear_extattr;
 				break;
diff --git a/lib/ext2fs/ext2_ext_attr.h b/lib/ext2fs/ext2_ext_attr.h
index f2042ed5..c6068c48 100644
--- a/lib/ext2fs/ext2_ext_attr.h
+++ b/lib/ext2fs/ext2_ext_attr.h
@@ -57,6 +57,17 @@ struct ext2_ext_attr_entry {
 #define EXT2_XATTR_SIZE(size) \
 	(((size) + EXT2_EXT_ATTR_ROUND) & ~EXT2_EXT_ATTR_ROUND)
 
+/*
+ * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
+ * for file system consistency errors, we use a somewhat bigger value.
+ * This allows XATTR_SIZE_MAX to grow in the future, but by using this
+ * instead of INT_MAX for certain consistency checks, we don't need to
+ * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
+ * defined in include/uapi/linux/limits.h, so changing it is going
+ * not going to be trivial....)
+ */
+#define EXT2_XATTR_SIZE_MAX (1 << 24)
+
 #ifdef __KERNEL__
 # ifdef CONFIG_EXT2_FS_EXT_ATTR
 extern int ext2_get_ext_attr(struct inode *, const char *, char *, size_t, int);
-- 
2.31.0

