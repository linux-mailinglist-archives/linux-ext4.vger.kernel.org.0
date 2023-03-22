Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4C6C4D21
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCVOLh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCVOLg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 10:11:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30B60408;
        Wed, 22 Mar 2023 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679494296; x=1711030296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R/NM27p9IJi6tkU9vm19fosAfBY50JC5QYvv4nC1jcA=;
  b=POU+yTTlBSqr7o9NjYicgBJYMt3C/okMo5kemBzAdf8lfYRbm/tQstxU
   lSot/OI/5KRrXhayFZlROBR7aL7Idjwr1cGPQ6E1/Cmg4n+XUHqDfPMEM
   6Ehl42TRviadSW/vha2vVjlVGxIeejvtfe2YkMiA8ACz0bArNwqp9l2BJ
   KM4ETa715kIEnEmMzZt+67HLT9rdpwhMTiofsb2Udj1ZrJCK5LcoB8jmm
   G6G+a8AvrKZJZoPwmiI7xTu+JE5d2aU5GSimQBHj3Q18bDgl3/2zdea37
   RrjMGtgnUWwVol6Uo3tNPHGXmTCvV3N/M4zaZ9MVOImtw2wWlH7X8t4eI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="336725182"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="336725182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792574215"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792574215"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:11:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D4D51CC; Wed, 22 Mar 2023 16:12:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 0/3] lib/string_helpers et al.: Change return value of strreplace()
Date:   Wed, 22 Mar 2023 16:12:03 +0200
Message-Id: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

It's more convenient to have strreplace() to return the original
pointer. This will help users to make their code better.

The patch 1 kills the only user of the returned value of strreplace(),
Patch 2 converts the return value of strreplace(). And patch 3 shows
how it may be useful.That said, the series can be routed via fs tree,
with or without the last patch.

Andy Shevchenko (3):
  jbd2: Avoid printing out the boundary
  lib/string_helpers: Change returned value of the strreplace()
  kobject: Use return value of strreplace()

 fs/jbd2/journal.c      |  5 ++---
 include/linux/string.h |  2 +-
 lib/kobject.c          |  3 +--
 lib/string_helpers.c   | 10 +++++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

