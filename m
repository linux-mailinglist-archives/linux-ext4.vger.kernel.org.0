Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F258DC60
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiHIQqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiHIQqj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 12:46:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBC6301;
        Tue,  9 Aug 2022 09:46:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j1so14994357wrw.1;
        Tue, 09 Aug 2022 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nHbf2R9YS+QLu619Bbr1qiSpwX/gscQK0/msY+tSKMI=;
        b=qqPEBjrFDDiTHnkldL0thOUFkPzpTaagqYKlKsEpeHnOLD6l34Im7Wo+giaBoFCbbv
         ZxBacHL6RuNnvNa7fLbWME0f1A/TVhIlVHUNXzushW3adHNO6l4mqzBiQJZIs7pOoDf1
         Qn5cxTgzmUkwgk6Ow1CzlcirntGHBTJ9AdOxA1EG6mvA30D09vikY1qfDRYpxEjeCdpZ
         lQ16LnpMlDrjOlZRLJCJavmAZYHbnIaHKLlN5o4M3lbJof5l3FngELdyAyMSY9U7iOwj
         k/nt4TKPEV8WjbPoD7ryg4D5dhZWzpDcO6FlvsUrzcOR1sl/xLn1S2heZ0+Qv769jEd9
         OjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nHbf2R9YS+QLu619Bbr1qiSpwX/gscQK0/msY+tSKMI=;
        b=w7bRzwecR5VCjXGqJyDJzi2LeX8UEXi8Fi1GQ0/9JqNhVumTCh+FWHbdhQFqGkPx2g
         83KI3qOdDTdnESaNs/WqnqVLKekqtmefiPfbINVnBC+Qoqsaqz1Wed8u6FuMn0tbvxb5
         2v9k7CMSSewBOUB8x50Y7wsbQFXc0O4mPGAZzK7L/+QZoy/NZUK1jTjF7RzEE0udYgaT
         tNS6UbBcOjUKBmVMWvgWrZ/MgFZYm67wmjW0IX0V5jpwYWvOgUlgxvxySYq0RIAQ+UB4
         9hQiLi88uv+gXJgWPxW0epRKFmvInTrkNmQE97NslRbQEd52/s91G7oOecmVmCxsQUla
         tN2g==
X-Gm-Message-State: ACgBeo0BsahrB1TzQPELOg94hNx6fyVJ1D6tunGPVwVPAyUxgrwTUIFq
        5xIvKgdDzX7rlKm+sMSr+gUoackYAPPP6g==
X-Google-Smtp-Source: AA6agR49xb05WczEjMdPv3pwaVlpJVUONYbN5CbNDLIce+skzs9XuuAUuI9NJ/o7BJdSJVOzNOp+Yg==
X-Received: by 2002:adf:f38b:0:b0:21e:c041:7726 with SMTP id m11-20020adff38b000000b0021ec0417726mr14724896wro.394.1660063597100;
        Tue, 09 Aug 2022 09:46:37 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0022063e5228bsm14002083wrw.93.2022.08.09.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:46:36 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] fs/ext4: Use try_cmpxchg in ext4_update_bh_state
Date:   Tue,  9 Aug 2022 18:46:26 +0200
Message-Id: <20220809164626.8999-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Use `!try_cmpxchg(ptr, &old, new)` instead of
`cmpxchg(ptr, old, new) != old` in ext4_update_bh_state. This
has two benefits:

- The x86 cmpxchg instruction returns success in the ZF flag, so this
  change saves a compare after cmpxchg, as well as a related move
  instruction in the front of cmpxchg.

- atomic_try_cmpxchg implicitly assigns the *ptr value to &old when
  cmpxchg fails, enabling further code simplifications.

This patch has no functional change.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/ext4/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..ce2f03621be8 100644
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
2.37.1

