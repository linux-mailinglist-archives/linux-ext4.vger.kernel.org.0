Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D963232D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKUNJh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 08:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUNJg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 08:09:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD98CDC
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 05:09:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1059D21AAC;
        Mon, 21 Nov 2022 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669036174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dzrjOcoB0lQsY/xMhwo+mrDtU8sN8eyeRw2AbQOov8o=;
        b=SQWkho6f1nXXIl+1OG9d+ACV/i6mzkS3TtVTrhMtf6W4JSUVY+V3xqM0ULdtEFxTRx9KOU
        fEE6/x5Kl9CmROJPW3iqU67EpOTzCdiVMw1CXIucTR3A6UW2Vs9DrStj2VnpHJZn+Fw5yx
        KMbocwQYoP7Vw39MW/RbJo/MbEdZSdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669036174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dzrjOcoB0lQsY/xMhwo+mrDtU8sN8eyeRw2AbQOov8o=;
        b=PUQJBen87He/Rp3MSZVoWOGfGYiQCQ0SBEB9scV2hzYh+GFPldUUJdEdo7w2MeXAUd+HzD
        Fa9VH6Deb7wr0bDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00B5D1376E;
        Mon, 21 Nov 2022 13:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hlYkAI54e2NWbwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 13:09:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 70053A070A; Mon, 21 Nov 2022 14:09:33 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] ext4: Avoid BUG_ON when creating xattrs
Date:   Mon, 21 Nov 2022 14:09:29 +0100
Message-Id: <20221121130929.32031-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=jack@suse.cz; h=from:subject; bh=4z9xcXTcZ/JI6j3J5fCI5ZbaNVDLAscbJB3ac6tGkFU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBje3iDkXM/I4DwyRuiYa/NeAjK+WvxE3B42+qPwl12 I/o8BFmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY3t4gwAKCRCcnaoHP2RA2Z3qCA CNdMCKxez7DgCn9woF5efOHLz2DGRFngVWrKxarLktmQ1R56jKXAtOoPpTMzTtKLZtq6fiVcsqO4zP Hlb0RGTSRnHv6XVRuWJmXOOCSqLAQJC0QcT/BesmatQ1XRZ31kJDRVEP24FuhiGWzek06F6/xBXJU/ QSCrbGup3qR588TrYQFg2bloMj3umlSFKpJUFo9pluu/hQZJhHlYGhEqXZ6V9EHJDK5r9JvZWz6DTy 1N5jWlCyGK+yiFYP+6txK458JjBF0kgvjLz2DKXW2HwhwpZRiapjsOINu1glSOm/eDO7Wgrq2B+8sb VZ35EErHTT9mpOcwpfcUFq90VfYoiw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit fb0a387dcdcd ("ext4: limit block allocations for indirect-block
files to < 2^32") added code to try to allocate xattr block with 32-bit
block number for indirect block based files on the grounds that these
files cannot use larger block numbers. It also added BUG_ON when
allocated block could not fit into 32 bits. This is however bogus
reasoning because xattr block is stored in inode->i_file_acl and
inode->i_file_acl_hi and as such even indirect block based files can
happily use full 48 bits for xattr block number. The proper handling
seems to be there basically since 64-bit block number support was added.
So remove the bogus limitation and BUG_ON.

CC: Eric Sandeen <sandeen@redhat.com>
Fixes: fb0a387dcdcd ("ext4: limit block allocations for indirect-block files to < 2^32")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 36d6ba7190b6..800ce5cdb9d2 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2070,19 +2070,11 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
-
-			/* non-extent files can't have physical blocks past 2^32 */
-			if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-				goal = goal & EXT4_MAX_BLOCK_FILE_PHYS;
-
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
 						     NULL, &error);
 			if (error)
 				goto cleanup;
 
-			if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-				BUG_ON(block > EXT4_MAX_BLOCK_FILE_PHYS);
-
 			ea_idebug(inode, "creating block %llu",
 				  (unsigned long long)block);
 
-- 
2.35.3

