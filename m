Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D36F19AF
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjD1Ne2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbjD1Ne1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 09:34:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49892116;
        Fri, 28 Apr 2023 06:34:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64115e652eeso12522337b3a.0;
        Fri, 28 Apr 2023 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682688866; x=1685280866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLtrKfbx8wA+iw7edCvDg/yUO74cXbRU6n2TMZ/9ubk=;
        b=HMDMPs0w4XFvOHY5G0UoIq7nfpYh6JvYCo3DilMI5O/zQzJutW9YStZFx7VtmPEw/v
         U1gHNNh3VBxQtFcF2ftbxDuUA0d9eqcqYGNwUKAYzWrwL5yA/Y/kqhqw0Sr9OqN0ABFU
         epJf63sFr44aGZqjU0P1vW18Ui27FBMAkGf4YZNRfnF65j/zpWa97EVsJHYOLlwNGuJ9
         x4GEaFzuHpp8IcAt5usrh4kSVrsFA7aF94eGStxMgRFUxGB2Qr5g1CnqyoCFRRCIJRdW
         9ebAEi9eQGA1IKXcPahYtZ3W+ED08P1hkVso6E4iXy187lN9wIHYXaeOtIUi7Ri5fYhR
         i2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688866; x=1685280866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLtrKfbx8wA+iw7edCvDg/yUO74cXbRU6n2TMZ/9ubk=;
        b=DSE2DEEfXNY9Xtr7rGIahqO4+OxUkhJEmK/uTbcavxax70uZ0DZWrXOzJbpAwh8OQP
         xAEeyUXxL2U9W/jQqeQyQXe7gmzgCPxacEuuR8xK+3/zEBW3rse3Uu6Pzma2f92F9EJl
         QY0cq68mFV4WAT4lXMWnEu27c4gY2lwVtOzYI78dlK8mXJ07T9R5TX6Wqk57ElspY6GH
         XIS2YyI/YEjNe/ilkbZtSda6OJnUDoGJg7pa4jecgDttbr3m/im+McpwIsG7amssMOpo
         808Ams2vON9V//Qia4kBvWKVcqRhYDk8BNUK5hXAJQX9b47OKUFXGO+FCF01cBCOIMse
         5Sjw==
X-Gm-Message-State: AC+VfDxtN0IbPRHTqlFrplszAGfA7UEYxPv/G73H2wAhVTwfoRuqOAQ3
        6aDRDt2M9hV2e23EkSvL+65YcofmUhc7oQ==
X-Google-Smtp-Source: ACHHUZ6HL9vXoS8kn/zyNrcZ4cMeZHd5P5pbWzlb7B4dTHMNL/UYT5psy31LbHB2AhIk0JAnOu6xNQ==
X-Received: by 2002:a17:902:f14d:b0:19e:b2ed:6fff with SMTP id d13-20020a170902f14d00b0019eb2ed6fffmr8442814plb.31.1682688866083;
        Fri, 28 Apr 2023 06:34:26 -0700 (PDT)
Received: from ubuntu2204.. ([125.118.5.31])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027d8f00b001a6527f6ad7sm13352893plm.85.2023.04.28.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:34:25 -0700 (PDT)
From:   Wu Jianyue <wujianyue000@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Jianyue <wujianyue000@gmail.com>
Subject: [PATCH] ext4: Put inode_operations in inode.c
Date:   Fri, 28 Apr 2023 21:34:20 +0800
Message-Id: <20230428133420.6959-1-wujianyue000@gmail.com>
X-Mailer: git-send-email 2.34.1
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

inode_operations is more suitable to put in inode.c,
instead of file.c, so moved to inode.c.

Because struct inode_operations's functions are already
included in header file, so no need to change header files.

Signed-off-by: Wu Jianyue <wujianyue000@gmail.com>
---
 fs/ext4/file.c  | 11 -----------
 fs/ext4/inode.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0b8b4499e5ca..a64184c74e4e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -961,14 +961,3 @@ const struct file_operations ext4_file_operations = {
 	.fallocate	= ext4_fallocate,
 };
 
-const struct inode_operations ext4_file_inode_operations = {
-	.setattr	= ext4_setattr,
-	.getattr	= ext4_file_getattr,
-	.listxattr	= ext4_listxattr,
-	.get_inode_acl	= ext4_get_acl,
-	.set_acl	= ext4_set_acl,
-	.fiemap		= ext4_fiemap,
-	.fileattr_get	= ext4_fileattr_get,
-	.fileattr_set	= ext4_fileattr_set,
-};
-
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8dbd352e3986..db08dd51b6b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6147,3 +6147,15 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	ext4_journal_stop(handle);
 	goto out;
 }
+
+const struct inode_operations ext4_file_inode_operations = {
+	.setattr	= ext4_setattr,
+	.getattr	= ext4_file_getattr,
+	.listxattr	= ext4_listxattr,
+	.get_inode_acl	= ext4_get_acl,
+	.set_acl	= ext4_set_acl,
+	.fiemap		= ext4_fiemap,
+	.fileattr_get	= ext4_fileattr_get,
+	.fileattr_set	= ext4_fileattr_set,
+};
+
-- 
2.34.1

