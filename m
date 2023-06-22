Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F073A675
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jun 2023 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjFVQvP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jun 2023 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjFVQvO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jun 2023 12:51:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7458197;
        Thu, 22 Jun 2023 09:51:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC8F21D42;
        Thu, 22 Jun 2023 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687452672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q5bTcwRpOQqDZeBG6wcf8dPs5qbb9VV08OwcH6T8toQ=;
        b=eHCkflT5BXAUCE9W/2YKkR3mi6WgjkQG8VvT8jOnJ3Ny/UHmNnrCvu5UBhtAPEHwc9omsk
        aCV7+/oRHsxjBFI7h8Co9uSpdyGuF4QydfnoHbl2C6Ll4sQKM+12j6yx0Nhx4IaegfNnHi
        m0ZmDCS0AgJlWKozGBXUJdtbAjKZg5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687452672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q5bTcwRpOQqDZeBG6wcf8dPs5qbb9VV08OwcH6T8toQ=;
        b=6E1se03t/3uAWtYUc88jX7W6o4F1a5x0ATDFOovANabjRIlF1nNgaP2PwggsiQLCVaOmoV
        Qp1gKpOgSwCTMNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E76713905;
        Thu, 22 Jun 2023 16:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q3r1GgB8lGRqTQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Jun 2023 16:51:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE42EA0754; Thu, 22 Jun 2023 18:51:11 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        <linux-ext4@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix warning in blkdev_put()
Date:   Thu, 22 Jun 2023 18:51:07 +0200
Message-Id: <20230622165107.13687-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=jack@suse.cz; h=from:subject; bh=i5SQsfEQ6FLHG5qn+W2tiOHApX2mmYuZkyz4E8WBuPc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBklHv0zj1YyI1UOaRwK54xrTwJ69oc3f05YwPhpmbr wtPU1JuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZJR79AAKCRCcnaoHP2RA2W+yCA DeXI3YFNgz3v8pkNMAGteyHMiH7a9n+EQwggIWk6UPyOzOl2vPiG1HC63YJpbV1sAPLhXN22jOm+sg 8wtSsZkD6qhwaYsNu1XtA6+Q4L7b+QpCVGJX+xVsDHrYIfu25YfQc08MwiQHKmvXobgH5Bnqev147n XtDmzgxfQd6HBvX0jxsj3S5lcCVVQE0FLzWGH9Q7UmCpJu+A4HEPKaKnG0K9TYn5AnhqUjwHFOQ7xm ih9uFnbLOK5kIh5laurnxt6J2jd39I6cRzI5T6NuCVjhr4wLeTwSZmetdmygjDAd/2jQVEdzNXTwGf A3Xp3UbVrQIiPlMZcVHORFagZRfRW5
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

ext4_blkdev_remove() passes a wrong holder pointer to blkdev_put() which
triggers a warning there. Fix it.

Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Jens, this is another fixup of the block device handling series sitting in
your tree.

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 53d74144ee34..d34b4eb90fe8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1133,7 +1133,7 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
-		blkdev_put(bdev, sbi->s_es);
+		blkdev_put(bdev, sbi->s_sb);
 		sbi->s_journal_bdev = NULL;
 	}
 }
-- 
2.35.3

