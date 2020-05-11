Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA741CDAFE
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgEKNOt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 May 2020 09:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730195AbgEKNOs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 09:14:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8FC061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so9409743ljg.12
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hd5CEiw3xAmj+Qu84GZ/dMO9hkSOA6ixaeeAM/KiNHU=;
        b=t/q/Xu2Wsk1cQP379bqb7AKPnMVYlzvnTZ2iToF9D09oipRJWynKJ+gRR+xoVRGhom
         6pD/9G8cClGfg/m8k9yWgDTlOIQbm9Ixb6cWlOWc6rC7qy407QUS0Rka78Hf+0F+RzNM
         Ujd1KPanQ5orj9cBzjrZfDRy5lLAxw1jJCOqjN4grijylK/LSWTGqs2BjeJWF8qPKUAy
         SqwMRZfnwvux94TcbbUvcFI2qJKwwB2+W0O7QQA+5+IjPMogtRBJae4RHVct7pW7Obgz
         z3gIn0kYZs/dFBbBaETQJRSXt/eQ7otP//1WDRZgjNOexrXZffr+COFscNImDd2SZgMA
         uJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hd5CEiw3xAmj+Qu84GZ/dMO9hkSOA6ixaeeAM/KiNHU=;
        b=qFDosDE0i5QJxLaGGdxd+a1/XtM++rs5fyrg3lM6ziY6M3fyWGr499R1Ka27AX5x0j
         zP7e44WD0PrM4ykAWsp6dcTd/qWHid0rvy9mNLzLRgh/t1cVCFmebY/tiXyUlvjcQL8Z
         ZjrZXW9tW9cXo76XlWu6KnF9bxTU/TShbNHPe2mdg0N0MQYo32vN4iC4sz8O0cyj7K7P
         am3XNRuPacpRdjndOqPmwqW9ouQBPYI/HE/7T/q5fxEgmEnby1n/w4WajEiiEmCqdK9S
         VQDqfaMHq4ROks+1H6qZpfNRqXmorhSMCfUn+HwE5MB1jFYm94vqQPdB7iwb+4X0mTDH
         g/sg==
X-Gm-Message-State: AOAM531/IWsP8oCxB2SibM8mZP5D+37jTN3XE7ImPgtUcjKETE5BKah2
        C9a5QOIg5MtSfixtSS805EcZag==
X-Google-Smtp-Source: ABdhPJyoLfetCr2ckH+XHqfj73a09MRKqeRqRgsIHcO5n6iFQ2egpeSzjj4Oiamdu1pt1MeA5mVJZg==
X-Received: by 2002:a2e:920e:: with SMTP id k14mr10674436ljg.288.1589202886078;
        Mon, 11 May 2020 06:14:46 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id h11sm10223074lfp.22.2020.05.11.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:45 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 6/6] security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:42 +0200
Message-Id: <20200511131442.30002-1-anders.roxell@linaro.org>
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
 security/apparmor/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 0fe336860773..03fae1bd48a6 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  the kernel message buffer.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c"
+	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y && SECURITY_APPARMOR
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the AppArmor KUnit tests.
 
-- 
2.20.1

