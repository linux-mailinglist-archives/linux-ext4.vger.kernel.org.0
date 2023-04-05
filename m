Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887B6D7DCA
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbjDENej (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjDENei (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 09:34:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390524ECD;
        Wed,  5 Apr 2023 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680701677; x=1712237677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WTaTpeinTLP9YiOHzm0EGWTxzWO7nFA7QVsXFAsmTRw=;
  b=ViE9e8lb/f4YFn8BLBIAPWwrvr3c1t158UnxgKgGXqumi/DmvhXiGA8B
   RYN/Ow593rrjMCr0Ttno7t4A1kwy5SRC7mqa3IiLU0Bf+ON174hS0EB71
   Eo0PqpJEdLj+wF4MO3CGckSghZYf9Vvhs+DsEP7u8rH2SBCUjaYdStL2M
   CI9KQFMZGPIJqFpeRbkNgiAUD7fK+H2hDRieWbXG4EoG5UWeXNfH4f6LX
   LcMFIB7Si7khvdX8UFOpFKJ6BLucqkL15rVVtYVvImAokLLZvhxXJC021
   I0mgf8CEqAdj0E9GoMcrEx8gFxp9bjAxhdf+YMk860ueNlQ/SYArxJOJU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="345032966"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="345032966"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 06:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="776056257"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="776056257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 06:34:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk3HU-00Cqst-0F;
        Wed, 05 Apr 2023 16:34:32 +0300
Date:   Wed, 5 Apr 2023 16:34:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of
 strreplace()
Message-ID: <ZC1454AwRUNFTbIW@smile.fi.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
> It's more convenient to have strreplace() to return the pointer to
>  the string itself. This will help users to make their code better.
> 
> The patch 1 kills the only user of the returned value of strreplace(),
> Patch 2 converts the return value of strreplace(). And patch 3 shows
> how it may be useful. That said, the series can be routed via fs tree,
> with or without the last patch.

Since there are no comments, who can apply this (patches 1 and 2)?
Greg, are you fine with the kobject change?

> In v2:
> - removed not anymore used variable (LKP)
> - added tag (Jan)
> - fixed wording (Kees)
> - actually return the pointer to the string itself
> 
> Andy Shevchenko (3):
>   jbd2: Avoid printing outside the boundary of the buffer
>   lib/string_helpers: Change returned value of the strreplace()
>   kobject: Use return value of strreplace()
> 
>  fs/jbd2/journal.c      |  6 ++----
>  include/linux/string.h |  2 +-
>  lib/kobject.c          |  3 +--
>  lib/string_helpers.c   | 12 ++++++++----
>  4 files changed, 12 insertions(+), 11 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


