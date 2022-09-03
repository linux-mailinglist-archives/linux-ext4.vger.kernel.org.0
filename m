Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885645ABC03
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Sep 2022 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiICBYs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Sep 2022 21:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiICBYs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Sep 2022 21:24:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8811C103
        for <linux-ext4@vger.kernel.org>; Fri,  2 Sep 2022 18:24:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d12so3451410plr.6
        for <linux-ext4@vger.kernel.org>; Fri, 02 Sep 2022 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jP6EPggHjkZX1NaV9U8a8QOu1uLproFoHSDlqllEgzg=;
        b=HEhKmQ7gwK/HxPmpwnIWy4QlrEFl9/wj4w99hLp/jVkhQLgZ4BAmC76DOTiCqRjsDr
         fZiLkszhkXerCXtNDQLNeXW1GK3grzipGrmPCQkBVgNn0+S9w2zh5nIa+W5kpdZEwKSu
         0i4UIFEZqLZAm8d4Jtdw4nUGMB0wMY12p9HUEmuRkxF1ybhxrIg3uAFswaj+QR2ODU4k
         nLTL9W45u7hJ3vfGnUikejtAJts46K+2IZKiBObrqrnR8CFOys0o04MzBWJYKX9ByATv
         FbKqt59LgeJs6PO3Fpfgmv9lSJWaCjB6BiK22ChN/bjbUJ0nH5cHRENg0IxCSxxbBb3L
         abBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jP6EPggHjkZX1NaV9U8a8QOu1uLproFoHSDlqllEgzg=;
        b=sXUFiFkmNCslXZ3ATMxQj8tPkRcAthSAmLK5bdP/s4+ur9dWR/1QJAshQsKGxny6z3
         x3WOz9mNTS5pOahJge9rZxzwsaWLQFTMLcUl8LLpj9/RcvH8GzVtNFHUW2c5cTxS5N+s
         Ibi86HqihEQNDL4JYjOmLkxGoqBTnO6ZaYT0tNnx9E0nBwNVZffcQ/yPAo5TykJzZ1Dm
         iCR4VKR0iYfMVxSDkFaO0v7iXV0Kb5gucj8zBll/Dxtf0CpNoNgu9l6p2B7vTxl0zWy3
         CEGUaqb1X/KSvTB7ZPAFDTvQR9YLHxf4Cibcalkr4BvQNxu6oJze+ccsnBK3z5GfP7tr
         eMaw==
X-Gm-Message-State: ACgBeo2LC70gJFnrSxQTaHgtVnq8V97BdhiQiJ6QZd97b1TQoRqC2i+w
        xOyOzpzwIuu/h/tPAFKl/+Yj9w==
X-Google-Smtp-Source: AA6agR5IEz5aJDLkp5TRHq5P2h/qWb7MGKFVw0S3OHTvkLzzJ2T8H7XmTUu8Ga+mU6r2dqZKmJDQJw==
X-Received: by 2002:a17:902:e94c:b0:171:3df0:c886 with SMTP id b12-20020a170902e94c00b001713df0c886mr39349023pll.39.1662168284652;
        Fri, 02 Sep 2022 18:24:44 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b00172ba718ed4sm2262494pln.138.2022.09.02.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 18:24:43 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] ext4: place buffer head allocation before handle start
Date:   Sat,  3 Sep 2022 09:24:29 +0800
Message-Id: <20220903012429.22555-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

In our product environment, we encounter some jbd hung waiting handles to
stop while several writters were doing memory reclaim for buffer head
allocation in delay alloc write path. Ext4 do buffer head allocation with
holding transaction handle which may be blocked too long if the reclaim
works not so smooth. According to our bcc trace, the reclaim time in
buffer head allocation can reach 258s and the jbd transaction commit also
take almost the same time meanwhile. Except for these extreme cases,
we often see several seconds delays for cgroup memory reclaim on our
servers. This is more likely to happen considering docker environment.

One thing to note, the allocation of buffer heand is as often as page
allocation or more often when blocksize less than page size. Just like
page cache allocation, we should also place the buffer head allocation
before startting the handle.

After commit:cc883236b792, no nore need to do for delay alloc path, just
do it for no delay alloc code.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 fs/ext4/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..0d6c4ec7c840 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1188,6 +1188,13 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
+	/*
+	 * The same as page allocation, we prealloc buffer heads before
+	 * starting the handle.
+	 */
+	if (!page_has_buffers(page))
+		create_empty_buffers(page, inode->i_sb->s_blocksize, 0);
+
 	unlock_page(page);
 
 retry_journal:
-- 
2.20.1

