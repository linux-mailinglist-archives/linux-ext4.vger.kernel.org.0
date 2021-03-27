Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EC34B633
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhC0KdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhC0KdD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:33:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF975C0613B1;
        Sat, 27 Mar 2021 03:33:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j17so4218745qvo.13;
        Sat, 27 Mar 2021 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZT613DrUbepdNuCAEnS5dxRoZIorC9eFyKZisFT1yHE=;
        b=poN3IV60jakRs1Kcg6pS+owZ0cGEk61PVbmdUjedZaxp7maAhYmoeaiw4on66QWKDd
         hoVoBy6RlyUweH+3iclhzEKbJhw+CKYGFPo8PYuHn6S1T30oZfdhVWLwxz7XWdydA/3O
         WOxDN1fen/rNLV+sdB5GTwWpRiUPcNRk/v9fQ1VTww1jqa6gt4gRjLc67TrljY0IXtJy
         lOC8rC9mqgof9OgqJaB0aRrv4nLaGdtDeO0mbOQXpi/y2cnkeF1/+4E4WrDhxJUGNOfl
         Ety0uSrZwgH8YCNDbEqt/FFVPW1ZdJlzT6Bq+b9JGeqxB7cy+qUgn13bELVcyp0kuiW6
         fT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZT613DrUbepdNuCAEnS5dxRoZIorC9eFyKZisFT1yHE=;
        b=KOIcHpXwG8dftmsur1i9+lRX0ZJFJ2uKzARpbCyLx/irfu1xEKp5U2HkFrxgfM7hPJ
         +xsj1E9L/vuraE/HeXed9dc/ghIgcOPNmJe7uR1DCUDlF79j8168AZ7DiBqpwzh+SjzA
         ygqHTJLNpz386SVVHjOd4Dtq9mgoLEHWzArxq5SK6WBUdomz9BPgfcq95gy+k5pyoxXm
         ZRYIcQgVZ1kAArurr6v0jvSdh/b6OTGB6UQHtQz+1WDghC1xJCgwq2CdRfFEpWS9+df7
         zBAwm5xXtEy5s2Ylj7N7AvRT5sgMDuz5CJ0KW3jppcQUg4QbZm1XV1Sc//fSG8jy05OB
         NEBQ==
X-Gm-Message-State: AOAM533hWMr3dceYjYe54fOFkD/jGreV8wbpfwz+ROGQdllzhopXMkMg
        IRH5Jyu+7cIOmfMbFpRdxHk=
X-Google-Smtp-Source: ABdhPJwQQdCq4IryBCPkKV36MnNB61knvwAM8qRItshc1GiO1O7uvpeLOWKAbK/obboJUg3LtbLR8A==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr17280822qvb.46.1616841182048;
        Sat, 27 Mar 2021 03:33:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:33:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] EXT4: indirect.c: A trivial typo fix
Date:   Sat, 27 Mar 2021 16:00:09 +0530
Message-Id: <da435d1220293293bf4d4849a74a667a3c5ab09e.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/conventient/convenient/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/indirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 1223a18c3ff9..a7bc6ad656a9 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -705,7 +705,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,

 /*
  * Truncate transactions can be complex and absolutely huge.  So we need to
- * be able to restart the transaction at a conventient checkpoint to make
+ * be able to restart the transaction at a convenient checkpoint to make
  * sure we don't overflow the journal.
  *
  * Try to extend this transaction for the purposes of truncation.  If
--
2.26.2

