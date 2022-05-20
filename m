Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED552EA8D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbiETLOO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 May 2022 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiETLOK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 May 2022 07:14:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719C9E9C7
        for <linux-ext4@vger.kernel.org>; Fri, 20 May 2022 04:14:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4885221B76;
        Fri, 20 May 2022 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653045248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AzcF5C42Pb0QQ6TCm9R9bQt5hJ/uIFIu00sFQbRhOH4=;
        b=ykD52o9IKUyVzQfEQiBxkqTgvDlIAb9/7qSPSS1dcIVpaRRkTzwfaUZk7qVdqtBnGbe2X5
        zqnm53RvqSsfHQktxU1o+2cgaejcb3K5sh1cxXtIEILxd7uytJ3DCokgre73tert71hX5N
        dIArNPuFWDJuu2J8k2o6/YBLCfEqfGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653045248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AzcF5C42Pb0QQ6TCm9R9bQt5hJ/uIFIu00sFQbRhOH4=;
        b=uiPCtZ93rlq07jFPpbad2zXQfD/ZPFviT/BxJdMBcCOiAnLaCUgLDvxohyZmWBBtsHYOaG
        BwVUcR6thliCliAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1AB3B2C141;
        Fri, 20 May 2022 11:14:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2B79A0634; Fri, 20 May 2022 13:14:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Improve write performance with disabled delalloc
Date:   Fri, 20 May 2022 13:14:02 +0200
Message-Id: <20220520111402.4252-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

So the poor write performance I was speaking about on Thursday was due to
this...

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 646ece9b3455..815da8f6c2e5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -822,7 +822,7 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
 	return _ext4_get_block(inode, iblock, bh_result,
-			       EXT4_GET_BLOCKS_IO_CREATE_EXT);
+			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
 }
 
 /* Maximum number of blocks we map for direct IO at once. */
-- 
2.35.3

