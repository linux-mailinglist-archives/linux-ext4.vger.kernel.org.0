Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A36C6881
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCWMgr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjCWMgm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:36:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33071CF41;
        Thu, 23 Mar 2023 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574998; x=1711110998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OAAjRWa/GMe3Eyh4EzhGnD6aqq4E5v6Kahs4zyE3gnQ=;
  b=JlFNifkK2vnleKWitd8wXZANVEYiicxQLwnQXd87xpz+53z7ivSXme5e
   LFqVkMfbRvJP46qEMHryBS4MDn3vyHQ+D1UxsHJbeOuoWsMY98G84facW
   ouoTF3riOFnLy1aoNup3eimJ1HjUhqhC4DWNtKLGXvj+TW12ykCmx2Osi
   AYcn1BTuhfIMtuVkSEPkuaB3T/QXZ6YEetm/zC/ERsg6Jk4wrj1hV2qsJ
   r64rGSUDMpLDsJe/jq5xyPWPfuodcVCnqk/z4PEIUMq14kfIz/uX89CpO
   8NmlNF78jg8jhnqn2Q6VuREvkwyJwWI7ERw0rqVDLQyjlPdhVa1S2k6kO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341011540"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341011540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856466578"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856466578"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 05:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 237F794; Thu, 23 Mar 2023 14:37:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/3] jbd2: Avoid printing outside the boundary of the buffer
Date:   Thu, 23 Mar 2023 14:37:02 +0200
Message-Id: <20230323123704.37983-2-andriy.shevchenko@linux.intel.com>
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

Theoretically possible that "%pg" will take all room for the j_devname
and hence the "-%lu" will go outside the boundary due to unconditional
sprintf() in use. To make this code more robust, replace two sequential
s*printf():s by a single call and then replace forbidden character.
It's possible to do this way, because '/' won't ever be in the result
of "-%lu".

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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

