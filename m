Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA736CED67
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjC2PuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjC2PuG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4725590
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8DC2C1FDFF;
        Wed, 29 Mar 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qginDrDPhWvURCYSKzNZeybzI8E2Q19RupKMewFftA8=;
        b=1aijEkaaS5niMv/YV5J2HI9snxD1Nv9GcUkv1o6yne15Ou4gT3s2UmW2RiDKtapcsxXzU1
        pcfUN7+/Atw/JfmL0vhXD/xrDBtuDjoGaH4hS2gzkvXB1wDgcR5bkV4Z79xJacgUIS4Yow
        R5Py78GF3R5j+X1GdacCs+md3fsWY8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qginDrDPhWvURCYSKzNZeybzI8E2Q19RupKMewFftA8=;
        b=DbW7HV/Lxs9PzjIDHvRHPmg8oYow2IYCzqLEyJU93xPayJNpEmp/KvKLzqjXV6NPQ3tosS
        EMaxqH9dBYtVFGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B09C513A2A;
        Wed, 29 Mar 2023 15:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y0AbKypeJGRhYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6611FA0754; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/13] ext4: Simplify handling of journalled data in ext4_bmap()
Date:   Wed, 29 Mar 2023 17:49:42 +0200
Message-Id: <20230329154950.19720-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3652; i=jack@suse.cz; h=from:subject; bh=MsyqEWAHaPf8fnwRj15WiSvHd22BcxkZdh7of5Oc1iA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4VNZsSmltjy1FxjmYG7BpyowaQLeqHAY1wJRo8 8ksso+uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReFQAKCRCcnaoHP2RA2UdvCA CRh8RwLsNVdXgiCXttvlx4N7gdDorU7KqE4MOtvnZ+S+TgZjoPVi3o04Ia53gpxMfuSy5mOxt5ZemD Ln2p5dj6E5lRqioehSwTsQPLhVszu3w4D5fH9LGlE0HLzrczmcpcuTQgMbV8dzoUch3EEdCtv8TLfv C3dYaeauw8NGO3lxmii9U6fMPWDUusOoV0ybtbF2iKKoDktT6oE/kUwNlsU1Kooz6pr98SnlwJHGqR ZOVB+yEeRl/+L1fIAM3fgrIlm43VNjFhsSoeEvS843jcNAXp9JRPXdkZmGOlX684gjnbsWsOF8Zny5 zDv6vWV0XveLRYRJG4ZNig+Nu0Aby8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that ext4_writepages() gets journalled data into its final location
we just use filemap_write_and_wait() instead of special handling of
journalled data in ext4_bmap(). We can also drop EXT4_STATE_JDATA flag
as it is not used anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  1 -
 fs/ext4/inode.c | 44 +++++---------------------------------------
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9b2cfc32cf78..7a6e03da5a3d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1887,7 +1887,6 @@ static inline void ext4_simulate_fail_bh(struct super_block *sb,
  * Inode dynamic state flags
  */
 enum {
-	EXT4_STATE_JDATA,		/* journaled data exists */
 	EXT4_STATE_NEW,			/* inode is newly created */
 	EXT4_STATE_XATTR,		/* has in-inode xattrs */
 	EXT4_STATE_NO_EXPAND,		/* No space for expansion */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94bfb12aaa9e..3c6bce0afb20 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1408,7 +1408,6 @@ static int ext4_journalled_write_end(struct file *file,
 	}
 	if (!verity)
 		size_changed = ext4_update_inode_size(inode, pos + copied);
-	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 	unlock_page(page);
 	put_page(page);
@@ -2334,8 +2333,6 @@ static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 
-	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
-
 	return ret;
 }
 
@@ -3079,9 +3076,7 @@ int ext4_alloc_da_blocks(struct inode *inode)
 static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
-	journal_t *journal;
 	sector_t ret = 0;
-	int err;
 
 	inode_lock_shared(inode);
 	/*
@@ -3091,45 +3086,16 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 		goto out;
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
-			test_opt(inode->i_sb, DELALLOC)) {
+	    (test_opt(inode->i_sb, DELALLOC) ||
+	     ext4_should_journal_data(inode))) {
 		/*
-		 * With delalloc we want to sync the file
-		 * so that we can make sure we allocate
-		 * blocks for file
+		 * With delalloc or journalled data we want to sync the file so
+		 * that we can make sure we allocate blocks for file and data
+		 * is in place for the user to see it
 		 */
 		filemap_write_and_wait(mapping);
 	}
 
-	if (EXT4_JOURNAL(inode) &&
-	    ext4_test_inode_state(inode, EXT4_STATE_JDATA)) {
-		/*
-		 * This is a REALLY heavyweight approach, but the use of
-		 * bmap on dirty files is expected to be extremely rare:
-		 * only if we run lilo or swapon on a freshly made file
-		 * do we expect this to happen.
-		 *
-		 * (bmap requires CAP_SYS_RAWIO so this does not
-		 * represent an unprivileged user DOS attack --- we'd be
-		 * in trouble if mortal users could trigger this path at
-		 * will.)
-		 *
-		 * NB. EXT4_STATE_JDATA is not set on files other than
-		 * regular files.  If somebody wants to bmap a directory
-		 * or symlink and gets confused because the buffer
-		 * hasn't yet been flushed to disk, they deserve
-		 * everything they get.
-		 */
-
-		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
-		journal = EXT4_JOURNAL(inode);
-		jbd2_journal_lock_updates(journal);
-		err = jbd2_journal_flush(journal, 0);
-		jbd2_journal_unlock_updates(journal);
-
-		if (err)
-			goto out;
-	}
-
 	ret = iomap_bmap(mapping, block, &ext4_iomap_ops);
 
 out:
-- 
2.35.3

