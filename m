Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81447550921
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiFSHaE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Jun 2022 03:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFSHaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Jun 2022 03:30:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429865C8;
        Sun, 19 Jun 2022 00:30:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l4so7572137pgh.13;
        Sun, 19 Jun 2022 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Zq2sYSbf3nMISBHuZKmX2FWCO+JFM7UHxrKNRM8l4=;
        b=dxxKD1IIOw/UKep65Yl2KZVU8SjzPt9hxjuqZgqBYI45aLQUYyqZQ448QkezxmCvbC
         egrUNykFdjpdxPMfABGIEGvjVD1JU1kkWMg/xcGAjyMUvpvwr+NjGawplPiR9ud3Kuc+
         XPO0Rxqa0B9QRwNRu3Zduu3tg6jPaHttKvg5539KS/Om3ml+hlOOWjtRIUcIomNTxkRc
         HW8CeNwyIghLYAVT6Oe0vePiqQJtlDAEsZjYdr09XXwEQ472QG1S+iuQa/wB8FDhe25J
         HI6f7dGSLgIeaBGqW9ffGNIX8V6sQSyY8g9aijW9E8wb7ptphNe7hWnL6zVNoRrCYMop
         654w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Zq2sYSbf3nMISBHuZKmX2FWCO+JFM7UHxrKNRM8l4=;
        b=zw2CSeH6mbRPQUzccWwXElX/SsnK/20W3Wm6lu6MPSEi9BFvU8lWJNKFvTQfE6+GBy
         +bc8aai1nsMwNN4zTSaG32X03YFS/hLSCeCJMkE0zdQvl/iUqO/G7PneYg3yLNi6v7KZ
         2+XgGXfn5U7N4jInVX+JjVy9GynrrjNSmMiEBAF85RUtNQJsdKvol8v8QfOB89I5N6/d
         L/BMj2EaHy6Plw3F+iy5RsNqGNz2zIaD6uTKDV9YlhAWMu0BB3SiQq6W2sXcwTHke2mh
         pLzz3KS8C9E+ydR4/X2Y9m2ozqsgDyoiPi0/6GNJQ7gHgHCj7oDX3u8L+xbgzgvv59Qq
         ezwA==
X-Gm-Message-State: AJIora8ehmTNiXmueLBq97cAPFKTqyKWgueSWI4Ex3i0JUiFDYZeJdV5
        VCeAow/aM/fL24ei7G2BrPnPYxqYipg=
X-Google-Smtp-Source: AGRyM1vO/efRhjdO+72XdR9PXMipaaDp8WzocoemKoakQ1UjHnv6cZ3qoJH5VU0st1L98/7W44jE7A==
X-Received: by 2002:a63:ae4a:0:b0:40c:2d48:5fda with SMTP id e10-20020a63ae4a000000b0040c2d485fdamr14003202pgp.434.1655623801856;
        Sun, 19 Jun 2022 00:30:01 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-74.three.co.id. [180.214.233.74])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090af8c200b001e02073474csm8166168pjd.36.2022.06.19.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 00:30:01 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ext4: fix cell spacing of table heading on blockmap table
Date:   Sun, 19 Jun 2022 14:29:39 +0700
Message-Id: <20220619072938.7334-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 3103084afcf234 ("ext4, doc: remove unnecessary escaping") removes
redundant underscore escaping, however the cell spacing in heading row of
blockmap table became not aligned anymore, hence triggers malformed table
warning:

Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.

+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
<snipped>...

The warning caused the table not being loaded.

Realign the heading row cell by adding missing space at the first cell
to fix the warning.

Fixes: 3103084afcf234 ("ext4, doc: remove unnecessary escaping")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Wang Jianjian <wangjianjian3@huawei.com>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/blockmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/blockmap.rst b/Documentation/filesystems/ext4/blockmap.rst
index 2bd990402a5c49..cc596541ce7921 100644
--- a/Documentation/filesystems/ext4/blockmap.rst
+++ b/Documentation/filesystems/ext4/blockmap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
+| i.i_block Offset    | Where It Points                                                                                                                                                                                                              |
 +=====================+==============================================================================================================================================================================================================================+
 | 0 to 11             | Direct map to file blocks 0 to 11.                                                                                                                                                                                           |
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

base-commit: 354c6e071be986a44b956f7b57f1884244431048
-- 
An old man doll... just what I always wanted! - Clara

