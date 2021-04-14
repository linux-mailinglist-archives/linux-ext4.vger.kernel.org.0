Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7035EE95
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbhDNHma (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Apr 2021 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349580AbhDNHm3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Apr 2021 03:42:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49430C061574
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 00:42:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z16so13801388pga.1
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xU8WG5+NcR3eTLPyi1wo1D3S3/zOx39I7p4dBbe6EwU=;
        b=nYrpIc9PHHZ/LhMMSwMIkPMzKQWwl6aXom7z6/i7LVQIikFs7DCPtOUIMpf9snGwJ9
         t+bdbCyoxkC8qxYih4ts96TyghNw7gBtaY2y0lAFKOoHJ8JKIjfKqCPc4TBAvPWLwoFR
         RWUw8QJOgfF1qBVjU5UKKKVA0Pl0Y8I01ar3Mj7zuruPF+5M1TCiL27aiCom+zeySUyi
         Pb7zj8Tw/GSzaGcxLDJ5t8+8cr2g0NVUKoTneYvyJH11TwMLvJjRVhP6yTsn9Sje+lfm
         9Ucwnr2DeQOJLl3r3LlXEwTMbdfA5F72YqHmpucAAeBWg4hZjmbEtdLoykSapVmwMKR8
         BNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xU8WG5+NcR3eTLPyi1wo1D3S3/zOx39I7p4dBbe6EwU=;
        b=YrPsQDgO0+NCV9EJPjC0RCi7mE+3C+zRViZVOSagPihQqFcqyun9BHyQUQH64i6rzx
         xFn95zQqMZJYxpZKSert/Tq4K5ZuClOAPl3RWIeY/k+5s4ws7phbt/A/QCpkL2OiXXem
         39EwPvA/2MBmpKet0a7zNuKz1ao+VFXfoB9yhle8yOXAh0ECXnm5G+0MWaivj1ADX8QE
         6/huk/s3Lqwb+cAphmxxI8TatfTBu8S/55e79aGUDbn2faJn4R/sXjtCIKPUSdKxR2ck
         QqyfaFbFGp4zw6GoNeNgF5YGemyEKg3Ez2vZLaX+8zgEblkBChg2En9SE/K+cfwEmWO+
         yCwQ==
X-Gm-Message-State: AOAM530INRs8kwzMdPJRBz9RKlTnp1VAC3czVKBERj+XZ4NCEwCRQ/M9
        E8VYw5RlPC6aTzWbD17Xf1QABg/T2mhbAwdEDQA=
X-Google-Smtp-Source: ABdhPJy5NVpoAglPtD1nhPlNQdOcs+5WuyBeSmjGS/sv19lDBqjF7W6Pi3rt8289zPRVjzIwJh6Adw==
X-Received: by 2002:aa7:850c:0:b029:24c:b470:cc79 with SMTP id v12-20020aa7850c0000b029024cb470cc79mr13740297pfn.69.1618386127599;
        Wed, 14 Apr 2021 00:42:07 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id x62sm1175268pfb.71.2021.04.14.00.42.06
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Apr 2021 00:42:07 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] libext2fs: use statement-expression for container_of only on GNU-compatible compilers
Date:   Wed, 14 Apr 2021 00:41:27 -0700
Message-Id: <20210414074128.31268-1-mforney@mforney.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Functionally, the statement-expression is not necessary here; it
just gives a bit of type-safety to make sure the pointer really
does have a compatible type with the specified member of the struct.

When statement expressions are not available, we can just use a
portable fallback macro that skips this member type check.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 lib/ext2fs/compiler.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ext2fs/compiler.h b/lib/ext2fs/compiler.h
index 9aa9b4ec..03c35ab8 100644
--- a/lib/ext2fs/compiler.h
+++ b/lib/ext2fs/compiler.h
@@ -14,9 +14,14 @@
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
 
+#ifdef __GNUC__
 #define container_of(ptr, type, member) ({			\
 	const __typeof__( ((type *)0)->member ) *__mptr = (ptr);	\
 	(type *)( (char *)__mptr - offsetof(type,member) );})
+#else
+#define container_of(ptr, type, member)				\
+	((type *)((char *)(ptr) - offsetof(type, member)))
+#endif
 
 
 #endif /* _EXT2FS_COMPILER_H */
-- 
2.30.1

