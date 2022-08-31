Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A445A82AF
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiHaQIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHaQIs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 12:08:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A143E6A;
        Wed, 31 Aug 2022 09:08:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 73so5537280pga.1;
        Wed, 31 Aug 2022 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1ML3cNXfhq9rEB+qfxCa2xE/l1U9LW22nELg+7jasok=;
        b=eVICr39FQ/tuup32emSWE+2lhNedDjWxFuUP0MqW19vODyiPOCUzk3oFLEHn//JNnV
         UhUzFtiFRIqAOyrp6ZDL0QkKBXvG2tBPfxjovs7RIp9/+9L53rTUp13HXalflG6DYYS3
         7CGML8X2kggF1yIdxhv4uIETVAjsaLvy8amodvKCY+TcdMEB1pQESGjpmeiS13b1zkHC
         zTmSZ330CJJ6NBXLYg/Cw+QUP+hWtVP3OyGuH4ZjB3ju4Enx8zY49YlM8jFxeAwjad0X
         h28lO/iKwiK9F36RHPRKOVddIDgGBrloM64oSrN/NgwjOHkuPBWz3eFqKL34RwuRH8A7
         J1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1ML3cNXfhq9rEB+qfxCa2xE/l1U9LW22nELg+7jasok=;
        b=EADJdkucbWebM0VnHiaweeFpVqxEyKlalQfdZhZF2ZUXewXaCEZkNZywqssG8EvVcy
         0yXvcvW1zLvk6t2lPJATo/MhRYudzvMZMuua3hsv3rdkfPocOwS+twkHKtK7P/ooy/cc
         LBg76qUj4IeuhlhaCA5iLofSHgBain4Iz28dp5Ziy7WF/En1Z0thSamXrGU6iAYTo2gy
         7pZUOSnr5XMyozLZ/eB+KwcVXGGKwAwgSaJU4LxdNZYEXwfHgax8e/uUtoU3hJWsY+TO
         pSrde4B9QG9PnIr/8BYw4DFrb64BJIauE8py0APztX7G223CLcxpLBlKH1TlXnA9//SZ
         99iw==
X-Gm-Message-State: ACgBeo0o98WgAv49qWz6lAOmg3ScIG98AQP2oL6MFXaSKcBVN8iKLbeg
        Q2kcxURnOwOvXRTFj5Rran/JEIrmf98=
X-Google-Smtp-Source: AA6agR7D8ifKIkBK+LiwrxCMLDrDQB3OmWmVh8ys1O8oBFRtaaZVtLbkSvoxd8zoXI+eBq+TMD2RjA==
X-Received: by 2002:a63:1725:0:b0:42b:4300:358 with SMTP id x37-20020a631725000000b0042b43000358mr22928021pgl.536.1661962127594;
        Wed, 31 Aug 2022 09:08:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b0016f8e8032c4sm11952239plg.129.2022.08.31.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:08:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: remove redundant variable err
Date:   Wed, 31 Aug 2022 16:08:43 +0000
Message-Id: <20220831160843.305836-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from ext4_group_extend_no_check()
instead of getting value from redundant variable err.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 fs/ext4/resize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index fea2a68d067b..94460f3ca666 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1826,7 +1826,6 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 	ext4_grpblk_t last;
 	ext4_grpblk_t add;
 	struct buffer_head *bh;
-	int err;
 	ext4_group_t group;
 
 	o_blocks_count = ext4_blocks_count(es);
@@ -1881,8 +1880,7 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 	}
 	brelse(bh);
 
-	err = ext4_group_extend_no_check(sb, o_blocks_count, add);
-	return err;
+	return ext4_group_extend_no_check(sb, o_blocks_count, add);
 } /* ext4_group_extend */
 
 
-- 
2.25.1

