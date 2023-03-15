Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716C6BBBE4
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCOSTn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjCOSTe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 14:19:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425479B09
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 11:19:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x8so2127507qvr.9
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zopkQ37OTbb3jqgpfO1W4/ZEQgiXwNommG9IMZvT2rg=;
        b=TLYClVd+VJLKTpszbcY+j5Cmv4IE4AGWIiTfyq5wjafEITguH3DeszdQNA3wA+fTJP
         Iu1VSWCUseU8K3SHSlfuwq9B/N9dua+Daz7K8vnKt4UH++qSDzv/Q6FTB8oS7N7seNRM
         0uau9GpCOhyskfAsaKnRFlCO4F1KMLe6iOvig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zopkQ37OTbb3jqgpfO1W4/ZEQgiXwNommG9IMZvT2rg=;
        b=jdK8Ub+YDgFhXfin5RPqJw8Jqk/hTDWgIjU7f0FNImG+lQ330UiGW8T3nNcz1UfEF7
         QOrXrAZTN6U6iyvMNiorfnOC56znAcgQ5msms0n46VfJX+6BuvFw61WgUf7SxyziSlnF
         zdfESp/ldgrQjU9S6yjzuJcjERqqeDUSJl3sQUaQQE/K5MWlQo6h6F5JHD1K4JejY58s
         BAlyagsvZC4bS9ZQnV6KgY60cP3rPB+H541KpHblE667JpE8pRTM3Zf8X2qNFrSO51Ep
         i8acKs5X0vbQIFg+AHRJOStmOkb5cq+ja1m4JLDZ/fOG5iMSeEBGTTi9l+Ys5ddSuCWt
         SzCw==
X-Gm-Message-State: AO0yUKWlQYxZgzfmJAqEdWu9vsSt/V+DHgk0RC/bdHDmbx1OiJZDpVA4
        IUOBbR5BWJmGPkJ6VBnATMO9tA==
X-Google-Smtp-Source: AK7set/hCCFJOC2Yg+Yoi2Re2vblNTj2n9yVDq3z2Os1uV34xJ6baMyuRQji3/AZqoHcyys1zoL/Cw==
X-Received: by 2002:a05:6214:d89:b0:56e:ac97:85da with SMTP id e9-20020a0562140d8900b0056eac9785damr26734276qve.30.1678904372039;
        Wed, 15 Mar 2023 11:19:32 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:54 +0000
Message-Id: <20230315181902.4177819-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
of the single-argument forms, which can introduce functionality bugs in
atomic contexts and latency bugs in non-atomic contexts.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88f7b8a88c76..405a66b47311 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2500,7 +2500,7 @@ static void ext4_apply_quota_options(struct fs_context *fc,
 			qname = rcu_replace_pointer(sbi->s_qf_names[i], qname,
 						lockdep_is_held(&sb->s_umount));
 			if (qname)
-				kfree_rcu(qname);
+				kfree_rcu_mightsleep(qname);
 		}
 	}
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

