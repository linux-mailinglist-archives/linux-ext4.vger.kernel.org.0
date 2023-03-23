Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7D6C6B9B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjCWOyK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjCWOyJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:54:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B5196B2
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:54:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 863341FE92;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679583245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKRAlNt64iKYXXbCZJYG2+NeCIHtLmxkDAc5tTzA+1M=;
        b=Z6U128bWqbe5pWWwoxDT0JQUWHSSuKmTEYBlSTQGuRTbcWhRlf5LlXexZK1WbuZp13RP/7
        aJ2GFhINofqb381mz6W6dIXsxQ4WSAoLgZQQhC8iQlrM8lqTUX1Djh/V3otjLieo1hz20k
        POtBBCYKARodnE0drdcU6famk8jks18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679583245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKRAlNt64iKYXXbCZJYG2+NeCIHtLmxkDAc5tTzA+1M=;
        b=HsSE0EdcVpzH8OZsRDHkZZFAIl8btr4QTgzfDn8ji5LCGNR1RyOy58e2rLzl/l5XNr4xR6
        O48Ucu9m/jv1zEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75DD713A2F;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Us4pHA1oHGSdDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 14:54:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C6CBDA071E; Thu, 23 Mar 2023 15:54:04 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] ext4: Fix crash on shutdown filesystem
Date:   Thu, 23 Mar 2023 15:53:59 +0100
Message-Id: <20230323145404.21381-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230323145102.3042-1-jack@suse.cz>
References: <20230323145102.3042-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=jack@suse.cz; h=from:subject; bh=1Mcqxse+4pvCNgWMJO09+091ZcUMGLycR2cUG+2cfRo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkHGgGAiZ5MfVkM9vDppEFki/hVesEPYWtu56vnK7J 9f5HpYOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZBxoBgAKCRCcnaoHP2RA2bUbB/ 0ShYeh63ONwoE2lIm7yD/2vdsWoKwhWK/1Yr1YT2o7Uazv4Eye0Dw89W7d879oYax29GMFT6Xjir+t IZ3LNzxQPJ26qqw2slz3oSMkFjpeTZxQWMn1t8kDAoS4mqar3ANN/SsjMcZLf6w2Aq3zBtTmfHbYoM o4V7JohMlwIyL1EtHh8BnS1tpAdpY0AIJFoF4lLMa14Jjo/gPNEf30L79vcSiBtX0ZtM85a0gNPUey NLp+4If7gCZqELDl6c7S7B6gMBRRmzxTLWBA2TEL8e1pEtm9Ia+2KC1lGiLST7vZRnq+csB+EuhOsE gSLKJzddKUz3RWcB4YyGBZyc4TaqKX
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

Test generic/388 triggered a crash in mpage_release_unused_pages()
because a page in mpd->first_page..mpd->next_page range was not locked.
This can happen in data=journal mode when we exit from
mpage_prepare_extent_to_map() before actually initializing
mpd->next_page. Move the initialization to a place before we can exit
with error from mpage_prepare_extent_to_map().

Fixes: f7233fb54d18 ("ext4: Convert data=journal writeback to use ext4_writepages()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 15bac8181798..dbcc8b48c7ba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2428,6 +2428,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	else
 		tag = PAGECACHE_TAG_DIRTY;
 
+	mpd->map.m_len = 0;
+	mpd->next_page = index;
 	/*
 	 * Start a transaction for writeback of journalled data. We don't start
 	 * the transaction if the filesystem is frozen. In that case we
@@ -2443,8 +2445,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			return PTR_ERR(handle);
 	}
 	folio_batch_init(&fbatch);
-	mpd->map.m_len = 0;
-	mpd->next_page = index;
 	while (index <= end) {
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
 				tag, &fbatch);
-- 
2.35.3

