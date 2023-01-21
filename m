Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA6676966
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAUUha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjAUUgx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2829409
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE5E60B6C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D27C4339B;
        Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333406;
        bh=AnN2GfP9pe+y/8eQBQy8xcWtCw/5pKPMCwPQ4aCKKko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBo37R+tumOJ7TCJmhI8k+XiLQ8zXEK0xWskVtMJroc9vog+RuAzMCwGVU71Unn9i
         mHarNFBjd18SLi5KiV1FB39izahaMLFFZ538FPK9yVYTmeZ5E5uJvx9jtE/oIF1BI3
         lH4cl7tv0gdPdCQPVSmnUAHO8alIhpkpLFhkk98Iil1v/iTc/r2ewwJmNorgnY4cq7
         6nhH+sZzUryU32lIQHXav+OpCq30zJevYzb8dJVfqXBZSGbm4QwB7/0VND9TEz3XNC
         fCfuPs4d6LrHBEDQGBXTbD80bs7O6Ke+Qa8COIGEB+7G4AM+XByq3qbHvTO19NWMvy
         znULM0wUNzF/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 37/38] resize2fs: remove unused variable from adjust_superblock()
Date:   Sat, 21 Jan 2023 12:32:29 -0800
Message-Id: <20230121203230.27624-38-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In adjust_superblock(), the 'group_block' variable is declared and set,
but it is never actually used.  Remove it.

This addresses the following compiler warning with clang -Wall:

resize2fs.c:1119:11: warning: variable 'group_block' set but not used [-Wunused-but-set-variable]
        blk64_t         group_block;
                        ^
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 resize/resize2fs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 243cd777d..5eeb7d446 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -1116,7 +1116,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
 	ext2_filsys	fs = rfs->new_fs;
 	int		adj = 0;
 	errcode_t	retval;
-	blk64_t		group_block;
 	unsigned long	i;
 	unsigned long	max_group;
 
@@ -1181,8 +1180,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
 		goto errout;
 
 	memset(rfs->itable_buf, 0, fs->blocksize * fs->inode_blocks_per_group);
-	group_block = ext2fs_group_first_block2(fs,
-						rfs->old_fs->group_desc_count);
 	adj = rfs->old_fs->group_desc_count;
 	max_group = fs->group_desc_count - adj;
 	if (rfs->progress) {
@@ -1209,7 +1206,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
 			if (retval)
 				goto errout;
 		}
-		group_block += fs->super->s_blocks_per_group;
 	}
 	io_channel_flush(fs->io);
 	retval = 0;
-- 
2.39.0

