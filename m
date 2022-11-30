Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A963DAC8
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiK3QgY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiK3QgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A74880F0
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B950D21B11;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNcFZrDchNAcG7wnaRrC+qlgFFqQw1xJwvIcMyjzi/U=;
        b=U7p7LwYxmiUeQPjc32+DcgoND1P/CaIiCo3upXU3LNZbyz7ec6INjbyfyaCB/0wYWEjHL3
        ptHi186AeyMayWcZEoJt/hPyTyEtRehEcr5hUetpCc1e5stAnpQswhh1EXqPpgJdBLFXvb
        HTRlOEf1OKy0vLypHndWb8VsyoCQT0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNcFZrDchNAcG7wnaRrC+qlgFFqQw1xJwvIcMyjzi/U=;
        b=QwI/Gw5f2h9ZyWoSp60B09J1KBPRBbM4/aI/2WiawvoqMceDKsj9zKLSrcG+Yd4WjAgs4n
        BKS1Cby1T3qGbJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADBDE13AFB;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3H9mKnmGh2NhQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CADB7A071C; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/9] ext4: Move percpu_rwsem protection into ext4_writepages()
Date:   Wed, 30 Nov 2022 17:35:58 +0100
Message-Id: <20221130163608.29034-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=jack@suse.cz; h=from:subject; bh=CqrdRoULi30+1u2C8jYfDV3/nqlShtu4GpVS5vyMC3Q=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLb2/KyQ7ibvh3aGFES353i3PysS3/xMn1pjfemJ8PtSvTi wk51MhqzMDByMMiKKbKsjryofW2eUdfWUA0ZmEGsTCBTGLg4BWAiW1nY/wc4vxBYEyga/ej+C0v9rQ xSm5K75ufWfrzrqXnrgIyJ165X+53kPjxZ0959OfVa1bQrH+14WNnZ/Z5ycyi+ef3+7Qp/TolE8473 PVHXJFavytw4NVBOsS+VeWGQTOrKynPnHluJ1XzoZedyedoe3DTJu8R2kW7//k+RUVO2iXPa/GM9vm SPqG1yV1uDhObU/aefz11pXKpkZvvuXv7yppQTm3ctvX2uR+KY56Jf4fkzFz2KlnrtPOdZ62QLSaVp YrW5Me37NPunKlb92FTfY5+1y2Pes6LQ4/ePsXA3uvVr73/JIqYi8uxR5pkYEQmhO16iHR/seTUvX1 OIfBBa3MJdmaQyvY2118R8V0g6AA==
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

Move protection by percpu_rwsem from ext4_do_writepages() to
ext4_writepages(). We will not want to grab this protection during
transaction commits as that would be prone to deadlocks and the
protection is not needed. Move the shutdown state checking as well since
we want to be able to complete commit while the shutdown is in progress.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fbea77ab470f..00c4d12f8270 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2718,10 +2718,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	struct blk_plug plug;
 	bool give_up_on_write = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
-		return -EIO;
-
-	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2930,20 +2926,28 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
 static int ext4_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
+	struct super_block *sb = mapping->host->i_sb;
 	struct mpage_da_data mpd = {
 		.inode = mapping->host,
 		.wbc = wbc,
 		.can_map = 1,
 	};
+	int ret;
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+		return -EIO;
 
-	return ext4_do_writepages(&mpd);
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ret = ext4_do_writepages(&mpd);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+
+	return ret;
 }
 
 static int ext4_dax_writepages(struct address_space *mapping,
-- 
2.35.3

