Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285441C5341
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgEEK1j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728835AbgEEK1j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 06:27:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98256C061A41
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 03:27:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so908492lfg.9
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=230loUifIymLa/TVi9RdiH3XdsCp0ddGQu/ABs4Cb/4=;
        b=x92NhqmCrm4AnAjLTvH9UeLaB71xW26RAg+TIq9FmwhUI5v+CVWxv6VxxO+P3RoT4Z
         s4QjqMqalrxfMf6UgUgIRjpHcFtySd4i6a8Nt3ZY3SMhDa5t+ykTQt4xA2I+KVD2A9is
         G63HxsG7KE63wMd6ZRUU34E43yRCqU0ia91PBrZHf9zM+hQgVQLHq4zlDqwYqVGZnaRu
         57tXMyOtQ/wOOD7DugMWjt9vbUfRL1mLbdL/LryZqmwSml1lWJ0pFEhD/Y5bitoLxufZ
         eCIoo1/B74mEAJakYcJW7PFgxdacVK+uRtcNflMt78pYhgNyp5DPcu8iZbtuu3haD/fS
         8+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=230loUifIymLa/TVi9RdiH3XdsCp0ddGQu/ABs4Cb/4=;
        b=tKXh2V14LvQaYWtzohD54z63uwImKctYNFqa83zFAy08mxflLp9iQhcaLfvWjKq+AS
         PGySv1ArbLEyILqvT8dTohePfYKoHVCsPm1h3t3XfgGgJqcw2paUXt2zVCoI0Mk6g9HB
         QSQXKS9K/dMdQrcIC2VXKiDC8WKqFXPHTU5Vn7fZ9247DBcoW/ntNpoqGS7n1N8EF06r
         kmJ/DS5mYiPfHJKJohK9KJOpVpR6ZutsYW0XF9mDHxC78GZDqVeO+EUawyZvcZeoohU5
         KE33I87CPZpGXghrqpsBcNxsSEoSXMUE2oU5zy7hxIuZElJtpB8RlGAHrdLLoq7BBMek
         AvHQ==
X-Gm-Message-State: AGi0Puaf0SwG9j/ZasRwNWQNGw8qfx0TwZtdYzGGagV4TWRXxci64ICX
        1OzUvXmS5K7dpegMGxLg8Tom3g==
X-Google-Smtp-Source: APiQypIZ4cT/7LUuGVlV7W088j0iK9PnOaD9C4La60LR67rrDJBNi8X3LJVh/k9ffnvmmU6KZArQEQ==
X-Received: by 2002:a19:ad45:: with SMTP id s5mr1277949lfd.106.1588674456921;
        Tue, 05 May 2020 03:27:36 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id n7sm1777255ljj.72.2020.05.05.03.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:36 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        brendanhiggins@google.com, =linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 6/6] security: apparmor: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:28 +0200
Message-Id: <20200505102728.8168-1-anders.roxell@linaro.org>
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
 security/apparmor/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 0fe336860773..c4648426ea5d 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  the kernel message buffer.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c"
+	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_RUN_ALL
 	depends on KUNIT=y && SECURITY_APPARMOR
+	default KUNIT_RUN_ALL
 	help
 	  This builds the AppArmor KUnit tests.
 
-- 
2.20.1

