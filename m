Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A77336AD
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjFPQw4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbjFPQwM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:52:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF93C26
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D3E5021E08;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Qr0zdZIFD5ThYBzQBiHJ+80SgMeh/4kkZZMWNAK0Z8=;
        b=U73CnNqv7oS+z/ctHaLAeeZWeoyizOuOQttbCbsLsg/6PYN3DBrMo2SOvxiSWmSBXZwcN4
        /HTbodMNAkIcwX+mHtuFzV5Cw+HgnV3USG/Mc/QlpJ61N640hPvVIO4LOCjQd/N26sM7mV
        1WfwBQd/o62H41HVBLPAazqTISZpllA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Qr0zdZIFD5ThYBzQBiHJ+80SgMeh/4kkZZMWNAK0Z8=;
        b=/I9SkOZ3GpiFxxzZ7mq6BPudTYme4BOUd4wrmMW3TlsDr9dbRnuzKmBncmAO7rg5/BzgNj
        nvhxe7Zs9Avjj8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF08113A74;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ZacLv6SjGRVIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1933A0769; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/11] ext4: Drop read-only check from ext4_force_commit()
Date:   Fri, 16 Jun 2023 18:50:56 +0200
Message-Id: <20230616165109.21695-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=jack@suse.cz; h=from:subject; bh=sht+TYSezT/dcIxixlpCN8Vt7D+E44WKIhe1VnurU94=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLvM8ApaAKqlrgE41juPNcqht6yZFu8CRTJuX3E CLykzmSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS7wAKCRCcnaoHP2RA2eu/B/ wKj2I0AOYsphKWf3kfRM4v9koMjvRP7BHhnG0Q40zH3CM7HHeizKPMM/uUmTR6kqU8Y6ymAcF1ztYw t8lp7ocCWHPOkwGTx5baEeiyMh5yDhguclJtFBDU5fiQspDQr8C8ASBXdrEg45nmKbKFYlmLjbB4Yj KIMR4issHTaFjaQ4s/nUcd3OESoDIsnnKGAQ4qKb1yrZaaSAw249ZQsYWV03V9VICPIJHrBZqABEJe uPhTqZ4TbwCA+g3FUGJWg7LlFJcNZ/0Pj9pc1C/RMvNeiOJZ1+XWpYirpiKYsm8zotQOmpUA+xGQ+P ijcAFm5Beugzlz4CizfqhzmSut+Npl
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

JBD2 code will quickly return without doing anything when there's
nothing to commit so there's no point in the read-only check in
ext4_force_commit(). Just drop it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7dc6750be978..5299ef013bcd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6233,13 +6233,7 @@ static int ext4_clear_journal_err(struct super_block *sb,
  */
 int ext4_force_commit(struct super_block *sb)
 {
-	journal_t *journal;
-
-	if (sb_rdonly(sb))
-		return 0;
-
-	journal = EXT4_SB(sb)->s_journal;
-	return ext4_journal_force_commit(journal);
+	return ext4_journal_force_commit(EXT4_SB(sb)->s_journal);
 }
 
 static int ext4_sync_fs(struct super_block *sb, int wait)
-- 
2.35.3

