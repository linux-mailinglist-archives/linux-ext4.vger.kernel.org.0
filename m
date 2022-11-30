Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6C63DAC3
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK3QgQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiK3QgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886F86A36
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C172421B12;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z441ZeCqEE0sfhCJc0co0PzncYIwOxI96zyBrV+QmUA=;
        b=WzzKU3ENdzn5dLGDvZqQ42IvX0XYs4WZRcndcRgLC64k9sj76dcWVBWGydLrqt7kY7I09K
        ZKlwX6ZxcFbn3zFe8ETrTfToZ637yoC3lcNCKu11lUf1/iwyanV2A0TfxqFuxSyw0wy0qH
        NJkCKljD/xsTV9ADiLEmYuvZrPPCFm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z441ZeCqEE0sfhCJc0co0PzncYIwOxI96zyBrV+QmUA=;
        b=4NbsOXjpoyi+P17xgOEQQUaIdlzqyKmQI8oYVIPL+Ku/dJOnu0jPlTRQmALUDJost8xjXt
        15rkGuqQ0CqXQlAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2CD613B25;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X9ylK3mGh2NiQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D07B6A071D; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] ext4: Switch to using ext4_do_writepages() for ordered data writeout
Date:   Wed, 30 Nov 2022 17:35:59 +0100
Message-Id: <20221130163608.29034-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=jack@suse.cz; h=from:subject; bh=xrZV+XmyUTBNF6kIFVC6Dhs/s/T7qbfVszfA0d8XoOU=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLb2/JTfPu2/2495yO+WrttUumXtbnsQqzzE2fdan68qaTv V01CJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAm8kOe/Q/Pu5YL3y9JnA3TMj2Yl3 rhyHqJOL3vh8oPp87+fC1q5SI1iZoFZ+71nnojfafmYr2pS0dwgYd6Qwm/KveDLEu+hUFWp51zfyfF Khv2dOw/6mr/Winjs7u2w6Nt1YJJ8UbBL5SdGLPq+Va9yPt0dM8O2U/+zOYSHxTS10Tt2HLT871uoL jmSh3hnZJWSxdu31dkaL5a1D79l2+84+3fdvwr9DY7xc+Q5/3kZflpSVPC5Qi94q5PB7qbre+3vbpV cVGLYw3TA0/xaMXvp6f7deVa7/gzsfeNVpuOtHatQq4iG9uG5ueTPsq+0wxweyDvsL7nY/In7+MCqZ 3n89jrnWy3Ho6w6U/VEmILvJsBAA==
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
index 00c4d12f8270..c131b611dabf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2950,6 +2950,22 @@ static int ext4_writepages(struct address_space *mapping,
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

