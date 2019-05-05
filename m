Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0396F13F02
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEELBd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 07:01:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43235 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEELBd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 07:01:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so4986524pgi.10;
        Sun, 05 May 2019 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+1cPFT8dnCWgz3zt/i02fRI75qAmJ69l7KEIsJZrbI=;
        b=BGyhGRzecWr406lSEUbYsTJMCgyAvYteJ+g2xNAWNFmDq3jEIPHlWP/NuNTlTJvTyH
         EiJyJTYsNeDUB7Bpv+Rk8yZiqx5fpNgMJ7Uk2AJd95jBtfVoaoReWPPY3MZYK/SEsklr
         0FZ6Be6ZutYGYCfRCf/qadz8x3LF4DS5yPWRq+YXZz1oVT//b7jP835pswGUJdYXL+yk
         VqpxOA6SbkJ7lKVJrPZEdEGfqizJLs0kWKhqgJXq+MTj5Jt0EIk+yQuedaNvzwAOrGzd
         CERoQY8/by5Rq6gkMNX7HH+tBmrY4bOUaAQvPN0hUjK4Jho0bL/kJ0eAbEd0b+RzQsh5
         1FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+1cPFT8dnCWgz3zt/i02fRI75qAmJ69l7KEIsJZrbI=;
        b=TqYrDEgtD+9Cx0UjyThJxS0NdIcf/f+qK3Tx1ytdl/FX3am/Y13XtO64y6qid3NP/9
         Y5lk8SFolniyTHvtGV/joUe/UdOmAoVLZRHTBl5A3wntDMwLCrQYVbZaFXJzZyPIDJo7
         4RHHRwANvtC5tgA14y81XwWQBF5SSbGTNTSguSlOBqgWh8TqInLcTIz8di8R0TJuAaZ0
         gogG7ZyOY4bQV9t1IWFeLKyuIoOjYBFKjhW+xk3iXNorBPXDYeR65NkIUg9eXKnKhYJ9
         mGKZK6gT0YodWgfi7YnVLAl8Lt+WOpuxMCOXv9dQAaUlfzE26uAD0lUx/xqiQhW6KtUa
         UzVw==
X-Gm-Message-State: APjAAAVA00vo3BIoJjuQRBed0HFOlP5596b+pNNtbjOFRlryDZA0aa87
        aCEhAd84RhUw82Plp9pyrSI=
X-Google-Smtp-Source: APXvYqyTvUMQWHesPrALnXfyEmi30IKF+5aON693o0Z76jcDi0u4TPrxGNu91L7FmtigkSElwBz36A==
X-Received: by 2002:a62:6f87:: with SMTP id k129mr9390371pfc.53.1557054092799;
        Sun, 05 May 2019 04:01:32 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id 10sm12962955pft.100.2019.05.05.04.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 04:01:31 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH 3/3] jbd2: add __init annotation for jbd2_journal_init_journal_head_cache()
Date:   Sun,  5 May 2019 19:01:04 +0800
Message-Id: <1557054064-3504-3-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
References: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_init_journal_head_cache() only be called once,
so add __init annotation for it and do some code cleanup.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/jbd2/journal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 49797854ccb8..43399ad423d0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2371,22 +2371,19 @@ static struct kmem_cache *jbd2_journal_head_cache;
 static atomic_t nr_journal_heads = ATOMIC_INIT(0);
 #endif
 
-static int jbd2_journal_init_journal_head_cache(void)
+static int __init jbd2_journal_init_journal_head_cache(void)
 {
-	int retval;
-
 	J_ASSERT(jbd2_journal_head_cache == NULL);
 	jbd2_journal_head_cache = kmem_cache_create("jbd2_journal_head",
 				sizeof(struct journal_head),
 				0,		/* offset */
 				SLAB_TEMPORARY | SLAB_TYPESAFE_BY_RCU,
 				NULL);		/* ctor */
-	retval = 0;
 	if (!jbd2_journal_head_cache) {
-		retval = -ENOMEM;
 		printk(KERN_EMERG "JBD2: no memory for journal_head cache\n");
+		return -ENOMEM;
 	}
-	return retval;
+	return 0;
 }
 
 static void jbd2_journal_destroy_journal_head_cache(void)
-- 
2.20.1

