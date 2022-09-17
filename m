Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4545BB4FE
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Sep 2022 02:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIQA2b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 20:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQA2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 20:28:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3057CBA154;
        Fri, 16 Sep 2022 17:28:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f23so6646590plr.6;
        Fri, 16 Sep 2022 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kTvHTRdGpwQfrHf1mYlFoNNym2cjl9gl412BKvC3kkQ=;
        b=QlHgeuUztAObKBPo/C81p1EMvxaHJ3h6VHk5/SlxY8oURHoWjHw9MhlbBdAfkZQQgq
         HpCavhxRYVii+P6JO5YEIh5xEPHEivcu7itAgohfaW1hMUSvll0Sq/ux2uqai4Qs9Mr7
         1F/GHuE8Bw74i6ZLfCgk+UkD7ORrdvOgxWyQuUyRDZ67f8bjjFK73oj+L8aUvaWQfx6Y
         3rANrkp9B2Uhqle++mibYdPM+bPAwN5nWclq69t3r46HAyLvNWcxIIE6Gu1tyKm5mHUl
         peV6tUZdqrhkwDnD1JBYo1GClJhHb+VLyRfU1HYw8DfalCMXLeedPQVdbyuOAUvrAP2O
         5/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kTvHTRdGpwQfrHf1mYlFoNNym2cjl9gl412BKvC3kkQ=;
        b=pYxg+JQxp/uc+ySX33sLEnOr3/L+aK88ov95T7K/ZtyALZ8F1EyYdBVKDszEsCb+LD
         CHcAeUF0MPuBItTe9i7uyFRNO3nsaHI//kEKDoEt4D3GMegTxvRwOppatvYGMCCAU6Db
         HwrhXMRbjhxwuLpEpiAAOffwOGMHVSMWpzg2L411+cbTI1sbI4euxtnxL3Y1vllWKIbX
         mFzpPiIISg9I+GG/OCU2C2qJFCPz8tz3zjxBovrvQEBJl+R+6QspWnPGXDDQQRdxd+k7
         DVtslFUQ8MLPe9dePkCOT8zGkdObDQCNwW7tgAITce0BcBfJ8dcH+/tijTsueNzmg0LT
         52ug==
X-Gm-Message-State: ACrzQf0xXuGFPScOJAtg6yqJKfiwweYsmHDfYF/dB9n5a5i/0ibrvsiR
        QFL2niKDVOQ7035YK+R/xl4gtkmFck1vOg==
X-Google-Smtp-Source: AMsMyM5cc0aZRuZ1bmc6Itdvh2LucXfMwdF5ef+jX25bEVpoXF27FVX2fUFoWH2/yUm/kpjxO2N3yw==
X-Received: by 2002:a17:903:514:b0:172:dab0:b228 with SMTP id jn20-20020a170903051400b00172dab0b228mr2245275plb.170.1663374508392;
        Fri, 16 Sep 2022 17:28:28 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id z13-20020a17090a1fcd00b001f94d25bfabsm2077955pjz.28.2022.09.16.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 17:28:27 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] fs/ext4/xattr: check the return value of ext4_xattr_inode_dec_ref()
Date:   Fri, 16 Sep 2022 17:28:16 -0700
Message-Id: <20220917002816.3804400-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the return value of ext4_xattr_inode_dec_ref(), which could return
error code and need to be warned.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 fs/ext4/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 533216e80fa2..e6d62fd4ac31 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1540,7 +1540,8 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 
 	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
 	if (err) {
-		ext4_xattr_inode_dec_ref(handle, ea_inode);
+		if (ext4_xattr_inode_dec_ref(handle, ea_inode))
+			ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
 		iput(ea_inode);
 		return err;
 	}
-- 
2.25.1

