Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED03B437E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jun 2021 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFYMnH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Jun 2021 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMnH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Jun 2021 08:43:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C3C061574
        for <linux-ext4@vger.kernel.org>; Fri, 25 Jun 2021 05:40:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 21so7966344pfp.3
        for <linux-ext4@vger.kernel.org>; Fri, 25 Jun 2021 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtxieOWWF2q/DmHIqXKFfRcCME/sC3MlnwAVnx6u0Vw=;
        b=C5RU9R7N6x5oOAPEb84W8DWqic/aHlw1wqHI3CL1XIH6nLv/0/btDJVUWCRb5IecFI
         OKJIwxiNX+W799LRfdTEibLWRXiVlilczwfN9LfL8eGxDvRfh4gv49Jq0SxxDsCLQNm5
         IdCdHit6Z/EfL0PGBJxEpJ0yWtDWwbhQvcH+a4yHIp1/Jm8oKWyNW67QGIT4m4Ozm/ik
         fQxfBuHVnXKLDbgl/Xn3ISfUemuwiJ0sbomkwJHsgmU3rQOYDCZVc6Fw6YfjheLl5y+j
         cP/3kvyOltkL1AWeeah5i5Ygu/jBBB9axMFA0xXTupcaOBtg5lVxsa/7y8TDo0CABOr4
         sS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtxieOWWF2q/DmHIqXKFfRcCME/sC3MlnwAVnx6u0Vw=;
        b=oTS9T2bH0Eo8r3E5D2e/10dh4tSn5YMCiu1nj+khAHHLD/Ybv0g3drlKPIGUY1ioX+
         XfomLJPV9EDUqkTgYC8L+2O6DT6MA6+XxBXaMH34cDU3ojEDUwQDN3zOV2LH92TNmlDx
         jTGoLriRqYxWYOvONKq8NEw1PfPsj7B5bn1MJu7PDCn4SH2cnxGxXFXeGd7Fob1US0Zb
         /gkK3K0NRedhzHFEWcLQcDgL+XctCg1B8xMXUMISqvZq6EM7/9l1SU91tE+DzFLCv9vS
         dRay+EMT3nxA/AkkRMt//Zj/wIrjjViG+CJ6m0ZPAh+DOhAAbZRal6zaOdoOheogReEC
         6rvA==
X-Gm-Message-State: AOAM5317lFyFTuSEyDyGWCFojXSb+2xWbuep0HskMorvy7owRgHYmlmc
        FZzyZ7stCWUgunt04/ImwQokv0izCgqXCTul
X-Google-Smtp-Source: ABdhPJziLVMEwFRKMskXOIV/6BngFN/d58+ybt76cBdrf3W7EtlkTuJjhpUXqeGhYurG6hnjNm1kug==
X-Received: by 2002:aa7:8d86:0:b029:2ec:82d2:5805 with SMTP id i6-20020aa78d860000b02902ec82d25805mr10493636pfr.11.1624624846220;
        Fri, 25 Jun 2021 05:40:46 -0700 (PDT)
Received: from localhost.localdomain ([36.62.197.104])
        by smtp.gmail.com with ESMTPSA id q29sm2587765pfl.209.2021.06.25.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:40:45 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     wangshilong1991@gmail.com, Wang Shilong <wshilong@ddn.com>
Subject: [PATCH] ext4: forbid U32_MAX project ID
Date:   Fri, 25 Jun 2021 08:40:33 -0400
Message-Id: <20210625124033.5639-1-wangshilong1991@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

U32_MAX is reserved for special purpose,
qid_has_mapping() will return false if projid is
4294967295, dqget() will return NULL for it.

So U32_MAX is unsupported Project ID, fix to forbid
it.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 fs/ext4/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 31627f7dc5cd..f3a8d962c291 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -744,6 +744,9 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
+	if (fa->fsx_projid >= U32_MAX)
+		return -EINVAL;
+
 	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
-- 
2.27.0

