Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6E1CDAED
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 15:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgEKNO3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 May 2020 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730147AbgEKNO1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 09:14:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4EC05BD09
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so9431709ljj.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+jFcqLuH7ub0fRzkztO3YdE2YZwIRumdprp3l4s3TA=;
        b=S+IZahvZJp4K0ZjCDFnUtbgri3iCzQ9xVa+NFBDWxFnhZcoipbUX1TBsfs9tQYB/A9
         ROQFWMnaiF7sTgNUVZnttw9paL9nttAQFDBxZRszwoVUSTYZFn6AB5B09aq8XgDwv01A
         cCwAHc+nntQU1kxDqivnyvh5zuuDBPw13dfdDS2jNclJwx1C0wRVNqiOa0LsHSllOm7j
         HeUebaKfHvjPC3u2k8K6Ewe6Yok+sjFrbV+u3M+gPJGSnjYRBl1QNK3Bp23iRzn+B5x7
         Ypj5/rVymNmIOwxkgCkQvknu10jj/QMORu01sPMsZ1AoLOhTBGTf8NBivwqo8JcyzcFE
         riFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+jFcqLuH7ub0fRzkztO3YdE2YZwIRumdprp3l4s3TA=;
        b=NFOcelBc8ZXbdanU4I2vkBqu3FNcRVk16kBTPpyWEVhUsUInYnvFUh2/yYoFwO6rbM
         bbNnSlQBTVsVjJ2hYMk53kIzbVReZtZCwnIs/XkOOfLKvT0GrCQwLjnLRqR1GXSJu9qt
         LBaa/SbnlT+qcdwvukwwstpqerxc6J+OZyEbliJi8+hYCZO0+D7yhCXVKVcobsbqe45H
         c9aU/B2jbNSjDq64h970Embh28lnaqojeMlhNAii5ltkq3P7jOf8tMWPB8bgT0HtFlur
         sTGmMNx+ic7vKmjx6RxliLjzkZtiWw78jABu/xItgo6HqE7Gw1YnA18LreBhS4NTAEhr
         uchA==
X-Gm-Message-State: AOAM53174su0Nfp+1iktKf2JndZLT92dq4Y7m7RIzP4oPshA3oQrlQxM
        yoJU517hs5JUx4iorJcxkMMr/w==
X-Google-Smtp-Source: ABdhPJxn7boJJ0vbZwT5jKpePnX26KnZkvCwlvbR3Tgj0jF/CyUo77s+zpDKAbUF/jYHQDVW9ICJ8A==
X-Received: by 2002:a2e:a176:: with SMTP id u22mr10438276ljl.177.1589202864204;
        Mon, 11 May 2020 06:14:24 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id s8sm10952175lfd.61.2020.05.11.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:23 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 1/6] kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
Date:   Mon, 11 May 2020 15:14:20 +0200
Message-Id: <20200511131420.29758-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make it easier to enable all KUnit fragments.  This is useful for kernel
devs or testers, so its easy to get all KUnit tests enabled and if new
gets added they will be enabled as well.  Fragments that has to be
builtin will be missed if CONFIG_KUNIT_ALL_TESTS is set as a module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/kunit/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 95d12e3d6d95..bdeee7639005 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -41,4 +41,18 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_ALL_TESTS
+	tristate "All KUnit tests with satisfied dependencies"
+	help
+	  Enables all KUnit tests, if they can be enabled.
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endif # KUNIT
-- 
2.20.1

