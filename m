Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC12722D46
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjFERGF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjFERGB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 13:06:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FDED;
        Mon,  5 Jun 2023 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685984760; x=1717520760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KBLjfFtbsCdNjxRprw9OiUI+007+Q0Bv6edzE8t+Abo=;
  b=fLlLmNLk7EN2fFWVHDienboKYrMJTdfYjtWSnZW81E3ulMkfI/1ldwdU
   TTuZ5+cADGB7YgIPt6DoRtQV+vHDew6Y1xbYhM4YA709JHONoiNVKIYva
   hBMZDtgjKx2+ANcFZFjot6biQxwz5F41tAdiQKFNUWUichxnfkWCcLcJN
   0uxj/BKh/IkjcZ7kAQgkPwJI6rFPS3ZEeGHfglAhaw3m4psLIWyebc2gA
   YpC030bVDDBHsfaC3h/1LeL0VGCwVZ+W/N86p5kPWq8lNb+w+rlRAOf4c
   sSQKc3MxRT1/ntgpdjcVl5OviCBlzT+h3h5ihTa3eBWBOR7dTIqvnaSxu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356431401"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356431401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773807508"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="773807508"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 10:05:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93C65FD; Mon,  5 Jun 2023 20:05:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/3] jbd2: Avoid printing outside the boundary of the buffer
Date:   Mon,  5 Jun 2023 20:05:51 +0300
Message-Id: <20230605170553.7835-2-andriy.shevchenko@linux.intel.com>
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

Theoretically possible that "%pg" will take all room for the j_devname
and hence the "-%lu" will go outside the boundary due to unconditional
sprintf() in use. To make this code more robust, replace two sequential
s*printf():s by a single call and then replace forbidden character.
It's possible to do this way, because '/' won't ever be in the result
of "-%lu".

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/jbd2/journal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8ae419152ff6..6e17f8f94dfd 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1491,7 +1491,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 {
 	journal_t *journal;
 	sector_t blocknr;
-	char *p;
 	int err = 0;
 
 	blocknr = 0;
@@ -1515,9 +1514,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 
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

