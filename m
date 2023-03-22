Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E766C4D29
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 15:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCVOMC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCVOL5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 10:11:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B062329;
        Wed, 22 Mar 2023 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679494316; x=1711030316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7YSrH58f/8PCUQYRKrz3TF1JgsLkqas7q/pNYTkDdYg=;
  b=WheSQgqFqkhGk6imopb2h1P4H1rqvyS8a99bKra+DmoCEf7E2mz4Aq5R
   6VWwqvJJVj169H4a59yd13JK6r71cWrj/JTyqH73KTbyBTQTBJBQj7kY/
   wUei93bxePoW+m+5P2EA5gMbqXvio5cdwmm2CV3Z+SkoycnOaTQjF9Tf3
   3e/Vt5SGhHAGJHLvhSb3r2763llOh+Ctz5KZYT5CJzJacfiTS4mdWqUCo
   Edyda6w8X4JtZ+IXVVE7w1nkfJycvD4VEnBtyLuAUmHXymY/dL+BvI2jb
   wjBjz96+TKuY4bV0bhWmA7HJmFyuK6Q1OamcAY9GnHm+avHnoLuQUFYSX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318865981"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318865981"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="1011377031"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="1011377031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2023 07:11:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AC3C3DD; Wed, 22 Mar 2023 16:12:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/3] jbd2: Avoid printing out the boundary
Date:   Wed, 22 Mar 2023 16:12:04 +0200
Message-Id: <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theoretically possible that "%pg" will take all room for the j_devname
and hence the "-%lu" will go out the boundary due to unconditional
sprintf() in use. To make this code more robust, replace two sequential
s*printf():s by a single call and then replace forbidden character.
It's possible to do this way, because '/' won't ever be in the result
of "-%lu".

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/jbd2/journal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8ae419152ff6..00c0aa4a3a91 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1515,9 +1515,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 
 	journal->j_inode = inode;
 	snprintf(journal->j_devname, sizeof(journal->j_devname),
-		 "%pg", journal->j_dev);
-	p = strreplace(journal->j_devname, '/', '!');
-	sprintf(p, "-%lu", journal->j_inode->i_ino);
+		 "%pg-%lu", journal->j_dev, journal->j_inode->i_ino);
+	strreplace(journal->j_devname, '/', '!');
 	jbd2_stats_proc_init(journal);
 
 	return journal;
-- 
2.40.0.1.gaa8946217a0b

