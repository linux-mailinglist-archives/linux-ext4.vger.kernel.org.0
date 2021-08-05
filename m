Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96E3E17AF
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhHEPOx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHEPOx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 11:14:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A82C061765;
        Thu,  5 Aug 2021 08:14:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g13so11764443lfj.12;
        Thu, 05 Aug 2021 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcxM4SQZ1Owp4dygHmrLmNFPgwp1t/zdZnY5NIzOZu0=;
        b=F/f7mAWu68gjHXLeJysy7N3Wx6VCcxwKiBK0KP0WJJtrNT9A067qrqdCCidLM0zG2M
         ruhMXbpNj5ZGC8wD/o6gYlpA2vTfYtdVzubcJk3uY1ICqTh+tJmAYlTtZZ4FwSKVmbCi
         6miM2IjtWUiP37u+9fEwsvk2CkMU/ShdQQLBMkCDw28jlQg7oOm3RQkzVLAVQnHVEl2e
         KQFdwvvmZipEc/aWkwGlzTCJXs1+4Asn3+EH1RT0sGtMDVi8+aOTk+uPnBvGgkJvClKC
         +DRqpPG2vPcjeDU5r8VM6OsIYm47IIZ7y73xqWdci7a+B3FyJ8Qtju9srIrrd8SwVJe8
         xwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcxM4SQZ1Owp4dygHmrLmNFPgwp1t/zdZnY5NIzOZu0=;
        b=WGm4f4+IN1r+kHbgTSD/p203uqgJeBUBVXxV9L1E/6WhYHk13cZM4u/la6Bvnaqc5A
         lHYKgdFKyKdG8zRDRHFgx8oMO0eSyDw65yeO8I35ruOrq3A9tCXgMgdY5aHLXoolAQQT
         XmVKgNgPCt3zXBOtDEas4+Yv7SlJR8iZqzxFJduI6rnbPF9SvezQNlDQ3tE26A1veDlo
         3m6Y8AGHOkZmMVphx988iu4vvpsiHNX1HwdwZDQdKd8cl+rB176CzTKj/Dt0Ebn5J4vi
         /LHPNmjyqF91o2L4+pcKQrFzXxncGogkO2peQTNtf7uKb7uul47zHbqEVt+FPAUQPeo3
         6qnw==
X-Gm-Message-State: AOAM531pVaQIWdaIRG5x2JNOi+cLG3RaL8kG3csAqpN29kLTmFJODi+Y
        RPc83uQvQ7t7CcqonlwYp/w=
X-Google-Smtp-Source: ABdhPJzQpgpdw8+dPgM2yFriEmZyNjF5sCxv74DBD7aDbc1EdfcyLviP1dqLuHxqJAD6JFeJ6RGOZg==
X-Received: by 2002:a05:6512:3c96:: with SMTP id h22mr385622lfv.517.1628176475747;
        Thu, 05 Aug 2021 08:14:35 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.235])
        by smtp.gmail.com with ESMTPSA id t142sm540204lff.269.2021.08.05.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:14:35 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, johann@whamcloud.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
Subject: [PATCH] ext4: avoid huge mmp update interval value
Date:   Thu,  5 Aug 2021 18:14:18 +0300
Message-Id: <20210805151418.30659-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzbot reported task hung bug in ext4_fill_super(). The problem was in
too huge mmp update interval.

Syzkaller reproducer setted s_mmp_update_interval to 39785 seconds. This
update interaval is unreasonable huge and it can cause tasks to hung on
kthread_stop() call, since it will wait until timeout timer expires.

To avoid this sutiation, I've added MIN and MAX constants for kmmp
interval and clamped s_mmp_update_interval within the boundaries

Reported-and-tested-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
Fixes: c5e06d101aaf ("ext4: add support for multiple mount protection")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Hi, Ted and ext4 maintainers!

I am not sure about min/max values for interval, so I look forward to
receiving your views on these values and patch in general!



With regards,
Pavel Skripkin

---
 fs/ext4/mmp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bc364c119af6..160abee66dce 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -7,6 +7,9 @@
 
 #include "ext4.h"
 
+#define EXT4_KMMP_MAX_INTERVAL		100
+#define EXT4_KMMP_MIN_INTERVAL		5
+
 /* Checksumming functions */
 static __le32 ext4_mmp_csum(struct super_block *sb, struct mmp_struct *mmp)
 {
@@ -140,6 +143,12 @@ static int kmmpd(void *data)
 	unsigned long diff;
 	int retval;
 
+	/* We should avoid unreasonable huge update interval, since it can cause
+	 * task hung bug on umount or on error handling path in ext4_fill_super()
+	 */
+	mmp_update_interval = clamp(mmp_update_interval, EXT4_KMMP_MIN_INTERVAL,
+							 EXT4_KMMP_MAX_INTERVAL);
+
 	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
@@ -156,6 +165,9 @@ static int kmmpd(void *data)
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
 
+	ext4_msg(sb, KERN_INFO, "Started kmmp thread with update interval = %u\n",
+		 mmp_update_interval);
+
 	while (!kthread_should_stop() && !sb_rdonly(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
 			ext4_warning(sb, "kmmpd being stopped since MMP feature"
-- 
2.32.0

