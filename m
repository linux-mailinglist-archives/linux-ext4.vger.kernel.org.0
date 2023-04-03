Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D26D4641
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Apr 2023 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjDCNxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Apr 2023 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjDCNxP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Apr 2023 09:53:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31230E0;
        Mon,  3 Apr 2023 06:53:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso30586666pjb.3;
        Mon, 03 Apr 2023 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680529990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SW9D8BEM++mU1mqMGl1AFvxnGWHPgMmcAakeggyzyYo=;
        b=oR5QkpTB3u45hn9geHeHFTG+NzVWvk2PBEEG/1KlzYUVg/1Tb66u8+aOui687oOyCn
         kC/DpBz7PzQEVWVp7XGzx9QWGtUvlkpbJ3vgSsjuGybxo/wA78fqZHnoBf5uYh6TSnfn
         34LPanpDc9WgKViJiS4Eet7t3cWGwyNYZnxC5WKUscuXe5Zg2qqBHuyQmONdtyhgJ9Gw
         Gn11mgsp2XYusvdLdA1pYdpYavod9FNcDuUo1t6CtukgcE431D+ueHXyDSs+8JnsvhwN
         f2gQ1H+i7CX5ez4lE6xHp4vVl82AdAbexQuiVFPu3kR/wWeUobfDs4wf2SoWCsev9oSI
         KbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW9D8BEM++mU1mqMGl1AFvxnGWHPgMmcAakeggyzyYo=;
        b=SwxrtxIDYVlGpaAe19kmg2f5pE98d3ZqtaPwGBM81nZPgtOrptLXSM5dDu9TUClE2L
         ExEQjFqsKvVhnl8dap+40lIEc7gK9I7HZPeLwciGJE04DHWDt+oCuF0FEEorXBDgN6kX
         atGxPZ5U0KjVxoFHU8bI430Wh2yrNkhqhP8s9I8US1F30ap2VK5SXGEllB84JKuvYhGu
         ev38sIwtIwl9hJOcUpwjAuosizw6KwPckWsWn1bqZZyORiFAIF9kQwMxFkxL8+d5c5FT
         bpQHH0VUb4zDXvxhawoaTfvdzzaSRRoQ0/FvNr1k3pl+jqoZWC4R+f/nXKbeBJTIhgpG
         eq+A==
X-Gm-Message-State: AAQBX9c/E5yyAMV+SxxgIrlixRkBTQliUPcB+R/hpI5eu37eEmtUJmGs
        PDUy2AEpv7P7StZlyhyVstWahNtgE2oAsQ==
X-Google-Smtp-Source: AKy350aM7ZRpNAENcPfSAhXTyjKBSD5aUYh7GIre+Z44Z+39FLIXXXAS+1MhS00aQBS8pfmkhXNrAA==
X-Received: by 2002:a17:90b:3846:b0:236:6a28:f781 with SMTP id nl6-20020a17090b384600b002366a28f781mr41273891pjb.22.1680529990285;
        Mon, 03 Apr 2023 06:53:10 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id nv8-20020a17090b1b4800b00233cde36909sm9802883pjb.21.2023.04.03.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:53:09 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: simplify 32bit calculation of lblk
Date:   Mon,  3 Apr 2023 21:53:04 +0800
Message-Id: <20230403135304.19858-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

commit <ad4fb9cafe100a> (ext4: fix 32bit overflow in ext4_ext_find_goal())
uses value compare to fix 32bit overflow. Try to simplify that.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 fs/ext4/extents.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3559ea6b0781..324b7d1386e0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -237,10 +237,7 @@ static ext4_fsblk_t ext4_ext_find_goal(struct inode *inode,
 			ext4_fsblk_t ext_pblk = ext4_ext_pblock(ex);
 			ext4_lblk_t ext_block = le32_to_cpu(ex->ee_block);
 
-			if (block > ext_block)
-				return ext_pblk + (block - ext_block);
-			else
-				return ext_pblk - (ext_block - block);
+			return ext_pblk + ((signed long long)block - (signed long long)ext_block);
 		}
 
 		/* it looks like index is empty;
-- 
2.20.1

