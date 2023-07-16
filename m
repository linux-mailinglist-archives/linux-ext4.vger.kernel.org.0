Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B3754EEB
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Jul 2023 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGPODs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Jul 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPODr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Jul 2023 10:03:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDBBE7D
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 07:03:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e3b15370so2596113b3a.0
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689516225; x=1692108225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7IAbx0OUUSrlPthyJTQ0UOVjqJAOrg2OPpx/qgjHNuw=;
        b=naUe8xwLdQ9VhK2dUWcpvvWtlIESx6O5YW2ZuTYlGicFqfuTdn5EuAVvT+xJM0lflh
         VMIMHnUWOTG5wRJtP01KFZGsMzylXDGCLWVwwk3WJuxYxk2nj/k21VIP1z0lmu85ekKW
         ZvOgMIzrlGMt8Gc65TibvAj6jjkf3YowS6RXhOoyKgcmzaeQMpjrWXgRhULTx1MuMvJr
         kytdZJGYrNfJOWI7j1x+AYYNeP/oJzuwRPR0oN/a6mPK1Lvw/Re+qvI4cxCL19g4GLgl
         RCifg1ol7gs12oa2t0PXHEwmyUoNsUkI7bn2GsCb7U2+wHafWdObVFMR3UNMz2Ddocj8
         vVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689516225; x=1692108225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IAbx0OUUSrlPthyJTQ0UOVjqJAOrg2OPpx/qgjHNuw=;
        b=ECkLd7/1k5cE/V3YE4C6ypsDyDZRVwy2OFgx1qfrd9gzKM6Byuy0KE19hDZ1h0VUTL
         E4F/to74qDJEvjBmr84rNFKco4wDkKvYHIvPQMd9i8y9Ed/UPHYodK6idT+N2VuA1iE6
         y8/6d54KVNMIDsJ7IQ1Yh4TqRXb3NIFYWcFpYSPfqqBZBTg4DwiMqjGtKsX2Ssd4nlOz
         L7VGjesVQhOIW4hiC1wW2G67J8PSi8MgehP1oyJOsoWC/ATkAbjFosV7Jcg0wSxmTbzb
         +NLRK5rezEQgvoos0y3gPmg+M3sWoTTPJxaOsTxC0+iuqCWRcRkp4ewbAB6GccXXLMVG
         XtKA==
X-Gm-Message-State: ABy/qLYQR5RpH1hkSuTB7uGz7JwfOwFAwolmvk0GcwSihhNqqlMjfaOG
        23wZWRrcf8yeUZSqNJsuDT5eiP6TpVA=
X-Google-Smtp-Source: APBJJlEkKLJ6nI6WonPbXD3eZYedXbg7qNVFqrWbKl5DzoSXYC7HD5T8O1r0hSq0ChPgpFRnEKi8gA==
X-Received: by 2002:a05:6a00:24d5:b0:67d:b924:54ca with SMTP id d21-20020a056a0024d500b0067db92454camr11684384pfv.34.1689516224901;
        Sun, 16 Jul 2023 07:03:44 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0066a4e561beesm10599386pfo.173.2023.07.16.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 07:03:44 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: Don't use CR_BEST_AVAIL_LEN for non-regular files
Date:   Sun, 16 Jul 2023 19:33:34 +0530
Message-Id: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Using CR_BEST_AVAIL_LEN only make sense for regular files, as for
non-regular files we never normalize the allocation request length i.e.
goal len is same as original length (ac_g_ex.fe_len == ac_o_ex.fe_len).

Hence there is no scope of trimming the goal length to make it
satisfy original request len. Thus this patch avoids using
CR_BEST_AVAIL_LEN criteria for non-regular files request.

Fixes: 33122aa930f1 ("ext4: Add allocation criteria 1.5 (CR1_5)")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3ab37533349f..bc004f5d3f3c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -975,7 +975,18 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 		*group = grp->bb_group;
 		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
 	} else {
-		*new_cr = CR_BEST_AVAIL_LEN;
+		/*
+		 * CR_BEST_AVAIL_LEN works based on the concept that we have
+		 * a larger normalized goal len request which can be trimmed to
+		 * a smaller goal len such that it can still satisfy original
+		 * request len. However, allocation request for non-regular
+		 * files never gets normalized.
+		 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
+		 */
+		if (ac->ac_flags & EXT4_MB_HINT_DATA)
+			*new_cr = CR_BEST_AVAIL_LEN;
+		else
+			*new_cr = CR_GOAL_LEN_SLOW;
 	}
 }

--
2.40.1

