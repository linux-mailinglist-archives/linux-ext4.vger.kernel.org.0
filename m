Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A5564E42
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiGDHH2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHH1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6052E59
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so8144723pfb.7
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClUzsN3Fm289Jwfth+qW4A+dENSlWPnbU1nlePrBKkU=;
        b=TyECdMOwayp+9bygjrMGlQ4isEHZaodr5yuKGIwvsmymiDabqq8mm88DZgqBV2rdKB
         zxma78Kl4AiX26eQ1TzdSW9JFXpO+0i1UXdhU3hhYKtgpUJVYQjhAbWm6rGAq8KPeKUh
         wJ6mwQeDtCkaIqcxOztkEPUBQ2TgtQv00Uprj3ljNkR32k2TptLf9sRnwvsbCxVSVLTe
         B61ygId8unC/0VsskMkdA3jh42tvirqFjBsRexC2ihvVKAiohCbl1ED49qD6c4cSQ9UO
         HehICoBT0NvK/PI/vX2WY9m2SDDiMMzMFlEp+05OBgXQ0M9Smtpm2GRQFbSgyA+B6lpU
         T6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClUzsN3Fm289Jwfth+qW4A+dENSlWPnbU1nlePrBKkU=;
        b=ALW6E3TNU51pa8pJ4Xz6uTMc9p/Zi///9e59pClOtf0NZ0/5a4r0G4spkowG9po99y
         4iKvb+bW4o1uZBJnKh98phtObZ6YEoi1ZW/ET422HV1faaSOB/zkluHqVAeLPeCFx9UE
         pw2OGYNXerCQPFa1U1HKCrQbzFL9+87hC5i19HC60v3Dl/WE2jIsYi+UIJxLNgjSVQ8M
         7JAYrADK51Z2h8wnmqSDO/IyyLSUPz+hx7FadRRFrtDsC6gNEVOIR+HvUC47tNenHmt+
         Mpv6buSjfDl15EraZB4+kbvVCidRaR/G6yNvQhNOwjq+KDjsQL+Pv/1WLeVMt3NZq1H7
         Hu+g==
X-Gm-Message-State: AJIora9KZgnq+N6P4UjFt6gEYVkRMvjahiCnANk3V1W+OcSyTYIEltcg
        Sq1uZJJgjCK5yINkFJHXzR0=
X-Google-Smtp-Source: AGRyM1vu8VZpwb3iueEEcW+4Pv74wj3VtnOMoeYrmUQgQjM5FDxJMmMkasJ5fz+kkhagWw5YK+NZww==
X-Received: by 2002:a05:6a00:13a5:b0:525:1da8:4af4 with SMTP id t37-20020a056a0013a500b005251da84af4mr34847905pfg.43.1656918446295;
        Mon, 04 Jul 2022 00:07:26 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b0051835ccc008sm20297797pfg.115.2022.07.04.00.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:26 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 02/13] badblocks: Remove unused badblocks_flags
Date:   Mon,  4 Jul 2022 12:36:51 +0530
Message-Id: <49dc04a33aa0432b3ca512dbb0bd7509cb0cd1c3.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656912918.git.ritesh.list@gmail.com>
References: <cover.1656912918.git.ritesh.list@gmail.com>
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

badblocks_flags is not used anywhere. So just remove it.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/badblocks.c | 6 +-----
 lib/ext2fs/ext2fsP.h   | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 0f23983b..0570b131 100644
--- a/lib/ext2fs/badblocks.c
+++ b/lib/ext2fs/badblocks.c
@@ -81,11 +81,7 @@ errcode_t ext2fs_u32_copy(ext2_u32_list src, ext2_u32_list *dest)
 {
 	errcode_t	retval;
 
-	retval = make_u32_list(src->size, src->num, src->list, dest);
-	if (retval)
-		return retval;
-	(*dest)->badblocks_flags = src->badblocks_flags;
-	return 0;
+	return make_u32_list(src->size, src->num, src->list, dest);
 }
 
 errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index a20a0502..d2045af8 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -34,7 +34,6 @@ struct ext2_struct_u32_list {
 	int	num;
 	int	size;
 	__u32	*list;
-	int	badblocks_flags;
 };
 
 struct ext2_struct_u32_iterate {
-- 
2.35.3

