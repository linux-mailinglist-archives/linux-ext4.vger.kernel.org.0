Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36E61F2DF
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKGMWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMWs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:22:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95076633D
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p12so5404068plq.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymBX60LUOuBsP+vRhvxq6pMPtRa4aOay12HNgYBIPk8=;
        b=S/Z5s8P8T5uiK4XbX4rCHctiscfLR0VRkfVa8d/UjKp4EGl/YLo7qlEmhcS0/sed7c
         TDZaTDoUC0Yk0MEyLxMv9cwVzIszQAZ9xvMqtpb1Vd2BC6vSp10KqA/E3jj9OBZ8V0rv
         qD/RXLMeRr15dwdiXgCJi+UgutxS5NuOXI5+F59/CAofV4Pd6AorhFx3Zm8aBlPSVnFi
         4ggcjjtnHbIItdYxv5yy8Pp8jp/4/c4RF31WSlW2E7kdTCp5peYN6/Cg8d6YbokZRlWI
         gmZo0uNHxCnsD71h1eZ0BV70T2hoo0wDxXCvNCQj7xAWEOEq49wrLfquuC4yrnCgynvj
         LdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymBX60LUOuBsP+vRhvxq6pMPtRa4aOay12HNgYBIPk8=;
        b=IfmQc/N7p2W+44/A+3IKXfPmENQLE5wbmJnsL4aop3AVkyqDpeZW794jVN0Tf5uEKG
         +TgTjcq7zr574/AJXv84wjAO0HfOfsmB6RF/QVOBO7OtvCi/+38q3R1i6nsrqBpaEtKj
         DJfSxj8uH4NWoM5UzhNtpekkI3rOlzub+NmSwkGAfP3YRTUq3naYsVwThQ+i3zz2rf+q
         v8DA0aCIb66LfGINJf5ReCwYtbXy3HDEjtZKnRtce2BLJOjIKeineu/TtDr6boPEshFa
         3h7X30pwaCVCkzuDeV7y2w8X7PjqI1ez1mJqv8Rz35+EhqiFHxw6UDsqIzMHvbbpf4hV
         xCng==
X-Gm-Message-State: ACrzQf2/ig9PoVr83/CBKo+C7FE7SDh7GfUGN3HyTOU9xtqU6PcG2d4t
        Nh512YxxhntPcTOwegVfXyk=
X-Google-Smtp-Source: AMsMyM5EZL5GsQknopktkzGmJCun0mSTKCL8lq2xeFwr0jRo84n1Q1L8/dn4GReV6pnfYEjCyxU08w==
X-Received: by 2002:a17:90b:30d8:b0:213:fd7d:6a7b with SMTP id hi24-20020a17090b30d800b00213fd7d6a7bmr37298919pjb.29.1667823767066;
        Mon, 07 Nov 2022 04:22:47 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id s23-20020a632157000000b0046ec0ef4a7esm4104967pgm.78.2022.11.07.04.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:46 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 04/72] badblocks: Remove unused badblocks_flags
Date:   Mon,  7 Nov 2022 17:50:52 +0530
Message-Id: <3b00feafe3b640cc230582eeff4a194a5ba5838b.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
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

badblocks_flags is not used anywhere. So just remove it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/badblocks.c | 6 +-----
 lib/ext2fs/ext2fsP.h   | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index a306bc06..345168e0 100644
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
2.37.3

