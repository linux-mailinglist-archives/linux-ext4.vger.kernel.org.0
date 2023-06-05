Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D19722D4D
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjFERHS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjFERHO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 13:07:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1B11B;
        Mon,  5 Jun 2023 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685984827; x=1717520827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orhtIbFdFJ/vZtw5mqPX0sVVvIYZvmqrT7bkUFf8ebI=;
  b=Byp+CeMnFA9VY7bdcF3ROuq0ZLbt1vltCHqgBsTnzk/ESGhmZWwGwozX
   n2G9hVk/nLWhv3XP4Y/v2pNST6wSwoELjXfcjjjyF3CQFUiYCCRCVbtjC
   zj2oZKEUIcPlVFUF/mINJC2YNCSePUZiJeZFCL1WAa8tl4qsxbmMLBonN
   HHQILWFdZFoLfir+85URn+oe9sY48FR8QU9YufR2sU127kXjKkCDN39uE
   WejodDTQTZexCUQm5T1hSZoTi3WGly/utuSrlEf7/MlTuXj3NRugLnp7j
   1BvUEbB9nEgL2TBKrdLuAgNTU9U+CctdIV8acXTrp4vVpsOGkpPdv8vzc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355275870"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="355275870"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="741785902"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="741785902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 05 Jun 2023 10:06:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Df2-001QZ0-2M;
        Mon, 05 Jun 2023 20:06:28 +0300
Date:   Mon, 5 Jun 2023 20:06:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of
 strreplace()
Message-ID: <ZH4WFCgq7kUwHLgl@smile.fi.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
 <ZC1454AwRUNFTbIW@smile.fi.intel.com>
 <2023040523-unworthy-uncured-1eab@gregkh>
 <ZC2H8ODMwoO5hzZG@smile.fi.intel.com>
 <47D8878A-1108-4AC3-BF7F-507F90F6970A@kernel.org>
 <ZH3rezDApUro84HB@smile.fi.intel.com>
 <2023060537-espionage-comfort-3e56@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060537-espionage-comfort-3e56@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 05, 2023 at 06:57:48PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 05, 2023 at 05:04:43PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 05, 2023 at 07:58:40PM -0700, Kees Cook wrote:
> > > On April 5, 2023 7:38:40 AM PDT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >On Wed, Apr 05, 2023 at 04:24:42PM +0200, Greg Kroah-Hartman wrote:
> > > >> On Wed, Apr 05, 2023 at 04:34:31PM +0300, Andy Shevchenko wrote:
> > > >> > On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
> > > >> > > It's more convenient to have strreplace() to return the pointer to
> > > >> > >  the string itself. This will help users to make their code better.
> > > >> > > 
> > > >> > > The patch 1 kills the only user of the returned value of strreplace(),
> > > >> > > Patch 2 converts the return value of strreplace(). And patch 3 shows
> > > >> > > how it may be useful. That said, the series can be routed via fs tree,
> > > >> > > with or without the last patch.
> > > >> > 
> > > >> > Since there are no comments, who can apply this (patches 1 and 2)?
> > > >> > Greg, are you fine with the kobject change?
> > > >> 
> > > >> Sure, want me to take them all through my driver-core tree?
> > > >
> > > >Fine by me! Dunno about others. Kees?
> > > 
> > > Yeah, that's cool by me. :)
> > 
> > Greg, does this slip through the cracks?
> 
> It did.  Can someone resend this?

Done as v3.
20230605170553.7835-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko


