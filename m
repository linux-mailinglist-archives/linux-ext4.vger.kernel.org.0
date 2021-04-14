Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39335EE96
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349580AbhDNHmb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Apr 2021 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349708AbhDNHma (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Apr 2021 03:42:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94F1C061574
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 00:42:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r13so6036242pjf.2
        for <linux-ext4@vger.kernel.org>; Wed, 14 Apr 2021 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8a4+QM2cN3ClF4jMy+wdo1aOSs6UrwNPl9bPzaFpOFM=;
        b=QIasb52qm+otSclRc6u2qNS6uBwuoH/GRmLJ36xkfQEy39WgaIi+AH2sEKPAy3+V+1
         85kpck89j5lZseUDvQeNN+qo9M2rmGGgmzNiqTvkxaaUISDn0gg7jdAteElgEF8RNoqc
         pmsQeg66Kxti/jroQwQoYr4DlRXxCTMqI5aTM1d/PVYT2WceTbODgsZOpSmiwJ1d8ysr
         P8ptuYg3i6dx6tuVt8HBd45ebmZn8O1qH6SR4VV3wAiP8cssyBUV6WxXn3kBuXfU1NaJ
         mY/h+lOVW770XfAhXbKp3KoHQtVEiPKgriMnwAXWu/OnClCPT5YQ2vdp2denI4wRP4M2
         xgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8a4+QM2cN3ClF4jMy+wdo1aOSs6UrwNPl9bPzaFpOFM=;
        b=cH2RPh2dDVep/fVN9l2H00Kk9G60lLvvI3cux68HsgABlxAHF/E14C0cfw38LqyoV6
         dPvnjPLGpCsVTPmZrS8Nq3V3/K56GCRMAeZF+eKCpJH7qmte2YH9UBg7ltIblQXJxz0M
         XdFqXjGl+Ob4UrpyKpkCBBHV0fXxkvBaE0WrcN6mPHabbZ3DgYuhOQpYA1P80yupDOr/
         uoL+b9R0CLzxNTUXbUj+nBAz9ubv11NhF2wtk9VCQAuVwdQu75sGg700S89mvDxCOmjB
         cXt5seLzuSDoWMXcOaVDRz3J8xqaZ66thn05ItAAV5i1nTIQ+i0UTR6CB0fAAm3KS555
         KX7g==
X-Gm-Message-State: AOAM531H0GqMrgEqyITUEZjdbmSbi8ifEVGidKszOP27azqZGw8hzCGK
        VDqUGOcQn8kPuCCGk6oYV59ugPdL/nlg3HA9tuQ=
X-Google-Smtp-Source: ABdhPJzgiRgPn834sJYRlvzlmP9vJoYCiyLW+CM1PipzEi3oqVgvLnstcHsHavXOTcNZdIOlqd5mbw==
X-Received: by 2002:a17:902:d507:b029:ea:ac65:b98e with SMTP id b7-20020a170902d507b02900eaac65b98emr25569504plg.56.1618386129297;
        Wed, 14 Apr 2021 00:42:09 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id g8sm14166056pfr.106.2021.04.14.00.42.08
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Apr 2021 00:42:09 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] libext2fs: use offsetof() from stddef.h
Date:   Wed, 14 Apr 2021 00:41:28 -0700
Message-Id: <20210414074128.31268-2-mforney@mforney.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210414074128.31268-1-mforney@mforney.org>
References: <20210414074128.31268-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

offsetof is a standard C feature available from stddef.h, going
back all the way to ANSI C.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
Perhaps there is some reason to prefer compiler builtins over libc
that I'm not seeing?

 lib/ext2fs/compiler.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/ext2fs/compiler.h b/lib/ext2fs/compiler.h
index 03c35ab8..42faa61c 100644
--- a/lib/ext2fs/compiler.h
+++ b/lib/ext2fs/compiler.h
@@ -1,18 +1,7 @@
 #ifndef _EXT2FS_COMPILER_H
 #define _EXT2FS_COMPILER_H
 
-#ifndef __has_builtin
-#define __has_builtin(x) 0
-#endif
-
-#undef offsetof
-#if __has_builtin(__builtin_offsetof)
-#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
-#elif defined(__compiler_offsetof)
-#define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
-#else
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
+#include <stddef.h>
 
 #ifdef __GNUC__
 #define container_of(ptr, type, member) ({			\
-- 
2.30.1

