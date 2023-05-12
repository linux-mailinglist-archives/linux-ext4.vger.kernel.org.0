Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1983701200
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjELWDV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjELWDT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 18:03:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1C10C9
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 15:03:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34CM3CKp013016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683928993; bh=iIyr1OgraawM51obo7cofzPvcYsrDguKcQMjMExh5gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZQfvbBLJrdTS2d9EYLWwQa/5wk5Zs+M12sHiSo9l7Oy95EQra47cqhz5r9TJD/k66
         ceTr74zNROUNxvU8j7kYcNqf/7ktxanvYQyp474R4AfZIz8JUQqat8wgVy0Bo9ATIr
         fzFjnRh+D22f71B3CBmgw3aakI7lECJdW4FZDRng9WvumjWPy8uTQCH82ZCWIrtier
         5FvOZiIVU2zHYsTeG0hv9vdA+1edF5lpG6tP1AFAGQRb0PYh1sCnbhVES7xKkgqrP1
         gexvPXdd2amMBs3aL74/ZObEhj/DGUNxFK6ks2mw3uAoxd7kS+2hlV17mZfZ02aQed
         qFKcF2YIWGtCA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DEACE15C02E6; Fri, 12 May 2023 18:03:11 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com
Subject: [PATCH 1/2] ext4: add bounds checking in get_max_inline_xattr_value_size()
Date:   Fri, 12 May 2023 18:03:06 -0400
Message-Id: <20230512220307.1412989-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <ZF6vgw+DUP7/orzj@mit.edu>
References: <ZF6vgw+DUP7/orzj@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Normally the extended attributes in the inode body would have been
checked when the inode is first opened, but if someone is writing to
the block device while the file system is mounted, it's possible for
the inode table to get corrupted.  Add bounds checking to avoid
reading beyond the end of allocated memory if this happens.

Reported-by: syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1966db24521e5f6e23f7
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d3dfc51a43c5..f47adb284e90 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -34,6 +34,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -57,14 +58,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
-- 
2.31.0

