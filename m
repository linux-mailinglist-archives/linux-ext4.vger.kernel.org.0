Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8946DDA70
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDKMK1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDKMK0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 08:10:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F8E7B
        for <linux-ext4@vger.kernel.org>; Tue, 11 Apr 2023 05:10:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3A2E219DA;
        Tue, 11 Apr 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681215023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bv8x8jQlW6Pb0Rh2Oe1ctp/9xyNXEJx4R234z3ZM3W4=;
        b=tzoEcsb5yESgle3g3nI8HT3OMn+fRzlmwMC1TJ1e11GtxvOmheUzeQuXm3qjPm0JHKf/c3
        YKTvla+exI5nNFkaj74PwxsRjmkwtvYEHgF1h89f1iUz/L7qSri8sC2ujoRsJZZMGIJ5Lm
        tozIo7eBVHc5yNPUHiCsi1OVOmcHDXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681215023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bv8x8jQlW6Pb0Rh2Oe1ctp/9xyNXEJx4R234z3ZM3W4=;
        b=MifkFwh8CAX/q//2mIN0rzeeaCMA45jveTpUYKDtQHJ5ENmsjjlYddbNJgmRqSJswo3R6m
        s24Wi7JsCsrNTZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D32A413638;
        Tue, 11 Apr 2023 12:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jHa4My9ONWRYCAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 12:10:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4E4B2A0732; Tue, 11 Apr 2023 14:10:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Fix lockdep warning when enabling MMP
Date:   Tue, 11 Apr 2023 14:10:19 +0200
Message-Id: <20230411121019.21940-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523; i=jack@suse.cz; h=from:subject; bh=dD3uoQhrxJx8Hg+MhgRvQlTGtN7kO+Seo/HbO/qLn4Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkNU4q0LYqi+HejodJpDdqQ8p+aqthCR8psLgTBWy4 kG2d0PuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZDVOKgAKCRCcnaoHP2RA2f4fCA C2Cm8Li25hR8w/aalU0GwnEl8+r33qUqzAUwjxjl9DzfFCWgmwmQ4qpoJ9n1a2BIpwMAZlYesEnMsM 33NdX3cSjplrl732msBedTXP/Zt8ZKgCW5MEH8GdxYgx9jAE7/NSVM+GzZ30TKznp74jXrFbu5EwGK J8ffeNrJkJ5yD+zi6GuTfWBU2KUYcEVKGGDe/4MTPVqYwUVRDlRaP7BkKffyTglaJh2derALEGBWdi ruBMAh/Gxz7t8kxmteX8w70L8pk9DwlgHd3rhFquxR6zot+zk5/8iffba5XjZ5ZOGuUHi3wzNsCbPf Phx1PpUgb322jtIouZhTQamZQ7aJLX
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

When we enable MMP in ext4_multi_mount_protect() during mount or
remount, we end up calling sb_start_write() from write_mmp_block(). This
triggers lockdep warning because freeze protection ranks above s_umount
semaphore we are holding during mount / remount. The problem is harmless
because we are guaranteed the filesystem is not frozen during mount /
remount but still let's fix the warning by not grabbing freeze
protection from ext4_multi_mount_protect().

Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mmp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 4681fff6665f..46735ce315b5 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -340,7 +348,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 
-- 
2.35.3

