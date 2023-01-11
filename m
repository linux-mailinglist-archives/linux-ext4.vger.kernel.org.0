Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43990665F8E
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjAKPqT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbjAKPpm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:45:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF939FB6
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:43:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20FEE8B8D3;
        Wed, 11 Jan 2023 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eDpHMFOwJ7Imien0QpSOQ3X4KMxSthjAjrPjJ/A2yw=;
        b=YyeYZkD7n5nSD58tK8w1PGsAiWyqYR2sorp6bweXNQwp5/6axd3vAVSCz+35OahwToKmDf
        wnuNj39+XPRrUrMTLpfqXA0GDVIiObI95W7Ld+JJANDR9T/HRyhouM5Nk2wy9NfnTOz+Jv
        pEwjGM0Nksp+7uRc8VBTlQhnPrx1w1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eDpHMFOwJ7Imien0QpSOQ3X4KMxSthjAjrPjJ/A2yw=;
        b=l9l47LUKAse16ObMufLnouCOE7p2hp2Op5gB78y5/0XAhYVFxTAwdKvQkqJTefoNLh/4ZD
        l4z9C5RmiG+JUTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06E8313594;
        Wed, 11 Jan 2023 15:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nV6jASzZvmPPOwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 32E2BA0752; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/7] ext4: Move mpage_page_done() calls after error handling
Date:   Wed, 11 Jan 2023 16:43:30 +0100
Message-Id: <20230111154338.392-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=jack@suse.cz; h=from:subject; bh=TTp6BPUOiVSDwO9eHBxXU6rfjaCY0QsiMMuLhfjClZ8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkhpwZfI0H6Jz4ybZBzDI0gKM8BzgSWBcWS87ax zKzdMC+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZIQAKCRCcnaoHP2RA2aFACA CBqQfuJvLMZhMlayyZR8ApJF0iumvB3LKzxl1YwmHWBtRQHeE0LAQ9Y2ZpNujTuKhAPNzEWTCvFadM VAOkjPLF1p031gP/S0sNznDqWRjptO31vxvMu0fPt8k47G7sqevEnnGGEAauy6GDsqwLWumo4lditI RHfxtZWXl0xRPpEhlQimfcqtvJez7Jv/JLFqyF3lIso4UnjR1awjAnEPeGU0DBdooXjX1OJw/Twv1s Is1n+typtcmjonzjGB9k8Ram0N1C0fouPvNOQpcuNzg6LgK0pWoJJuE8M2hJMdB0YJamfGUXsdtKkl Q5rGFZX467qV42Du0jlrItaSA+m3t8
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

In case mpage_submit_page() returns error, it doesn't really matter
whether we call mpage_page_done() and then return error or whether we
return directly because in that case page cleanup will be done by
mpage_release_unused_pages() instead. Logically, it makes more sense to
leave the cleanup to mpage_release_unused_pages() because we didn't
succeed in writing the page. So move mpage_page_done() calls after the
error handling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 28b59e078a1d..d0102b1c6b27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2230,9 +2230,9 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	/* So far everything mapped? Submit the page for IO. */
 	if (mpd->map.m_len == 0) {
 		err = mpage_submit_page(mpd, head->b_page);
-		mpage_page_done(mpd, head->b_page);
 		if (err < 0)
 			return err;
+		mpage_page_done(mpd, head->b_page);
 	}
 	if (lblk >= blocks) {
 		mpd->scanned_until_end = 1;
@@ -2362,9 +2362,9 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 				goto out;
 			/* Page fully mapped - let IO run! */
 			err = mpage_submit_page(mpd, page);
-			mpage_page_done(mpd, page);
 			if (err < 0)
 				goto out;
+			mpage_page_done(mpd, page);
 		}
 		folio_batch_release(&fbatch);
 	}
@@ -2673,11 +2673,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(page))
+				if (ext4_page_nomap_can_writeout(page)) {
 					err = mpage_submit_page(mpd, page);
+					if (err < 0)
+						goto out;
+				}
 				mpage_page_done(mpd, page);
-				if (err < 0)
-					goto out;
 			} else {
 				/* Add all dirty buffers to mpd */
 				lblk = ((ext4_lblk_t)page->index) <<
-- 
2.35.3

