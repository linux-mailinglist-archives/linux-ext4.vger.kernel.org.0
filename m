Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5370EC16
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjEXDuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 23:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbjEXDuL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 23:50:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E3DFA
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 20:50:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O3nvTI023548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 23:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684900199; bh=LDdPWpg3cnYRw6nGzZtk6G6JnmPnT2mMBhfp1e0PK84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f4A0loeyXm7TDpUQjaVDyLQpo8cEhaO6Egz/frMahlscKNsIffg9dXfVchrbQMQlO
         yNdn59LUR59mZunmoCnZdH1oOQbYywt7oot1slk7YxyxMnYG1FQf0EF2h8A2YTepBE
         s5l6CvlMmudPcjLdRRNJiUOoxWZEAa01Vu5yzX0KJ6S2eCOcQzHSHnhOEfWz3GdqV7
         uh0XR+ELZknZwDtHLB271UZFstIbCzreEnX3ir/mnXEA1QNMY11Nhx1FCbn6g+lHqg
         r59oYGhmwoYsIkxYzwSgMF+BeuC5YF/NHnJFfOv+8wVsoO0IIJzq5w9FUPd780g4LP
         4egFF7K4qM4dg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 89F5E15C052D; Tue, 23 May 2023 23:49:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org,
        syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com
Subject: [PATCH 2/4] ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
Date:   Tue, 23 May 2023 23:49:49 -0400
Message-Id: <20230524034951.779531-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230524034951.779531-1-tytso@mit.edu>
References: <20230524034951.779531-1-tytso@mit.edu>
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

If the ea_inode has been pushed out of the inode cache while there is
still a reference in the mb_cache, the lockdep subclass will not be
set on the inode, which can lead to some lockdep false positives.

Fixes: 33d201e0277b ("xt4: fix lockdep warning about recursive inode locking")
Cc: stable@kernel.org
Reported-by: syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index a27208129a80..ff7ab63c5b4f 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1539,6 +1539,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 				     EXT4_IGET_EA_INODE);
 		if (IS_ERR(ea_inode))
 			goto next_entry;
+		ext4_xattr_inode_set_class(ea_inode);
 		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,
-- 
2.31.0

