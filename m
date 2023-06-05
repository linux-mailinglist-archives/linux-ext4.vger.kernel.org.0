Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B516722D43
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjFERGB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFERGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 13:06:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D09C;
        Mon,  5 Jun 2023 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685984758; x=1717520758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gFiVCBXWyj8bmgbMxtEqGr730r7w2iTq5mksoPWBe7A=;
  b=WWqlzGxd7lWQv+bSr1iQeZlDLji0adz9uhaWwby8h4ZqhsyW1TQQ1SLr
   v+loH2puNZ2ZiG4ZLui0gxAV2WCYy/WsMlqzHCNk+w11pyT81LQsTNst/
   xm+R5YKJb3ymTsQiK0wNNkIM0AeeEkcG+J58QXGwKPCuFhJpEawsoZ0M8
   2oMxVuxLNUn0LC+xKBTzG0b2/Q0HUgaBlZAKjUhhYFCY5sT7GWSBXKXXS
   m8m+pvdjbgvpTpdtOLal8+esIG0+cyYlW3nvWijSYl6L7oZJU0ADm8UaC
   BV3RU3l+uBOzvKC/gHDNvTAMdmCQ5aNXe5q3UZQXkwgGMC009ATtqlN1A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356431386"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356431386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773807503"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="773807503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 10:05:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E28B34F; Mon,  5 Jun 2023 20:05:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 2/3] lib/string_helpers: Change returned value of the strreplace()
Date:   Mon,  5 Jun 2023 20:05:52 +0300
Message-Id: <20230605170553.7835-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230605170553.7835-1-andriy.shevchenko@linux.intel.com>
References: <20230605170553.7835-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It's more useful to return the pointer to the string itself
with strreplace(), so it may be used like

	attr->name = strreplace(name, '/', '_');

While at it, amend the kernel documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h |  2 +-
 lib/string_helpers.c   | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index c062c581a98b..dbfc66400050 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -169,7 +169,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 #endif
 
 void *memchr_inv(const void *s, int c, size_t n);
-char *strreplace(char *s, char old, char new);
+char *strreplace(char *str, char old, char new);
 
 extern void kfree_const(const void *x);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..d3b1dd718daf 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -979,18 +979,22 @@ EXPORT_SYMBOL(__sysfs_match_string);
 
 /**
  * strreplace - Replace all occurrences of character in string.
- * @s: The string to operate on.
+ * @str: The string to operate on.
  * @old: The character being replaced.
  * @new: The character @old is replaced with.
  *
- * Returns pointer to the nul byte at the end of @s.
+ * Replaces the each @old character with a @new one in the given string @str.
+ *
+ * Return: pointer to the string @str itself.
  */
-char *strreplace(char *s, char old, char new)
+char *strreplace(char *str, char old, char new)
 {
+	char *s = str;
+
 	for (; *s; ++s)
 		if (*s == old)
 			*s = new;
-	return s;
+	return str;
 }
 EXPORT_SYMBOL(strreplace);
 
-- 
2.40.0.1.gaa8946217a0b

