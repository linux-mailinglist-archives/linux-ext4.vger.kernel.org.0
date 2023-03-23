Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EC6C6B9C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCWOyL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjCWOyJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:54:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B806C17CF9
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:54:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84AFB1FE58;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679583245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dmk5Q4C3guQmEpiXuzzzuPN4hd6KwB+S4yuEEvg06U=;
        b=d2sPERhFl5BpnZUCJU4amQHOYFS7GHUXNse5CSovuyi13nsJgAZPgYTiW26Q9JYseuHX/7
        dMac2disrDMPvJ1kha6OGsyzLwUJvoNKSwj9kOSV4bOvvaxAn8StywsrQqnjd5SGBYCAGl
        Dl7XmxCYToQv1t681/21KxNwCn8xiUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679583245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dmk5Q4C3guQmEpiXuzzzuPN4hd6KwB+S4yuEEvg06U=;
        b=JCAqyA9rOUk5xOrKbiKd8MRITsEfPDRWUO4Dlbw8HBMJrvVoI9GOp0gWaAoo+byAFDk48I
        e0x5rm8SWniVRMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 717DF132C2;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YjG3Gw1oHGSaDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 14:54:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C19F9A06F2; Thu, 23 Mar 2023 15:54:04 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Fix data=journal writeback of DMA pinned page
Date:   Thu, 23 Mar 2023 15:53:58 +0100
Message-Id: <20230323145404.21381-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230323145102.3042-1-jack@suse.cz>
References: <20230323145102.3042-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=jack@suse.cz; h=from:subject; bh=4auudl/oofRIzGTxWiDlBiCE3uHqE84wg8RsV/7Br9Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkHGgFhIX1w8j+AIY5PW0aX0jFbJE2gw5D1BuMSFyl jIBNF4KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZBxoBQAKCRCcnaoHP2RA2Y7KB/ 9hgWvYacbRvu3mtE+6R6z6WuLQj5MPy/XS09G9Q6eHpNRRHDl75cuPxErTxl6sThbUxWZfFnznW+x7 x/xXc8h0G/0BN+BhxYdU/ijNzCiVsl5QvL+pQOeiWIlum/NFwf3fERN5YH3d/JDvlOlxlRhtBqcwqD qJOUbWV5Q/FIXPr7yw+qYifpCDS3VUk4hg3+BNAGrKuG8bNawyt/l6BPKsfXe33EJ+b+QedIzWXwKu VuN8IrTOi+UHJQveLNHG6ge+BuGjRXTFuXU4hCvgmGYFNYU6bVs57HJ6ZrTSwXYWtG+BCOLeErZBPY 57FATkvvWDXwFoFdBwOdpWVBwp5rmt
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

The condition in ext4_writepages() checking whether the filesystem is
frozen had a brown paper bag bug resulting in us never writing back
DMA pinned pages. Fix the condition.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/all/20230319183617.GA896@sol.localdomain
Fixes: 18b7f4107219 ("ext4: Fix warnings when freezing filesystem with journaled data")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3e311c85df08..15bac8181798 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2436,7 +2436,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	 * loop clears them.
 	 */
 	if (ext4_should_journal_data(mpd->inode) &&
-	    sb->s_writers.frozen >= SB_FREEZE_FS) {
+	    sb->s_writers.frozen < SB_FREEZE_FS) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
 		if (IS_ERR(handle))
-- 
2.35.3

