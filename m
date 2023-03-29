Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD386CED6D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC2Pu3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC2PuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5854699
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4C7521A1E;
        Wed, 29 Mar 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkxVP7aRumgmxpVKpT56v+Tlo7r4pDoPeQGbUaDkmhE=;
        b=FliYw8KYwhMftLl6DprkYm7781L8LhpTsrSGU/lvyKSqdJN2ZYX0xxiFnz5JKHUWP69dIe
        rMpUeelVGzgJ7ulBPgfV3CxVdGBX+kKawUy15SNgXrCnq22zc4QU3cB/HbG4BPzBv0Kr2t
        /f2am0ZtDJAq97rTiDKB9tqLkUtQObo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkxVP7aRumgmxpVKpT56v+Tlo7r4pDoPeQGbUaDkmhE=;
        b=87HM+mr6U4jIcNM7kj+aCzozmO0tW91XUXGH93JRNRqvY2Pm4pfzOb1zq00M3IUPPAWE9l
        6PEUGztLlTBlm7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAC6013A2A;
        Wed, 29 Mar 2023 15:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IpGqKSxeJGR4YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B5F3A074F; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/13] ext4: Drop special handling of journalled data from ext4_evict_inode()
Date:   Wed, 29 Mar 2023 17:49:40 +0200
Message-Id: <20230329154950.19720-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=jack@suse.cz; h=from:subject; bh=qucJxV+iEyD6sZZKBCazGMPu/mTeOpijMCAuab3mzsw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4T4g0jpTt2fpdinJ2XC8EskmU5EpLR+erwEjT+ ixdxh1OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReEwAKCRCcnaoHP2RA2UsRCA CXHsDuCj4aR1pI6LMv9XqnWdZWPO71Cauh2MsspiJc3P6J8/TBc4N4lpbrB1kf8qmEikw7UxItwb5X 0qvw3fE5kv2MT0MJtvtIm6cpn05HN1jc5jNr+ghjjYIJpDTckOkCnyexf830lf3qpYQ71kJFzi9MGe WfqjZ8u0JTMW8cGE2hWVc0XbnoybG7Ww8uuqbQ9t8pazFIuy8CyDHJVRnMdf6pliOjyF4yL4zLXFEr 4rAYwkHordd4C9fyJYGwL9gy+uOdaiPKYyy8RAyb3d5OTZDG1f59mzNVZksRBLvtk89zX3LWLH7BD+ 0P83u4oXKDTdF00+/x1on/SdpLoqVo
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

Now that ext4_writepages() makes sure journalled data is on stable
storage, write_inode_now() call in iput_final() is enough to make
pagecache pages with journalled data really clean (data committed and
checkpointed). So we can drop special handling of journalled data in
ext4_evict_inode().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3ab2d56b6840..94bfb12aaa9e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -179,33 +179,6 @@ void ext4_evict_inode(struct inode *inode)
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
-		/*
-		 * When journalling data dirty buffers are tracked only in the
-		 * journal. So although mm thinks everything is clean and
-		 * ready for reaping the inode might still have some pages to
-		 * write in the running transaction or waiting to be
-		 * checkpointed. Thus calling jbd2_journal_invalidate_folio()
-		 * (via truncate_inode_pages()) to discard these buffers can
-		 * cause data loss. Also even if we did not discard these
-		 * buffers, we would have no way to find them after the inode
-		 * is reaped and thus user could see stale data if he tries to
-		 * read them before the transaction is checkpointed. So be
-		 * careful and force everything to disk here... We use
-		 * ei->i_datasync_tid to store the newest transaction
-		 * containing inode's data.
-		 *
-		 * Note that directories do not have this problem because they
-		 * don't use page cache.
-		 */
-		if (inode->i_ino != EXT4_JOURNAL_INO &&
-		    ext4_should_journal_data(inode) &&
-		    S_ISREG(inode->i_mode) && inode->i_data.nrpages) {
-			journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-			tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
-
-			jbd2_complete_transaction(journal, commit_tid);
-			filemap_write_and_wait(&inode->i_data);
-		}
 		truncate_inode_pages_final(&inode->i_data);
 
 		goto no_delete;
-- 
2.35.3

