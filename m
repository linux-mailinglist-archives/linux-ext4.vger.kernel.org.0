Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B39732EC7
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbjFPKhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbjFPKev (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 06:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331E1A3;
        Fri, 16 Jun 2023 03:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE836364D;
        Fri, 16 Jun 2023 10:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2818BC433CD;
        Fri, 16 Jun 2023 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911340;
        bh=L+FYAyysL82MW2zB+dM/zpMrUXN7ZRSoB9sGeI/jDIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDZgR2ObLAH47STwcuU4fASgwtiw1NrmOgWdo3DXANTNX4W/vcfr/BwfK7sglOYja
         tNr3aJn+RYsvtARwE0/LKM57BU0v75davo7nYM2olWltq4EFDsjXYmFZT3LKwXkKVU
         v8XOc9dN8lPuBv0Oa4gtdtR2+PBmqrAzc3apQtNGcHXOrGvUgiD85pHawg52+8Er8i
         C7jEeNXMJqgIcwjGfMmS/MN7x2VFsB1R9DuNnUjisueL5AxG+WFb8px1DrWJEtW0zL
         6Kxd+fJVpgc87MmzQ/oLYkKKvLuNAWpWm+/qfahC8zG0hroc6pryQw3/mRVOO60lmh
         w0AxeGzzGX6kA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/5] ext4: only check dquot_initialize_needed() when debugging
Date:   Fri, 16 Jun 2023 06:28:51 -0400
Message-Id: <20230616102852.674366-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102852.674366-1-sashal@kernel.org>
References: <20230616102852.674366-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.318
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit dea9d8f7643fab07bf89a1155f1f94f37d096a5e ]

ext4_xattr_block_set() relies on its caller to call dquot_initialize()
on the inode.  To assure that this has happened there are WARN_ON
checks.  Unfortunately, this is subject to false positives if there is
an antagonist thread which is flipping the file system at high rates
between r/o and rw.  So only do the check if EXT4_XATTR_DEBUG is
enabled.

Link: https://lore.kernel.org/r/20230608044056.GA1418535@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e6c3bf7ad9b90..c2117b985d4af 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2021,8 +2021,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2090,8 +2091,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
-- 
2.39.2

