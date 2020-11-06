Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF532A8DD9
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKFD7d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:32 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFAC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so2943281pgm.2
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxBA7QqEbwKIQCT5XwpBIZ8Ga7/Na7Ld9Hk+O1xgFsM=;
        b=jdX7b6XIp3b8jw5TP8wAhNjmTZ493aQftPdTQToDO74pDxfNYmpzVtTf3XKDQlUNvM
         mQwsVBtD/r+N39OPPRiSLrzUfXVK1SVAXuRhtvPbnXI9UiTqTTy9yIpgjpodtTEdz6P9
         gbN0F+JUC1ucgksH5S8QoP5PolgVH8mhcF5g9HY0hC81kx+pjGdszP6ubCkth4evhEmE
         uVIe7b7gA4HZuAQYJDIXbHuUgGmvPjcmdNmgsvqAo8Q/10SMsCXgWeVrMCePjKFlIM/p
         6sO0VaxP1yhYdnifN1uuNtnB2jScsDt2TuZpkxYhxHIkFNpOLUggQIeq0PWkHAKDbgaP
         8SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxBA7QqEbwKIQCT5XwpBIZ8Ga7/Na7Ld9Hk+O1xgFsM=;
        b=obnYT6zgZMyEwOOUekyIF7Ul7nFFoO7t+ZO5xrFyieo6CbptTPqhVlLZtOvpkRqmZK
         cEL4A2qrch9Dhz7MmnCXnuFbDfdQ2BghSycMFaCIWO/F1kx2HW+TXo/L2mciklKffzBh
         FgHYpfLzKrJDODSUYAa00vSskIy+o4B8Sqh/YsXfDzYD/pA6aEkSE+1Fc6WRPEhtSdgu
         sAQduFCVaJvAudtaSh8PGxnqdKpbzuWMXjObmQSm6aAIHQ3jq1hAjrrBlnNalHM/aaHN
         H/u7t/rd22O8WkaycIMowwQkdevT3vu4os7toG2aZO/VNTPMeWlJ8u8CO55N2OJKJaJD
         5aZA==
X-Gm-Message-State: AOAM5308wj/J91XYysdGpwxfSvNjgR5TAw/ypM+gFY2LUeuN5/ANH+Ce
        l18rHkEHyz9kNUeyQDBlmOojDLf3HdY=
X-Google-Smtp-Source: ABdhPJwGV4GSoB/cll0kWd0mO0dIEpcBu/Sjz9S42emK7VI8gHViOhYvOZRiVxXiV9UJt89mmX3e3w==
X-Received: by 2002:a17:90a:c596:: with SMTP id l22mr277725pjt.184.1604635171690;
        Thu, 05 Nov 2020 19:59:31 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:30 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 07/22] jbd2: drop jbd2_fc_init documentation
Date:   Thu,  5 Nov 2020 19:58:56 -0800
Message-Id: <20201106035911.1942128-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that jbd2_fc_init is dropped, drop its docs too.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/journalling.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 5a5f70b4063e..e18f90ffc6fd 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -136,10 +136,8 @@ Fast commits
 ~~~~~~~~~~~~
 
 JBD2 to also allows you to perform file-system specific delta commits known as
-fast commits. In order to use fast commits, you first need to call
-:c:func:`jbd2_fc_init` and tell how many blocks at the end of journal
-area should be reserved for fast commits. Along with that, you will also need
-to set following callbacks that perform correspodning work:
+fast commits. In order to use fast commits, you will need to set following
+callbacks that perform correspodning work:
 
 `journal->j_fc_cleanup_cb`: Cleanup function called after every full commit and
 fast commit.
-- 
2.29.1.341.ge80a0c044ae-goog

