Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7754CDBE
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiFOQFi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiFOQFi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 12:05:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D118D1166
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jun 2022 09:05:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ea7so9102292qvb.12
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jun 2022 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9MhuL6Mcz5nl71AH2tb8Yy8xl4fJagf2zi0cQ2VWOs=;
        b=aGhiMK7FPRtE/hCVi2t/T0Y/WArMKB9HzVn/H1swbyELqj4mkwTE8e5FghIW1rj4qn
         /L0G3vLopdrEYPMrtDf8yaqbeIQMxYS3quyKLWC3VsNHblnRSGtrt3tM/REQhJKVuhcD
         Aez8L2Q8OD+NwxoxX71OZyaSBfZ6SWFhPylQmsa98rUHMcfxyJwYNDnpX8NHQImlvcaM
         Mrebe2FqFt8MadhWoU98lZTR5CpC6df0fkiFQehrw8ID+F58FHeXZ01gOS6QwUKiFBDn
         /b0IGNrpaWIi4WcIe6QIigjhtzuzJN1DmA5A7BzMxvlzZXQ0+P27KsGb8JrR601z54mC
         F9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9MhuL6Mcz5nl71AH2tb8Yy8xl4fJagf2zi0cQ2VWOs=;
        b=Vt1z8AaOfE7+YOi1zB2OE3Uvn6HUWi7SliHbtqhoCEAVmoVHRgiuDOnVuDQKcLjWqR
         2A3yXgFWegbr0q6YyDC2BP0rS+ztCXR3yVdwWyMCgulr8AFYV0ZSQc3pgSwkSsPvefr3
         8xiSSFc3SVSfl+r8+vAY0mhlUa4d8tBfaX4YMN38vaFXMeg/qvmcEf8InvDsjgzEP4O5
         ZEhoZE7aB7KTbBy7bhald6EUxzdlKzfIIez20jrxp55tsp9SQ9xcSJB/nFpMqWqYcMOd
         UgllJSEoJcne0Tc3FyPdZ+5CIYyFbYXUo/0oP17n29wuRZu7HoaRxMi4DOeZ72ZVi18/
         roGQ==
X-Gm-Message-State: AJIora+u+A9+hOJNPzr7uNah7F1mncLXdpI/nXtlqc6QYiE8W+M3F0q8
        Z/KTRMIr93r5mSfoqg/qB9aURaNfNgHOXA==
X-Google-Smtp-Source: AGRyM1tT0viK2SaVQauWSZfIltvKI8ZZTB63IIGcz/B0wUI2UWBwfy+NlsUkSHjMotslWOlYrYwABw==
X-Received: by 2002:ad4:5ec8:0:b0:464:5cc9:468b with SMTP id jm8-20020ad45ec8000000b004645cc9468bmr184515qvb.125.1655309135791;
        Wed, 15 Jun 2022 09:05:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006a791a42693sm9362077qko.133.2022.06.15.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:05:35 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, yebin10@huawei.com,
        Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: fix extent status tree race in writeback error recovery path
Date:   Wed, 15 Jun 2022 12:05:30 -0400
Message-Id: <20220615160530.1928801-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
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

A race can occur in the unlikely event ext4 is unable to allocate a
physical cluster for a delayed allocation in a bigalloc file system
during writeback.  Failure to allocate a cluster forces error recovery
that includes a call to mpage_release_unused_pages().  That function
removes any corresponding delayed allocated blocks from the extent
status tree.  If a new delayed write is in progress on the same cluster
simultaneously, resulting in the addition of an new extent containing
one or more blocks in that cluster to the extent status tree, delayed
block accounting can be thrown off if that delayed write then encounters
a similar cluster allocation failure during future writeback.

Write lock the i_data_sem in mpage_release_unused_pages() to fix this
problem.  Ext4's block/cluster accounting code for bigalloc relies on
i_data_sem for mutual exclusion, as is found in the delayed write path,
and the locking in mpage_release_unused_pages() is missing.

Reported-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..95a7a90b3942 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1571,7 +1571,14 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 		ext4_lblk_t start, last;
 		start = index << (PAGE_SHIFT - inode->i_blkbits);
 		last = end << (PAGE_SHIFT - inode->i_blkbits);
+
+		/*
+		 * avoid racing with extent status tree scans made by
+		 * ext4_insert_delayed_block()
+		 */
+		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_es_remove_extent(inode, start, last - start + 1);
+		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 
 	pagevec_init(&pvec);
-- 
2.30.2

