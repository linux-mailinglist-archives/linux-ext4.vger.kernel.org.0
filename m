Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE753F51E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiFGEZs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbiFGEZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC39B82CC
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PTMj005595
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575931; bh=CsokmL2EFFwkPts+K9i7MBBVQEKp451vpopb4oYRdhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lfd2354YhAKuCLcY1zaVoAEmEC2XoDx25q3+uiK7Zp8uwdU4f2KzIFLO2kGoBnuIj
         NdH/bRhbC+1x7WpVDaKJgxVL9TCovhVv4509cUrfN7diw/S0bUYVnBN+3TVBb7XjU1
         YmJf04NwpBReE/TWvbXaPPHzdC+wFqwsYSKtpJkuHP6qcl71VaWsznZRbmWfhq8Xmu
         /fXtquOipPytTjU8UxtxJKytgF7+BRATKebtgFHo65nwGs5M0t4Up0XDOR+ItaHDC0
         lzoa1d3MKLx2/CBL6cHNGF2XifZGfDsmmxrz87FoI+ST9uZU6/vsUENiQFs4bX9pZh
         PgrM1P6xR4bfQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CACA115C3EC2; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 7/7] libext2fs: check for invalid blocks in ext2fs_punch_blocks()
Date:   Tue,  7 Jun 2022 00:24:44 -0400
Message-Id: <20220607042444.1798015-8-tytso@mit.edu>
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

If the extent tree has out-of-range physical block numbers, don't try
to release them.

Also add a similar check in ext2fs_block_alloc_stats2() to avoid a
NULL pointer dereference.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/alloc_stats.c | 3 ++-
 lib/ext2fs/punch.c       | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 3949f618..6f98bcc7 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -62,7 +62,8 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
 {
 	int	group = ext2fs_group_of_blk2(fs, blk);
 
-	if (blk >= ext2fs_blocks_count(fs->super)) {
+	if (blk < fs->super->s_first_data_block ||
+	    blk >= ext2fs_blocks_count(fs->super)) {
 #ifndef OMIT_COM_ERR
 		com_err("ext2fs_block_alloc_stats", 0,
 			"Illegal block number: %lu", (unsigned long) blk);
diff --git a/lib/ext2fs/punch.c b/lib/ext2fs/punch.c
index effa1e2d..e2543e1e 100644
--- a/lib/ext2fs/punch.c
+++ b/lib/ext2fs/punch.c
@@ -200,6 +200,10 @@ static errcode_t punch_extent_blocks(ext2_filsys fs, ext2_ino_t ino,
 	__u32		cluster_freed;
 	errcode_t	retval = 0;
 
+	if (free_start < fs->super->s_first_data_block ||
+	    (free_start + free_count) >= ext2fs_blocks_count(fs->super))
+		return EXT2_ET_BAD_BLOCK_NUM;
+
 	/* No bigalloc?  Just free each block. */
 	if (EXT2FS_CLUSTER_RATIO(fs) == 1) {
 		*freed += free_count;
-- 
2.31.0

