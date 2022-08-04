Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C10589FC4
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHDRQ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiHDRQz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 13:16:55 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Aug 2022 10:16:53 PDT
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FDA5C940
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 10:16:53 -0700 (PDT)
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
        by cmsmtp with ESMTP
        id JXhBoX2XsSp39JeRNoHQoE; Thu, 04 Aug 2022 17:15:21 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id JeRNoy0fOvn7BJeRNovuM4; Thu, 04 Aug 2022 17:15:21 +0000
X-Authority-Analysis: v=2.4 cv=a/cjSGeF c=1 sm=1 tr=0 ts=62ebfea9
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=kYvXSgR7y552xbGySgwA:9 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] misc: quiet unused variable warnings
Date:   Thu,  4 Aug 2022 11:15:11 -0600
Message-Id: <20220804171511.68460-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD9h82KeNv8S2317jPbXBF/ONIMaC+JaraLjcIOXh9FH/yaz5gYC1nPSLpu6p6u1r0H3NSTOu2zgHPF9zxWjkwLEiUSYGrDkxQBL4/8OmZ9Yz/Dm+ZrD
 EUId9/nQ+LK4QF2cUDVU5AuEnQITa11ctso/KPJ+ddSevyNWX2+HYE2QQjfZ6hMR2IuOrwiOMB+/EhSXPNbBRvQXK9anzGpUP2gLFideZiDpOlb/g0hnsMnE
 B+s+AhoYk6nRnyjVMTe/QA==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Quiet unreferenced variable warning if jbd_debug() is a no-op.
Quiet unset variable warning because compiler is dumb.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 e2fsck/journal.c    | 15 +++++++--------
 lib/ext2fs/swapfs.c |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 12487e3d..571de83e 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -620,7 +620,6 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 			     struct  ext4_fc_tl *tl, __u8 *val)
 {
 	struct ext4_fc_dentry_info fcd;
-	int tag = le16_to_cpu(tl->fc_tag);
 
 	memcpy(&fcd, val, sizeof(fcd));
 
@@ -636,10 +635,10 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 	       darg->dname_len);
 	darg->dname[darg->dname_len] = 0;
 	jbd_debug(1, "%s: %s, ino %lu, parent %lu\n",
-		tag == EXT4_FC_TAG_CREAT ? "create" :
-		(tag == EXT4_FC_TAG_LINK ? "link" :
-		(tag == EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
-		darg->dname, darg->ino, darg->parent_ino);
+		  le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_CREAT ? "create" :
+		  (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_LINK ? "link" :
+		   (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_UNLINK ? "unlink" :
+		    "error")), darg->dname, darg->ino, darg->parent_ino);
 	return 0;
 }
 
@@ -652,11 +651,11 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl, __u8 *val)
 	if (ret)
 		return ret;
 	ext4_fc_flush_extents(ctx, darg.ino);
-	ret = errcode_to_errno(
-		       ext2fs_unlink(ctx->fs, darg.parent_ino,
-				     darg.dname, darg.ino, 0));
+	ret = errcode_to_errno(ext2fs_unlink(ctx->fs, darg.parent_ino,
+					     darg.dname, darg.ino, 0));
 	/* It's okay if the above call fails */
 	free(darg.dname);
+
 	return ret;
 }
 
diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
index 1006b2d2..cd160b31 100644
--- a/lib/ext2fs/swapfs.c
+++ b/lib/ext2fs/swapfs.c
@@ -244,7 +244,7 @@ void ext2fs_swap_inode_full(ext2_filsys fs, struct ext2_inode_large *t,
 			    int bufsize)
 {
 	unsigned i, extra_isize, attr_magic;
-	int has_extents, has_inline_data, islnk, fast_symlink;
+	int has_extents = 0, has_inline_data = 0, islnk = 0, fast_symlink = 0;
 	unsigned int inode_size;
 	__u32 *eaf, *eat;
 
-- 
2.25.1

