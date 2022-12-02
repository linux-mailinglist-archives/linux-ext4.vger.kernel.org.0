Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8D640D94
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiLBSlp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiLBSl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A2ECA1F
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6036421C6C;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRL9HSNDPxndL/iWjvKgnJTLS0SyU1yRnnF/bjgnqSg=;
        b=Ub39c4t99QJXJcZl3bC4lKktBvkJ5rItLX1tDJJ/A1wPcqonis33SEAnsIAXPzb03w+yfU
        deb1KCqko4VPochJa6iDClCqTSZFHiFLe1C8JWb/sUJU0pxee0xY4dg92+cZvN/0/TiYPT
        qrnV2WMgopnJDRCBfu60JBtDdSS/JTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRL9HSNDPxndL/iWjvKgnJTLS0SyU1yRnnF/bjgnqSg=;
        b=ymoxc5OpLTjaFLLmaTfs1bBI8U+wVgZWniaAYhro2Rb5VVzFOj+r+AzB8E9KOYB7kHd+03
        8eTwzZxI5QopOcDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 53055136CF;
        Fri,  2 Dec 2022 18:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id p75DFHBGimO/ZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 75F5BA0723; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 8/11] ext4: Switch to using ext4_do_writepages() for ordered data writeout
Date:   Fri,  2 Dec 2022 19:39:33 +0100
Message-Id: <20221202183943.22640-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=jack@suse.cz; h=from:subject; bh=1DpiIb6jrYzzd8S41J2Oi6C2LCb51db7zasTxtbdn0Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZkiFRrb1UumImEoDzsbG/JPo8cQ2I82qGic2UO 6eUKvr2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGZAAKCRCcnaoHP2RA2eg7CA C83th3POI4N917JA1m1RmoeJt78BCkFPbSCliZ6FrlW9O3SeWifeCGu681Q+mUgv/Qimi48b7+cHBG UeGxLhodhPt5UWI2TvWp64xDOVnf3syonTCCLPnCRYXQpJzgJiVuHoREC/WGTEXKpH3vtZRkjHExHa pP2wCHlRpt7TBZQBXzad1snZDtK35nW984BW5vl508ydx5zk57Q04tgGBwAm2mudDl+Yre2VnaXdJH 9puuvI/dsijdT8cAzdryoA+KNniBr+DVLrE6w0U+Ut82mSxBY50/K5Z6aZE3R6mh8T56Q085VmardQ gVjCvMJDnnvTz53zIKz5ummEa+l6bA
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

Use the standard writepages method (ext4_do_writepages()) to perform
writeout of ordered data during journal commit.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 16 ++++++++++++++++
 fs/ext4/super.c |  3 +--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1b3bffc04fd0..07b55cc48578 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2999,6 +2999,7 @@ extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
+extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index aeef57d907c6..88772e1ddd3b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2952,6 +2952,22 @@ static int ext4_writepages(struct address_space *mapping,
 	return ret;
 }
 
+int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = LONG_MAX,
+		.range_start = jinode->i_dirty_start,
+		.range_end = jinode->i_dirty_end,
+	};
+	struct mpage_da_data mpd = {
+		.inode = jinode->i_vfs_inode,
+		.wbc = &wbc,
+		.can_map = 0,
+	};
+	return ext4_do_writepages(&mpd);
+}
+
 static int ext4_dax_writepages(struct address_space *mapping,
 			       struct writeback_control *wbc)
 {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7cdd2138c897..c02329dd7574 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -540,8 +540,7 @@ static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 	if (ext4_should_journal_data(jinode->i_vfs_inode))
 		ret = ext4_journalled_submit_inode_data_buffers(jinode);
 	else
-		ret = jbd2_journal_submit_inode_data_buffers(jinode);
-
+		ret = ext4_normal_submit_inode_data_buffers(jinode);
 	return ret;
 }
 
-- 
2.35.3

