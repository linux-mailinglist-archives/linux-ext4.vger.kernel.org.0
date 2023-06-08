Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2371A728279
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjFHOSU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbjFHOSU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 10:18:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908342D48
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 07:18:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 358EI9RD005448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686233891; bh=uy0FNftnFbBcEV9jQmWPf0rxTnbvOJvnEx79Jfl7wEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VAtX3w/sdTX7RQDrLkBFB237n2xQXa/EohBHE5LokZs6rJdD8buS/rSnSCUfABWt1
         DGaqYe/Geh7kx/jcXiT1XTuJWsFlPIdNPcpDj8mlLUB0sa7KbpzB927B+ORCXl6o9h
         mEKxUrJ4kj1aSjnBtahYOSYUCgYEQbNwgK9RZ+gOluEPj2awgZjVA0us1daVFeLqca
         EasmeJh++moQz+sfTRQDDTVpJIOECVVQu9BFvEehKl2T9fFBNfpiITIxPlQAUMWWHn
         bRBs9lTghzpvQe7jubDwyWlPiNiTcd/zbxjfmHCLgsmHpA6TN0XCJbH47T6RADFCXA
         OWPq4zMrT2qtw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D9AB315C04C4; Thu,  8 Jun 2023 10:18:09 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     bagasdotme@gmail.com, nikolas.kraetzschmar@sap.com, jack@suse.cz,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: only check dquot_initialize_needed() when debugging
Date:   Thu,  8 Jun 2023 10:18:05 -0400
Message-Id: <20230608141805.1434230-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230608141805.1434230-1-tytso@mit.edu>
References: <20230608044056.GA1418535@mit.edu>
 <20230608141805.1434230-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_xattr_block_set() relies on its caller to call dquot_initialize()
on the inode.  To assure that this has happened there are WARN_ON
checks.  Unfortunately, this is subject to false positives if there is
an antagonist thread which is flipping the file system at high rates
between r/o and rw.  So only do the check if EXT4_XATTR_DEBUG is
enabled.

Link: https://lore.kernel.org/r/20230608044056.GA1418535@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 13d7f17a9c8c..321e3a888c20 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2056,8 +2056,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2120,8 +2121,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
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
2.31.0

