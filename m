Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AF6C4D2C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCVOMd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCVOMc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 10:12:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA66484B;
        Wed, 22 Mar 2023 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679494339; x=1711030339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=skh8+hJ3oe4RQZywlVKVS1TXtOKwAEOQhUA8WWOtK0g=;
  b=MXMWHxqPi4sBbyGZrjhnK7OYVgF7SZo/pdmBi5iIflo/a5rijL7cAZt7
   q9JmqVVE1q4/QMwKHJAx+f8zJMw0brf/hCJgXX1TmIp5qb8KIHflwgoPp
   RNvOtD7G/gs8mAb9YoJEBveBbZxVVVHJYaJcOoynrk66oaX78ROUjwyzq
   JiYOtz8CWQJ5uqrA6dFZ+/y891viSDS3x4/o+8wW8LGQ8ddBWBp7QxiDd
   K2+Vl6Q4F6QduhcSBo4Cv+MkqFqtjZXecKeHj9CmQjZx759bJQmlKhxuR
   VxtpAJpi5/e3nXoUuPu9Yq4OZtGohuQaNMXeSKFNzmWxZGKi8FYsOlpYi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319613611"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319613611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="805829396"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="805829396"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2023 07:11:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 150091CC; Wed, 22 Mar 2023 16:12:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/3] kobject: Use return value of strreplace()
Date:   Wed, 22 Mar 2023 16:12:06 +0200
Message-Id: <20230322141206.56347-4-andriy.shevchenko@linux.intel.com>
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

Since strreplace() returns the pointer to the original string,
we may use it directly in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/kobject.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index f79a434e1231..16d530f9c174 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -281,8 +281,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
 		kfree_const(s);
 		if (!t)
 			return -ENOMEM;
-		strreplace(t, '/', '!');
-		s = t;
+		s = strreplace(t, '/', '!');
 	}
 	kfree_const(kobj->name);
 	kobj->name = s;
-- 
2.40.0.1.gaa8946217a0b

