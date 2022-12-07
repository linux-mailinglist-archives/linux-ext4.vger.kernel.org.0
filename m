Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A156458FA
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLGL1q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51019C32
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:25 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC2D21FDCD;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBKreX3WrgErele8L7u8nVH17dq+EVu9oGvoF+vxPDE=;
        b=czKFWdO8cKaB/MZYfyQ84EgWWvbY3bWWAdzsRahyCFX1UJtHUXJCsGVhTsYFcgphsMVocS
        yyvisUlZjpFduBad6UMbK77ufGW+h8la3HW3JwqcsypG7vuYPLYUL8D/3pkVrgz8iI3PSN
        Th1ZM3r6XlI4r9bi/UAWgeAnmzCeWYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBKreX3WrgErele8L7u8nVH17dq+EVu9oGvoF+vxPDE=;
        b=c7BXSZzfIOeunBJou66xAhsnynR3lR5AqA+lj/eOfSZd7GvD5L2Tk975qwKJUe/stxTZTZ
        JZ2yZf2rTvia0WBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BF13413885;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id PoanLpt4kGNHLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0384DA0733; Wed,  7 Dec 2022 12:27:23 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 08/13] ext4: Switch to using ext4_do_writepages() for ordered data writeout
Date:   Wed,  7 Dec 2022 12:27:11 +0100
Message-Id: <20221207112722.22220-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=jack@suse.cz; h=from:subject; bh=Xla02KpoxUXAb9plraIfU2pPNCtU7kGlSHOadzf1kqA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiPAIGF8wiX8A0ogB0q+Wk3tz7lp59ACKhFyATW iXPC/9yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4jwAKCRCcnaoHP2RA2YeuB/ 9/fE4el91sUxnqc2mDP6cz0IWjX9aC4pgQRb1S60/me8oe9kw6993SlLDt0W4JzHQ+TMYoVZLSsTHL C0U1WBLomvB53NhK5M2R5NxQjlAsxqQ+y8+7IdYrTFb1//Qaxl34C6VkbU0dduyg2HkBjDO6xRm12D VANX9vjHno90G8U7FAH0FOJj14xfFSU6e2K/SgW7TvAlPwrY2OJ2VXCKlmEuchgw2ZcQh505jsmTDh ltP1w2ylpFSjW97Wh3SN2BRecHeEHK57+I2XRmdyXynvdDr/1E0w00abgNXALA/GRUyvBJ/GG1Huz/ lUb7Xr0w0A6d7+rJZSI5axOe87/xR4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
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

