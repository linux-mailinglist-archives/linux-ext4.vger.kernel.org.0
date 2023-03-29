Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB26CED62
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjC2PuB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjC2Pt6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:49:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F54C13
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 185AB1FE06;
        Wed, 29 Mar 2023 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680104996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MWnBp0VUfnENKN7Bz8LG/W3hpagIiZqnvYASV9HfGk=;
        b=MNXVBxITu5YUGjEVgqQS1ATOYNUCjBCirfpe96eTVZXTFDSgmgCdlQjvjTIy+McCI6Orfl
        MH/JYE7ci7wj3OAbrr7PLcGioxte5eK/zkm335Vbnn2Db0IXL7HiCenUmIdeNRllASs1Z5
        EmtFOmB4oGDf+nH6ZLFOIn3EZkTKpbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680104996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MWnBp0VUfnENKN7Bz8LG/W3hpagIiZqnvYASV9HfGk=;
        b=E5kPDQlkQ3xltRUDzcUJjp9l0W1BEO0XL8Mz4iSqy1EmdbsofBoHx9L/jlpYpgSCa6PzKC
        oa66v7VrKnRXQgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF79413A6B;
        Wed, 29 Mar 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5LwsMiJeJGQ6YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34557A0729; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/13] ext4: Mark pages with journalled data dirty
Date:   Wed, 29 Mar 2023 17:49:33 +0200
Message-Id: <20230329154950.19720-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923; i=jack@suse.cz; h=from:subject; bh=4CACrAhgp2gKwcaBMvpEb+LcmyosLjHrV+HfFtYzpPc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4NsRxilcjDLoFUs6GXdPaVUZoS46b4kwBB7F+r SNOIPqeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReDQAKCRCcnaoHP2RA2XYfB/ 9wzvoTYRVTxJtLJylW32Ch/qy/rzLN6HnUB9i0DbYOh0xry8QiJPa0tFWfqDPyPBk090zLVztxBIVs OAWKEBwkH9Zio5KEpkADm5uZSKn5SUMyYzeEM+P8871LEnkt/dT1+yKPKcSn4roGUDGqvQXtjDMsOM P6ACFVyukHOg3SNUPty+uYe9rm2Yw2obLhzxTlIAbN6bR4sk01xa2XM5smGXRC/XoIIPzPS7UI2lGO SPOt0cBl+wsLaSqpg80lPXPVMGIG4WxWfzKQqTOOOIHpdFYIkRfWvG+Fxs1X2NApQp+iuTQZriGSh3 0OR40+U1QR6i3mTmwvPeY1BboYanMt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently pages with journalled data written by write(2) or modified by
block zeroing during truncate(2) are not marked as dirty. They are
dirtied only once the transaction commits. This however makes writeback
code think inode has no pages to write and so ext4_writepages() is not
called to make pages with journalled data persistent. Mark pages with
journalled data dirty (similarly as it happens for writes through mmap)
so that writeback code knows about them and ext4_writepages() can do
what it needs to to the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dbcc8b48c7ba..73e24e61fdd2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1003,6 +1003,18 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
+/*
+ * Helper for handling dirtying of journalled data. We also mark the folio as
+ * dirty so that writeback code knows about this page (and inode) contains
+ * dirty data. ext4_writepages() then commits appropriate transaction to
+ * make data stable.
+ */
+static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
+{
+	folio_mark_dirty(bh->b_folio);
+	return ext4_handle_dirty_metadata(handle, NULL, bh);
+}
+
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh)
 {
@@ -1025,7 +1037,7 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
 					    EXT4_JTR_NONE);
 	if (!ret && dirty)
-		ret = ext4_handle_dirty_metadata(handle, NULL, bh);
+		ret = ext4_dirty_journalled_data(handle, bh);
 	return ret;
 }
 
@@ -1270,7 +1282,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 	if (!buffer_mapped(bh) || buffer_freed(bh))
 		return 0;
 	set_buffer_uptodate(bh);
-	ret = ext4_handle_dirty_metadata(handle, NULL, bh);
+	ret = ext4_dirty_journalled_data(handle, bh);
 	clear_buffer_meta(bh);
 	clear_buffer_prio(bh);
 	return ret;
@@ -1353,7 +1365,7 @@ static int ext4_write_end(struct file *file,
 /*
  * This is a private version of page_zero_new_buffers() which doesn't
  * set the buffer to be dirty, since in data=journalled mode we need
- * to call ext4_handle_dirty_metadata() instead.
+ * to call ext4_dirty_journalled_data() instead.
  */
 static void ext4_journalled_zero_new_buffers(handle_t *handle,
 					    struct inode *inode,
@@ -3732,7 +3744,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	BUFFER_TRACE(bh, "zeroed end of block");
 
 	if (ext4_should_journal_data(inode)) {
-		err = ext4_handle_dirty_metadata(handle, inode, bh);
+		err = ext4_dirty_journalled_data(handle, bh);
 	} else {
 		err = 0;
 		mark_buffer_dirty(bh);
-- 
2.35.3

