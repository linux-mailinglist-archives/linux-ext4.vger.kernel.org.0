Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804BC6D8FA6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 08:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjDFGoJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjDFGoI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 02:44:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEB6581;
        Wed,  5 Apr 2023 23:44:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f22so32555980plr.0;
        Wed, 05 Apr 2023 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680763446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XBnQxjP2ylYL48AsMsqJUUlZkp52VkN+BigcNo4SiQ=;
        b=dx/VJIgP0dFPwE+hAodDjLSlhr9c9dcTApIXN+gKo1mgNohBB3II2KivA6IEyDZLqx
         TA6TDO6Q1TJMUHN6FB+qLuc7ucYJbcJiyfUNSwxYFk/pIr5LqAbTm94O1RMxKlph73CT
         8Dj4NJuOiySxYXRSK9SDEKPP7XgVTx3imOC41xbkX/5JkQL2MkFzyB5ITDzW/OhoFkno
         AJKbP0XSs6NVjQDqLxHVmf9+Q3HYLSnuRSosRQBccfXJAk53zoLgTbWbLQ+6PpfT20Q7
         z2xgvtLDGqeMOEXEo0QM2RCJQBG7U3tYgyqYfcU6rF+TMQbQI9zyN83Obyp3Yn5bNZdz
         hnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XBnQxjP2ylYL48AsMsqJUUlZkp52VkN+BigcNo4SiQ=;
        b=g/nxLy2lXAUMyMWLw07NEeyGUbTqXG5+ILcHnDjxsM/IewzNlqrdhThUTjk+ay0rOo
         6mOl2RKZS3tzkaJeoZ5zj7MJYe/fTKAaGvJNot1gDOqUxjaXCX9YBfQ+IcxyEvUrqiTi
         eWAnqWhGPO77YN+uGTM6rNXgoxdcWyDutAd6bZqeR62TFiOX7iX/mZBzHUFd38c/vL8c
         HLA/I5gJV31NiulizMKLahDEfTbACSg4/fqCKF0eNfA1q5FmIl6JPjhDipYG+btE1fJy
         9/qnumuYxzuOQRcBQgp9+UodgTovWm2rFQddq9SE7GzTsiynFuEbFDtN5jPwqGQJ85PJ
         lcKg==
X-Gm-Message-State: AAQBX9cGFx9kRoF1n0rZlA+TtXfdbJlcGZfui2hzVKkVdPctESm9xUJk
        KklqLMJaIPIffGuIV5DPZzo=
X-Google-Smtp-Source: AKy350Z3rmYRXzZpzHbV5gyGNdkjtZmonHc6/5yTJdzviBSj3FxsREROlrg54GkiXB3w2PE9gy1DMA==
X-Received: by 2002:a17:903:1205:b0:19f:36b1:c35 with SMTP id l5-20020a170903120500b0019f36b10c35mr10603846plh.64.1680763445834;
        Wed, 05 Apr 2023 23:44:05 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b0019a74841c9bsm614436plb.192.2023.04.05.23.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:44:05 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, David.Laight@aculab.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: simplify 32bit calculation of lblk
Date:   Thu,  6 Apr 2023 14:44:00 +0800
Message-Id: <20230406064400.2917-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

commit <ad4fb9cafe100a> (ext4: fix 32bit overflow in ext4_ext_find_goal())
uses value compare to fix 32bit overflow. The resion is that
(block - ext_block) will overflow and cast u32 to u64.
eg: -1(u32) cast to 0xffffffff(u64) which wasn't correct here.
Remove the brackets will solve it simply.

Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 fs/ext4/extents.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..254d380ff46e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -237,10 +237,7 @@ static ext4_fsblk_t ext4_ext_find_goal(struct inode *inode,
 			ext4_fsblk_t ext_pblk = ext4_ext_pblock(ex);
 			ext4_lblk_t ext_block = le32_to_cpu(ex->ee_block);
 
-			if (block > ext_block)
-				return ext_pblk + (block - ext_block);
-			else
-				return ext_pblk - (ext_block - block);
+			return ext_pblk + block - ext_block;
 		}
 
 		/* it looks like index is empty;
-- 
2.20.1

