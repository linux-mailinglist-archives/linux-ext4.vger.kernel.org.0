Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6562DFC6
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKQPZg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiKQPZD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 10:25:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF937C455
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 07:22:14 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d123so1579853iof.7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jrJhuhq3KYHNV9wWZHzOxwybZeNy1bqo6hooQqU3yE=;
        b=NwsQVbItPOz9KbUN8Z1nPovd4MsvYwhUpRm+1LCDaXcVXHvaB6VEAL8QUPLuGU7tvU
         /oOVp+TB3UXFrbKKVMCWEMbCD0exnaP9c17jhHvT6r5CEEsWeLU/34hoF8LSyYGz8yQ6
         w4WFFZTmQxqGLvP8lG1iXRP6BvZRXPUloOXROuommGjFty8VruS0RuSNXkXPxkcJj+hg
         vmomCHsGLM3wjJ8VRG0WCUH33PsA1lhtA3FJTETIpNbrIBn29IqVBarsx/fZo/TFCYpK
         De4FQEzxKB7vygx9uViMz/f1U1YiCEnTNE5us4G/5eeCgYIweyAx3fOiFBT0XlV+NJh/
         Sg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jrJhuhq3KYHNV9wWZHzOxwybZeNy1bqo6hooQqU3yE=;
        b=NyjXLzw5rV/vqGGMo5QGsP3P2/GRkJBOD4YpopZLatOu5gJ1fwODFHtV5jeOodkAqM
         MZCFMx/siril7ii1CQQLSDIdikoVrzgOHTgMEZe8joZg1tEjA/14A6ERkwjmqUuo5v8t
         Sd5Odt6g/ST801BGeOtsnxWaNrnJSHoSnAcUDePmWENj1ILfNjGBKwzTzj8j60MGsWBu
         71XbaT6i9KEeSEPm2bRnXNt8mAxzJW2IFcmn5ltfG8Z8zCo76+J3docReJfBfCL9nQmK
         HbW6capm/gJTwuy8G45jsBBWFJtBevJoqQMCTD9wVLvDCRd5bkRxXI2i27JBzON81bE6
         oLGA==
X-Gm-Message-State: ANoB5pmPb4xeEQFff9XBatTezRXSVYgOKl+tAV8JKRAmeFPAdexpct+Q
        Y+94eGUoTT+8P3o1avs0A2kRixyGfGY=
X-Google-Smtp-Source: AA0mqf6cj2rR5zJY5S7/cvQIBmmLUestQigj5ovnqZfLDpqrMZvvst+2zMIfegaoXfFWr18e5cMvaA==
X-Received: by 2002:a5d:9443:0:b0:6cd:c485:2c9e with SMTP id x3-20020a5d9443000000b006cdc4852c9emr1482973ior.138.1668698533761;
        Thu, 17 Nov 2022 07:22:13 -0800 (PST)
Received: from localhost.localdomain (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id y13-20020a92d80d000000b002f8d114ca84sm424084ilm.17.2022.11.17.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:22:13 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline
Date:   Thu, 17 Nov 2022 10:22:07 -0500
Message-Id: <20221117152207.2424-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
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

When converting files with inline data to extents, delayed allocations
made on a file system created with both the bigalloc and inline options
can result in invalid extent status cache content, incorrect reserved
cluster counts, kernel memory leaks, and potential kernel panics.

With bigalloc, the code that determines whether a block must be
delayed allocated searches the extent tree to see if that block maps
to a previously allocated cluster.  If not, the block is delayed
allocated, and otherwise, it isn't.  However, if the inline option is
also used, and if the file containing the block is marked as able to
store data inline, there isn't a valid extent tree associated with
the file.  The current code in ext4_clu_mapped() calls
ext4_find_extent() to search the non-existent tree for a previously
allocated cluster anyway, which typically finds nothing, as desired.
However, a side effect of the search can be to cache invalid content
from the non-existent tree (garbage) in the extent status tree,
including bogus entries in the pending reservation tree.

To fix this, avoid searching the extent tree when allocating blocks
for bigalloc + inline files that are being converted from inline to
extent mapped.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1956288307f..a8928d6d47ac 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5791,6 +5791,14 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	struct ext4_extent *extent;
 	ext4_lblk_t first_lblk, first_lclu, last_lclu;
 
+	/*
+	 * if data can be stored inline, the logical cluster isn't
+	 * mapped - no physical clusters have been allocated, and the
+	 * file has no extents
+	 */
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+		return 0;
+
 	/* search for the extent closest to the first block in the cluster */
 	path = ext4_find_extent(inode, EXT4_C2B(sbi, lclu), NULL, 0);
 	if (IS_ERR(path)) {
-- 
2.30.2

