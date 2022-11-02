Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993A615CC9
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Nov 2022 08:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKBHNE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Nov 2022 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKBHNB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Nov 2022 03:13:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AF21248;
        Wed,  2 Nov 2022 00:13:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t25so42893555ejb.8;
        Wed, 02 Nov 2022 00:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+IeUzxt6orpOlekXZBA+T9iyN6d3oGAR7wGHMXLHvo=;
        b=pdtwWebe75iegeVM79otvSfrtFou8j0pW/4zklqkXm7x1R0VadKV/ByxKcv2nu54+u
         euzuvJRBjjNZl4xS6I3oix2lZYVB1GVbHAGn6TcINY+eK05QfIYGp8ewdPnUM5gN792+
         MQyEMrE6sA1M6DERuziD66kJ8EDrPpJ3dmSYBek3zAp/MBv1HfT5AbnE//WQJflOmAlE
         ACyeoNPzPHZbVF4nL/A1w8mAVVv0wCw7FdvXGl7pbJvBpmNxl7q/x6OlfBwYNA6KbTrO
         G20zpPE7Nqr/UrhMF+nTQSOWK878LOoX72ypgI7Dr6vKUSFfgywyl+uwnyfl8xp3PnRS
         HzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+IeUzxt6orpOlekXZBA+T9iyN6d3oGAR7wGHMXLHvo=;
        b=w21zaKWQ1Uz+sH/zRDJOe+dHXoZCctJRuaTYeXGhjaigzQTITnMZzqsnGsgeYRdn6L
         goeiNkzoeNNutl+u6LMdmCFVEJuHmudi0sK8HcJhTdT/stgzMYNr+PBlu+0r5+8QwA1+
         sL9QOwUgkVS0eIlnXcHOa4JZy2BKc+dCI+h44GPSIfuiQO8xJAytBaL1lzvHvCi+EGof
         QNffQxR0t1c8ooZ8R/ekTa1Tm+qFjFWE9WI21ilExya1kNGHChCVM1gcW2GDgyn44ltv
         RBxbGJbAwTYYGxaK9KFt1USMq8sPeExGecsYNwztN/A/+agv7VMp1GZfHPXFDkUOK3Z5
         fSaw==
X-Gm-Message-State: ACrzQf2nwGnSoA2enJtv0vJM+IrwE3BWiBRTcJrQKHJUiGU/0Ff893/K
        T7vqIjpm4mX3wpvwR37esXcoNiCyNPbHpg==
X-Google-Smtp-Source: AMsMyM5ARv2QWNszOAthBVutvxps337BuD2bKMwP2sv1ggNbxZoCLIeJ0P3N3tTbqde/yJeqJFqYSg==
X-Received: by 2002:a17:907:6d88:b0:7ad:b5f1:8ffc with SMTP id sb8-20020a1709076d8800b007adb5f18ffcmr20491200ejc.727.1667373178984;
        Wed, 02 Nov 2022 00:12:58 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0077205dd15basm5031930eju.66.2022.11.02.00.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:12:57 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH RESEND] fs/ext4: Use try_cmpxchg in ext4_update_bh_state
Date:   Wed,  2 Nov 2022 08:11:47 +0100
Message-Id: <20221102071147.6642-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
ext4_update_bh_state.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/ext4/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..162e39e2f59a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -780,11 +780,10 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
 	 * once we get rid of using bh as a container for mapping information
 	 * to pass to / from get_block functions, this can go away.
 	 */
+	old_state = READ_ONCE(bh->b_state);
 	do {
-		old_state = READ_ONCE(bh->b_state);
 		new_state = (old_state & ~EXT4_MAP_FLAGS) | flags;
-	} while (unlikely(
-		 cmpxchg(&bh->b_state, old_state, new_state) != old_state));
+	} while (unlikely(!try_cmpxchg(&bh->b_state, &old_state, new_state)));
 }
 
 static int _ext4_get_block(struct inode *inode, sector_t iblock,
-- 
2.37.3

