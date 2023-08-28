Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6F78A8EE
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjH1J3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 05:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjH1J2v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 05:28:51 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0DF100
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 02:28:48 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49059b1ca83so210631e0c.2
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693214927; x=1693819727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pVYVQsFRl94FUBcafCId1bvkM5MyupvZsk+Ew4P9kg=;
        b=ke3eT8Dr5yM6fyTOZKfDU1j8x+freG4DafWi58C5ulo+3jfz0mFnC0QItbF7z3p3xu
         WBR02ZJcNTHZvRCNz2eFNaMqXBKS9bjx7YbAWMOYi9uuAcOYp+ZDP8WesR8csENt3d6X
         0SWUD5YzF8m05y90Qm2YiTgHIt0tH6EVUdIclqTu1/0SVQ5CsPvhRzdluw/Cyrx0m4H1
         Yy2xxdKuD83C4TxgYXpiTXQM8hDRhnN+IMXy1bTrt9ftGDXfJ2Rm42bMipeiiFjOkyn3
         0G/fviaA7k5QsvGnGK7giKS/qbmY5fdxvRrAS13ZMpWw/wbyW0UJnutiLad+i9iOR6dv
         xK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214927; x=1693819727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pVYVQsFRl94FUBcafCId1bvkM5MyupvZsk+Ew4P9kg=;
        b=jMpDoXT+7d2odK4PANLJyFlgnRxFPq0XPdqJna9ULceedTBdI0ej01JxFjAec0Gu4U
         AJXGCK+VjonK+i7QaMZfajAuwNgCiNbhfiEDJ32wg61w9NH9qQXQ4aG3RVy6xU79zynZ
         LPWTiOxF+S4SOuhC4tj3PIP6audhkWU3s7yGknYvAUDcqvbe/8EJc3TkZ4fXndShXCXT
         8+iSWdXfcHsSRZK93EF9ofZrQc0D0GX9JI5StYg15IwPT8JdS+rrIkpFwFoq+h+CavLg
         q6tK1WjiZYs8KBN3JXyMMnEtS75DFEATQUemXj+ZhUGj+y7AcVauJhnO0Jt0ji5hwti/
         8IIw==
X-Gm-Message-State: AOJu0Yxn/vT+Hm8E6fJI8BaUUCM7hZ1+RfCtniHShloPO7Q06hudoYoN
        +Cv9skysoTDuhaRPNgTlTZKkFzXlKlqRCw==
X-Google-Smtp-Source: AGHT+IGxTC6KUb/U5hNV52jvKLTj+EDcXf4pqiIlVAf7mlAyqgsVlE98GCIpuP2OXb06lCol+Wvbeg==
X-Received: by 2002:a05:6102:3a72:b0:447:6cf0:7119 with SMTP id bf18-20020a0561023a7200b004476cf07119mr22577189vsb.30.1693214926975;
        Mon, 28 Aug 2023 02:28:46 -0700 (PDT)
Received: from localhost.localdomain ([143.92.127.238])
        by smtp.gmail.com with ESMTPSA id mg24-20020a17090b371800b002630c9d78aasm6699052pjb.5.2023.08.28.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:28:46 -0700 (PDT)
From:   Haibo Liu <haiboliu6@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Haibo Liu <haiboliu6@gmail.com>
Subject: ext4/super.c : Fix a goto label
Date:   Mon, 28 Aug 2023 17:27:26 +0800
Message-Id: <20230828092726.19400-1-haiboliu6@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There are 9 goto labels in ext4_init_fs: out,out05,out1,out2,out3,out4,out5,out6,out7. So I feel that replacing out5 with out0 may be better. 

Signed-off-by: Haibo Liu <haiboliu6@gmail.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 03373471131c..115bbbd95a7b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6696,7 +6696,7 @@ static int __init ext4_init_fs(void)
 
 	err = ext4_fc_init_dentry_cache();
 	if (err)
-		goto out05;
+		goto out0;
 
 	register_as_ext3();
 	register_as_ext2();
@@ -6708,7 +6708,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
-out05:
+out0:
 	destroy_inodecache();
 out1:
 	ext4_exit_mballoc();
-- 
2.34.1

