Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81FB19E96F
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Apr 2020 06:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEEy5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Apr 2020 00:54:57 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53245 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgDEEy4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Apr 2020 00:54:56 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so5005621pjb.2
        for <linux-ext4@vger.kernel.org>; Sat, 04 Apr 2020 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8gQeGNDkB+ERKJN8tgzWDwu8rNNZn41Iteab0ATdJc=;
        b=oJL6E5io6qalYVkcLyagDGske1YtuiLixLxFLw5B+ZlZ7TEghPvO8t7W+3I1PiOOrL
         M+v6oYay8CLlA+/wHYtfhO0Q4GSLJNJYgbxr0DbW1KgUrU2Sfhv6eyV+FUsxV2fc7BCu
         eZV75WnTd/lH4uMFFweNFFADMx3kgkuhPL7SKP7WQeI30ckZN0Tghawj4uygr89acg1L
         8nDNS8G7mMMxmkp1R3i5WINZAUx2ZExYjVE2unIb2tXKHcpx0ihoTLIBiW6+dHzVrgqZ
         xpQ/RS/RptaojnGWN6Lz4umwTquzGpwt852e+VFjIn/5OMcIa8Hy6VixE5eoXzSjsQPW
         c1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8gQeGNDkB+ERKJN8tgzWDwu8rNNZn41Iteab0ATdJc=;
        b=GFmHqt8QsihTTI3JXQJOh99crrU14PfZeqh9rYZLSxh4x4rCGfmlHKsLHraMWRHYZM
         MuLQWVBRoNfZZFgyKMYuqH813aGuH3YTFGtAiNev1R3Bsw6sQGhq8/UumA9zTmmK7s3c
         ugNMj/6aC2BiXfBhYkUu+q94HrYHer/vPQj5XmmTuWHSsBDOV+N6nAZynCHwmwjUQ004
         UqBLVkANKAtfffuppZAusaZYBKSYarm43rlc/LNT7tbgvFF2OfskstEslITffB+rMcBl
         0165bAKG0npfVcTYVVSQVGPjTYT0facFedlEbG6tqCAQDkH7Tr1Ue6YmkeUiGwNb7YBe
         uUUA==
X-Gm-Message-State: AGi0PuZGnf/ZwixXyuf3kZ1rAj2/8hUFgNmhGKEXnJxKtX1NpE9Na4KF
        igi1jFc3mssKJijCGrh4QeWn44J4mGk=
X-Google-Smtp-Source: APiQypI4XabCmy6/6FKmCXmARbE1CI7zKvob96yjR84vX5NZnxHJwcAkT+Uf9ipUmfN1jpdhWpBWBg==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr19375193pjw.128.1586062495682;
        Sat, 04 Apr 2020 21:54:55 -0700 (PDT)
Received: from localhost (c-73-70-188-119.hsd1.ca.comcast.net. [73.70.188.119])
        by smtp.gmail.com with ESMTPSA id j1sm8714883pfg.64.2020.04.04.21.54.54
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 21:54:54 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] libext2fs: avoid pointer arithmetic on `void *`
Date:   Sat,  4 Apr 2020 21:53:46 -0700
Message-Id: <20200405045346.21860-1-mforney@mforney.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pointer operand to the binary `+` operator must be to a complete
object type.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 lib/ext2fs/csum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
index 8513d1ab..c2550365 100644
--- a/lib/ext2fs/csum.c
+++ b/lib/ext2fs/csum.c
@@ -274,7 +274,7 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
 		rec_len = translate(d->rec_len);
 	}
 
-	if ((void *)d > ((void *)dirent + fs->blocksize))
+	if ((char *)d > ((char *)dirent + fs->blocksize))
 			return EXT2_ET_DIR_CORRUPTED;
 	if (d != top)
 		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
-- 
2.26.0

