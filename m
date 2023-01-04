Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C465CF04
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjADJEP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjADJD7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E218E05
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:03:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2B6615D2
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E370C433D2
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672823037;
        bh=A6iaykidPgtKyGr8woEMBjxW2GCRYEtro1Dv7S+wD00=;
        h=From:To:Subject:Date:From;
        b=ePgWxdUl8OlNUACoZFzw4ZIvbwGCKfUCBNlcGAVYNv01qTc2P0De6rFn9VGlSeOVk
         Wm2oyOyYZ4ET59Ql+kgdP+GMWM2F/MdaCYE1onYgFMCvlKSkFFYCutW9fRMAETt0WT
         Pv6xqwOS9AqVVvsUZxqwTvLpkDDUoPndsnIHFeqaU1ZDI3Suv+Ba1Q2/PMRR80GErn
         WrGJdpaVKBX+zpj/fUi23Uhw7AVhXQK4dVn6ME4mDkotZNubJPGdZS8ZyTHaJVQSLv
         J2/zcProO2ZB8sCjn3T8KUC62SmIx91cceK3rk8Q6qMBZvKEpXx//Zbf2juw5VYiXA
         2w698u+riBQaA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH] resize2fs: remove unused variable from adjust_superblock()
Date:   Wed,  4 Jan 2023 01:03:51 -0800
Message-Id: <20230104090351.276159-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
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
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 resize/resize2fs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 243cd777..5eeb7d44 100644
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

