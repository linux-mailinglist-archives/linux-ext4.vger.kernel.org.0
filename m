Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80B722D3F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjFERF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjFERF6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 13:05:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9EF1;
        Mon,  5 Jun 2023 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685984753; x=1717520753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uqba7KW+LSTrR6KDuN+F/tgiTmPx6AhRcJexGJYfzL0=;
  b=gZnt7i7S5RAKnCKhWoOseINM9UweFOim683+c0tM4l+IvhnrTiEsvNsw
   JAbAU1C6zGh/Jgx/2ys2TRPKu32shLHlX47KJdo9lEMBGzeqdPFOutF6E
   sXVfRKyebWO6uAl1SSnvYo2BJLsEGI2CyZNgM23CdLIWozuWyhe7pHjfY
   l9Nxg6UnQShrJF8Q7HpHEZB+EtoN5++Oz4mwgOXik1k7dVyxUHOZIqEDC
   eU/oQPvR4mY32FA+j5qW6AJJtHJwXa5CPKCnY9K/cT2jPhSqrirF88/rR
   s3YfBWRqAuPdYQ4yjKUwKZbtbhqMVxwOqK5YTIKOdCtUO9LfCAyauBLRi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356431378"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356431378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773807505"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="773807505"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 10:05:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE297379; Mon,  5 Jun 2023 20:05:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 3/3] kobject: Use return value of strreplace()
Date:   Mon,  5 Jun 2023 20:05:53 +0300
Message-Id: <20230605170553.7835-4-andriy.shevchenko@linux.intel.com>
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

