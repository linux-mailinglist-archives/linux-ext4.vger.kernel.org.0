Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAA6C4D27
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCVOLz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjCVOLw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 10:11:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E061538;
        Wed, 22 Mar 2023 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679494310; x=1711030310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NtifLXAlEOC7145wqW0H2RVF/LMJYofx4l0+YchUjsw=;
  b=ZDQGjBZdmgowWchuIny2nhWLOqMzfjcShR2zPaQIagn3RBo3E5BoGnGP
   BN51OFTYZoDlUI9FEisRQtYCe/xWOVk156zpWE+4GHcjl+ANf2kjonBo4
   cMI1OrPoDICdBuy/7sPBYM7I+qcgwuEA75OXcpxpMqI/LNqlPajutWkNj
   XI6F4F81LyyHyqr6PJXBPg09axxp1zBS9VYo2jr2v2/xjgUhJM2rMYCDJ
   pUyjI6RkFldACgNPeuO8xjy4qU/X6XJ+Ag++HZ9LbbW9XC6R/kj03lQC9
   aOyifkHLd+6Qi8d8ayQUhKwVbVQRx3NxRX9qZch2rue8LhjCxRFbragP6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319613517"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319613517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="805829250"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="805829250"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2023 07:11:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 236531CC; Wed, 22 Mar 2023 16:12:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/3] lib/string_helpers: Change returned value of the strreplace()
Date:   Wed, 22 Mar 2023 16:12:05 +0200
Message-Id: <20230322141206.56347-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It's more useful to return the original string with strreplace(),
so it may be used like

	attr->name = strreplace(name, '/', '_');

While at it, amend the kernel documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h |  2 +-
 lib/string_helpers.c   | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

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
index 230020a2e076..ab7b1577cbcf 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -979,14 +979,18 @@ EXPORT_SYMBOL(__sysfs_match_string);
 
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
+ * Return: pointer to the original string @str.
  */
-char *strreplace(char *s, char old, char new)
+char *strreplace(char *str, char old, char new)
 {
+	char *s = str;
+
 	for (; *s; ++s)
 		if (*s == old)
 			*s = new;
-- 
2.40.0.1.gaa8946217a0b

