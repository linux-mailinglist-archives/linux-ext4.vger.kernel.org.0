Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4AF309FB7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 01:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBAAdK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 31 Jan 2021 19:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBAAdH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 31 Jan 2021 19:33:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919AC061573;
        Sun, 31 Jan 2021 16:32:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g7so12942022iln.2;
        Sun, 31 Jan 2021 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7jA619CFLWmFa7U9RCqRtrwaxAtDkBtNPUOaZVyUNg=;
        b=Zj+sdCwwO697ptJRwWCX3i4RaWrSx6gEU6sUALOEl8NYtUx2MeQWQ9QAEIZnydenj6
         DVL0Brjje+WH0hdKGTnqGaKJ9r/IcAmSp8IUownUT6PWrtVJ7/rgxYr6EN7TPMTWzsuu
         E1jGYUjtw4xDtUxDW7kf4aIEQG8ceVh80r27L5XCRX2STPYmaEdILKldaGLoUYrdt3WJ
         XKdglsHQGTQqhgVcE0LSG2MYH4UKrlCWy8Hbd0W9lT0PDKt7sLYwpiUKX3upSY/y/qj9
         /Arhmj9s6sRUkUUQEQKTUqlTCULuy51GqY6nV0ETpiRgkj+7j/DQkn2q5c3xq65gT6T3
         zUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7jA619CFLWmFa7U9RCqRtrwaxAtDkBtNPUOaZVyUNg=;
        b=Z9h9sQ/f3yNuVrZmGH2Ff9fDeKas4pwSpmcnqj/BF+uiYP1eyzzZ9IY5hn3HF00vbv
         +uscqKVEwxvqA4NwtcH6vZCVERzY5W8kanHJX3l89j84UEgyDM4Nx1VcwErSsth3Xopy
         uuHAccdv1RRPjzqS1jgtebXWB0M4xZFLYHIlYnzmC+MvBMVKmkltZHTetoWFCI3h0RFs
         N1d59Mr3Xva7Ny8Mcmc/c7zJngL7DKx0otoE9h/+EB4X+J6dmyECC+z1MpwMxQ/kxbM+
         qioxY+rw8jHdE3oHvhJL9AXvTzvOZFRT/7R77E8oyh5symW9VYxa1KpdnAwlOT+02nDC
         OwEg==
X-Gm-Message-State: AOAM531vJOrS1+MEfSRtRnj7ck7bPvYirJysw/V9de9TUW0WcqdFxT+I
        edkQAsWh6Murw4IG3Z4+IA0s/sbi9eDTiDG2
X-Google-Smtp-Source: ABdhPJzM7P9FgEtc51SjGzn+nX9W4gssJ4uhbFNAd5YYP1Qndlj9HgxhD4VCHXc7unI3YHIZ0p1e9w==
X-Received: by 2002:a05:6e02:c08:: with SMTP id d8mr4896115ile.102.1612139547154;
        Sun, 31 Jan 2021 16:32:27 -0800 (PST)
Received: from llvm-development.us-central1-a.c.llvm-285123.internal (131.28.69.34.bc.googleusercontent.com. [34.69.28.131])
        by smtp.googlemail.com with ESMTPSA id x64sm8529485ilk.47.2021.01.31.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 16:32:26 -0800 (PST)
From:   Vinicius Tinti <viniciustinti@gmail.com>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinicius Tinti <viniciustinti@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Date:   Mon,  1 Feb 2021 00:31:25 +0000
Message-Id: <20210201003125.90257-1-viniciustinti@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By enabling -Wunreachable-code-aggressive on Clang the following code
paths are unreachable.

This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
copy of files from ext3") and fs/ext3 had it present at the beginning of
git history. It has not been changed since.

Clang warns:

fs/ext4/namei.c:831:17: warning: code will never be executed
[-Wunreachable-code]
                        unsigned n = count - 1;
                                     ^~~~~
fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
explicitly dead
                if (0) { // linear search cross check
                    ^
                    /* DISABLES CODE */ ( )

Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
---
 fs/ext4/namei.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..46ae6a4e4be5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -827,20 +827,21 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 				p = m + 1;
 		}
 
-		if (0) { // linear search cross check
-			unsigned n = count - 1;
-			at = entries;
-			while (n--)
+#ifdef DX_DEBUG
+		// linear search cross check
+		unsigned n = count - 1;
+		at = entries;
+		while (n--)
+		{
+			dxtrace(printk(KERN_CONT ","));
+			if (dx_get_hash(++at) > hash)
 			{
-				dxtrace(printk(KERN_CONT ","));
-				if (dx_get_hash(++at) > hash)
-				{
-					at--;
-					break;
-				}
+				at--;
+				break;
 			}
-			ASSERT(at == p - 1);
 		}
+		ASSERT(at == p - 1);
+#endif
 
 		at = p - 1;
 		dxtrace(printk(KERN_CONT " %x->%u\n",
-- 
2.25.1

