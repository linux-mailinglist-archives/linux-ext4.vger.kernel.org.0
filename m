Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7D5A6888
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH3QjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH3QjN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 12:39:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE9D8E2D
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 09:39:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 69so9512551pgb.13
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=M2Mp9f5DVJxTpoZI1oYE8MHOlo/U4X+ZxTmE6/qXS28=;
        b=C2c7iQJMDRXzRJu2vklzu1zX6R7d9/ScH6eqBq4M7g1lEVX/Lfl6QDWOT0+HZ84nnU
         w10Ds9iNb7xLiUsSlXwCb9TnpjDxATe85QlJ7WGgALbZ/OpifmoTfBsDDmB5KN4nb+BG
         0e/kwN720QLQdIb8D7EgT3lM8z60UyJB63eLwdqYGoKxhyaI1NRx8A3uLXBejOmnYwyy
         xUAUxGJp/xQ6lvMca5zI+fgQ0Sx/bg9lx4QRaG7SdyGNVvh2ZLeoLixQf/J2s32dKuL2
         RmlhNLKZEcAbeMdC2p/7e2yUJkurgV7nauVkJqUtpjS5oPR4OkwU+6Ij1Xv7XOwOI3lJ
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=M2Mp9f5DVJxTpoZI1oYE8MHOlo/U4X+ZxTmE6/qXS28=;
        b=HMGT3p3gIVNun3LNcfFyWgS4D9Wbx9wBTOyi9YSlXJV0D7exJxWSNlawH8ZHTzFGb/
         yDIkzgHGukPPGp3JzfTp9HiZwINQFMn0HEwvdz9Zchc79AZzeeH4DHhrtdbA8Bx51/pl
         XskfF8MixJnQzE1ERE32pu4BHKly759RoScSU20hl4uSnhCFFX4T2nH1hmDZ4Of3o++V
         7cwrL1eFd+cCq7WiMkMnHB8dP+b5/N6CoyxOqFRD92QGacLWSHc5sBlOZnluhimUheRJ
         EcnpxQmo95A9QlioqnxoAvQqRyDyfDlXC9+jmOp3QqNGx37b6d2kTiiRmz1JqS7uyYPL
         7luQ==
X-Gm-Message-State: ACgBeo286QQkqaWmtOKN3n0FRzR7qZSTckwNHkLs6jG9qG2yO5XNWr4i
        CCy63h1/7uG6m+ge0D3T3Gcnog==
X-Google-Smtp-Source: AA6agR53IfXEN9fumeIPX3d8S1mf4AjvuydUxVyJ28R0nBXWbQXmOoHd0FrjDOEHUv5YYNTVrw7F8Q==
X-Received: by 2002:a63:fa53:0:b0:42c:18d3:6a6 with SMTP id g19-20020a63fa53000000b0042c18d306a6mr8736105pgk.79.1661877551522;
        Tue, 30 Aug 2022 09:39:11 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001749381ed8csm6303855plk.254.2022.08.30.09.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:39:09 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: place buffer head allocation before handle start
Date:   Wed, 31 Aug 2022 00:38:55 +0800
Message-Id: <20220830163855.87496-1-hanjinke.666@bytedance.com>
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

On our online environment, we encounter some jbd hung waiting handles to
stop while several writters were doing memory reclaim for buffer head
allocation in delay alloc write path. Ext4 do buffer head allocation with
holding transaction handle which may be blocked too long if the reclaim
works not so smooth. This is more likely to happen considering docker
environment.

Just like page cache allocation, we should also place the buffer head
allocation before startting the handle.

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

