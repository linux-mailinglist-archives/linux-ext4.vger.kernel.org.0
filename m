Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCD6EBDF4
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Apr 2023 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDWIZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWIZi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 04:25:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A191993
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 01:25:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f58125b957so3014083f8f.3
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682238335; x=1684830335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyqKx1Yy3Bow0alfoaVl/iTsTrPMSG3w1cokbbjpDec=;
        b=Je7QWYitkVexae+v7QbllGm3yEPsO/HJS8VmbrIhyTuHt4KNNi7CDQGQ7v/l8+bCK7
         CxkTRoA+XvibebMOlIjCa8ZHnuRhkyl0Hz2i8Ui8fmzg/tG0WfX1eyi7lkJ71FqRawdR
         iD6ckTTVtGmUVasW0AGu74uaVn9Z2COXcd+RkuJKBcBA0aqozUF4ioCNOfRd8duqByQ/
         9YRv9NfOev6ZHbOFDCeuw9NcxOL8hM9OQMY7Izku66sgCLTlxkKUn1fzLo27vELRLGTV
         Xv+N18++99AYlz6Y3rS11+9lRhm9RbVJn0qSIPLs8sgw1fQwN3nKcJPsItEuBqB+Uztx
         4EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682238335; x=1684830335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyqKx1Yy3Bow0alfoaVl/iTsTrPMSG3w1cokbbjpDec=;
        b=GebwNfnziMKncXFDZoyOsWTdQu0vU+t27Gkur4EcD3YOTIb4vMScGqVtb7TISrkH43
         zs0O1g2BxyHYaPpw6aBIH4MUmTq8f4eC6jrtZALCthvbpaD66+jnDTskkpabBT0v/VOg
         WnK/smTBJSWYY9BV4hT9TMUwjWT/lNQOwqVJOMdQp3u3Bneur1whbPA5Lvv886ydGg1W
         /1F+0DVoOlqBOtyLZcTXC4axOysLMuloOfQzG0RLvVeSNB3aYYlMG83vMqG7SMFxqzYZ
         u4F49wIc9fo5oFDvtN8Pm2nVNBhdbB0qYFzhKTv6HE5ZTNYh6ofTZ+XzdUmkhiDeoB/P
         Kwfw==
X-Gm-Message-State: AAQBX9cztKeck8ncdb7dO/fB3tw5k71rztOqs2XegCJJ8QCfnzj5tTI7
        ya8DUQqJ8/k/B8mRQBDrv61PEKkpf8RaRg==
X-Google-Smtp-Source: AKy350Y9jfixMuwori89UE27HUa4Z6VsptOq+LESRH75xRTiB/zGpqE4W9EpnGAwu2AHyBII97O/Cg==
X-Received: by 2002:a5d:5381:0:b0:304:794c:1534 with SMTP id d1-20020a5d5381000000b00304794c1534mr478393wrv.4.1682238335549;
        Sun, 23 Apr 2023 01:25:35 -0700 (PDT)
Received: from localhost.localdomain ([213.177.197.108])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm12389153wmp.5.2023.04.23.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 01:25:35 -0700 (PDT)
From:   =?UTF-8?q?Oscar=20Megia=20L=C3=B3pez?= <megia.oscar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     =?UTF-8?q?Oscar=20Megia=20L=C3=B3pez?= <megia.oscar@gmail.com>
Subject: [PATCH 0/1] I want to add percent to output used/maximum files and blocks
Date:   Sun, 23 Apr 2023 10:23:48 +0200
Message-Id: <20230423082349.53474-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I think this is good information because
numbers alone are not enough for people.

I check that the denominator is zero for safety,
may never be zero, but I prefer to check.

Same for copying in char pointers. I prefer to use snprintf,
than sprintf or strcpy, because this way it won't never
overrun the pointer size.

My experience says that there is to check all possibilities,
even if I think that never will happen (error free).

Oscar Megia López (1):
  e2fsck: Add percent to files and blocks feature

 e2fsck/unix.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)


base-commit: 25ad8a431331b4d1d444a70b6079456cc612ac40
-- 
2.40.0

