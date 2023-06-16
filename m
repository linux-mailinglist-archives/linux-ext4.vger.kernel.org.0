Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA573369F
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjFPQwM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjFPQvS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716993AAA
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 224F11F8CC;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9m6aB+fcbsckYfiFj7Gk3OhfCgUWPFcgLjEz+0Z9gM=;
        b=s012W4SElYS7YvQFkeIXQYgdz97M1d7vBdFW+4fKqrXTL01IG+aa9VZLSN1nYG8/jjUqiT
        GXboUesEVeXZz/6bSPArDWDpFdVmnF/GGkEhDhV5Il0EA74xHRBOD1ZzsOnKz5TUrxjcpz
        BlmYpM9zZEkXJWo4EXvN5qB/H+8HyZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9m6aB+fcbsckYfiFj7Gk3OhfCgUWPFcgLjEz+0Z9gM=;
        b=Iys+vyedrSFCTIMNiuJ7+OecbuAIaitvw1Sws2xOB+xiAwvaxXkOPktKHrb0r+arEBjE6y
        kJihfAZzY493KWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 141D01391E;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iZLnBP6SjGQqIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76F6AA075F; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/11] ext4: Use sb_rdonly() helper for checking read-only flag
Date:   Fri, 16 Jun 2023 18:50:48 +0200
Message-Id: <20230616165109.21695-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=jack@suse.cz; h=from:subject; bh=ZsVILZbGIyRADFfbE7iVvyYurOfDqarYnbLEd07/hRw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLoLR3AqKzvzY6MegP1eJGa+mLAJrgNm587/ZE7 A3YpKrmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS6AAKCRCcnaoHP2RA2d+eB/ 96dpy8sAB85l/K6hG0fKdkOuL68rvc8oSW6zatw9qnEHxI9NZA+MLASwEzqLeD4VzYEU6cTeMcK+qw DcinivBzrLxFpvKV/Dx87F8nnWKmEldkVGjcC6wpfdTvBtviVWnCY7NRHrL9ZMNONUH0ieh6Pw9sxE 9BQ0vGgRSKW8F58pKU+VAgl2Cf1vjE/TJvLFpqwj760ZBs7dhVuz/RT/dXuZEQp3ZOnDKvbVbNUL3z 74O1Rdo+wLa/cEHzwRlJNTIxmDd590v/glpO6XPrc33soX6QDXAdG3fjDT8Rdv/FFimjAdqK119hoL sqj+GPSHvRWjpQoS0EEmSolsHcvmjW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

sb_rdonly() helper instead of directly checking sb->s_flags.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f24a7919a328..8c843ceb3cbb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6047,7 +6047,7 @@ static void ext4_update_super(struct super_block *sb)
 	 * the clock is set in the future, and this will cause e2fsck
 	 * to complain and force a full file system check.
 	 */
-	if (!(sb->s_flags & SB_RDONLY))
+	if (!sb_rdonly(sb))
 		ext4_update_tstamp(es, s_wtime);
 	es->s_kbytes_written =
 		cpu_to_le64(sbi->s_kbytes_written +
@@ -6638,7 +6638,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	 * If there was a failing r/w to ro transition, we may need to
 	 * re-enable quota
 	 */
-	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	if (sb_rdonly(sb) && !(old_sb_flags & SB_RDONLY) &&
 	    sb_any_quota_suspended(sb))
 		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
-- 
2.35.3

