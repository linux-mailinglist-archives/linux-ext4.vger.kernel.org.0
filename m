Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1F23EEB5
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHGOIg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHGOBs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:01:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE4C061574
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 07:01:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so1081608plr.7
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bUZ4Q5RH7zb2bG1L+RkK39Nzy7rYlY1f/w+I8CaPhQQ=;
        b=e+YuR0cAPQwisrA12WSi0ijueBnY7X7YXYs3dcBXds635U6NoNMIYOnUzwJL/u3MPG
         X0+/WeD7sZsCxnvkoAW5yJvSleizqWdeFlCz8EK/jfdcu5+arxOqYv7MwfrisnHFhSom
         qBGkMbhR4EqmgfLGBIRhYWbY2yXcWVBb6YRja7an8PxHnYReR2NmOY8atQtb1/WdMrcN
         rb2BizKSDvWVoqKFm9V8v1z7gbHVXr8kfAVP/y0texAR+zClmlMVyIi2I0mrCn6U0rns
         WfHCodHIohr0MwPg7z8/KIDU+5lgk/akPOzsslsDquYC1BuUVqbj11GKioFzMaYXZ/jI
         e+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bUZ4Q5RH7zb2bG1L+RkK39Nzy7rYlY1f/w+I8CaPhQQ=;
        b=fxGK5vRCuaPwhBkxjYN/mnXKJRiOD6AWQ3NJ5hjrOsXmpXTw8ETJZMLY5rZio5IY66
         lWPqnmoeAlQa4J6uoI0vZqTWKktdl5VDcEt7jFhQZ5cghUOG8omkM1BBsZ4nuOnb6re5
         slR4/JnKp66FxmB0t6oridikrmGQWXayimXaCuHIjoM37qE4gvVr4TZbXJwBaCoJ5ayH
         OIbLKsZWyrUwAwiO+NAJecw1tssVgrK3poJbAoBMjh8Yxe71kUrX/zS6ZLs+Dukjuo+l
         nTUvbY4V9PCwQaaNu5gE5RKuIWOWz1fWKlZWGMbbo0tC73D0EMjb1iBYAdBLiaATa1LZ
         oBag==
X-Gm-Message-State: AOAM530mcSJ08saKPSF66LErSZxKKNThbOrfDQ4RscwKzEgT76tC3ZZv
        Y463Z67tLuaFpOlLVif378QUif9RPGU=
X-Google-Smtp-Source: ABdhPJygQ9kQ5CR3wYBXBKbjsDFrknDcRR3MERAQf/eaAaVXuNGCOnROJIO39pL+L9710qQYqCgyAg==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1mr12479313plb.118.1596808885594;
        Fri, 07 Aug 2020 07:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id d128sm12839556pfa.24.2020.08.07.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:01:25 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: fix typos in ext4_mb_regular_allocator() comment
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Message-ID: <d6514145-73b3-808b-ec5a-a8be27c51f9c@gmail.com>
Date:   Fri, 7 Aug 2020 22:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix typos in ext4_mb_regular_allocator() comment

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4f21f34..0edec26 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2237,8 +2237,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		goto out;
 
 	/*
-	 * ac->ac2_order is set only if the fe_len is a power of 2
-	 * if ac2_order is set we also set criteria to 0 so that we
+	 * ac->ac_2order is set only if the fe_len is a power of 2
+	 * if ac->ac_2order is set we also set criteria to 0 so that we
 	 * try exact allocation using buddy.
 	 */
 	i = fls(ac->ac_g_ex.fe_len);
-- 
1.8.3.1
