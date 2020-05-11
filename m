Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870D1CDAF4
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgEKNOh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 May 2020 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730167AbgEKNOg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 09:14:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A86C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so2855375lfb.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7bMy350M8ax4YqO1k0ragPxZVB4Sq8gKTVAQseth78=;
        b=tyeSTc03oTY6K3LroNm5HKqoawup1Mj0X6sMI2LGMzkNnWIn2McTNMZ0+NG4IDrCTF
         mYmq171N/IAt1AL4hcG2usJLLR+FKwBKAdDk+D2CGXghJG5li2ANUCY+waO44fWVsuhu
         GAGLLMK0E8G1g8jd42IDjIQanmldx0bv5iU9sCfC8p4701nKozgpMyCEHS9Yg0H7sADO
         lTXVv2UrUhGLg/O3+/eInaBkR73wfVPL7uDqSrRJdA3p7So65TgSSNC8zzLhfv/gNvuA
         UfYYrl5w8+EtkrBDJVKle8IvHG5dYC3DnFqsyti3J8mLK33RY56Eg8+XDiQmW58DkjUI
         LCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7bMy350M8ax4YqO1k0ragPxZVB4Sq8gKTVAQseth78=;
        b=orpdLONqpHyR4UcOIVYi63nOJC8ZQaPglq6Z7eKgxs2qq4f302y30oVzMyNC6YGbb7
         EcgaJvPQHH1o4dvrTzEzX9k+AHRoFlh4e5SpoRkgBxJU+Gbj/pvDxNR9d2mVkCKyj6EU
         rsmjuGhfNmwOKFE9QeN/nBbFuuTwlWjJXEcf5KAAU5qSVOjahCR42BPET9jmQLCbCj2w
         ZMPttB1CJ2DJ1qccP2aIDa4+RN2ifZNbnF+0hxCUy3WDC7GR8jrUmcAbsKlSUZ8JvsDr
         9upI2RI8cuCV32O+zi2L0L3tIOKdqz6xqsgkcL0S2FFc8T/lvE4K2byGvlthJ4OO1702
         Z3Kw==
X-Gm-Message-State: AOAM532AOcbP6EPbXFKRpKGlt5GqPKPHR7DFMIkdw+uvxavf+qiA8YRN
        kEN4jwi3d6kbMYS4CKVnc7CV6w==
X-Google-Smtp-Source: ABdhPJyYMsO9TgP6DGnwyc67H9w/1hGv3XoXQ3P1ggxxHr47+Uuk3J2Lv1s11k+ixLL2310k5dEpCQ==
X-Received: by 2002:a19:4816:: with SMTP id v22mr910163lfa.30.1589202873699;
        Mon, 11 May 2020 06:14:33 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id o22sm9844221ljj.100.2020.05.11.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:33 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:29 +0200
Message-Id: <20200511131429.29856-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS' so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..1f4ab7a2bdee 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2064,8 +2064,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	tristate "KUnit test for sysctl"
+	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
 	  Tests the API contract and implementation correctness of sysctl.
@@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	tristate "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the linked list KUnit test suite.
 	  It tests that the API and basic functionality of the list_head type
-- 
2.20.1

