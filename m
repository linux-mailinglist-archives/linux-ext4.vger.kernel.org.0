Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1520E1C5340
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEEK11 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbgEEK1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 06:27:21 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968BDC061A0F
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 03:27:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so910280lfa.10
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgXGdUpeDA6S2n2bWfsapxIox2ARona/I5hdI1ZbAMo=;
        b=jCg5rc4fzbUcTEW82gMx4stI32yZ+9/AL2EMw+SxTScb0kgtBp4gy01prld/ovKhlg
         phUMh+Ol9Lsoue6wcRVA1f9S4Mp0nNf9LIyJD0VUiNMN9jjgp68FD4GZcb4/pEHlzZ0g
         BYQvsJx7Kn6Ufa6bJPwUgnVYZ8liUKU3W4dejF5TTBCCSKY7jx22+P2uLRGMRiNz3W9s
         MpX46xaYG/zR/6xFfjjF3xWx7XMXSPz56wxgMrF289Hpp3/TKC3vkhKq2rdMcjRvszH0
         /W1p009a5oG+az6+pK9gkFpq65lLB3lBHgN/H3c9DCYMGdm2Apx5WNVmjhi7OMXfyj04
         gPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgXGdUpeDA6S2n2bWfsapxIox2ARona/I5hdI1ZbAMo=;
        b=Umqyk1ZIQZpUD+PkqYs0xpXf5txzzJ0/eRrvUd82UPm6CnxBHVkyqH4MXehcIMXw6O
         TKMx5TNDVfWCZw/fMjc01BQNG6N94nOjiHIR/48oRuGNKMAeG1Kjr0cZ1Tz/N85og39z
         J0lI3eOsXhArd4Z1ACxKfgkD8Vm+073LPdYBSYhhzKxTUHWhRJQ2NW0zEdvhIYi2a7AD
         vSt1iLfW2fx+6/q5E+o9wj4nF3P5VcZ24XduRHyVdkMVmdJWHjOvZF311NUTk40Xk8RY
         pTXM/RNORgX60BJ8/IowKYl+NQp1HnGI3mfckK6n11Wic3o2xPKM31dtFi41FLLbqQ+4
         fmOg==
X-Gm-Message-State: AGi0Pubc4s18on8ub2HkPjfD5mFyiHgwU/ob8mt4ZiKvOhzX70LLPEub
        QnhDRb3mK7rYarjTKAULUOwpQQ==
X-Google-Smtp-Source: APiQypJSHpXephHI+itU620IH4y5WRHndCkK56pPYq/1X0jg21roe+fznpAa9iZ47D7i1WwwUxIP8g==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr1255915lfb.208.1588674439039;
        Tue, 05 May 2020 03:27:19 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id g20sm1649058lfj.1.2020.05.05.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:18 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, brendanhiggins@google.com,
        =linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:14 +0200
Message-Id: <20200505102714.8023-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..d1a94ff56a87 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2064,8 +2064,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	tristate "KUnit test for sysctl"
+	tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
 	  Tests the API contract and implementation correctness of sysctl.
@@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	tristate "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the linked list KUnit test suite.
 	  It tests that the API and basic functionality of the list_head type
-- 
2.20.1

