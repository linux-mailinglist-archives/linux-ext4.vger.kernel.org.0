Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B551F4AF75B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiBIQ6T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiBIQ6G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 11:58:06 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059BEC05CB87;
        Wed,  9 Feb 2022 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644425890; x=1675961890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QoxB7339BnBkugvaYIedB66T9O8oyGrxlDFYROzaZRk=;
  b=rjJLLrpB9Gnq8IzsA+WruPIGHdYtEE4IaZHEEq9jnIdoIhJKnUK1cVV+
   /RpCnLX7qYzRrX2KeF4mFxiqfvXz8E83ETXJxVZG63Tuf2SxR05nHtZbE
   nID/zrSVW2qZ1r8BKhwfnjYOYdrGbmfXClyQKUpOlN5Lpj0yXfaEZCoUK
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 08:58:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:58:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 08:58:09 -0800
Received: from lsbug.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 08:58:07 -0800
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Jan Kara <jack@suse.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-ext4@vger.kernel.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Date:   Wed, 9 Feb 2022 11:57:42 -0500
Message-ID: <20220209165742.5659-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since the linux-next commit 120aa5e57479 (mm: Check for
SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
boot warning. Avoid it by calling synchronize_rcu() before the zeroing.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 fs/jbd2/journal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c2cf74b01ddb..323112de5921 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2861,15 +2861,18 @@ static struct journal_head *journal_alloc_journal_head(void)
 #ifdef CONFIG_JBD2_DEBUG
 	atomic_inc(&nr_journal_heads);
 #endif
-	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
+	ret = kmem_cache_alloc(jbd2_journal_head_cache, GFP_NOFS);
 	if (!ret) {
 		jbd_debug(1, "out of memory for journal_head\n");
 		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
-		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
+		ret = kmem_cache_alloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
 	}
-	if (ret)
+	if (ret) {
+		synchronize_rcu();
+		memset(ret, 0, sizeof(*ret));
 		spin_lock_init(&ret->b_state_lock);
+	}
 	return ret;
 }
 
-- 
2.30.2

