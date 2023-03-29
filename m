Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BE6CED6F
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC2Puc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjC2PuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5B55AD
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C958121A20;
        Wed, 29 Mar 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NxcFGA9NBM1mZDsYhaMJSrXtll2l3LazqbMz1KQdrw=;
        b=hru2ow85E4RI1rT58/ifXuKlQRF75DAp95b4Tfvh5fbGTuUQmsR4oOSCGz5AKimaUND6yl
        tS9LFv+JC1MXI01Auj1PF6FhxwAKmAPcxQgaD8lCyuv9QeGQ4L/dq/1avakBCxBofnlZET
        dlotJfDkuk1qcEAwbAoWcBvvyVvR/xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NxcFGA9NBM1mZDsYhaMJSrXtll2l3LazqbMz1KQdrw=;
        b=qkmp+C3n9Fni06Zt9eEo8S3Asdp9pFssWlSH4ZQ/pS9GtQfak8OdayMcx4nUXpQrNw2ULh
        D/Fxs2INKVkSYTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B029513A6B;
        Wed, 29 Mar 2023 15:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oef9KixeJGR5YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5051AA0749; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/13] ext4: Drop special handling of journalled data from extent shifting operations
Date:   Wed, 29 Mar 2023 17:49:38 +0200
Message-Id: <20230329154950.19720-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=jack@suse.cz; h=from:subject; bh=8jIC0uqJEaJBZTrcP/P9flmMUsS09b+4tuzBQjUnk8w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4Se4EaAfYN7Xme4QnBP1E68EFgr3cmO8JispCo IqsMA0uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReEgAKCRCcnaoHP2RA2alsB/ 9HtyfjrH1iTU4C5tuUkrcx0BB3QA3m0oY6AI3fPVmD9iD1RNym3srkwV5w8ZgMxDYXjCOaNvIAAbBF gJwa5O0oKjiBFzaptiksnKV0007IucaqDOMeii9BjOIHfya5PMwpIbZA/NyuxCUjdO4HGj4hx/3zT3 nIj2O6XHTDq/VYm0RDnUWsgoHxOBzbUInRx/OYwsU6H2Zrv81X0Mspa6vxEXJflPMujpa0NsWQ2m3Q nNP1F6weGZmihzJeP8kPaOboHe3W9R/m7XzBK7dutSc3jN91O1SDnNeBULuLjz1d5hcxo91jUj5pX+ hN9QGI1ZxlrJAWftOJ2CtdItiTtJpi
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

Now that filemap_write_and_wait() makes sure pages with journalled data
are safely on disk, ext4_collapse_range() and ext4_insert_range() do
not need special handling of journalled data.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..0b622ae29a73 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5290,13 +5290,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
 	punch_stop = (offset + len) >> EXT4_BLOCK_SIZE_BITS(sb);
 
-	/* Call ext4_force_commit to flush all data in case of data=journal. */
-	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
-		if (ret)
-			return ret;
-	}
-
 	inode_lock(inode);
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
@@ -5443,13 +5436,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
 	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
 
-	/* Call ext4_force_commit to flush all data in case of data=journal */
-	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
-		if (ret)
-			return ret;
-	}
-
 	inode_lock(inode);
 	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-- 
2.35.3

