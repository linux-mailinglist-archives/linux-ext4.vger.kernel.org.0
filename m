Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0004310A792
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2019 01:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0AhZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 19:37:25 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:51952 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0AhZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 19:37:25 -0500
Received: by mail-qv1-f74.google.com with SMTP id e11so8617179qvv.18
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kDJP03s8s8T9Vmv8o/f6MTS/LgroUMLjoGB1CZ2BzSI=;
        b=H4ljBdij21KypDxw//C1Oqw1ZUz5l+ZxCH1qIFJX/wMZ/YUyLYLJMqVqvk78lIYfXH
         xB8gkircyK8b1+mUTYRhFZyu85C8xkr2zGuMoW+LLSY/AvhjjDLiCVOpggz+T9M2Ugw8
         cCokicxmEeRktS0w7yCEd9bTdCdTrWm1XfCO/dF5aPfeSTD+UAHzGy0xBiX9iGvVxYOm
         YgWKD/pL0EuDfTB+/WuAz7py5ZlzL1KjM4X/Rg5HVgl086txLy36rKGzuFMYLYyGWRT+
         KWLH4AOuC8+U4DTRaa6Js3d7pNS3O2jUv/CCfTA3LGt6O9vy22ZAziFsEtLFMb2GSZ6j
         aABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kDJP03s8s8T9Vmv8o/f6MTS/LgroUMLjoGB1CZ2BzSI=;
        b=r8LBrGsZIUBEqlVr2XWzUinj/qJfInqNJU4yENFPWwG98WPYTctVZYpMIBTYkTz5zq
         WxBidgwERQUFxLQQDudM1yLHHb9KHMSrb4dcygQwc1xo0ARy1tXVXeRIVVBvuZ8aCPz9
         GRsJExLLTPaNu90ZNfZHKQ0Wb2GsxXs8R6gqgHnCAviHQ8LOiomz33U9RjuzdxwzaE5b
         rxzqRuktuyBLadRmdMqW4RpiaPZgZMmWRPOiOMqr8EC4I6CF1A0M75LLqeWgxO8NXsYy
         fKjLh3ydlZeOUaceJtkvPr1dSmQjRUYhJJSHQsLc+TXyDGPSKonKR+QQTcVuACDzqzI5
         huuA==
X-Gm-Message-State: APjAAAUXqlreNZIeYDIfG2P7SY5hc/q9un32hGulpxN+9PVGiK2E4gbJ
        l4WVBmmUizhtoypxOQA2Rnji0KYekQw=
X-Google-Smtp-Source: APXvYqxnf7Zk9iRXiPguDd1hC8mrvt7yS3lTSrT2kR8ANqLHZNS4+q3rKgHlyR+WgtAWJYxZSH4X+VGf+D/A
X-Received: by 2002:a37:b703:: with SMTP id h3mr1345799qkf.79.1574815042647;
 Tue, 26 Nov 2019 16:37:22 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:37:15 -0800
Message-Id: <20191127003715.108479-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
From:   Iurii Zaikin <yzaikin@google.com>
To:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        tytso@mit.edu, geert@linux-m68k.org
Cc:     linux-ext4@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes the issue caused by the fact that in C in the expression
of the form -1234L only 1234L is the actual literal, the unary
minus is an operation applied to the literal. Which means that
to express the lower bound for the type one has to negate the
upper bound and subtract 1.
Original error:
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == -2147483648
timestamp.tv_sec == 2147483648
1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: msb:1
lower_bound:1 extra_bits: 0
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 2147483648
timestamp.tv_sec == 6442450944
2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on:
msb:1 lower_bound:1 extra_bits: 1
Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
test_data[i].expected.tv_sec == 6442450944
timestamp.tv_sec == 10737418240
2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on:
msb:1 lower_bound:1 extra_bits: 2
not ok 1 - inode_test_xtimestamp_decoding
not ok 1 - ext4_inode_test

Reported-by: Geert Uytterhoeven geert@linux-m68k.org
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/inode-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 92a9da1774aa..bbce1c328d85 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -25,7 +25,7 @@
  * For constructing the negative timestamp lower bound value.
  * binary: 10000000 00000000 00000000 00000000
  */
-#define LOWER_MSB_1 (-0x80000000L)
+#define LOWER_MSB_1 (-(UPPER_MSB_0) - 1L)  /* avoid overflow */
 /*
  * For constructing the negative timestamp upper bound value.
  * binary: 11111111 11111111 11111111 11111111
--
2.24.0.432.g9d3f5f5b63-goog
