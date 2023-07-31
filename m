Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E176896D
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjGaBBZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBBY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 21:01:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07EAE79;
        Sun, 30 Jul 2023 18:01:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbea147034so36737725e9.0;
        Sun, 30 Jul 2023 18:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690765281; x=1691370081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqHefzyFteg+XSDK8TjKUuurTQ3TCfNZauRn+ePIKMo=;
        b=mBNiY17I+06vfDqduqEp9Eu92UazmmoxGjGV5kDopFuUT3knqdiTTaca9SCpEpD9U/
         oQ8YBtrW1BMlZUID0/sARvSK9sdrj5uxl8TKHvdoT41BvOoLGgf9B7h2cJkcJE8/wSNu
         Gt8Y1IzTZVZ7Kz5GUj/4dCWEjSGOweLHg0yISc7oE6BXOSqOQA9mbngEbTnnuG9cIejs
         RT0f4pP/x2f44lVzh9dHBcECScP3gZwpakwCuo1C3FEBV/6xksXT0m9sS1ePp9E22H7s
         XW0ypopZdDfZmy4xPx91Xbt3vJHdBt+chF5oO6s45DLvzO03yKREiBt8GbZU0mxJErDq
         pEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690765281; x=1691370081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqHefzyFteg+XSDK8TjKUuurTQ3TCfNZauRn+ePIKMo=;
        b=CdDQXqgvmbb9UzHn9yDGmvuoKR/r7JRMHw442L2WWUaU+OGaZmLnlwItYgYwx2/CZ6
         CyGXF0UMBsx6Lf2Vy8JW+jEo4fQwB2hcxKHoDb+yBv93unn3MARRnmMclHYGk8gFnqz8
         6xzwhLjo3sqMeZCar7WZCq8G+ozMyEIwUZEjLUUql6QLMgQHGVWzetx7GH6IfaImlk6t
         1xdLujSsfzDqhRxdvYCrgy0+QMSjLbVHG0J6BfVqllEi87F341UEYk9NPzTN6Y0SNQDZ
         +rMfoTyZ8tfYbENCZ1lraUrDJ4uIw3IjUunB4COd5aW6New8favFfXvu7bpzhdg15r3c
         fA9Q==
X-Gm-Message-State: ABy/qLZvLT+tNxpH3sjhmxNJxk3f7HWcFAxuC6O7XFr+t9qFILE0OZh6
        4TbhZ0NqEf6z8PNshvJVtjjAAIUHdtw=
X-Google-Smtp-Source: APBJJlHwCz1UkjOVuaRzHJmxVag4LxAKS6YT7RLfOi3MxMHa4thRTAcv1sSdpxv5AIbv3pz0RxUqYQ==
X-Received: by 2002:a7b:c405:0:b0:3fc:4:a5b5 with SMTP id k5-20020a7bc405000000b003fc0004a5b5mr5226525wmi.29.1690765281064;
        Sun, 30 Jul 2023 18:01:21 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003fe20533a1esm1850336wmj.44.2023.07.30.18.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:01:20 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, starzhangzsd@gmail.com
Subject: [PATCH v2] ext4: Fix rec_len verify error
Date:   Mon, 31 Jul 2023 09:01:04 +0800
Message-Id: <20230731010104.1781335-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
a problem occurred when more than 13 million files were directly created
under a directory:

EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum

When enough files are created, the fake_dirent->reclen will be 0xffff.
it doesn't equal to the blocksize 65536, i.e. 0x10000.

But it is not the same condition when blocksize equals to 4k.
when enough file are created, the fake_dirent->reclen will be 0x1000.
it equals to the blocksize 4k, i.e. 0x1000.

The problem seems to be related to the limitation of the 16-bit field
when the blocksize is set to 64k. To address this, Modify the check so
as to handle it properly.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
v1->v2:
  Use a better way to check the condition, as suggested by Andreas.

 fs/ext4/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..fffed95f8531 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
 		count_offset = 8;
 	else if (le16_to_cpu(dirent->rec_len) == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-- 
2.27.0

