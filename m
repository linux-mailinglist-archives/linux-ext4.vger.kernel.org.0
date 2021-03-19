Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3534117A
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCSAbs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhCSAbk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 20:31:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D0C06174A;
        Thu, 18 Mar 2021 17:31:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o11so2527855pgs.4;
        Thu, 18 Mar 2021 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCj2ToX9GCCPyWC+y9XAU0OjtPq0vsBVNVC+AP3EALc=;
        b=thmxeNzhpah1sIKJugQmjoohSX75Om4Md4HFMt+IgN/eJuuf0rA8HyBoZNbOCeUPuf
         /2QmxDdxV3Ion/xMstzvYJut7Uu4MZqWDwWUzDg1OT6bCoqBlMwIHonnHrTUoRa1ThRg
         RwzoMmP9xz25eGqRCBg7MT6AzrTsnociSz7FMnmuiQCN+3lceBJqAmftOO73H2jEDsNE
         IMhnmkiooQAcWFxpY+fVLeqbSJj7DhbysMXKedbymhs/e1xlvBWoE09u/YZm+5o7qLEf
         xUSt3tQvW5467tZFHksXs9Whnxu2fwCUoUpx29Z4U+yK1iesPJ/O+nWfqk5q/p4A7gYb
         VNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCj2ToX9GCCPyWC+y9XAU0OjtPq0vsBVNVC+AP3EALc=;
        b=f1oZ7KC2J4gCjg690RJTVYT9EE2lG66XxBtMQTUhrwag6dNbXYpuUNUTXSmI/cCX1d
         act2IovW58AbKE9bFXpmiiph4Z5FFNiqXxy3SvCjmMRrhN25/rrc21vBnstIpR7zkkT2
         0nzgX4aE/oywgCmC4xM7hgb5eIK+bIvbvRb8g2AlyrsVw5LPlCC1OkbFkUwlc9dDC4Rk
         ZTMt9tNclhtB7GVJGNTaWQwmzhKPINpUpEUuPbM6/8nXxsRsFzAble8OISXVlUcO2uEV
         kPAmLLzJ6pceX+tyf8Qby3C/CKoUdMqcUNGuNfedoXwY3D1zZL3iFNJHkDH6Uawp6GU0
         7Jww==
X-Gm-Message-State: AOAM5323vEGqm74fFq3E8+xPHUd9BK8mJg5QJgBbML9rRYWxadZeu5N9
        uNOcxMjB7pQ1e8y1js6kIAc=
X-Google-Smtp-Source: ABdhPJyDu/1zw03Dk3iyEisrSR2rKyeb+nrgxAEHyM2f1QzIYX+azNTqEtzsSpYZ37SPUtQjrh1aLw==
X-Received: by 2002:aa7:952c:0:b029:1f1:533c:40d7 with SMTP id c12-20020aa7952c0000b02901f1533c40d7mr6573459pfp.81.1616113899410;
        Thu, 18 Mar 2021 17:31:39 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id q14sm3549718pff.94.2021.03.18.17.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:31:38 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: liu.xuzhi@zte.com.cn
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu xuzhi <liu.xuzhi@zte.com.cn>
Subject: [PATCH] fs/ext2/: fix misspellings using codespell tool
Date:   Thu, 18 Mar 2021 17:31:31 -0700
Message-Id: <20210319003131.484738-1-liu.xuzhi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Liu xuzhi <liu.xuzhi@zte.com.cn>

A typo is found out by codespell tool in 1107th lines of super.c:

$ codespell ./fs/ext2/
./super.c:1107: fileystem  ==> filesystem

Fix a typo found by codespell.

Signed-off-by: Liu xuzhi <liu.xuzhi@zte.com.cn>
---
 fs/ext2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 6c4753277916..d2fd9707e953 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1104,7 +1104,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
 
-	/* per fileystem reservation list head & lock */
+	/* per filesystem reservation list head & lock */
 	spin_lock_init(&sbi->s_rsv_window_lock);
 	sbi->s_rsv_window_root = RB_ROOT;
 	/*
-- 
2.25.1

