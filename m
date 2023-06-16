Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617D7336A6
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbjFPQwW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbjFPQv1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951BB3ABB
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0AF421E06;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dSA8jB4R9SGcdQ4c0A4MwJQa9nZZr8//eERI14/DZM=;
        b=xWddxTXkHYCxZtVlhGhXhgNufjgEkVkzG7zY7Pu8Fs5fX2BHAAqIlfQBEe2gsTKRn2Gl1n
        JpPyzUh6IX9mGH1PTPeQXjyI3VvSxyGIBDezB8xxZlbPZgCd3bZKOfthHxcLIwN/2SlJya
        Udj62Cdz3ofTnP1HJhlvE1Kj3beDcGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dSA8jB4R9SGcdQ4c0A4MwJQa9nZZr8//eERI14/DZM=;
        b=lYhZE8CnSKyW7NHPIncZDOWdlay6z93dExb1sTVVzn75UfZB9zMw/OVhsqDwirtdPk3Nzr
        9Vj+UaJjI6mm9uCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEA4913A8D;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJSiKv6SjGRGIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90C00A0766; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/11] ext4: Warn on read-only filesystem in ext4_journal_check_start()
Date:   Fri, 16 Jun 2023 18:50:53 +0200
Message-Id: <20230616165109.21695-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=jack@suse.cz; h=from:subject; bh=FUMTIeNNszHoGRDFEZLaNAmGP5V2s+kq7zNf+imVRTM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLsXm+SQiX93iiX60RdrAROR5kVgSlG0JAW2X8h 4hBqhO6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS7AAKCRCcnaoHP2RA2SvPB/ 9gzC+FDWQOl2tAYrCGGQH2dtCpA+S3w74W8J8xlDgF5RMXtvNY/Cjpjr8MtcBjl+TUFfsnLLhm4IZN n7XKWpqh1jklbmIHkHGRy2noBm9TCc9iD2o8NLvS0vyl9g5t/A0sKUIkEMMcxLTL4Qj0GIV2u2dfzy 6MiQlXg9AHEvHBlRKCEbHoUI7iI2DZuYyX5JDs0eGPPNEm3y8pZO22CrLgzgSSj2/u4pcsTtjj8+L6 Xn6qvpRddz+xJoiA0Xg4WoG0msvaHePGHdDsSSM7WMlwiG+T4hbKnilWaYii3tnx+1BiDjKtuMKVzp wyrmFbe64q/KxBsRfciIlu4rM7rBEl
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

Now that filesystem abort marks the filesystem as shutdown, we shouldn't
be ever hitting the sb_rdonly() check in ext4_journal_check_start().
Since this is a suitable place for catching all sorts of programming
errors, convert the check to WARN_ON instead of dropping it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b72a22a57d20..ca0eaf2147b0 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -70,8 +70,9 @@ static int ext4_journal_check_start(struct super_block *sb)
 	if (unlikely(ext4_forced_shutdown(sb)))
 		return -EIO;
 
-	if (sb_rdonly(sb))
+	if (WARN_ON_ONCE(sb_rdonly(sb)))
 		return -EROFS;
+
 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
 	journal = EXT4_SB(sb)->s_journal;
 	/*
-- 
2.35.3

