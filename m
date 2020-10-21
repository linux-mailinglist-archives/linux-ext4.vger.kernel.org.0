Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA86294A4E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437557AbgJUJQP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC956C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f19so1103236pfj.11
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9db66j5jgBwQHfPYVkQHfIXD2LLsb4yznWteentD3Y=;
        b=YNFFfBwjI90ifdG/sAEfyOZ1tUaGOOYvf4nr80E3oNMJj1+gCbOKv8/KglcfasyTOG
         S6oP2iy5mUI23N9tZ+9L4tDQy2WnGlesXt9O7LXA6uSuewXXl6KWGhbwY4ZBR0s0wC5N
         6TQ9DWHi4fe9G+fnqQA3sV8grrXGDd8+5xl5Kcka+JIecXHQJdQ8BW/YWdCx7bxSSXuw
         vCYG8aT/2qvqyfbJj+oe0vrCVjfKVbWJOJf7goV7UtsXhm9qnKXLlUXYkCy9BJrle20E
         QFSrYUpJwES2pmqLvkQYu0/b+HHSt4SG5sjOit+UA07Fo8Z4t2Az7/wjUyA0ZHAgF0Tq
         6sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A9db66j5jgBwQHfPYVkQHfIXD2LLsb4yznWteentD3Y=;
        b=fJmLhPGpU3KnDXhkUl+xme7O2inwYZQ9cOUavtDazgJE6woEhNEiBEGvFA7bIQKzB9
         CUJY8ieedXaPrRfQQcvpUECTc6R+f0fxfKQbCOqeT61MUGrj3rMA/T5NJAeDqrpOXUWJ
         ywpRQ1sAe1LSYNay6YrT1oHV7bqWkon8MMvNeFgf2nsMqdPzUNmkNfkX/Io0O2NnU0mA
         RhXZHz5SKFxiwJn0/yzAQNTk2WY9c9MXuKR/vMeMEVlImbbnO8QaZw2JSAiPnEVwbnb7
         2sf0xnqstXFAm1WTeRvs0FpevOS2V/OpqUzbX0PPLsjVDvQmi+P/qKuMpKt5bjPw6t7T
         Rmfg==
X-Gm-Message-State: AOAM531wTbpj//hhd/zmHSE0AKts5tqKwHGKaBuOgO2z6/L1dNOheERi
        M4Y+6DIxlvmroTHPid8Wl2I=
X-Google-Smtp-Source: ABdhPJwDUuGnIwIwClcyeH47ggGrqEBlLaCSAVS0nhhBdYJcxMb7TSNk5lmsKk5wPUo2x7+ZLev20Q==
X-Received: by 2002:aa7:8b0b:0:b029:152:900d:2288 with SMTP id f11-20020aa78b0b0000b0290152900d2288mr2430480pfd.53.1603271774437;
        Wed, 21 Oct 2020 02:16:14 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:13 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/8] ext4: simplify the code of mb_find_order_for_block
Date:   Wed, 21 Oct 2020 17:15:23 +0800
Message-Id: <1603271728-7198-3-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The code of mb_find_order_for_block is a bit obscure, but we can
simplify it with mb_find_buddy(), make the code more concise.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 22301f3..2efb489 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1289,22 +1289,18 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 
 static int mb_find_order_for_block(struct ext4_buddy *e4b, int block)
 {
-	int order = 1;
-	int bb_incr = 1 << (e4b->bd_blkbits - 1);
+	int order = 1, max;
 	void *bb;
 
 	BUG_ON(e4b->bd_bitmap == e4b->bd_buddy);
 	BUG_ON(block >= (1 << (e4b->bd_blkbits + 3)));
 
-	bb = e4b->bd_buddy;
 	while (order <= e4b->bd_blkbits + 1) {
-		block = block >> 1;
-		if (!mb_test_bit(block, bb)) {
+		bb = mb_find_buddy(e4b, order, &max);
+		if (!mb_test_bit(block >> order, bb)) {
 			/* this block is part of buddy of order 'order' */
 			return order;
 		}
-		bb += bb_incr;
-		bb_incr >>= 1;
 		order++;
 	}
 	return 0;
-- 
1.8.3.1

