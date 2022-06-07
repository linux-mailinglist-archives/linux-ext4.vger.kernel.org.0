Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495653F521
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiFGEZw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiFGEZr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869FB82C1
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PTee005590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575931; bh=1phfi+h3z1CXGQrojnEaWVd3MbzTtWwV0CEBPOs01Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HTGEhpgem2pt63ip+YMSDw+Y55m0yUZXaJyqPEwVZdg5PizCkDNLGk164p5S32qTs
         8JmHfUNmf27jPKIoPJ+BHIkkyzDwvI2TvK0Pk29Lhq+/Ft1siExNrKWqMw/+Cv2LdV
         bqKPwDj7glsfSKEbc+PIuRWL0ssTS3ElrXtwBmy73M4qGh7P4sXT0BnbyQSkC/GZD3
         /0xQWaUveDScxp1saQWXFsYEUoMXHOtqjWBorbARkd0WJfilXS1fWiVXQ3QTfk/G3Q
         2w2Y9J1usYGmVphftMjHzFIztrmzYLTYPgLBYVJD0/VJpIIKEORzDhs+3+dXOjL9iE
         F4fw+oUVa2kag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C89DF15C3EBE; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 6/7] libext2fs: check for cyclic loops in the extent tree
Date:   Tue,  7 Jun 2022 00:24:43 -0400
Message-Id: <20220607042444.1798015-7-tytso@mit.edu>
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

In the extent tree handling code in libext2fs, when we go move down
the extent tree, if a cyclic loop is detected, return an error.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2_err.et.in |  3 +++
 lib/ext2fs/extent.c       | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/ext2_err.et.in b/lib/ext2fs/ext2_err.et.in
index cf0e00ea..bb1dcf14 100644
--- a/lib/ext2fs/ext2_err.et.in
+++ b/lib/ext2fs/ext2_err.et.in
@@ -551,4 +551,7 @@ ec	EXT2_ET_NO_GDESC,
 ec	EXT2_FILSYS_CORRUPTED,
 	"The internal ext2_filsys data structure appears to be corrupted"
 
+ec	EXT2_ET_EXTENT_CYCLE,
+	"Found cyclic loop in extent tree"
+
 	end
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index 1a206a16..82e75ccd 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -47,6 +47,7 @@ struct extent_path {
 	int		visit_num;
 	int		flags;
 	blk64_t		end_blk;
+	blk64_t		blk;
 	void		*curr;
 };
 
@@ -286,6 +287,7 @@ errcode_t ext2fs_extent_open2(ext2_filsys fs, ext2_ino_t ino,
 	handle->path[0].end_blk =
 		(EXT2_I_SIZE(handle->inode) + fs->blocksize - 1) >>
 		 EXT2_BLOCK_SIZE_BITS(fs->super);
+	handle->path[0].blk = 0;
 	handle->path[0].visit_num = 1;
 	handle->level = 0;
 	handle->magic = EXT2_ET_MAGIC_EXTENT_HANDLE;
@@ -305,14 +307,14 @@ errout:
 errcode_t ext2fs_extent_get(ext2_extent_handle_t handle,
 			    int flags, struct ext2fs_extent *extent)
 {
-	struct extent_path	*path, *newpath;
+	struct extent_path	*path, *newpath, *tp;
 	struct ext3_extent_header	*eh;
 	struct ext3_extent_idx		*ix = 0;
 	struct ext3_extent		*ex;
 	errcode_t			retval;
 	blk64_t				blk;
 	blk64_t				end_blk;
-	int				orig_op, op;
+	int				orig_op, op, l;
 	int				failed_csum = 0;
 
 	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EXTENT_HANDLE);
@@ -467,6 +469,11 @@ retry:
 		}
 		blk = ext2fs_le32_to_cpu(ix->ei_leaf) +
 			((__u64) ext2fs_le16_to_cpu(ix->ei_leaf_hi) << 32);
+		for (l = handle->level, tp = path; l > 0; l--, tp--) {
+			if (blk == tp->blk)
+				return EXT2_ET_EXTENT_CYCLE;
+		}
+		newpath->blk = blk;
 		if ((handle->fs->flags & EXT2_FLAG_IMAGE_FILE) &&
 		    (handle->fs->io != handle->fs->image_io))
 			memset(newpath->buf, 0, handle->fs->blocksize);
-- 
2.31.0

