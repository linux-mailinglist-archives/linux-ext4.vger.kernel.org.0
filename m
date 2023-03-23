Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3C6C6842
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWM1J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCWM1E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:27:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256BE231CE;
        Thu, 23 Mar 2023 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574422; x=1711110422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0HrI5NEKrbmgscOSpZOd8GAmA8hg3OJUpDame2NVD0=;
  b=HV5vebDz/5We/YY0zuc7Mz0HRK8vHh6G62jFojGCEsAb5yQtFj/S7Ksb
   tbczVupT7+6ECn4CsFuA9ugu1aMfMW9IEyhTEpFvOk4KN9QB17Ev9QyhK
   tyoKbfHFL3jFuciJzAU22FchapV6GLi+YRkbl3v+8uM4MZb/sUGFerD4r
   2eFb1REWqOzIHpEjvg0Udq4n3NARsaW21wOO40IW3iovr11bewerF7oQA
   LbJ6GSqhhag+o10SsajD8EPsDZBJSpHFAeGW8Ytnl3+VW1fVgpMim4cDK
   2Qkbs9HdciJu8yqzuCVS/R/L6nKTWX/86gVyYwFowtIDd/OeAgHy+Jkju
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341009923"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341009923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682287118"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="682287118"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2023 05:26:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfK1w-007VRl-2B;
        Thu, 23 Mar 2023 14:26:56 +0200
Date:   Thu, 23 Mar 2023 14:26:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] lib/string_helpers: Change returned value of the
 strreplace()
Message-ID: <ZBxFkFlR3c7zX4fi@smile.fi.intel.com>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
 <20230322141206.56347-3-andriy.shevchenko@linux.intel.com>
 <641b320b.a70a0220.2bb1d.30fc@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641b320b.a70a0220.2bb1d.30fc@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 09:51:22AM -0700, Kees Cook wrote:
> On Wed, Mar 22, 2023 at 04:12:05PM +0200, Andy Shevchenko wrote:
> > It's more useful to return the original string with strreplace(),
> 
> I found the use of "original" confusing here and in the comments. This
> just returns arg 1, yes? i.e. it's not the original (unreplaced) string,
> but rather just the string itself.

Yes.

Okay, I will try my best as non-native speaker to fix that for v2. Meanwhile
I'm open ears for the better suggestions.

> I agree, though, that's much more useful than a pointer to the end of
> the string.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


