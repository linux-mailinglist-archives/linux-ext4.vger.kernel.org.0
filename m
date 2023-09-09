Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF37999C7
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Sep 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjIIQZm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Sep 2023 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjIIQOq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Sep 2023 12:14:46 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Sep 2023 09:14:42 PDT
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86107197
        for <linux-ext4@vger.kernel.org>; Sat,  9 Sep 2023 09:14:42 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id f0UBqPpdGlD5tf0UCqzuca; Sat, 09 Sep 2023 18:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694275630;
        bh=M9hyEFFDEMxxrx1+9It4RWlADeh61fRaXNc2/8F9oGU=;
        h=From:To:Cc:Subject:Date;
        b=H1kBQ1HrwcdInkRmHnzdOZ75JPnmDdIoR7TL3xoOw3MpJBojN563dgCQGXEeU8LBY
         wms5cu3/os9G/8qftVre1W4aabxP2zWDYSzIPaB/tdpdXsqjCiIwrQrmjcC7inQJvM
         lY6eRlkox4L0W16sBPGaEU1MIIQCcc9yWdKaWE2eX2Ya6jruwFMRra3bY086U9aUbj
         9+uy1KkwwsN9FuOqUZnVKZpW7ANPEF2PghMKlep6KCoyaY7DZs6NFA2ncmZSCfqQxK
         M77Me8ky4BIEH7LprZRLZe355DeE1xZewEOpnL/keOpXXwlOLGu/86uJrOVBJHYJKd
         39Yz0EaiaRTQw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Sep 2023 18:07:10 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Dave Kleikamp <shaggy@austin.ibm.com>,
        Andrew Morton <akpm@osdl.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: Fix a test in ext4_decode_error()
Date:   Sat,  9 Sep 2023 18:07:02 +0200
Message-Id: <2c0edffd8557807c6cd6d55111482c5cad7c8f2f.1694275603.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The doc of snprintf() states that "If the return is greater than or equal
to @size, the resulting string is truncated".

So in order to "Check for truncated error codes...", we must check that the
returned value is < 16.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f938..f58fc7cc6f81 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -941,7 +941,7 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 		 * NULL. */
 		if (nbuf) {
 			/* Check for truncated error codes... */
-			if (snprintf(nbuf, 16, "error %d", -errno) >= 0)
+			if (snprintf(nbuf, 16, "error %d", -errno) < 16)
 				errstr = nbuf;
 		}
 		break;
-- 
2.34.1

