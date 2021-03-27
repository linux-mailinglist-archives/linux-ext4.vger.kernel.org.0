Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A134B63A
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhC0KdP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhC0KdO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:33:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F812C0613B1;
        Sat, 27 Mar 2021 03:33:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q3so7824091qkq.12;
        Sat, 27 Mar 2021 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8x3S30nwWm4eBT9fgz39qxkWNuyfoei+JU+2PzvBLRw=;
        b=GxH+mo8r00QPN0Bet/CqkBvJQrUjRF5+EZEpOHRW0WSKKIFQpgVN6E3VIPL3vVZRy/
         BjmJlkiOp/a0CBzHTErVbaF9sCkz/MgMdSBQsAUHiCm59QJiLr4iT4P5QneX3n0Zx0rW
         XBMft+mt2Huu7IGi7TOJvN83U8OchTpffur2k5D92JRbfgJu3VwR+AQQj1xU3R6cFKCJ
         2GtX822DJhalzd3kT5/phRk4psvsXBZBkBa1zJgOJVfj8goFTBJe13ma40ttGp0M7yYQ
         VMdMSYs2a5aOqJUrlcJTh6Zl8PtQsZpQYebP82qS5WoMh8ix+/IottfyfdrFR1CopCIU
         r67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8x3S30nwWm4eBT9fgz39qxkWNuyfoei+JU+2PzvBLRw=;
        b=KOvI6Afug1ZEq16Wox3jxNjUS/v84sDUBQ/TON+BHhbg08N0f/osWXdIqBzo57+D1d
         vBdgxC9Euu6rsTZ1zLSuAaxC9A/hKA03mxRBP2XuLJ4DZAxkAOZJsFb0dX8TOx15EO9N
         ZlgNOWNUiP+9SxU/22K6zYquX9nvomasbRyKhP9RPClD+e4lUIfUxK9B6EHeKRqsTJ+i
         sKpagrFk+Y1gqHq80tusFNWGxTDdoGpxL+mmbENFYAeVDiVp+zucHBicZ5uZQi1Z8ChE
         ArX+fwhRIEP/deEp6cTK1B7FbP5JnhxJ3IYteRe5lddMA51ysKsBKmjqnJ86LOaDO2EO
         602Q==
X-Gm-Message-State: AOAM530e/67d5rVg153hLNaq0qBf95yTBeu+LaTKl2gszqpOKd8vWpCN
        U/QeVu+/NSdtCfXqZE9QwS0=
X-Google-Smtp-Source: ABdhPJyV/9yH/QOXCpPfkshaEQOSd/zNmRk+9r6z3bknXO+KM5LhlCY0Y1s47zgxrafeeU/9XuC23Q==
X-Received: by 2002:a05:620a:525:: with SMTP id h5mr17300396qkh.100.1616841193912;
        Sat, 27 Mar 2021 03:33:13 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:33:13 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] EXT4: mballoc.h: Single typo fix
Date:   Sat, 27 Mar 2021 16:00:12 +0530
Message-Id: <7878db9d72c1b66f68f9d3b12a82afd7c8c47577.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/parition/partition/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/mballoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index e75b4749aa1c..7be6288e48ec 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -59,7 +59,7 @@
  * by the stream allocator, which purpose is to pack requests
  * as close each to other as possible to produce smooth I/O traffic
  * We use locality group prealloc space for stream request.
- * We can tune the same via /proc/fs/ext4/<parition>/stream_req
+ * We can tune the same via /proc/fs/ext4/<partition>/stream_req
  */
 #define MB_DEFAULT_STREAM_THRESHOLD	16	/* 64K */

--
2.26.2

