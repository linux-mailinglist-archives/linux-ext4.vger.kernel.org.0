Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C06CED69
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2PuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC2PuJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F855A3
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCC781FE02;
        Wed, 29 Mar 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRmkW0qb4fys9NMkqeRrsj5zDndaJRM+zfKkBoiiJVI=;
        b=MEjboS9JAPSdCdge8VAEhDN5aXMkX1aVX30lXf4kiIVGAFMm15Y7qT9WBE0yRZu3EGfkfj
        yOoZjfGbxiuoppTZTJOXHh2PREF+u7BgN2QARdoJuSzUDwdv5WyOG+YT7b4Uo5o3s6G6cE
        OqbKpUCHSoGD/0zp3eUqfFIM1O4WhSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRmkW0qb4fys9NMkqeRrsj5zDndaJRM+zfKkBoiiJVI=;
        b=V36XKE3NmdculiBiup0MDDOf1091tRVyWrtwKlRonD2UzhFSVrKDAvL0lwUoaLaUy9Irmp
        yi88OUIMA0toJ8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FFDC138FF;
        Wed, 29 Mar 2023 15:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t0EPJyxeJGRzYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55D87A074D; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/13] ext4: Fix special handling of journalled data from extent zeroing
Date:   Wed, 29 Mar 2023 17:49:39 +0200
Message-Id: <20230329154950.19720-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=jack@suse.cz; h=from:subject; bh=qQt8lHuUaPEzuywVrhv+LJKsM8HEzM4DCZEVJ+Li5n0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4TS6UgZfdHrw2WE4jB03wlIrTe+IhioT7eM6r+ ho0OUh+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReEwAKCRCcnaoHP2RA2UDFCA DsPpCMxG60gHMZUZxJOCoauvXQt3pT14rG4gD2NhRXWAWjhbJF5uMT338GuUBEQ6cw5fkSu31JRgzo wu9rjRJOrSuOG0y5vZdhcSTxtUvlTJ+nULh3UDcHebtNQJiI/hEOpxcxJc4JVqCrSrUPhV+2lyaINO DMxaWkK0UO3fA0Yr0dYWwi8G2nLELr8YIkeR+x5imJangZAYeJEllhudzgL7CGMwa1GGvAHlhWReBr SkZxM44upfPQ7vtM1x/NF388qcAavMoBezhXQl4dzmt/ylzhUL+hrSigu/FZ8XrHXWdQ5i74LJg2iq 1s4OhcQt/KVTDLeB1K4pyP8y8kdxcI
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

The handling of journalled data in ext4_zero_range() is incomplete. We
do not need to commit running transaction but we rather need to
checkpoint pages with journalled data. If we don't, journal tail can be
advanced beyond transaction containing the journalled data and if we
then crash before committing the transaction doing the zeroing we will
have inconsistent (too old) data in the file. Make sure file pages with
journalled data are properly checkpointed before removing them from the
page cache.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0b622ae29a73..e79c767cc5e0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4526,13 +4526,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	trace_ext4_zero_range(inode, offset, len, mode);
 
-	/* Call ext4_force_commit to flush all data in case of data=journal. */
-	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Round up offset. This is not fallocate, we need to zero out
 	 * blocks, so convert interior block aligned part of the range to
@@ -4616,6 +4609,20 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			filemap_invalidate_unlock(mapping);
 			goto out_mutex;
 		}
+
+		/*
+		 * For journalled data we need to write (and checkpoint) pages
+		 * before discarding page cache to avoid inconsitent data on
+		 * disk in case of crash before zeroing trans is committed.
+		 */
+		if (ext4_should_journal_data(inode)) {
+			ret = filemap_write_and_wait_range(mapping, start, end);
+			if (ret) {
+				filemap_invalidate_unlock(mapping);
+				goto out_mutex;
+			}
+		}
+
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
 		inode->i_mtime = inode->i_ctime = current_time(inode);
-- 
2.35.3

