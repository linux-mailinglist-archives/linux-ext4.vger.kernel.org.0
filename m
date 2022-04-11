Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08BA4FB24C
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Apr 2022 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiDKDZ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Apr 2022 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDKDZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Apr 2022 23:25:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F941A3BF;
        Sun, 10 Apr 2022 20:23:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j21so15467364qta.0;
        Sun, 10 Apr 2022 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxTBF5ylc1PcjiQhqnnTpUZjqhG5JQd7YWZvKQpsVTc=;
        b=W8YK+cBDYNmAoWo2NM8QKZv6OkeYNZYXkEdNw6qQevduBezaIlBbCaUfD5L8a/nSl8
         Ibg9fC+zex8eH5uo3MX97BKGSYwzhDXMYAck0HTNAW4Vz3c0UWmbmZ8jY42QeAE9IRqd
         hxX/NlEs2jPQb8KUP7aHOXP/V2u5vw9F3J5kaHFZak/mKTVU3otUbImHZDiVBlSh5Ex3
         3wPjrsIbukHDZntFrY2vBU9hNrnLed1RzY5RaM5mL2O9JlBQJV1lUnFWH+UG2z0wsf4A
         ic4KS3VfFGhJslk2baeMhPXsLdszDOZ2gdVxH6klGJNhVGRqI+xB5V0zkY6x/PePRQVy
         tyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxTBF5ylc1PcjiQhqnnTpUZjqhG5JQd7YWZvKQpsVTc=;
        b=oF4KgyRotj/9KR/uwSTCligyDszEvEFq6NaK8C3CjsdeZmGvUBDbzp68MAIWUGbLWM
         FfF1muOt9Wy6aS7pP0PCXAoqRf9gGQ88Zl/jJKE0sHlUeMGNFPyya+BF6sgck0jNP5Wy
         C2ISRHVxYEUysf+GK4TXIOinMvIO9JdjqObc5Nq1IKTLaEJ7tzh+HMRVoyiIJLMJTm28
         r+rWlm0K5kI8aKX9j98kLrUYhVHe4Vthb/1vEhM5nuA6pzv0lMTQKOZuAYbWqI/rTjKh
         AsWZaZPsM8+2vvsW+9ptWA/ElRCIa1qgZ1M5hyrajlu8g37Nc49x3FW1z84Dq2Uh25Uj
         JSeg==
X-Gm-Message-State: AOAM530+AMLXMf4mloAe+OJ5m/HwJBmdEYSJl6AC4UFF500Q85ZtREIY
        iJ2yoGaFDIKRR0kkSvToh1vsqPteDiU=
X-Google-Smtp-Source: ABdhPJymvXQVk9mB07Cu4bPhBbnhFdk7NqUv7qRAvfROLG+Z4QkQI5eJM8B0I9r1j6etjds6Bvj2mQ==
X-Received: by 2002:ac8:7616:0:b0:2ed:41c3:d519 with SMTP id t22-20020ac87616000000b002ed41c3d519mr4277873qtq.64.1649647422590;
        Sun, 10 Apr 2022 20:23:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a034a00b0069c06c95bf7sm3050253qkm.14.2022.04.10.20.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:23:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] ext4: remove unnecessary conditional
Date:   Mon, 11 Apr 2022 03:23:37 +0000
Message-Id: <20220411032337.2517465-1-lv.ruyi@zte.com.cn>
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

iput() has already handled null and non-null parameter, so it is no
need to use if().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: change subject from "remove redundant judgment" to
"remove unnecessary conditional"
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

