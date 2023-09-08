Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBA799052
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjIHTjI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjIHTiw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 15:38:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE61FFF;
        Fri,  8 Sep 2023 12:38:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62765C116AA;
        Fri,  8 Sep 2023 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201822;
        bh=YYapb1OHBBNErDKXvjx0ajU9+gbVJbCE6tiNSdzw2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mehsvgOTc2y9ntTFrmT1Rfm+H8U6A706a8vJ+xPY/nMjq1ZL0HQoLOoulfbeVGS1t
         3T5Q2GCwDpDSMDpHPrHldMbd2OjCx9d6MxSeP+Ede5KQXyCpJDdswAWhM2IpzMPUjs
         zSGTGf1NhEscuQ8zj63lTn953rKXxquKCqK8dns2PBer9x0TeZcQebyhB+xgcf37DW
         RmE7Pd5ayaZCWXbiUKn0fvnR8T3awCsWY1jOEHZCb0dtnRbmzX7DM16cJ27WdDoUkd
         dB023SRiYpCAANPqtrpIYLTQHnNepbl9l5Q2bCaEQ0goQQ0ivb8YKsPlKZb70+jfJA
         7uhBmtD4n+waw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georg Ottinger <g.ottinger@gmx.at>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/3] ext2: fix datatype of block number in ext2_xattr_set2()
Date:   Fri,  8 Sep 2023 15:36:55 -0400
Message-Id: <20230908193656.3464052-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193656.3464052-1-sashal@kernel.org>
References: <20230908193656.3464052-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Georg Ottinger <g.ottinger@gmx.at>

[ Upstream commit e88076348425b7d0491c8c98d8732a7df8de7aa3 ]

I run a small server that uses external hard drives for backups. The
backup software I use uses ext2 filesystems with 4KiB block size and
the server is running SELinux and therefore relies on xattr. I recently
upgraded the hard drives from 4TB to 12TB models. I noticed that after
transferring some TBs I got a filesystem error "Freeing blocks not in
datazone - block = 18446744071529317386, count = 1" and the backup
process stopped. Trying to fix the fs with e2fsck resulted in a
completely corrupted fs. The error probably came from ext2_free_blocks(),
and because of the large number 18e19 this problem immediately looked
like some kind of integer overflow. Whereas the 4TB fs was about 1e9
blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
is called and the resulting block number is stored in the variable block
as an int datatype. If a block with a block number greater than
INT32_MAX is returned, this variable overflows and the call to
sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
ext2_free_blocks() produces the error.

Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230815100340.22121-1-g.ottinger@gmx.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index bd1d68ff3a9f8..437175bce22e8 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -664,10 +664,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block = ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
-- 
2.40.1

