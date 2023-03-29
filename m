Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781906CED61
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC2Pt7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjC2Pt6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:49:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578014699
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 093D61FE01;
        Wed, 29 Mar 2023 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680104996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ/E3aw0ZWeIyRIR5gH9zP4JGNutHvma1NIib7hsdEY=;
        b=k8z6DtpHZDjV7yF8W5ygCIYCdr83BHkIWQRXfC9g4e8doNLHaBCF+97WKCxD4S5jaZ+pgP
        6VW9mpG4okknMKV4dlm2JKe4Ns/GN0Jm0SEjMeIQ4oexx2noBYkT1yXjU+nJbIBB112JJ5
        RKsZCUALEHapCFnujOvs+U510aMLDTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680104996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ/E3aw0ZWeIyRIR5gH9zP4JGNutHvma1NIib7hsdEY=;
        b=x6NwaydIC2rGvrpbKFzXSoQjEzpYEJq5TzvVbxU+WsijZWH8uQwW0mXWZfLhfYvdGEvKHB
        sE2YCocsCOpVu4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6F5813A18;
        Wed, 29 Mar 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aZqXLyJeJGQsYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E148A071C; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 01/13] jdb2: Don't refuse invalidation of already invalidated buffers
Date:   Wed, 29 Mar 2023 17:49:32 +0200
Message-Id: <20230329154950.19720-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=jack@suse.cz; h=from:subject; bh=xU5dmX3MHZXfUu0hX4P4pTmX+LZt4yI0Sr3cvXhoXNs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4MxOcKe7y3zrJMxVXdkACs5g25WGBLB1cnNg18 T/us+YqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReDAAKCRCcnaoHP2RA2apOB/ 9b2gqLwj04ZrQgyM5dN0NnrEyRc/c5MwbzRLLKzTQhdmA0lSDYAOy8X1GENehjeAccWvUphkAUfxul si6d4iDNC/IdTmUUAVXgbSXTXZF15a/vGJEBwoROTJASddo1Q5utbOvsx6fYSq1EWiPRF/RG1o1JpN en7KzGV0nMcYzWrmEy8eSruKqUNhwdj9rE8KnlD4u1XHmxQeKve6Yco8CA/66UII4LbNYAoASYp1FQ faPYZv+8UPdgMcKVsuhqHfgoXILDOtdZ1C3pbKuVXb9RGoxc6HzsRD5wmqSjeODKfjeDVu+vC1E4UR 3ILoAR4EC2EXG3PbRBX/YrPpYRreFd
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

When invalidating buffers under the partial tail page,
jbd2_journal_invalidate_folio() returns -EBUSY if the buffer is part of
the committing transaction as we cannot safely modify buffer state.
However if the buffer is already invalidated (due to previous
invalidation attempts from ext4_wait_for_tail_page_commit()), there's
nothing to do and there's no point in returning -EBUSY. This fixes
occasional warnings from ext4_journalled_invalidate_folio() triggered by
generic/051 fstest when blocksize < pagesize.

Fixes: 53e872681fed ("ext4: fix deadlock in journal_unmap_buffer()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 15de1385012e..18611241f451 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2387,6 +2387,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			spin_unlock(&jh->b_state_lock);
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
+			/* Already zapped buffer? Nothing to do... */
+			if (!bh->b_bdev)
+				return 0;
 			return -EBUSY;
 		}
 		/*
-- 
2.35.3

