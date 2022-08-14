Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD9591F31
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Aug 2022 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHNJA0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Aug 2022 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiHNJAZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Aug 2022 05:00:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFECC12F;
        Sun, 14 Aug 2022 02:00:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso12011047pjf.5;
        Sun, 14 Aug 2022 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Z/Soyq/Fq75f7VTwuFktKuouQvCw6dYx/UMaXDk1MnA=;
        b=Qt7jWb38s1GSt1eZcBFy01iGjIrHWb5hTRYaIVsRQV92CTLhjvZVpre5EwfgKIZo7E
         oybs5JTxsLrbiQlrqhZFJ0DoUHsRsXgNz+MNzjL+rKkafrj5w49KaYsTtPcDlqDFCnIF
         EOdH+s0Q0nFU8LOqIc1rtguVK4HXR8z5DVBfVEjQ+tMnpXVLmAh4QiJFcCILaXWmnBQa
         BjBogmuTTps1EnJy4AhnXXumI21sZu3diFuR4c+Ys3ckM2XEtF2Rau5T6zUtN25uApNg
         5YCEMmyhkl1our2fxOnGFY+YxI8p3Iav55SmjzDzZdJTBlnEvzA/TuPEuTF4KKvBPKB9
         Hr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Z/Soyq/Fq75f7VTwuFktKuouQvCw6dYx/UMaXDk1MnA=;
        b=gPoNYcJpmiQ6y7WHV+CcCc6cS0qfhZT5wulLX7HdGeuxelh2Zv64Q06+gxF+sq1STg
         5d5yv5nG8jKzGKaWeMGzoS2c/e3D/NwsgWDnn7dwMOAupq04uLKbCdBgqGuTKmaJeE2d
         aw2Sk1ldHgqDCq2R7ip1/Dm02DmftkJ4Qw6OrWS3N/IvhkHHDwhSdbflqCM0lijdKrp4
         aP/jvDQk75Wszv37ldK8sKuR1tzXMwpwpUJ496E5Lp16kEYuCEerZBHJtTk180dB4hnp
         uj3qz2m3PEF7HmCdWfze4hfAZ+qYGp+YgIT5uzOwLY7ltlxLxep9h+US9WYeoa+30ADX
         N91g==
X-Gm-Message-State: ACgBeo33uGNyNYMETutWcAzCIQ9XYnyznuIyqHN7dN9zlpes5ddsGAdD
        iGcAXVbBm/EMrklqvY8JHb5iy0WTJh95NQ==
X-Google-Smtp-Source: AA6agR7opm50KTFkwP+SPd+0BGto9bJuXZjeJPCLHWUkQkv5nWalyscAMQQBQFmAJZaEh2QMzCgWvw==
X-Received: by 2002:a17:90a:e7cb:b0:1f5:38:cb53 with SMTP id kb11-20020a17090ae7cb00b001f50038cb53mr12893275pjb.110.1660467622931;
        Sun, 14 Aug 2022 02:00:22 -0700 (PDT)
Received: from localhost ([223.167.97.46])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0016be5f24aaesm4949328plo.163.2022.08.14.02.00.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Aug 2022 02:00:22 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tytso@mit.edu, corbet@lwn.net,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] Documentation: ext4: correct the document about superblock
Date:   Sun, 14 Aug 2022 02:00:16 -0700
Message-Id: <20220814090016.3160-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Correct some questions like this:
s_lastcheck_hi field should be upper 8 bits of the
s_lastcheck field, rather than itself.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 Documentation/filesystems/ext4/super.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 268888522e35..0152888cac29 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -456,15 +456,15 @@ The ext4 superblock is laid out as follows in
    * - 0x277
      - __u8
      - s_lastcheck_hi
-     - Upper 8 bits of the s_lastcheck_hi field.
+     - Upper 8 bits of the s_lastcheck field.
    * - 0x278
      - __u8
      - s_first_error_time_hi
-     - Upper 8 bits of the s_first_error_time_hi field.
+     - Upper 8 bits of the s_first_error_time field.
    * - 0x279
      - __u8
      - s_last_error_time_hi
-     - Upper 8 bits of the s_last_error_time_hi field.
+     - Upper 8 bits of the s_last_error_time field.
    * - 0x27A
      - __u8
      - s_pad[2]
-- 
2.17.1

