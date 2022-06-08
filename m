Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B220542F13
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiFHLYF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiFHLX6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 07:23:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B61732AD
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 04:23:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 977DE21BF6;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654687435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kn95+5DpuIaD4qeH4/8eeKaV6Rlk2aM9p3BEb5LQoU0=;
        b=nWQOPCee5d2vz1NGY8P7dLuhVd1DZKU4xiEeSTAi552XMyFjgAvcyCjS3xARUZdmQ987yQ
        oBXdpBuNgEoSaPY4f95U46lq5ihXEUtDtISNSoiezkuYVBjZMrjHSeeE98x5iqYpekutib
        GQVvP4IB+3FuwE0ub0Ulld4nfIQUP3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654687435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kn95+5DpuIaD4qeH4/8eeKaV6Rlk2aM9p3BEb5LQoU0=;
        b=6HaR7MtiN9KaldfiRCZy+gOvnt/nIj4Kw1qY59aKnDyu6dwuRBNUZptAb3/oiWmB9q11oX
        +kxNWUk5AHeKfvCA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82E312C146;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3E813A06E6; Wed,  8 Jun 2022 13:23:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] jbd2: Unexport jbd2_log_start_commit()
Date:   Wed,  8 Jun 2022 13:23:50 +0200
Message-Id: <20220608112355.4397-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220608112041.29097-1-jack@suse.cz>
References: <20220608112041.29097-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; h=from:subject; bh=ZIMteGVAns+quMqq7lmdRwSoRqk+9WURFFJLsCjvSpA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBioIbFiuBl0jbkV1Pd5WS5K4LiaGFmpNFUgHbNAyTN YpNlPV+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqCGxQAKCRCcnaoHP2RA2dJ7CA Car45PIgJkCKWHYRohoablHfQmwcOdzkaf80fF5KDaypcwfeWK7T+UWOojTXYWTlmeN+my3my2bz5q blIDrFlwmb4SQaxhW0o/OQtgBfyOHsXIsOsCvjQdPWzSfJIBPBYrh5rBdE6yV4l5kpw8LjFBcnttV4 bBBGldjooxjLFqSuwDWRjGfXLMt1e6vi4D3weTh88nJzlNSCa5Lyj40IrtrGWW/zXNrxq7KGTy0NXv wozZMOzduymn0Mb3Cvd1ix5Z6ix7qtvpATO15Z9WBVD2RZ8oFBlTzPZ69px++/iIQSf96cFyxAxLTF lJp7AjyD09+X243kw4i0MeNdJwgfy/
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

jbd2_log_start_commit() is not used outside of jbd2 so unexport it. Also
make __jbd2_log_start_commit() static when we are at it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    | 3 +--
 include/linux/jbd2.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f38f57942700..97e205a0689d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -80,7 +80,6 @@ EXPORT_SYMBOL(jbd2_journal_errno);
 EXPORT_SYMBOL(jbd2_journal_ack_err);
 EXPORT_SYMBOL(jbd2_journal_clear_err);
 EXPORT_SYMBOL(jbd2_log_wait_commit);
-EXPORT_SYMBOL(jbd2_log_start_commit);
 EXPORT_SYMBOL(jbd2_journal_start_commit);
 EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
 EXPORT_SYMBOL(jbd2_journal_wipe);
@@ -479,7 +478,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
  * Called with j_state_lock locked for writing.
  * Returns true if a transaction commit was started.
  */
-int __jbd2_log_start_commit(journal_t *journal, tid_t target)
+static int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 {
 	/* Return if the txn has already requested to be committed */
 	if (journal->j_commit_request == target)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6c2aa61e0f73..164ddf1211c0 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1646,7 +1646,6 @@ extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
  */
 
 int jbd2_log_start_commit(journal_t *journal, tid_t tid);
-int __jbd2_log_start_commit(journal_t *journal, tid_t tid);
 int jbd2_journal_start_commit(journal_t *journal, tid_t *tid);
 int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
 int jbd2_transaction_committed(journal_t *journal, tid_t tid);
-- 
2.35.3

