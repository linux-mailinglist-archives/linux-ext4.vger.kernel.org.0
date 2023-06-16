Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B273369D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjFPQvw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbjFPQvR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644453AA9
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11ECB21C2C;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPPoq7BWNEYmKUdVuNJC643nwmffEPPxpbN4JBDnHWU=;
        b=gy1exNMIvQmO5nSt7l/UcGrTr99e0pnSEvXLI9FiShW55UVe82QnQ7E0jk5UzBggCB4a61
        3p7m0ZDhMlOmi3HWk1kgepa4cvWhEH6OJli1/L6Q8KIec76coVhavyHc0yB0nbW1pWQ+Nm
        WX0v8jXgTLNfc7cdqG15EH85yoyiKpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPPoq7BWNEYmKUdVuNJC643nwmffEPPxpbN4JBDnHWU=;
        b=3jMvLEHl/4Y24KI7cLIW1I/ZVlyJ1EQsAQ8Bf/nzSLA4rlUG/mCxtHo7tFJ4PPvy57orNm
        9fVFQWhnQXb8R2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0188D1330B;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xoNZAP6SjGQkIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 715D2A0626; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 01/11] ext4: Remove pointless sb_rdonly() checks from freezing code
Date:   Fri, 16 Jun 2023 18:50:47 +0200
Message-Id: <20230616165109.21695-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=jack@suse.cz; h=from:subject; bh=wgEILQQw3TNf73J+iVDhoFrUsnE/Y4j3BObZjZX/AXg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLn+S8svWP6ZWVVlkZsQ/tD3MWzFot5HmL8YTZn tJYSkLCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS5wAKCRCcnaoHP2RA2QDDCA DPKuWaizap1l9yaqlg2j/VgXK3dh3Ko2z41x7U5e7vY/RvkWGT9jc9PpgjiydR9c5O1OMiOFixOhjA UZSewNWTQ6O9xBaashr3p0ozBgPXW+xPnh5aiyOf9joPu7mdVwra45000l5DuqpGWtatdVIi18/FPp ne1jY3kZ9QVrUCN/niQFsmYkoYbdlvTF/aY+GEskbn5UjZfKyz/U4hRKl8QMfyOi/uv85ZfupFvoPY hQK6rX01ksmy57MlOkNQx6iLTEFKKVQRHc067focP0N9X3CXQ9UXHCmm4zCQLLa3Kp30+20n0jzuGb rEZ5vNa85naE80kUl/0jv2MubZsIgP
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

ext4_freeze() and ext4_unfreeze() checks for sb_rdonly(). However this
check is pointless as VFS already checks for read-only filesystem before
calling filesystem specific methods. Remove the pointless checks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 05fcecc36244..f24a7919a328 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6310,12 +6310,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 static int ext4_freeze(struct super_block *sb)
 {
 	int error = 0;
-	journal_t *journal;
-
-	if (sb_rdonly(sb))
-		return 0;
-
-	journal = EXT4_SB(sb)->s_journal;
+	journal_t *journal = EXT4_SB(sb)->s_journal;
 
 	if (journal) {
 		/* Now we set up the journal barrier. */
@@ -6349,7 +6344,7 @@ static int ext4_freeze(struct super_block *sb)
  */
 static int ext4_unfreeze(struct super_block *sb)
 {
-	if (sb_rdonly(sb) || ext4_forced_shutdown(EXT4_SB(sb)))
+	if (ext4_forced_shutdown(EXT4_SB(sb)))
 		return 0;
 
 	if (EXT4_SB(sb)->s_journal) {
-- 
2.35.3

