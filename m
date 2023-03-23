Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C56C6880
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCWMgp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjCWMgl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:36:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF91B56F;
        Thu, 23 Mar 2023 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574998; x=1711110998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oFMi59KYeaqcmAy2tfu/4MDHteFRDFzaVTDWfROxUbE=;
  b=HhT9sPs7UFz67CCZeTnUn+pA/D/PDpg7ZcfJANyeNa/svjJEDVAwAdri
   CY6bMBpoaEZXgbOOwyasoTz1YRfLb6MAmsLRQRg0kq4jwdyJek0UHYfTT
   +0PvH6pHCHRIzTa+DXnHmioqex0WCgXGO+CfDzcMrFMK57txDLDKoA+M4
   c6evi8Npy73saogVnfn3sLUDxTdS1oy4JOVC7oKtZ71oGHADOJ/PrKWKv
   J05HcvefXYbUbAJdNZ3CpI/48AdYDQb4/fhtoFn0xD1iKc84eGq7Epuoq
   0F+oi19P66ilHyTN64nQncW2HUS1z7CHgPRGKcobW1kLuK8fKb4mz284v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341011534"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341011534"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856466575"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856466575"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 05:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14784D0; Thu, 23 Mar 2023 14:37:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of strreplace()
Date:   Thu, 23 Mar 2023 14:37:01 +0200
Message-Id: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

It's more convenient to have strreplace() to return the pointer to
 the string itself. This will help users to make their code better.

The patch 1 kills the only user of the returned value of strreplace(),
Patch 2 converts the return value of strreplace(). And patch 3 shows
how it may be useful. That said, the series can be routed via fs tree,
with or without the last patch.

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

