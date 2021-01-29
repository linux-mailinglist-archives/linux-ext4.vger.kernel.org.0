Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B54308CF2
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhA2TAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 14:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhA2TAF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 14:00:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF7C061574;
        Fri, 29 Jan 2021 10:59:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p72so10363785iod.12;
        Fri, 29 Jan 2021 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgYPIOqOXKdCc6WoLn7V5g+qgBdayVhc1PkpXTbqbXk=;
        b=GnXjtF8HzAzo7iSmOer2r2dfDd2OuHi51oE0gzSSiRytHTVSOy5iQs0uzqX0gTl2b8
         zbDWhAWHSHIasZ7KY+++5txY1UvOs2BqYUOp+QDqRg2APUImYqnX//tOVW5SWYQQpRa8
         H8emcLul4AA5dgHMJcayZUvsjyqBy+dJPBOoexDD47vbJ8BCgcUOYyE24H5LGAZf9Igj
         w4fFB5Uzu4ctdfwsjbYpWc4cvd1hkySYw8ootC3LDKA3lCXPKnbZFVKUn+D4ikKHt9aC
         G3IoQKLla/NSfiKssAtsJLXr6AoSnnhKu4Lru+pQ2mZ15YCiw0CDH26yxc9KVMQac5jh
         HmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgYPIOqOXKdCc6WoLn7V5g+qgBdayVhc1PkpXTbqbXk=;
        b=G5zX4l79+OJ075amVbWGzVqLTpfjvqa/2KMwWH5Z3pSXABpF7FNY1FF/jbwFoJ+QLu
         Bf9uQkW4Dh3VcazlhgOacLKbyU7AF3hVua2VfityHD3uqpwFF87EtUqlgmL6KpyP/1fD
         DcSQ2bOXQSAZAPl19KqbFttlbnn2/qCUqWYYEy2t/e2FsNHu7Y1AfH3bDYyHQsxbcJ06
         kQ+I5r6Gyo9BNHw7sdjpWfqoTsA/0h7bb35GqAdgUmuY3CqLiS8malJsgrsfoRZ+nWG3
         7rcH4j9JWwkWsykP4sLvcPIRI7qILmQCeTa70OajN/Lv/OVZe8EEcpUJmjdDEc4gN68B
         pe0Q==
X-Gm-Message-State: AOAM533o5dqDaq2vutDtKU/V/yyT+WfxZwK/cHN8jRhUz2lQ4lAhPdzX
        ay9PCuzb7MtD4/pfxgJR8b4=
X-Google-Smtp-Source: ABdhPJwDhrl9IvxbuP8ngx1wk9KC9Wv5j0rdVczHynGOSlOGUzdnMwRF37HqP+Fb2L5Pk7hwIqe9lg==
X-Received: by 2002:a02:cab2:: with SMTP id e18mr1122374jap.55.1611946765078;
        Fri, 29 Jan 2021 10:59:25 -0800 (PST)
Received: from llvm-development.us-central1-a.c.llvm-285123.internal (85.235.72.34.bc.googleusercontent.com. [34.72.235.85])
        by smtp.googlemail.com with ESMTPSA id h10sm4846817ils.10.2021.01.29.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:59:24 -0800 (PST)
From:   Vinicius Tinti <viniciustinti@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinicius Tinti <viniciustinti@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ext4: Remove unreachable code
Date:   Fri, 29 Jan 2021 18:58:56 +0000
Message-Id: <20210129185856.158310-1-viniciustinti@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By enabling -Wunreachable-code-aggressive on Clang the following code
paths are unreachable.

Commit dd73b5d5cb67 ("ext4: convert dx_probe() to use the ERR_PTR
convention")
Commit ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")

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
 fs/ext4/namei.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..1f64dbd7237b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -827,21 +827,6 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 				p = m + 1;
 		}
 
-		if (0) { // linear search cross check
-			unsigned n = count - 1;
-			at = entries;
-			while (n--)
-			{
-				dxtrace(printk(KERN_CONT ","));
-				if (dx_get_hash(++at) > hash)
-				{
-					at--;
-					break;
-				}
-			}
-			ASSERT(at == p - 1);
-		}
-
 		at = p - 1;
 		dxtrace(printk(KERN_CONT " %x->%u\n",
 			       at == entries ? 0 : dx_get_hash(at),
-- 
2.25.1

