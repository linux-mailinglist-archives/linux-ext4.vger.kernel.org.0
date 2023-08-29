Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1476C78BFBB
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Aug 2023 09:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjH2Hyx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Aug 2023 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjH2Hyv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Aug 2023 03:54:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390CBA
        for <linux-ext4@vger.kernel.org>; Tue, 29 Aug 2023 00:54:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc83a96067so24234545ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 29 Aug 2023 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693295688; x=1693900488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84ujWGF49V2wJszQXpSD4Tf8wEWo98zZJFgzvjEr2ag=;
        b=Y4xAjIKp9XNPX5YQTqfBYa/t0U/lhtWwNe05YYLEOSV2fN6UoFmDo003TvaeDQPW/Z
         qsUGsgg1Or11uNx17KoVYmlOLOehGwrZL7VQctXkHHaX4rpamFIS4J6kCDQEeJxArH3y
         NvxZyUAhD0cMYbIZli2O7TGsJMGnhsDKSaC+HPUo0Hq99ko51mkLBVpKP+Q0whR+63oX
         wlAiqO/cV+o+sLWr2lzU3rtP8KDZwXHTFDtTPhk7pTh2iCuOJfRwj7vRPRr9HTyTFaJ+
         FWJyi7t0eXCAB2A/K6WMFNq6/gbE/XbNsLtsMGcqabmXzI2xzZwBGCW3JWJJa55/2qAp
         yqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295688; x=1693900488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84ujWGF49V2wJszQXpSD4Tf8wEWo98zZJFgzvjEr2ag=;
        b=Idem4qk50+SIgfoToyKiGoNGZ6bLYppjOyRfJFLr5GE3pP8kduerTCZ5tVBxKhxqRo
         eceQA91BbCCoI/60F0ogv/1YWFa3QEQexiIz4CR2Z6i3qKZLIQaAe96K1/54Fkk/nS9H
         vnUM3ya6kh1xKWKVlvoZFKbKY5uUusXpR9yW24ElaAJ3p0W+C/+0k8cAwH41bcACz0Qh
         SuOAppQN2Qa3R2QrqFzK6hxWimceGVdBo09LNOJ1leEPYT7eq9KH+Dwv0HxPzhKyC+On
         kOoZk5VbxwQXtXkqGtpW/B7yybKeTAA2w0xCYVl+mnXEszKMKR3fw7Vvq+2joYernbQs
         XW1A==
X-Gm-Message-State: AOJu0Yx9ejJecwcSFYlfKsCgoDh4KwsAnMtKmc8eleW6D1MVZ0QyA0s7
        iHFqpTD643A5bApSzvNGqcqJLfRz2ZclRw==
X-Google-Smtp-Source: AGHT+IFVd4hBVP9gP8aIZVG2g6GanZPWFkBXOoqz2bb2CvAEWM4brhBkF7qE6qSYm695VXJMHk8WGw==
X-Received: by 2002:a17:902:e74b:b0:1c1:f5a6:bdfa with SMTP id p11-20020a170902e74b00b001c1f5a6bdfamr3640028plf.7.1693295688378;
        Tue, 29 Aug 2023 00:54:48 -0700 (PDT)
Received: from localhost.localdomain ([143.92.127.238])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001b892aac5c9sm8668728ply.298.2023.08.29.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:54:47 -0700 (PDT)
From:   Haibo Liu <haiboliu6@gmail.com>
To:     djwong@kernel.org, linux-ext4@vger.kernel.org
Cc:     haiboliu6@gmail.com
Subject: [v2] ext4/super.c : Fix a goto label
Date:   Tue, 29 Aug 2023 15:52:22 +0800
Message-Id: <20230829075222.50962-1-haiboliu6@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828092726.19400-1-haiboliu6@gmail.com>
References: <20230828092726.19400-1-haiboliu6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thank you for Darrick J. Wong's suggestions :). 
I wrote a new patch and renamed these 9 labels.  

Original labels -> New labels: 

out -> out_unregister_ext23_and_dentry_cache 
out05 -> out_inodecache
out1 -> out_mballoc
out2 -> out_sysfs
out3 -> out_system_zone 
out4 -> out_pageio
out5 -> out_post_read_processing
out6 -> out_pending
out7 -> out_es 


v1->v2: 
Followed Darrick J. Wong's suggestions, renamed these 9 goto labels. 

Signed-off-by: Haibo Liu <haiboliu6@gmail.com>
---
 fs/ext4/super.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 91f20afa1d71..11cffb5a05a4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7347,61 +7347,61 @@ static int __init ext4_init_fs(void)
 
 	err = ext4_init_pending();
 	if (err)
-		goto out7;
+		goto out_es;
 
 	err = ext4_init_post_read_processing();
 	if (err)
-		goto out6;
+		goto out_pending;
 
 	err = ext4_init_pageio();
 	if (err)
-		goto out5;
+		goto out_post_read_processing;
 
 	err = ext4_init_system_zone();
 	if (err)
-		goto out4;
+		goto out_pageio;
 
 	err = ext4_init_sysfs();
 	if (err)
-		goto out3;
+		goto out_system_zone;
 
 	err = ext4_init_mballoc();
 	if (err)
-		goto out2;
+		goto out_sysfs;
 	err = init_inodecache();
 	if (err)
-		goto out1;
+		goto out_mballoc;
 
 	err = ext4_fc_init_dentry_cache();
 	if (err)
-		goto out05;
+		goto out_inodecache;
 
 	register_as_ext3();
 	register_as_ext2();
 	err = register_filesystem(&ext4_fs_type);
 	if (err)
-		goto out;
+		goto out_unregister_ext23_and_dentry_cache;
 
 	return 0;
-out:
+out_unregister_ext23_and_dentry_cache:
 	unregister_as_ext2();
 	unregister_as_ext3();
 	ext4_fc_destroy_dentry_cache();
-out05:
+out_inodecache:
 	destroy_inodecache();
-out1:
+out_mballoc:
 	ext4_exit_mballoc();
-out2:
+out_sysfs:
 	ext4_exit_sysfs();
-out3:
+out_system_zone:
 	ext4_exit_system_zone();
-out4:
+out_pageio:
 	ext4_exit_pageio();
-out5:
+out_post_read_processing:
 	ext4_exit_post_read_processing();
-out6:
+out_pending:
 	ext4_exit_pending();
-out7:
+out_es:
 	ext4_exit_es();
 
 	return err;
-- 
2.34.1

