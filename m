Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB871C533B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgEEK1b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728762AbgEEK1a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 06:27:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B78C061A0F
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 03:27:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so928480lfp.1
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n6Cfn9T8YCEV6dpjNIVgTHrosueglFJqXjbboo9a8g=;
        b=Ogl9bS0ze7bvZClDL882hNRrW4mzKPxFGP2s0fltIPLqv9XaBJNvVnuXpwJfGQH/6a
         kkjxls2iJijFrKE2K6SSEveB/q4gKUDs4/TMxreRYN6KTkgwCIbINZBvboXv2fFOOzRU
         f4K9Qu8ek8smsPpbIRHKa3bFN7zgNUBouxESS7JkrluwMwJFsaEr4BfYrF16/VT0iVgr
         xpBKAHORARUj+lFmoOOgh7b7bdvzcG6qWvkLzrHH9661/fbSKnCTddzEKmWoUpihIxI0
         Y1mJycyBwQLzDLmH1OP/NPEoHDNe0GMmWeif9/x4M559YJPQ/5C7E2wMZMJfT6iBRbY1
         fLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n6Cfn9T8YCEV6dpjNIVgTHrosueglFJqXjbboo9a8g=;
        b=if6tIL+SUOVqI/bVw+0oeQbPOaAPjqMyWGM15Kb/DEvh787xaUUgql4A6eASxdK1S9
         YvczZzaJsxIqf4CnuybVWJR5CcugTpY1YCIB/jSVXGaQqA92/3xPM53d3jjsq543uldC
         e9ADc9s1QOPyXR5WtbUS98ickCV7JjDsyrYW4KVXnUWHPRbvLmboLlIDVybnPtzRPtdB
         +w3tlTmakOEAkJ7Nd3/nV8IrRR8IVQh3Us5DSuJs57Fl+q85BRggMLcZsRLG2ndX8JNx
         EfNY9Kg/dTb9P1eibuMesn8b/uo9bdk45TzH/8adhj3lB7PGrl456Mn9LBZlX666OMux
         q+eA==
X-Gm-Message-State: AGi0PubiryIu9r69joXuucNdbVLhlI41j1aHGv4vABbNr6o3NRGPLlTT
        wIdW06GgTxkU50GmmsIXPJPIIw==
X-Google-Smtp-Source: APiQypJ05S+8D6hCUKWWxXYjCtPUKhk7oai+ye/tyDqNidiPXly4f7vFf1vHOjA/N1XK92kKFf4bfw==
X-Received: by 2002:ac2:43c7:: with SMTP id u7mr1256634lfl.50.1588674448320;
        Tue, 05 May 2020 03:27:28 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id 7sm1592575lfr.52.2020.05.05.03.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:27 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        brendanhiggins@google.com, =linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 5/6] fs: ext4: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:23 +0200
Message-Id: <20200505102723.8120-1-anders.roxell@linaro.org>
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
 fs/ext4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..76785143259d 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,9 +103,10 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	tristate "KUnit tests for ext4"
+	tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
 	select EXT4_FS
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the ext4 KUnit tests.
 
-- 
2.20.1

