Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A427336A5
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjFPQwV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbjFPQv0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937813AB8
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9D3E21E04;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AIOjznxYYPI/+MmOL1C3A34YYZdCZSgvLfXqkAwEr4=;
        b=Im3iKElwcBeco+bI0yTWwBm85PHCuMHYGFl/04pabw6i50V2z8EEk/Kf3nYEWkFCbtKv2X
        heA2tyqZW+0CBs+a5qdcYDFMWucWvtGVr4Ah3LJn/Jr9AJFoX+NRXCFb8H2SqzHPHCT2Tp
        aW5HyhgcS4S1UKDZgcADTYGjq0J01Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AIOjznxYYPI/+MmOL1C3A34YYZdCZSgvLfXqkAwEr4=;
        b=CUWcSyLbPdrdZ02DEhuV6c5ElEogLcomhy6yN/qEnU4B9FqOpyw+FEmS4IN4tVDFmjq5ai
        k+WkV3/yVEjuJMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A852F13A74;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qbQIKf6SjGQ+IwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9585BA0767; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/11] ext4: Drop read-only check in ext4_init_inode_table()
Date:   Fri, 16 Jun 2023 18:50:54 +0200
Message-Id: <20230616165109.21695-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=jack@suse.cz; h=from:subject; bh=NH65IBbC9qMlBKI6g+53iOZKmYC1eG/3hHow1k3cOTM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLtRaV+2pDIkVe/Gwy13AbpFqpYH8UJTbUe9QKh DlGLN/CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS7QAKCRCcnaoHP2RA2SQqCA DJA0eMy96tgVOaYHm6ItK61ZTZ2ezKpg7ap6aKOjSLNZRIcC/zoXFUvfC70n6dRHD2vLVwgZdQIBo1 /ygG0rojgTCZnTYU/dbZvLovZJRwuEayHkO+FDDcIODAl/H1KTw8M0JZbdEA1GENHwkmzzyOsxhjiU 2vv7EmoBsaHSPZUH89TQuKD3q+F+ctRQC6Mb2F3UmXevqsWmSziErJVYmbPuMCbkLpJjVi9JsrzV3t 5MnQ8Xw0NHqZJuiqLooJgfHXX4E5jdvIvwQFYOfBus3QI7M3JYN1JwrMZxrKRvLbjWBy4kBIl6S18j 5uCyw47Ck6KxN2tKe80ZFXaKYc7z/3
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We better should not be initializing inode tables on read-only
filesystem. The following transaction start will warn us and make the
function bail anyway so drop the pointless check.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ialloc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 060630c0b0ca..e0698f54e17a 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1523,12 +1523,6 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	int num, ret = 0, used_blks = 0;
 	unsigned long used_inos = 0;
 
-	/* This should not happen, but just to be sure check this */
-	if (sb_rdonly(sb)) {
-		ret = 1;
-		goto out;
-	}
-
 	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
 	if (!gdp || !grp)
 		goto out;
-- 
2.35.3

