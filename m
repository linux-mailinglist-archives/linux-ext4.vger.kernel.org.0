Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58F7D0028
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbjJSRFf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbjJSRFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 13:05:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32EC130;
        Thu, 19 Oct 2023 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697735130; x=1729271130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SvRT6LTSrzS+ByQI2jQdeZOuYjcngLGwBF4+TKTOda0=;
  b=G7NnErs6GaEDfqZfERWKHcS3qcKgvT/+Q4D+A/SpSM4AKbc01PTCkTJz
   kMa95aZmx2gOmQwgb+WUYN8hIXeQZ3PG8VfSHkPDI39INIaVtoTmzg5NB
   VRV/5qV6YZcJyUh7kwcADUIUrtnr9mljugxslJqmNj2dRvNeYw7qB0xw4
   imAV+IKHwcyCuV4h8fVwC7tg87SZI/GHc/43XVWCi696SO7b4dAn7JW+q
   rEl3BMeZt/nw0pnFGJfIPQMxPrsH3WSOjysCGUiWJaJqavxsiWJxRenDL
   4qMohFI00DSVI6FNjZriy2L1OEsv0CichDXd85pi4L4m78KFYHB8CuGCK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="376691831"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="376691831"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="880746237"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="880746237"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:05:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtWSW-00000006w92-1Z6p;
        Thu, 19 Oct 2023 20:05:20 +0300
Date:   Thu, 19 Oct 2023 20:05:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
References: <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019164240.lhg5jotsh6vfuy67@treble>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 19, 2023 at 09:42:40AM -0700, Josh Poimboeuf wrote:
> On Thu, Oct 19, 2023 at 05:44:30PM +0300, Andy Shevchenko wrote:
> > So, what I have done so far.
> > 1) I have cleaned ccaches and stuff as I used it to avoid collisions;
> > 2) I have confirmed that CONFIG_DEBUG_LIST affects boot, the repo
> >    I'm using is published here [0][1];
> >    3) reverted quota patches until before this merge ([2] - last patch),
> >       still boots;
> > 4) reverted disabling of CONFIG_DEBUG_LIST [2], doesn't boot;
> > 5) okay, rebased on top of merge, i.e. 1500e7e0726e,  with DEBUG_LIST [3],
> > 	   doesn't boot;
> > 6) rebased [3] on one merge before, i.e. 63580f669d7f [4], voil� -- it boots!;
> > 
> > And (tadaam!) I have had an idea for a while to replace GCC with LLVM
> > (at least for this test), so [0] boots as well!
> > 
> > So, this merge triggered a bug in GCC, seems like... And it's _the_ merge
> > commit, which is so-o weird!
> 
> I'm not really a compiler person, but IMO it's highly unlikely to be a
> GCC bug unless you can point to the bad code generation.

Hmm... Then what's the difference between clang and GCC on the very same source
code? One of them has a bug in my opinion.

> If CONFIG_DEBUG_LIST is triggering it, it's most likely some kind of
> memory corruption, in which case seemingly random events can trigger the
> detection of it (or lack thereof).

Note disabling QUOTA has the same effect, so if it's a corruption it happens
somewhere there.

> Any chance it boots with the following?

Nope, no luck.

-- 
With Best Regards,
Andy Shevchenko


