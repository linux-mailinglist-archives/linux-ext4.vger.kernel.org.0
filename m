Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED36C687E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjCWMgk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCWMgi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:36:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DC26C15;
        Thu, 23 Mar 2023 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574984; x=1711110984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+ztcOnn0m/uP+HZ0+0cEy+nf6BiVCkiWkOotsDK89M=;
  b=c4rvo83jhJ2nLQrSFnjHUHfdytcNbPKzN+60XOeC4QdOZ//LKMBE109/
   K9YWWal5oWizE74v6jjf9us71lofeENL13gOMmUsRibdAbAHwfo6C8OpK
   2UY3VUi3qMkj5hk1b2dYPUfSuIxEC7y6JYK+MT/nbT1N7enGNlRe9rhVn
   8S2p2LT76zSzbS70IbJWVBJSl5cduKwuTIoxpzuomdqnOaoOUzN9ATPz0
   kANW5cnyt4A2SaP1im7c70+Cz3aHdnVbSh0EOzdaIv33wwbOOOz8inqnS
   R3savMneYomRoxUCWnTn+H2b0B3fO6ixz6c8GrhnN3zaJW6vL6clR3qd1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341011527"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341011527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856466573"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856466573"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 05:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35871250; Thu, 23 Mar 2023 14:37:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/3] lib/string_helpers: Change returned value of the strreplace()
Date:   Thu, 23 Mar 2023 14:37:03 +0200
Message-Id: <20230323123704.37983-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index a7bff7ed3cb0..cb0c24ce0826 100644
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

