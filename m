Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987764287F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiLEM3s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiLEM3e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462EBC3E
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:33 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18F3E1FEBD;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBKreX3WrgErele8L7u8nVH17dq+EVu9oGvoF+vxPDE=;
        b=aA89OJg4EpqFuGG3SE118L0Qp1sBT6Q9ePvVXAq5P0hTCnhdTnT2b1TEVn+8c+EpE20dMp
        VwNf6ib/mgD52d3Og3nlZa3nsiB4sgLWGJlhUpNu2Y7Pg6OCbtNC2C9QCnPozOEW9w1EsH
        LEDzsI3LjsojSKl0hqQ4UhR4EPWigCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBKreX3WrgErele8L7u8nVH17dq+EVu9oGvoF+vxPDE=;
        b=p1QFwunTJh6cYSKZ4CeGTsNP6kQ8/7J3UV2q3x+vzALA/qTXu1sXGIYiGbjcF/87LHL9Ur
        3iYM3t04hLAucbAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0A5F01348F;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id S6yCAirkjWMbTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6AF03A0735; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 08/12] ext4: Switch to using ext4_do_writepages() for ordered data writeout
Date:   Mon,  5 Dec 2022 13:29:22 +0100
Message-Id: <20221205122928.21959-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=jack@suse.cz; h=from:subject; bh=Xla02KpoxUXAb9plraIfU2pPNCtU7kGlSHOadzf1kqA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQiAIGF8wiX8A0ogB0q+Wk3tz7lp59ACKhFyATW iXPC/9yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kIgAKCRCcnaoHP2RA2fUEB/ 9hapHHWJwoMQ1xJPvPGGfePwt6FKc3QFBgSU0ipBR53lftQS29gyQggHiCdCTHHV3gM4XWMh950Ied R8by6vFFauo43k2Ei+3qf1XHr7uq3qcTZfw9s0XdsSL79CtYWOD71i0pvx105cR8D1WtCYHLRed+Wp fUYn6WEU7FXiq/oMfcoLnCz5sohZ5PxnSA2Jp7m5Vz20Hn0kBQKcqn4cvrnHoV82sQfSbBBPAMt0u8 LV2QYUiA9S1XJvv9SeFGYmc2SeBZB29lN6/CH0Dhq+eD6d7SRM8+wsHHoY0MuXPM9Ck9SGv4y1y/l7 /PUVcnOIfrqgj+rP9RKYtcLsoQTGQi
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
index 4f8f4959524c..b93a436bf5bc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2953,6 +2953,22 @@ static int ext4_writepages(struct address_space *mapping,
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

