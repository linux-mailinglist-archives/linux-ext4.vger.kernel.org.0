Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A8D4EFFF8
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Apr 2022 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiDBJJp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Apr 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiDBJJo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Apr 2022 05:09:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2B1B0BD0;
        Sat,  2 Apr 2022 02:07:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u14so615636pjj.0;
        Sat, 02 Apr 2022 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb/qK6YwYo8qBEXpAf6pyRs0qHEh+AFav1X8QEAR8os=;
        b=Ug1O3E84tV4pjJHKzV1eDj3dKs8QJdO2HQSbI0/0yBfsrcso5teAp+siFcwf5VJQxF
         G5MypeLuXGb7c/1L8avpx5B4K7JeWwksRAW/Z7bzVr08hwNEds6Z7hHEDij1EeS8rbvB
         Oh/6cBYAcCLhIKPSbbwLEf/6ghMB/De/bBE0Nfow5yWmnZsyLyjLsy7Vnb5JgdrRWHEe
         YDEM7tHRY8ze3gtpVuG74VrMYkmh9kR8oX6c0LnWua/33hmELOxZU4fgVEPxRHhkxzht
         MHDhv9pgSgv5qZjsby1aC29bMh9yr3kkBGvXt8KsqvYnw1ZsjMWRRy5Kmx9ndRhxokpq
         8mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb/qK6YwYo8qBEXpAf6pyRs0qHEh+AFav1X8QEAR8os=;
        b=lwjIL5D+SWNZ0mplnAIByvGDhxQUZUslzfcJ8xEOWdB48dsxN9VpMgYu9xiZLJwgSQ
         /VjhFtSJWAtqSOcNaytwt7QhXQ9Hksfj1OsJVJpxgOzbYaGhmRyfgyCIRiDTx9qOAIQL
         zJJxrr017MywbrT1arFT0KfQICtdiYz7b4uMuxK9LGWMwUFZ4k8PtPjaQ+0BwIj6RB4E
         VHWJb9hZxkM0m90RohXB9c+l0Mu89PVu4cYUAT3PCvgg8FIyY+okzw70S7DGk2kKuuXN
         UTxKLm4EACBHFtNwxT+qA4YMCphuo04CC0+cSvmB0kGnXGwAvM7SbdrjQ+9bZvMN+qyj
         qEQg==
X-Gm-Message-State: AOAM530XhXuzDjQ4rDjl1L0ez4WjWd03cvvJXNKaaqOZ9sAAfRj4Zls/
        qESo8P2PIWhaNlFLBatUBks=
X-Google-Smtp-Source: ABdhPJya5XWCnmEHVuRWundyGrsOfeggYaR9HeA7tSAZyW8bgeg2P20LbFIKpRTRGZgTeLeUDHcF0w==
X-Received: by 2002:a17:902:bb8d:b0:156:51a1:3f5a with SMTP id m13-20020a170902bb8d00b0015651a13f5amr13824226pls.65.1648890472953;
        Sat, 02 Apr 2022 02:07:52 -0700 (PDT)
Received: from ubuntu.localdomain (218-166-170-128.dynamic-ip.hinet.net. [218.166.170.128])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm5931216pfh.174.2022.04.02.02.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:07:52 -0700 (PDT)
From:   Chin Yik Ming <yikming2222@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chin Yik Ming <yikming2222@gmail.com>
Subject: [PATCH] ext4: Fix typo
Date:   Sat,  2 Apr 2022 02:07:44 -0700
Message-Id: <20220402090744.8918-1-yikming2222@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'functoin' and 'entres' should be 'function' and 'entries' respectively

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
---
 fs/ext4/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index a6bb86f52..52ebc40c8 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -412,7 +412,7 @@ struct fname {
 };
 
 /*
- * This functoin implements a non-recursive way of freeing all of the
+ * This function implements a non-recursive way of freeing all of the
  * nodes in the red-black tree.
  */
 static void free_rb_tree_fname(struct rb_root *root)
@@ -515,7 +515,7 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 
 /*
  * This is a helper function for ext4_dx_readdir.  It calls filldir
- * for all entres on the fname linked list.  (Normally there is only
+ * for all entries on the fname linked list.  (Normally there is only
  * one entry on the linked list, unless there are 62 bit hash collisions.)
  */
 static int call_filldir(struct file *file, struct dir_context *ctx,
-- 
2.25.1

