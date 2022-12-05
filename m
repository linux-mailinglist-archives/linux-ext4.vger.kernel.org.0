Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEE642879
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLEM3i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BAE1740D
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31F0621EE1;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Nhtqr8UdriMk3AjDYwCLDj+xnYpZDjboz9Lzk4A8nk=;
        b=Q1FyeEyPSwq5o/BnvaCS7LbK6gGjR/Tn8skndE6oOMFLV3kl6U9tJRG8bNxMb3oq/IL7cV
        6BcG7SVJMTzLkvMC9rNi1itATh6PJ2Mh/BJhoqTECQuspQNycB9Mwc8SuLE+Hggddyqa42
        HaoiQuYVTq5fXZY5/Uc1pIW6MpWfz68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Nhtqr8UdriMk3AjDYwCLDj+xnYpZDjboz9Lzk4A8nk=;
        b=VNvkl88v7cM20sfK+R5vwMRWiaZfcBqQmCOwQbdb3AWU2ZdH/we7HPTaooAYjZ4ZcdvO0/
        plmVTV8lmLYj6DCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 19CED13980;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 61tLBirkjWMiTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 70ECEA0736; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 09/12] jbd2: Switch jbd2_submit_inode_data() to use fs-provided hook for data writeout
Date:   Mon,  5 Dec 2022 13:29:23 +0100
Message-Id: <20221205122928.21959-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=jack@suse.cz; h=from:subject; bh=BwhuXcDi8ihTJ1g4K2G+XR7kilsjYpigi3eooLgj1Wg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQjKJLB5Af/xkDBCmsVQDb+UPi+dX+R4/U3QGNB teu4GI+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kIwAKCRCcnaoHP2RA2fR/CA CTY6pLtF0wjD+Osh4JU2cwP2aUcGaFrn+wvaXO2/Z+WPO61HyKhjQvxxK/q7jdVmYK0Stjpdd2Ji7R 1HcaCjH+jTttivJIMpOYrGSh8PzVCeNaY3mi6zaFD7MMjVSXKl7dnQtw83IV/pdWkVsutDMTMoarwf R5K/tGAuuctoZ9x3SRhKtpMttY1a6UHMwMCQfAS9OaXVmj6zvhWNOZm7nHlDF8W46B4ZFu0nCea8h/ enL6KJODYq9of7EcapyScSwi3zmiS9wY9R4DIUMZG/dy/ErkXnLL4veTLy22xKZ0xsBIizS/BFj14P wSJq4ke2HY99MQfI3XD5MGmLhPCLbj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_submit_inode_data() hardcoded use of
jbd2_journal_submit_inode_data_buffers() for submission of data pages.
Make it use j_submit_inode_data_buffers hook instead. This effectively
switches ext4 fastcommits to use ext4_writepages() for data writeout
instead of generic_writepages().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 2 +-
 fs/jbd2/commit.c      | 5 ++---
 include/linux/jbd2.h  | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f6d0a80467d..7c6694593497 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -986,7 +986,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 			finish_wait(&ei->i_fc_wait, &wait);
 		}
 		spin_unlock(&sbi->s_fc_lock);
-		ret = jbd2_submit_inode_data(ei->jinode);
+		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
 			return ret;
 		spin_lock(&sbi->s_fc_lock);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 885a7a6cc53e..4810438b7856 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -207,14 +207,13 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 }
 
 /* Send all the data buffers related to an inode */
-int jbd2_submit_inode_data(struct jbd2_inode *jinode)
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
-
 	if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
 		return 0;
 
 	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-	return jbd2_journal_submit_inode_data_buffers(jinode);
+	return journal->j_submit_inode_data_buffers(jinode);
 
 }
 EXPORT_SYMBOL(jbd2_submit_inode_data);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0b7242370b56..2170e0cc279d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1662,7 +1662,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
 int jbd2_fc_end_commit_fallback(journal_t *journal);
 int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
-int jbd2_submit_inode_data(struct jbd2_inode *jinode);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
 int jbd2_fc_release_bufs(journal_t *journal);
-- 
2.35.3

