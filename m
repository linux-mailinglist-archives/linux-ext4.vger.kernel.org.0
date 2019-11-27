Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A641610B638
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2019 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfK0Sz3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Nov 2019 13:55:29 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:43115 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfK0Sz3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Nov 2019 13:55:29 -0500
Received: by mail-pj1-f73.google.com with SMTP id cu13so11525949pjb.10
        for <linux-ext4@vger.kernel.org>; Wed, 27 Nov 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jREom96kPrkVRaSJyLna+V7rS+hyM0/IOYJmAKHXhJ0=;
        b=KKH874W/XQVmgWAp4+TIjpezcCZMg9WjevRswlOEhCRGrlGtLoJSJ998VSH1NJ8off
         ETqzp4z9r61DsXI5OOzxO1dOxSbUPvWWRdRhrWFkPP10dYW9RCg1ZQryuj3dkYz+gxJ5
         DtU8JbwimD021VNRuBmQtQg7J/a9yGYC3r820DDjndqzww93M+cHAz7pkmg0TOuZEK2Q
         CYgg0cJ8bji16VYOkrcB8fwGXNRZbigViayVf+N4UgJO3liQ0q6ajDGm/x58MZnTl/1P
         2+uOMqAcJrRkmgy/iarFSuur4H13FgSFbQYyejfE4UwVUMs7kYPcN+LUpFx0octP5/Xk
         bMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jREom96kPrkVRaSJyLna+V7rS+hyM0/IOYJmAKHXhJ0=;
        b=KWNzmUMGyVnWIp385lGd7yhHy4xa0lnMD0Q8aXF5h3b4U7NegCHiEO3KVuDF5Pbdxy
         cBB0s4v0DMfA85JDqZn6wQChP6Tt6fguAqE3MEX52ihSDhSa+BpdekiziVh5FEVwSCIP
         DAwAOE5LvOuITYedeAimEADuBnRC3WIBIgv2VguxwswiStPAB6qEi7IW7dqVofr2vJuy
         iQVonIJkmfOOyPfiY30uXMKwdk6XqmQRK/p2HhRqJSpUxCpEo0aaj3OtQFkCWvzzzSB1
         bZ4Ew46i/jsWMf0Q2QlgoS4FJ5oebSF6BWVeR/sQXPsoam15uViU+HDkYo3pstQq6cdk
         6IFA==
X-Gm-Message-State: APjAAAU0OX7LlcljsZwFACElp1HhLZDd2vKlHATXVKCOCVKkMZ0iUAbL
        C1qbxMcz54V7nVXI/tgFZ05YtpRisz0=
X-Google-Smtp-Source: APXvYqwxlZ6V4IoCz3uKIn8TZk+jPAYdMpXoG4X8hVyqJOopW33JqYNwm/AaIsk6WssYS/kXvFlKvTLavdAB
X-Received: by 2002:a63:1b1b:: with SMTP id b27mr6222499pgb.402.1574880928437;
 Wed, 27 Nov 2019 10:55:28 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:55:24 -0800
Message-Id: <20191127185524.40220-1-yzaikin@google.com>
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

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
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
