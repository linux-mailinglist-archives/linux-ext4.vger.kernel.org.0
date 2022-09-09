Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3855B2DBA
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 06:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIIEsJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 00:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIIErv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 00:47:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324DD115CEB;
        Thu,  8 Sep 2022 21:47:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t70so509376pgc.5;
        Thu, 08 Sep 2022 21:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=lHZr0z2LaLA2aH4nw3OWnSW2OW5stN7F6o9WPdifs2Q=;
        b=JPt7BVVLiWpv8FRMD5jPZLIap87tuPuddsllLwJ3vRD3MYlgfnuTR3f/e2IvPA0Ep+
         L4F1Gz5voEo/yTh4wR6FDSf3op9z44N+RyGdB8ubOioBV7nRIZ2WbObOT05B7jkMOrQN
         d0bkiefZm0PPodSP8Cwmw1Ul4M5qiTre/6il95ufBcW27HviZuJ1s4NjCi0nSOrYB/sA
         EeEqAcGXaDCE645bJbrAAe5Ofbvx8WKjdFLjwUwJyaR8vm2n60NUiCTnFud500qzi2+w
         UcIGEMhiIdOFGsD88aIzEkTxyO6wU7Uc5CoKJq65rb3Ky0eKxmkdsUh6SFcqeJE7vG05
         BRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lHZr0z2LaLA2aH4nw3OWnSW2OW5stN7F6o9WPdifs2Q=;
        b=1G7fvZJfovAdkuuF+xm9e+zr17ifrAPosWekNybW2O/DT7+UzXiC0v4qlbnu+SjWh0
         qy9pyRsllwmFLRxIOxs2BmPVT+YcsigDnNaeJrPLnobJTQBAKTyfjT0171e/WpYPIdK8
         RUnHH/vdiirMPZnI0HpLCGDZ6w142hs5pUHEcVXsd/jCYlyuH826CkDylb27ngq+CmKa
         Z+//JvDs6V6SNAXGZfJKI7QIkcTeQ991Ru3tIWwnUoWeuHfJA5CUMBAgLE68W7Zp2siR
         2sPg6WCD75MSnrBMLjlPJuLFNsNYmHrtE15Z5FZVLTY3d+fm8iDKc0ukJMZYtT0DkBPH
         E7bg==
X-Gm-Message-State: ACgBeo1uqdQZHtCcZV3Lkv6vOF//R//iqlmcuOW9skVEqDFIH4z6HEUQ
        wAjC4X95qJKo4LQG+y0Z50bbhwKJgLCsQA==
X-Google-Smtp-Source: AA6agR6p8S1IAjMAAie7aoxsq/JsVDuUKQcOPRARVZtvrYElwsoSPzMPJt7QTCe7LTZRwTWmDpyjoA==
X-Received: by 2002:a05:6a00:2918:b0:536:3967:5d08 with SMTP id cg24-20020a056a00291800b0053639675d08mr12216948pfb.68.1662698870300;
        Thu, 08 Sep 2022 21:47:50 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id bf23-20020a656d17000000b00434a2b8ab1esm330313pgb.73.2022.09.08.21.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:47:49 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] fs/ext4/xattr: check the return value of ext4_xattr_inode_dec_ref()
Date:   Thu,  8 Sep 2022 21:47:27 -0700
Message-Id: <20220909044727.2622256-1-floridsleeves@gmail.com>
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

Check the return value of ext4_xattr_inode_dec_ref(), which could return
error code and need to be warned.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 fs/ext4/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 533216e80fa2..76141ed12bc2 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1540,7 +1540,9 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 
 	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
 	if (err) {
-		ext4_xattr_inode_dec_ref(handle, ea_inode);
+		err = ext4_xattr_inode_dec_ref(handle, ea_inode);
+		if (err)
+			ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
 		iput(ea_inode);
 		return err;
 	}
-- 
2.25.1

