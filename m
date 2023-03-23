Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC66C687B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCWMgi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjCWMgi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:36:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B071B56F;
        Thu, 23 Mar 2023 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574984; x=1711110984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uqba7KW+LSTrR6KDuN+F/tgiTmPx6AhRcJexGJYfzL0=;
  b=DVpEUyVcB9cuHQaevin9Hs+FrKfkjYEBilsuB7NZEcmJ68Q6q5r1gG31
   aoUldmS7ijsb/RnEvdcQ/AGw8VWqYvT6mbmJ6cLoVQsk4OO66IizRsR+9
   fn8AHZvaZmXMiEgWNtxCHFpi7wc7WMocpWf/Xj/0JxGQnz565QA0Mnj+P
   zrHZePsVE6HiBlKFLldJVcYA02CXlD85JCEo5fBX1YHKugzTDpCtEztlt
   4Dlx6rJ5qYBKowjEn0nlMqB6bOFEQbUtxhFd/TaiD7InqMnD1Z5Gy7Vof
   +QYZaieWqldzU0n3Z5ZzMpOa9gz1waTZ3elG1kpxSQOv/AjfNMM09BSk6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="404359764"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="404359764"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675681050"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675681050"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 05:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3AE4C176; Thu, 23 Mar 2023 14:37:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/3] kobject: Use return value of strreplace()
Date:   Thu, 23 Mar 2023 14:37:04 +0200
Message-Id: <20230323123704.37983-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since strreplace() returns the pointer to the string itself,
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

