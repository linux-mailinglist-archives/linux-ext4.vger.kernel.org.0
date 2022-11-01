Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415126152B7
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Nov 2022 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAUHj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Nov 2022 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKAUHi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Nov 2022 16:07:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538D1C93C
        for <linux-ext4@vger.kernel.org>; Tue,  1 Nov 2022 13:07:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so10367813qka.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Nov 2022 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eY3Bbf/zsfgvPOTh2hdbpVjyLjeS5IW8PfDYm2tuUFc=;
        b=fzsBiB75R9xGI6BUBREcLDDHTmEgobKJ4HKnKcPGYrP5athM3eKZ1cipclzKjEurYc
         IJGQo/t4iVxDBm8w37vcvmRgRRp1ekP0VqQE28OAyGlJLrY/MXx4WyIlvRqKxxjSWQI8
         eQQ+g/ZalomV7Zq2AEzB/oae1HGDD2WCFj5GrIOx5MmzuPMjHh/+Vx3thYewhI4fLw4z
         STH0ZcBjX17EM5aNYo35KfVoZqr6VOnSHPCLT92xIf5D9dqFPzt13bm3aU57elOVqdqv
         Ga0VPWh1kfTfTA+brWW0yF/koRuXq4b13dXMJvtjQ5SGUen5ukvJ+bRolV4xY/E5dD2l
         STxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY3Bbf/zsfgvPOTh2hdbpVjyLjeS5IW8PfDYm2tuUFc=;
        b=s4jcrE4mRnZ5X2yysQdmEVupxhT/qj4HFaUFWT48Fe0052Lx/aSzCrKw56gDj0nTvm
         iJp6co++wd8DCd23PeeZgmrAoDO/VxpZe/YNFBMOHi+HbLK1WA9sPrN22Br3WtWC5pBP
         +VJ3Z6EkGpxcgxMsZetEvoIisDeBJ3kdJiDQCCiglY4LmvYdcgY/ZOc126gpra3VUf2P
         MtJTVkP96RXc5eSUo900nEQLV267sbNdvISrHlMPFlNy14rTo9yIcaQDjIo7DHYHYAp3
         12aR9OhGwqDuXKokHxwmLaIis3gIdJpPoaRifmbFMMj4lQclIEp80HoBlMEQI1OsLjo+
         1vDg==
X-Gm-Message-State: ACrzQf2uhWYpCR+aT3OUh9hDhMen4noE5FdXmYulaE4bGq83SC/HFw7P
        cyafqymVZ7ALo+cVpdhTMAsF+SMu33c=
X-Google-Smtp-Source: AMsMyM7reZ3PIpEV+KblOExa1Ps6lfMf9RKwmGhp2GE9LRKnyJjuidv4jINMuxI/9xK6lOxD6F/DIA==
X-Received: by 2002:a05:620a:400b:b0:6ee:e1f0:440f with SMTP id h11-20020a05620a400b00b006eee1f0440fmr14437433qko.558.1667333256115;
        Tue, 01 Nov 2022 13:07:36 -0700 (PDT)
Received: from localhost.localdomain (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a240e00b006e07228ed53sm7349438qkn.18.2022.11.01.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:07:35 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] test-appliance: force 4 KB block size for bigalloc, bigalloc_inline
Date:   Tue,  1 Nov 2022 16:07:26 -0400
Message-Id: <20221101200726.142241-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The cfg file for the bigalloc test configuration does not explicitly
define the file system block size as is done for the 4k configuration,
although the intent is to test a file system with 4 KB blocks and 64 KB
clusters.  At least one test, shared/298, runs with a block size of
1 KB instead under bigalloc because it creates a file system image less
than 512 MB in size, a result of the mke2fs.conf block size rule
for small files.

shared/298 currently fails when run under bigalloc with 1 KB blocks.
When the block size is set to 4 KB for the test, it passes.

Explicitly defining the bigalloc block size will help avoid similar
surprises in current or future tests written to use small test files.
Make the same change to the bigalloc_inline config file while we're
at it.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 test-appliance/files/root/fs/ext4/cfg/bigalloc        | 2 +-
 test-appliance/files/root/fs/ext4/cfg/bigalloc_inline | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc b/test-appliance/files/root/fs/ext4/cfg/bigalloc
index 18b0a60..366bf38 100644
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc
@@ -1,5 +1,5 @@
 SIZE=large
-export EXT_MKFS_OPTIONS="-O bigalloc"
+export EXT_MKFS_OPTIONS="-b 4096 -O bigalloc"
 export EXT_MOUNT_OPTIONS=""
 
 # Until we can teach xfstests the difference between cluster size and
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline b/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline
index 46af536..12ad66e 100644
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline
@@ -1,5 +1,5 @@
 SIZE=large
-export EXT_MKFS_OPTIONS="-O bigalloc,inline_data"
+export EXT_MKFS_OPTIONS="-b 4096 -O bigalloc,inline_data"
 export EXT_MOUNT_OPTIONS=""
 
 # Until we can teach xfstests the difference between cluster size and
-- 
2.30.2

