Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79A70F475
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjEXKpB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEXKpA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 06:45:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A961598
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 03:44:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6862E22216;
        Wed, 24 May 2023 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684925098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oF66gYTB+QJSrVWI5RQG+Ao4fzWor/HhKUumZiTVkUY=;
        b=Zu0r1soRm7McpET6O/13sBoq40nW4Z7NDdCwU0Ibk2pTdtPbLcvHy0lPgI2uO1O29FDvPM
        4xMJckKmR9SeDCyxSB5jrUf2Ta8fiOfUALe62iQm9XLNNRjH2puYSI+GmBXFPBWCmZ3fXD
        GTnXJRddJeZZ/ColGbOQIpWG+VqQXCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684925098;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oF66gYTB+QJSrVWI5RQG+Ao4fzWor/HhKUumZiTVkUY=;
        b=k8+S6YJ/ZW7iDI3an2ZpZ5uWLlxXnDyBm2WxrOM1gdNTZQnLrxdYARkQMHQ3pGALLX/3aG
        kR5uwxvpyvWh9ZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B34A133E6;
        Wed, 24 May 2023 10:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6M89FqrqbWQ/LAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 May 2023 10:44:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E101CA075C; Wed, 24 May 2023 12:44:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Whitney <enwlinux@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix fsync for non-directories
Date:   Wed, 24 May 2023 12:44:53 +0200
Message-Id: <20230524104453.8734-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=jack@suse.cz; h=from:subject; bh=CnRcWpd6OnMHLy8/NZ55lHLQg3F2ybI4ioyT51lJNHc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbeqfFO1A3LPH9Paeik1Y+6+DlD10KnitiqDCrLSz 9ePz32iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG3qnwAKCRCcnaoHP2RA2Tn0B/ 93Mb+xkVoQjg2Ytljh2wgyrXZEvFWIaMcAL3Sg5W55KkcPSXFEN7OOc2l0kjnDiBy3DheRqu8iQ/7p g9zlvM9N0uWjuHwcnkTYlWh2GkLqm981gmg4dNHIT1H0mvrtk3BUDHtJY2vQsXj1w+8MJlp9tsB7kB GTChfaRfoZBkpHbZg0Gx3okbnLW4f/ijxDDXf4RaSSlDSglJP+AFGxHC4nVOLb6oBv1iTKqRYrE3yl pur7K3MTOLlBmBb9aLtmUVK/bCTGpc33jsvpDz9tNfZmSCa32OGKqdVjeoAqke4lpeQISeIyFcvYhy fquiGizVbTbUbbgkcnD9Q3197UMAXk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit e360c6ed7274 ("ext4: Drop special handling of journalled data
from ext4_sync_file()") simplified ext4_sync_file() by dropping special
handling of journalled data mode as it was not needed anymore. However
that branch was also used for directories and symlinks and since the
fastcommit code does not track metadata changes to non-regular files, the
change has caused e.g. fsync(2) on directories to not commit transaction
as it should. Fix the problem by adding handling for non-regular files.

Fixes: e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Link: https://lore.kernel.org/all/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fsync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index f65fdb27ce14..2a143209aa0c 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -108,6 +108,13 @@ static int ext4_fsync_journal(struct inode *inode, bool datasync,
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
 
+	/*
+	 * Fastcommit does not really support fsync on directories or other
+	 * special files. Force a full commit.
+	 */
+	if (!S_ISREG(inode->i_mode))
+		return ext4_force_commit(inode->i_sb);
+
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
 		*needs_barrier = true;
-- 
2.35.3

