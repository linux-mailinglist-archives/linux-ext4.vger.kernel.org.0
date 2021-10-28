Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7E43D96A
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJ1Cmn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhJ1Cmi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 22:42:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE3C061570;
        Wed, 27 Oct 2021 19:40:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 127so4597297pfu.1;
        Wed, 27 Oct 2021 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxiIhsm7YU7OSO+F4l4BXdzqkhsJbBlK/iS/zR+pSQ=;
        b=f0Jk3OruJDRHOvw3WJlglMaZHj+YE1qFIxMKnslz32Ga1Ojpts28oR8XhUhFOTjTTy
         N9oZgmWg5Lel/ncDy5cjrBVjZz54BVR1wCrzSqr8C6fF+W5SVRYDtxxLKZaJcnN38j2R
         HOivZ2Pbl7cJB1QTmcViWuoBwAS32jg+lWTxMvC0msYjUXHxcuT1CB1ntzOCTkDZUzgs
         b+gjVgHRSYT08dYqH9kTR5D9BqdMFcBmxf51yvKgalsrlRUlroZ7+T/SxmkSCpJElWRm
         MJo8/tn/uxanQXDh/kqlKk9ekXW45c+Ng0pV7odkLvzgbyjQlOTVU6KrQwn6Om2ZqNi/
         9seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxiIhsm7YU7OSO+F4l4BXdzqkhsJbBlK/iS/zR+pSQ=;
        b=zRbdU5ihN/+SaiGshSNh9xiru1afVzhbdSLXYcp4n4jhzsGS7gm5/ocLKOYOyixR+3
         R7SE5XwYUiB+MSxgBkXZ1NNw0K8dvflwynWwkPWV+Y9XsU3Mrv036qjJvsYT63Mkeg9F
         sA6DARA5e8PfWTcR3kgn3XqNCYmk+YAAd/aMWAJtsRhTkT8hS9CieKHzIB91o7/yCkws
         IIhp/j9RlfTJejZug0anqK1JlO/bQqR+G6zGcy9wwih2O369yEiWfseWY1aap/QyuMY6
         +5PJnWW09sTtrlhhoKt9qQ7BuLbMSvlUqeF+aTp6OzoGZw+o6BDRo09rrBgjXQxjxx0W
         4k7w==
X-Gm-Message-State: AOAM531hotaVThexzVDv3mp5V98vcBjLFOeTu+Qy1X94mOKWa4qku/N9
        +wjgJkcfvJwG0SmKoHjXOD6sLJY/1W0=
X-Google-Smtp-Source: ABdhPJyvPZPulVtAwl6z8fIR9Q9sH7j0OYCWaC997zh7hh5p3L4eiDFLnpNEasa+wo7jBDxgwbxW8A==
X-Received: by 2002:a63:f05:: with SMTP id e5mr1176708pgl.226.1635388811932;
        Wed, 27 Oct 2021 19:40:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n11sm966077pgm.74.2021.10.27.19.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:40:11 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Remove redundant statement
Date:   Thu, 28 Oct 2021 02:40:02 +0000
Message-Id: <20211028024002.10254-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The local variable assignment at the end of the function is meaningless.

The clang_analyzer complains as follows:

fs/ext4/fast_commit.c:779:2 warning:

Value stored to 'dst' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/fast_commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 782d05a..9e5bfa0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -797,7 +797,6 @@ static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
 	ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
 	dst += sizeof(fcd);
 	ext4_fc_memcpy(sb, dst, dname, dlen, crc);
-	dst += dlen;
 
 	return true;
 }
-- 
2.15.2


