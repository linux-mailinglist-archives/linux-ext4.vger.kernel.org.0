Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61BE553D45
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jun 2022 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355792AbiFUVBk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jun 2022 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355511AbiFUVAW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jun 2022 17:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C694FCE8;
        Tue, 21 Jun 2022 13:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA786188C;
        Tue, 21 Jun 2022 20:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3CDC341C6;
        Tue, 21 Jun 2022 20:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844711;
        bh=7U3ei2s7RJZ4v+MhI7mnjMrb2CFiiXJuYxH5BGcxVMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/fC+rwqz4N3oIGkaZevQOpYhmof6NP0/rzmi8aJwUBu98TM29bUNLpx3CcFNLTML
         353RGACN+OLV50kZ7Mc99n7d9YyPyQmHuZbv6Nrh1WHzYEEzX+Gpr4GfS6+BWunGPz
         uhQ4V2hHtYP2hlW6gYcTmNIvwJHH2taqla8lR0rnFFBnnlZTxFvtNx1/n1qm3n5Gp9
         iT2nFEWjo2pU1a66jDwtmK2lcWGcdnfKtDFXkK7Q2YRFfFiFr2+Ka1GFvcqRhq8WF/
         h2m5gzyeVrJP7gOOrbga61IMgHVRLo5Z1E6pTqEnTLteilHHMrBdzi7WCAAHSB1tyf
         2eHHno4w+EriQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 2/3] ext4: improve write performance with disabled delalloc
Date:   Tue, 21 Jun 2022 16:51:46 -0400
Message-Id: <20220621205148.251040-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205148.251040-1-sashal@kernel.org>
References: <20220621205148.251040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 8d5459c11f548131ce48b2fbf45cccc5c382558f ]

When delayed allocation is disabled (either through mount option or
because we are running low on free space), ext4_write_begin() allocates
blocks with EXT4_GET_BLOCKS_IO_CREATE_EXT flag. With this flag extent
merging is disabled and since ext4_write_begin() is called for each page
separately, we end up with a *lot* of 1 block extents in the extent tree
and following writeback is writing 1 block at a time which results in
very poor write throughput (4 MB/s instead of 200 MB/s). These days when
ext4_get_block_unwritten() is used only by ext4_write_begin(),
ext4_page_mkwrite() and inline data conversion, we can safely allow
extent merging to happen from these paths since following writeback will
happen on different boundaries anyway. So use
EXT4_GET_BLOCKS_CREATE_UNRIT_EXT instead which restores the performance.

Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220520111402.4252-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 754b33828853..9aebd9bb68a4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -791,7 +791,7 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
 	return _ext4_get_block(inode, iblock, bh_result,
-			       EXT4_GET_BLOCKS_IO_CREATE_EXT);
+			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
 }
 
 /* Maximum number of blocks we map for direct IO at once. */
-- 
2.35.1

