Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EC722D44
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbjFERGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjFERGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 13:06:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C2CD;
        Mon,  5 Jun 2023 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685984758; x=1717520758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yNqEF3trYoU7hnGxpDpvi8nhlncENBsYKi1m/ukv08Q=;
  b=hq4be/5W6Z8JGFSbLxh4Q45s/wDXvLzCR3v1jDywRINqCA6+eqtI4UW4
   9xNuLmfraX1dldD2iXKD9XtV5V9zGiszQD/IdD6UEEVF/QWmRyAWFZTAz
   fDsS0YrgbKTgU6cmhXm2l7vQ8J8M4xCRhMFn6/kbzB5vC12vhTQq+juiW
   n3TGfkWUfCyMSYXDJjnrjgKo30mtV8tlYIwLpJHIyiuvCYQXelJUsFu6y
   wOC8w62JQY+r1NeQ4pePG5p61iw0NvtIDuIFoG9tJK2zsLWSfQt0s6yDk
   w+Gze3ia34R56QhkbSu/Zy0WzHoCSWKOh3QQFylsTTImC9LJ/QTBwF/Oi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356431394"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356431394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773807506"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="773807506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 10:05:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86EF6204; Mon,  5 Jun 2023 20:05:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 0/3] lib/string_helpers et al.: Change return value of strreplace()
Date:   Mon,  5 Jun 2023 20:05:50 +0300
Message-Id: <20230605170553.7835-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

It's more convenient to have strreplace() to return the pointer to
 the string itself. This will help users to make their code better.

The patch 1 kills the only user of the returned value of strreplace(),
Patch 2 converts the return value of strreplace(). And patch 3 shows
how it may be useful. That said, the series can be routed via fs tree,
with or without the last patch.

In v3:
- rebased on top of latest Linux Next

In v2:
- removed not anymore used variable (LKP)
- added tag (Jan)
- fixed wording (Kees)
- actually return the pointer to the string itself

Andy Shevchenko (3):
  jbd2: Avoid printing outside the boundary of the buffer
  lib/string_helpers: Change returned value of the strreplace()
  kobject: Use return value of strreplace()

 fs/jbd2/journal.c      |  6 ++----
 include/linux/string.h |  2 +-
 lib/kobject.c          |  3 +--
 lib/string_helpers.c   | 12 ++++++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

