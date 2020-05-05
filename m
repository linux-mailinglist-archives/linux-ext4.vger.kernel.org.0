Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F801C5333
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEEK1N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbgEEK1L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 06:27:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B685C061A10
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 03:27:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so1027364ljj.11
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4r4BzjDGTO09+pq2qJQzLpsqdYp3d0bmg7xrYt7/0k=;
        b=lxq8UsRbbA6JQHwi8YB41ue072QJ2ffr78bQkb/4GLMC458KwPgtwlcNH+7K8pq11n
         zoraXwhw9eRsviQtxRA+U4dervHMol0BBPlIVzZx/9cforLpLbgmHwtFP+/uBqR3RGfO
         CtucDsTaeq6V+hc8mK3P5FjYNUKYjKxOh5Z7HLpjOgkHftZDtQjx7tCwlFG1zVG1ve/+
         0Jw7mXl/wHOdI9vIPA5gO25bE4K+IakBue0rQ1ZRHihufkCi2AzoV5zH8nZq3YFPz29Y
         H752OVjW1oGHf4ltCmCXrQOYrGKbBDvHs8C0YNfPoKNcnoy1KeslY75+PptWpVM5voKr
         xruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4r4BzjDGTO09+pq2qJQzLpsqdYp3d0bmg7xrYt7/0k=;
        b=KW9YXYaoYfnamw7f/KX+0KMO6Y+Vs7a5HurF8bBKbhJlgT4jdMlhy7SznOU8B7OHJ3
         hXdPHaVQYlI8OOIk0L6sinA0M5TPevUFBtdDifFRHdBHafeiq9mU8V9nK698fuiM5TL8
         0zQOEUSRQfmByuzcgIusp8K/InBAUzLPblxZW27AiVbs9/yCoTJuxOkI2lXksEiZgbS6
         o+4KG0ttzp8RUp/YIAjT5I7agnSseL6dGTR77cufRKbiLVEVTMDUNachy6A2zLTcKGcE
         hd9y/Xx5Xi3XDKRxbqOg0wplB1RGUWT5xPjG4ZxUI3raQ4tNI7TrlyDRohWznsU3PVLp
         48kQ==
X-Gm-Message-State: AGi0Pubc5WZKB1v44apwsY3fwh6QNrpUYng5HIx7MUtZGtY/W157XYs2
        1wNzM1p9VHph0YBkHIePT8rm2Q==
X-Google-Smtp-Source: APiQypJnEG5pEB+WJjoe6xM1H2pstsQj428JhTG2iNFeTSyXwOzyD5BmMDWHrEub1AqznTCaupW6Lw==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr1390091ljp.95.1588674428941;
        Tue, 05 May 2020 03:27:08 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id j15sm1799172lji.18.2020.05.05.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:08 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 1/6] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
Date:   Tue,  5 May 2020 12:27:00 +0200
Message-Id: <20200505102700.7912-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make it easier to enable all KUnit fragments.  This is needed for kernel
test-systems, so its easy to get all KUnit tests enabled and if new gets
added they will be enabled as well.  Fragments that has to be builtin
will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/kunit/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 95d12e3d6d95..537f37bc8400 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -41,4 +41,10 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_RUN_ALL
+	tristate "KUnit run all test"
+	help
+	  Enables all KUnit tests, if they can be enabled.
+	  That depends on if KUnit is enabled as a module or builtin.
+
 endif # KUNIT
-- 
2.20.1

