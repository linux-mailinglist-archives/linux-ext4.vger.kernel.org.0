Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470217336A1
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjFPQwO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjFPQvW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469F3AB3
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFF0F21DFB;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX2jS64QrBPTY0oUZOWOjvaOFlr4Xx4YtuCsERkZe18=;
        b=1Sr09AI66ouOv/wOGpy58c1FRoHCwoBtgYLcAnVcPwV0Y+q7FkIxEpz3ssbYKUNqWxJO9q
        Oc70HD6JV5jOLtISeb3P8ERw9JdHZDfW5X+LnXmisNZe2n6jaDe94AtBJHRPYTmxAlNblb
        BNVh6keQ/m3TFF1SdPhC5DSyfBRQKRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX2jS64QrBPTY0oUZOWOjvaOFlr4Xx4YtuCsERkZe18=;
        b=0VFX/QWPwxivhuqplA6AJHu3Xdf/uis9b9ebVS1xDv/tOoMC1ZWOCgDsDw1uQur2NlDsst
        169fWN1ttymggMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A19C01330B;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oJuzJ/6SjGQ9IwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B9A0A0765; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/11] ext4: Avoid starting transaction on read-only fs in ext4_quota_off()
Date:   Fri, 16 Jun 2023 18:50:52 +0200
Message-Id: <20230616165109.21695-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=jack@suse.cz; h=from:subject; bh=j8/dBZLKOo2cMXAH5YDChqRVNz73I15ikhobjU9NYKI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLriNm6qcco35uEsSwRe2BKdkH+8tNtzsdD/a42 S8+Z2ziJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS6wAKCRCcnaoHP2RA2a2fB/ 9CDTw+owdjsehgg1PCPkVIn7yQJFZYeYet4KsLcO+yacjfNW3OA/2EfeXDgewPDQ2vxaCtmNphNgZU nGPxbKs2NnadNIt3KOs+1EWpR+aPwpVFezuJwETOW1DydUHZKFzxsyiqo+UXPyNkdxh9teUKbUH/E9 ubtGaAN1fH88vurKcjlle0aVlZPSkPl4eVdwFkvlCDad+MKI3CWBvnFltHT7BhsFcf2IY/b21u8+U6 C1kBiGSmXWFtODtPZjbcDIqjB/BRtKNGHz3j8si6z3JOTvNiERurEYHzUTNuz22iyIIJ5LGiQ0TdVI vcbbw3NB4TdAU6UEm0oUVN+q2NpeW9
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

When the filesystem gets first remounted read-only and then unmounted,
ext4_quota_off() will try to start a transaction (and fail) on read-only
filesystem to cleanup inode flags for legacy quota files. Just bail
before trying to start a transaction instead since that is going to
issue a warning.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f883f3fce066..7dc6750be978 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7047,6 +7047,13 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	err = dquot_quota_off(sb, type);
 	if (err || ext4_has_feature_quota(sb))
 		goto out_put;
+	/*
+	 * When the filesystem was remounted read-only first, we cannot cleanup
+ 	 * inode flags here. Bad luck but people should be using QUOTA feature
+	 * these days anyway.
+	 */
+	if (sb_rdonly(sb))
+		goto out_put;
 
 	inode_lock(inode);
 	/*
-- 
2.35.3

