Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082234F60AA
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiDFNyu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiDFNyn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Apr 2022 09:54:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413D5732D7;
        Wed,  6 Apr 2022 02:05:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 10so3193558qtz.11;
        Wed, 06 Apr 2022 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRCuLHTWWTpT7bdmuOGSkgf0tgmxSBp5myWKH11DKaQ=;
        b=GAyDYd122vZF+TofOvJPaSwqneU0oSy2YOfu9p3cQz9nxVDPgqeXh1ioJokj7ASNZw
         pmqCW065eAEKxFw77uVjG1yjv7OSb8kXibtdS0RvWpBhXTBdXlfxVN6Am9kKMiP8uXIr
         WGWHq/tcI7a+po/p7Y3qeeAVR3OiTu+WPTPQsWR5ontmaUODijBdI357n9k8PQ1JSLgZ
         LC/eX1ZxC055kc4B3WtB9cCTFjoB81ileWUg2xpClcl01UmDAcrUhCNjuN1Zdo2gaQnK
         H8khpIKHM7YMJwvFnsyt1A9rRF8xhhzlw0uKhcc8Y67kCpFrqL5m1O65D3KEi6S6c4qB
         uNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRCuLHTWWTpT7bdmuOGSkgf0tgmxSBp5myWKH11DKaQ=;
        b=QjRX85z6Z+Fe5yUcXC2DBjJyL0ieqaDuV7jC9bDi8Kktfm9yEHAZsQk/X+iQKj7rD5
         9mObWEJDjmlj9w1D5lqyHckb9WX7fVdfQK/44qXgbT7eFaaBSUPJIZECcHyE0Zq83ZEt
         Te8h7orYbly74Z5dMnZQNJOr223Ge9wL2ERru14y6FOqRvVUrbueozkwOiYzxxOoUB/T
         WTjFAbiOaMBcqm7KwLp5sPfkpIm3B4mGxcpE01mi3BYluXawIS/qtVmmVu3Qzzn2oCQb
         omzzSRfkMjys+JiqtBVvjebJ/b5WEahPOkJlTNq25s+T3fdbUt6jR1/2sKyJjhK5L/mL
         tFfQ==
X-Gm-Message-State: AOAM532pqQ34Q5igZJqRsK9dLiFGeGsaHzF5sp3de4Y8WV7MWlxhECMF
        Lp+0powaKzZZJWXAwHRph60=
X-Google-Smtp-Source: ABdhPJxo7JcbOt+cHU5D6rFx3zwKxuPaV0EfmjOtRFFY1DLbjTGCjWHQhDB/pky8om0HcpsQe0r2pA==
X-Received: by 2002:a05:622a:1715:b0:2e1:ce29:f805 with SMTP id h21-20020a05622a171500b002e1ce29f805mr6556754qtk.151.1649235907653;
        Wed, 06 Apr 2022 02:05:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm12904672qtb.61.2022.04.06.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:05:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ext4: remove redundant judgment
Date:   Wed,  6 Apr 2022 09:05:01 +0000
Message-Id: <20220406090501.2488853-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

iput() has already handled null and non-null parameter. so there is no
need to use if().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/ext4/fast_commit.c | 3 +--
 fs/ext4/namei.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3d72565ec6e8..e85d351a1a31 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1659,8 +1659,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
 	set_nlink(inode, 1);
 	ext4_mark_inode_dirty(NULL, inode);
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e37da8d5cd0c..2fd3b24a21cd 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3363,8 +3363,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	err = ext4_add_nondir(handle, dentry, &inode);
 	if (handle)
 		ext4_journal_stop(handle);
-	if (inode)
-		iput(inode);
+	iput(inode);
 	goto out_free_encrypted_link;
 
 err_drop_inode:
-- 
2.25.1

