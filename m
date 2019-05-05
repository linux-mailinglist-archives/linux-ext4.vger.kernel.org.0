Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2739C13F01
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfEELB3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 07:01:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43230 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEELB3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 07:01:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so4986471pgi.10;
        Sun, 05 May 2019 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MqZNEgC5BmtoBz8qTi1+bfplbvOpRDZelFl2KhxBBCo=;
        b=Wpgs5fvscpT1iyfEWSe39xD5Re7uuL7oH9eW7V+DVz2SndW+NU2YmpLxqmm8ceV0kb
         66RQBkYZ19a1y33ots8Li+fbbHHTho77P0dzHjbsJAd2CBUezqeHiPWm7HoP0Y9NGvpN
         NTzc5t5QBl/GBbtE5JHvMMnHmPLkItBRPS4uzoGJ5vDs9vPDg29DUZ7Da5F1XkSiw/NC
         rxWzH0HoKRDHzKJYJYbPF2pB/jyQpJp+a8nlCD+ZDdrXLhwiYcmiGT2FPmNQtUQ/fzPp
         nqaJL1mfZcgu/h9o/bQqLSQheEQXTDXHh+kPQPHsTZbV3/4kLPfDx2wFiPKMqSOWk0hm
         YZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MqZNEgC5BmtoBz8qTi1+bfplbvOpRDZelFl2KhxBBCo=;
        b=eaWNOHPRIeTZAVYa3zGmKbXcPDwO6UQu0tPaJ+USVxrALkatmPNxd8A2XdmyZeIeJG
         F7waGgvfk0paTc/cEObmkOCGgWst9nsp8uEKFhqts7pyr5lTwZaMe0sNR64tJ9Ys18aZ
         PWeRO7kx7l2Yw2mmpozMqxAr5eDtAH1j97W7746GdPio3ZJEiUfXmFM5tlMVMRG9yYUH
         mMAXNbxA9PONry5e84IBL+3UKEYSOFG3SaYf7T5Lvzg47wyJIcxNjYNjflLniWvTA2CX
         iV0TA45WeeAYt839UQIlsmntX637DXdVgU4KKWbtl/4TkhofeWh8bSV0UMwu6BmndMZj
         pOag==
X-Gm-Message-State: APjAAAVp0/xgKxNmE/3cCNOxJgcP2HsbtmBXxJbShqtcrEcS4R5Gf+Ga
        UuUlwzrbG1Naa3lln3dzNnCmR191
X-Google-Smtp-Source: APXvYqz8XyHKNsoBElURCGJZ77p7owPf/I5FH20chofXUubJMocIWSRS1KX1ytccOYvZv7nKagL8IQ==
X-Received: by 2002:a65:4649:: with SMTP id k9mr472542pgr.239.1557054088443;
        Sun, 05 May 2019 04:01:28 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id 10sm12962955pft.100.2019.05.05.04.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 04:01:27 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH 2/3] jbd2: code cleanup for jbd2_journal_init_revoke_caches()
Date:   Sun,  5 May 2019 19:01:03 +0800
Message-Id: <1557054064-3504-2-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
References: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_destroy_caches() can handle destruction work
for all caches, so we don't have to destroy previously
created cache in error path, it also makes the code simpler.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/jbd2/revoke.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index a1143e57a718..3b46b45d085d 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -194,17 +194,14 @@ int __init jbd2_journal_init_revoke_caches(void)
 	jbd2_revoke_record_cache = KMEM_CACHE(jbd2_revoke_record_s,
 					SLAB_HWCACHE_ALIGN|SLAB_TEMPORARY);
 	if (!jbd2_revoke_record_cache)
-		goto record_cache_failure;
+		return -ENOMEM;
 
 	jbd2_revoke_table_cache = KMEM_CACHE(jbd2_revoke_table_s,
 					     SLAB_TEMPORARY);
 	if (!jbd2_revoke_table_cache)
-		goto table_cache_failure;
-	return 0;
-table_cache_failure:
-	jbd2_journal_destroy_revoke_caches();
-record_cache_failure:
 		return -ENOMEM;
+
+	return 0;
 }
 
 static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
-- 
2.20.1

