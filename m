Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779D6ED468
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjDXSby (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXSbx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 14:31:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A435FE8;
        Mon, 24 Apr 2023 11:31:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-956ff2399b1so799304366b.3;
        Mon, 24 Apr 2023 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682361111; x=1684953111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILj5Yfya6TYia4X1kcF5IY0zYmEccgx71qEaQqZW73E=;
        b=cDQK//4yKjOcmJF10KvVjlntkOlNeF0Exw/0Hdko0HMO9VnjrbLIBJdyAbhgnZ2aQp
         Dnec1x13cKW7Q27Rs+X3v3MxmodonbnEYREtwjrBESdCEFA3dEfBX9E5AZPSjiuO20zR
         C4CAvqWZAOLqmd1rBDISznkvn9bJaEBnx9owWD9s/1GuQqezNY/5LJc4Y7i+WrzHTWmp
         MDzZpzp/0JbF0lboimouAOYvIOr7U/vNXEVgwSAzwmqCFmuoF9UcUFFD1FLrLItWNgT6
         nXVSWTkkiGBJWEY28DncYLTldNm/Msf1DL13AHn9TSKCRLknZ9J4ol4hjIDrPLQzi47R
         5CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682361111; x=1684953111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILj5Yfya6TYia4X1kcF5IY0zYmEccgx71qEaQqZW73E=;
        b=Gp8BRsOvBhc8j0dwqhQIf8Ce2gJNjUAjjcyvTQLCK5K2DJbUOH3yQnuTcq/2HKFfDp
         AKTE/b0CvbQTSNbL6ejLwNQC6E8bFYpQB9Dvlcdsj21S0lkb442sWb9cZ2fxmVBZjJ/G
         t/pmNeuIly5Nu2RF3irRdLMdZ8/Jw0K92eB+zcaTr2LS1wC71T8SBSGjbwk5sYyVUa8T
         g7kNPYLUpyiXu+g6loYIUx598HjRZgNThDqQXxuU1HzHaqaUJ4Q0DH4s/V1QLirvbKxh
         ifB2CLrS4Df4P9m9E3Y/W2Q5C8d2P9LysyxkJ05vW7VJn4QFzWBomH+2tmdiypIFJ3gs
         1Sfw==
X-Gm-Message-State: AAQBX9cfHfX+jpBXM48C+vMOulQV8f6/r3740xfKwjhjp6enl9bwA627
        hvVS8sioDwy6hDxnNXNC4tOoaoP9EfE=
X-Google-Smtp-Source: AKy350beBPnYSLiXozvvSsvWrThlQEzRoM4DzrrCgCtGwBlgqxNMuCHABROekZzgewl9P9yOoYjdiA==
X-Received: by 2002:a17:906:49da:b0:94e:8556:f01c with SMTP id w26-20020a17090649da00b0094e8556f01cmr9863662ejv.57.1682361110779;
        Mon, 24 Apr 2023 11:31:50 -0700 (PDT)
Received: from noahgold-desk.intel.com ([2600:1010:b0bf:49f9:6122:25ea:f378:f48b])
        by smtp.gmail.com with ESMTPSA id f14-20020a1709062c4e00b009582c49acdasm3244915ejh.47.2023.04.24.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:31:50 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     goldstein.w.n@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: move `ext4_count_free` to ext4.h so it can be easily inlined
Date:   Mon, 24 Apr 2023 13:31:41 -0500
Message-Id: <20230424183141.2005976-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421014750.2315938-1-goldstein.w.n@gmail.com>
References: <20230421014750.2315938-1-goldstein.w.n@gmail.com>
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

`ext4_count_free` is a one-line helper that is clearly better off
being inlined. This saves a handful instructions in `vmlinux` on x86.

Instruction estimates use `wc -l` on `objdump`
Before: 8539271
After : 8539248

So saves roughly 20 instructions

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/bitmap.c | 5 -----
 fs/ext4/ext4.h   | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index f63e028c638c..c3cd2b878bbd 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -11,11 +11,6 @@
 #include <linux/buffer_head.h>
 #include "ext4.h"
 
-unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
-{
-	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
-}
-
 int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh, int sz)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08b29c289da4..6e1d3c175a70 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2675,7 +2675,11 @@ struct mmpd_data {
 # define NORET_AND	noreturn,
 
 /* bitmap.c */
-extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
+static inline unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
+{
+	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
+}
+
 void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh, int sz);
-- 
2.34.1

