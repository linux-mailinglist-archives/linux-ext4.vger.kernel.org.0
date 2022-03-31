Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42E4EE253
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiCaUH3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiCaUH2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 16:07:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B16B190B47
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 13:05:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so3774025pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9t6Pq/1FxCVVbqJtOJthgB43FJ45dwItTm1qqJ1hpI=;
        b=k+DZFzBF4OXV/isOqu1fX+iYt/dbsfQpHxFsvVwXaosR6G0JGbByOJaOHyc5vCKVQr
         ltQm1edsWc4pHVXEoUwjDXuAleaSO3swIpZWeZ9/kFXxLJd9Slgm5PN1ON71WDsudY5I
         zT0QBDf0T6vMRkOCin7JC9IAXWiGIMksc68srEOT0k4+GxMULM4NpDia06MvLmpeZsCK
         R8d+M/t8ojbNFDdL0jJ9RYldFJ0LRimtfwfvC0KEQUlAvFn8nJ3S+NenOxBg4YxJC7vh
         mF7fOrFNOoEumhyEiaOoQ7q1yOj4Rx/ltc57kDtrRkfd6BpGEEGMCSJoUvpIGcN2QQml
         5TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9t6Pq/1FxCVVbqJtOJthgB43FJ45dwItTm1qqJ1hpI=;
        b=CDMIZMMkbw41oxj9CBnsyFCeeiCsGdm6T/ci//BxA6cUnS4j75tZ9srpDYwU/oUBqX
         pBsvcSmBMbfjjFOEYCzLVLKUxJ49MjE19jyR21UZ5/sFWPk3TL6I6+NGuqRWu9RbA6uz
         P6R6oaIDM0olXuDNunfwwHCOfL1yR9/PZk1bw3Z+jbP29CDhkuSagCT7V1lOrnPRmW1p
         eMJUKm0xn+ohU5OhkZt1E9Q78Fa1/pjO9B0RWuihSsKJmGWgM3nklB1vOM78YBsGLRAd
         ae6depUeQ15tfRULv7G+uY62V5E5K83orGdMtW7kpsmBzuxoEcjSvQ6S7/+SraNXBoHn
         Jo8g==
X-Gm-Message-State: AOAM533XtbgNDHasF49MNkeINLGk/EZZBnRW3NXi+nAyUMiWX0+xgddP
        ork3869Utpf4Y5xML6v072vWhqnYkUpkpVrV
X-Google-Smtp-Source: ABdhPJx+odBnk0xoMo0XR3TevKAR/mX56Y1ppZhg4q4Gj2inIRQlWGCUsTvVGClo1qK2sdWjNiDnuQ==
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id b12-20020a17090a488c00b001c7b62e8e8cmr7869098pjh.157.1648757140327;
        Thu, 31 Mar 2022 13:05:40 -0700 (PDT)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b0036407db4728sm179053pga.26.2022.03.31.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:05:39 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     linux-ext4@vger.kernel.org
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+7a806094edd5d07ba029@syzkaller.appspotmail.com
Subject: [PATCH v3] ext4: limit length to bitmap_maxbytes - blocksize in punch_hole
Date:   Thu, 31 Mar 2022 13:05:15 -0700
Message-Id: <20220331200515.153214-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzbot found an issue [1] in ext4_fallocate().
The C reproducer [2] calls fallocate(), passing size 0xffeffeff000ul,
and offset 0x1000000ul, which, when added together exceed the
bitmap_maxbytes for the inode. This triggers a BUG in
ext4_ind_remove_space(). According to the comments in this function
the 'end' parameter needs to be one block after the last block to be
removed. In the case when the BUG is triggered it points to the last
block. Modify the ext4_punch_hole() function and add constraint that
caps the length to satisfy the one before laster block requirement.

LINK: [1] https://syzkaller.appspot.com/bug?id=b80bd9cf348aac724a4f4dff251800106d721331
LINK: [2] https://syzkaller.appspot.com/text?tag=ReproC&x=14ba0238700000

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: <linux-ext4@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>

Fixes: a4bb6b64e39a ("ext4: enable "punch hole" functionality")
Reported-by: syzbot+7a806094edd5d07ba029@syzkaller.appspotmail.com
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
--
v3: Modify the length instead of returning an error.
v2: Change sbi->s_blocksize to inode->i_sb->s_blocksize in maxlength
 computation.
---
 fs/ext4/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1ce13f69fbec..60bf31765d07 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3958,7 +3958,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t first_block, stop_block;
 	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset;
+	loff_t first_block_offset, last_block_offset, max_length;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	unsigned int credits;
 	int ret = 0, ret2 = 0;
@@ -4001,6 +4002,14 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 		   offset;
 	}
 
+	/*
+	 * For punch hole the length + offset needs to be within one block
+	 * before last range. Adjust the length if it goes beyond that limit.
+	 */
+	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
+	if (offset + length > max_length)
+		length = max_length - offset;
+
 	if (offset & (sb->s_blocksize - 1) ||
 	    (offset + length) & (sb->s_blocksize - 1)) {
 		/*
-- 
2.35.1

