Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8E10A757
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2019 01:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfK0AK2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 19:10:28 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:47549 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfK0AK2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 19:10:28 -0500
Received: by mail-pj1-f74.google.com with SMTP id q22so10072528pjp.14
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 16:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5j8209s7wyWKdS1J+a/RMwLo3s0bXaXoyBAKaKACgqU=;
        b=sOz/WnOOzGDlwh48N4QMtKoKOE3lKBNSUMpnpOymzACK3shRbuXyHl/6WBEfn1Wb1Z
         qsMjrCZfpr7kr6XuO1/mtZa33hdJB7yx24E6EefYSGnxlB1QdK0jp2bRVEQmmKmEUDKW
         lMnckzt2Obexns9Ze5nschKzqlMM+3kQqDZAZzheas5OMSnTwgoHa/9YL9dIxqNl1TP+
         xSiPBu2VTPXnk4kOeXuMzwKoOFlxVetZaP1og88hGjN4CVIDJ+xuHI6DQqUuvoRxaPYZ
         ZDHIR2Ilyi41pNNAvdKovHJiCtFrPbMNnlH/EWPzCeSYj8Sz5rSRPrUvpRSTRn+0mhFR
         maMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5j8209s7wyWKdS1J+a/RMwLo3s0bXaXoyBAKaKACgqU=;
        b=h4bwoeJft8l2oeAd7do357Dygm4xgKikKavohLl4710Ql1rVIDGrm7Po3C5qp/Zw1V
         VgIM9VVmA7NKN1YFn3Prgp9k/JhBw9tug4mbnU/v1+G3F2vJBWhavLulrfDUy0alLwQx
         JwpeQkMd2kVBjxi4PbC7piUTr0eqCLvH1zCTJwxBPbcJCiZkt7u+DO+AB2Z3GoJ0coI0
         I8qsDR6c0Do714BnrzZi+UdqqSdNzaXWe6OvFMKCFBUBmcxCJM8HDGHjezQWJmqhqHU4
         CXVBmVAkEeqrmlGRxP98J5j2L3I1964/d7zRYnB8VXXfD7zRFHUWDfnVcCL5jQfYpfXn
         uiGg==
X-Gm-Message-State: APjAAAUOLPtGeqAk5hI+BhBKwHp1pAaBCa+Q27U0LLPQeTjlSwCOeX00
        lGnXWv6zKhZwpbadqQehu+4Lhrqg7p0=
X-Google-Smtp-Source: APXvYqznTyVgi1L2GWqo1+o7/rn73OMgsdD85PFwMmy3yFo3uQGCoQX75HcSdjNurxp2gLBPb/qv2dxNkpzx
X-Received: by 2002:a65:590f:: with SMTP id f15mr1325328pgu.381.1574813427623;
 Tue, 26 Nov 2019 16:10:27 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:10:23 -0800
Message-Id: <20191127001023.63271-1-yzaikin@google.com>
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
