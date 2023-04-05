Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F70B6D7FBA
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 16:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjDEOjE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjDEOjD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 10:39:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F845FE9;
        Wed,  5 Apr 2023 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680705525; x=1712241525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4l4SXawpYs9BoQ1e8o+bJafQBoj8zd6EQRUcysjpCg=;
  b=c11CGsILH0pI4IzX00yH6MTOpo53vPaPT9N/0qZ5Jij9Cl9fprtPwuvi
   0JhbZHIfQ30F7N4abDLzffgE9912mRV8lEeY8vGSrsUAfK0rkZfjJr5bU
   b0t/XIeAdnFB4IKA2WbN+SnH2U+mL9PPa7+WdW2UB/OCHUPcV9r2f5rm5
   HHfwDlOq5XwHIfwpiMKL9cBnyLJVilrgFwe6jfg8HaNCWNN+7M2rYmeVN
   so0sv/F3ed+SYoFO7ENytIY5ABPlnBBCOBXSRBENkQh/J/xc7K4FNkubI
   4bqQIoSgz4kAqDGq9p/CJtaqOLeGjDpKtqdLXJyh+YB5whgh881PFvLZd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428754798"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="428754798"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 07:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="680308910"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="680308910"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2023 07:38:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk4HY-00Cs5q-1Y;
        Wed, 05 Apr 2023 17:38:40 +0300
Date:   Wed, 5 Apr 2023 17:38:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] lib/string_helpers et al.: Change return value of
 strreplace()
Message-ID: <ZC2H8ODMwoO5hzZG@smile.fi.intel.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
 <ZC1454AwRUNFTbIW@smile.fi.intel.com>
 <2023040523-unworthy-uncured-1eab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023040523-unworthy-uncured-1eab@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 04:24:42PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 05, 2023 at 04:34:31PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 23, 2023 at 02:37:01PM +0200, Andy Shevchenko wrote:
> > > It's more convenient to have strreplace() to return the pointer to
> > >  the string itself. This will help users to make their code better.
> > > 
> > > The patch 1 kills the only user of the returned value of strreplace(),
> > > Patch 2 converts the return value of strreplace(). And patch 3 shows
> > > how it may be useful. That said, the series can be routed via fs tree,
> > > with or without the last patch.
> > 
> > Since there are no comments, who can apply this (patches 1 and 2)?
> > Greg, are you fine with the kobject change?
> 
> Sure, want me to take them all through my driver-core tree?

Fine by me! Dunno about others. Kees?

-- 
With Best Regards,
Andy Shevchenko


