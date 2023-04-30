Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42316F2971
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjD3QEh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3QEg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 12:04:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738F1992
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 09:04:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UG4U8Y003469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682870671; bh=RsCgHy9CLlwGu2NdYkWHrQfEcav7tzYLI+d8fRmv3LE=;
        h=From:To:Cc:Subject:Date;
        b=GBrxch/Tx32Itgi2NHySfxyE/az5IFvAvLL02Vn6pf26jpUwJ/AvUqsfYUsBV/3rr
         Cql8wxWvfBiOYufH3sIcsx8rcPTZy2FK70WL34PgUhc8s0KrgD14LNGtlrhpSJVEYl
         VGYzkVVr5tv0yZun8o0sMDCY7TRTEiZArOzk5jXfQHlTFhnHfgLYextJgOhOzUNyn+
         JMYDyjmOyGLNPvK3GRF0gOeJh5RokofPJheMi6WbOBRBpY8wZHRsitw2n5Y2AXQU7K
         L/zX79DXRMybvD5w11XCfr6onj6+VYoF/zenPESvGJmKmy2Pc7Ii51axM+pIDUDxFA
         gZNeiEBPuggYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DA95E15C02E2; Sun, 30 Apr 2023 12:04:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com,
        syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix invalid free tracking in ext4_xattr_move_to_block()
Date:   Sun, 30 Apr 2023 12:04:26 -0400
Message-Id: <20230430160426.581366-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
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

In ext4_xattr_move_to_block(), the value of the extended attribute
which we need to move to an external block may be allocated by
kvmalloc() if the value is stored in an external inode.  So at the end
of the function the code tried to check if this was the case by
testing entry->e_value_inum.

However, at this point, the pointer to the xattr entry is no longer
valid, because it was removed from the original location where it had
been stored.  So we could end up calling kvfree() on a pointer which
was not allocated by kvmalloc(); or we could also potentially leak
memory by not freeing the buffer when it should be freed.  Fix this by
storing whether it should be freed in a separate variable.

Link: https://syzkaller.appspot.com/bug?id=5c2aee8256e30b55ccf57312c16d88417adbd5e1
Link: https://syzkaller.appspot.com/bug?id=41a6b5d4917c0412eb3b3c3c604965bed7d7420b
Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com
Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/xattr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 767454d74cd6..e33a323faf3c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2615,6 +2615,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2637,7 +2638,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2676,7 +2677,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
-- 
2.31.0

