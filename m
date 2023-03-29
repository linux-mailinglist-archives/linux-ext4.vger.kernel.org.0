Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7F6CED6E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC2Pua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjC2PuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCC55AA
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF8C41FE06;
        Wed, 29 Mar 2023 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8d4usqkrkW7+cCBZEQr2MKFual/vPqxNVBzwJrYbHU=;
        b=jf46BEGtbXpH6eeSnAPm2Ae3AJDC2Gnri3PkeOOPEO5qdaQc1JiAQT893ICSYisj3O1/PZ
        z3OafFxFOdiPAiF3d61QK7UA0ftLAj8cpo4cPoYyPABXAgKVnZKX3Gi3BuRxFYTcUZ+7AY
        iodjUe2uJMr9U0Vn5vYss+NIpqSS7B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8d4usqkrkW7+cCBZEQr2MKFual/vPqxNVBzwJrYbHU=;
        b=iEHCIivnWdRshBuO7SAvgkhhXxce3TiiDYr/IFk8d+r1e2FKYCgABHVvzcDkigzwm7gaox
        FPj7r0iqZ+1YS8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A513413A18;
        Wed, 29 Mar 2023 15:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dT1KKCxeJGR1YwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5FED3A0752; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/13] ext4: Drop special handling of journalled data from ext4_quota_on()
Date:   Wed, 29 Mar 2023 17:49:41 +0200
Message-Id: <20230329154950.19720-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=jack@suse.cz; h=from:subject; bh=zDWaKYjrFN49QaUXpo+9B9Vwo+a6ZBMZE7wi/p5Erwk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4ULlnSrwRvpwdywbao0pA4yyQtHGnzBWILHdhS QOizfSSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReFAAKCRCcnaoHP2RA2YV7CA Dk7XC2vZdACjsk8BxtgFkalaRCPZdRukSzYtPreZWsBkFdPJ8GDBWmyjnPTiUFzI9pjVz3AuEsovo1 waEW9IvmcK6TuL5vaX2DwjaEv0oeRD/wZpfzCUoKDfRIFzUFufgQkkHySxp77/LRPyxAgrPoYgyr5b PFmBJ/uQmZ0/EN2PzTEFvDmjV10TY85WQGMgMvpJCE2bI4Um0ofLgwpDIbvbO4O3orhxlhm0nV/70J 6GmYVEHsN5bz93xQfahZd72xSDoZ5OrMkbWD7gk+H7I7Uo1PxY81j4YohyIecJb61mIigIOb/5E64u YxTBeQr/Z0nEjoJGJNKGoP7c42admy
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

Now that ext4_writepages() makes sure all journalled data is committed
and checkpointed, sync_filesystem() call done by dquot_quota_on() is
enough for quota IO to see uptodate data. So drop special handling of
journalled data from ext4_quota_on().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f226f8ab469b..b9f8dd0d6e46 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6881,23 +6881,6 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		sb_dqopt(sb)->flags &= ~DQUOT_NOLIST_DIRTY;
 	}
 
-	/*
-	 * When we journal data on quota file, we have to flush journal to see
-	 * all updates to the file when we bypass pagecache...
-	 */
-	if (EXT4_SB(sb)->s_journal &&
-	    ext4_should_journal_data(d_inode(path->dentry))) {
-		/*
-		 * We don't need to lock updates but journal_flush() could
-		 * otherwise be livelocked...
-		 */
-		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
-		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-		if (err)
-			return err;
-	}
-
 	lockdep_set_quota_inode(path->dentry->d_inode, I_DATA_SEM_QUOTA);
 	err = dquot_quota_on(sb, type, format_id, path);
 	if (!err) {
-- 
2.35.3

