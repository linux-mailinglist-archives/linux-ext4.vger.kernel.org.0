Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BD6CED65
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjC2PuN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC2PuG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD0D5258
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E27BC21A1B;
        Wed, 29 Mar 2023 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSHoy5sqEIsxfRrEwVp737xIrtbHS4OaWQUOqoD88/0=;
        b=TYQO5Ff9bLtZs13u3HJwEedwd40cMv+svm/enx0NgIHQZ0SHGEdkJpCmXuRxf0NMZIzr7v
        ZNN9wx4DW21BtcnZmo+xi4bTmNcwawzZYsyNcYNT7cf7IczgXCnRgn3M4sFyyxHXcnimyJ
        tdyHIDhu+ltxDX4NngfdlIdtPVn9aJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSHoy5sqEIsxfRrEwVp737xIrtbHS4OaWQUOqoD88/0=;
        b=Q6kRWouRbCA24o1tSXxvERcS7a2rL2Kc/lpV/H07DVNFu3/kAVdcRsFeXfHFjYkWzRC69j
        0kAGIDYUSMAgbFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7225138FF;
        Wed, 29 Mar 2023 15:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V3yuLCleJGRWYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4A27FA0746; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/13] ext4: Drop special handling of journalled data from ext4_sync_file()
Date:   Wed, 29 Mar 2023 17:49:37 +0200
Message-Id: <20230329154950.19720-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=jack@suse.cz; h=from:subject; bh=lzmTZToFAZLhUKG/l1ewqL7RDUtgwUySTRzjL32WFKw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4R+0u0e3OmEwlFCFAyrNvJ+e2goWyRaNVuV5Yj tFq1BSGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReEQAKCRCcnaoHP2RA2QYEB/ 0W92JuDp8u44T8NUqK6txpinz+5Qg3LEz7Ek8calUhWL1DsRU8L+1ujLT/ciWITsOktixn12vYkGKZ LY17g1qt0iKnGxnLRfOLZY3qckTKcvSwDdK+SQfl88gB3UfbPM5/PkFxL6TIncRj0oN/I85VVhHRyr x3XskxF+VmYCRI9DecnOCGv0EPHhTOrT9dMpcU6t5usOwusHsR5Y7x4R+Q0XGSRKzau29pkQqknVBl j5ItNByJTkfX9WEp3+v47vkmSbm6EampkmYfRhHf+0Pe6oggvgXxjmpDWL19aJaHiJgN+wVn5UQKDr dtkEnheEvWwecaYYLGmc/VhkRtXrqe
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

Now that ext4_writepages() make sure all pages with journalled data are
stable on disk, we don't need special handling of journalled data in
ext4_sync_file().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fsync.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 027a7d7037a0..f65fdb27ce14 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -153,23 +153,12 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	/*
-	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
 	 *  Metadata is in the journal, we wait for proper transaction to
 	 *  commit here.
-	 *
-	 * data=journal:
-	 *  filemap_fdatawrite won't do anything (the buffers are clean).
-	 *  ext4_force_commit will write the file data into the journal and
-	 *  will wait on that.
-	 *  filemap_fdatawait() will encounter a ton of newly-dirtied pages
-	 *  (they were dirtied by commit).  But that's OK - the blocks are
-	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
 	if (!sbi->s_journal)
 		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
-	else if (ext4_should_journal_data(inode))
-		ret = ext4_force_commit(inode->i_sb);
 	else
 		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
-- 
2.35.3

