Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A407D0138
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 20:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjJSSQ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjJSSQ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 14:16:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5C11F;
        Thu, 19 Oct 2023 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697739386; x=1729275386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3YH1xLn8uCgLxMdmvkYS5BOmN4lSQz1MtdOJPGdEOM=;
  b=Uzjwlqkq2ti9M4xct0plOIP611P6EDAi8rVGVxhnFGWxlmbiIMUmZwEy
   L7VvS6X/9vxmH+4BsTWAPCRZpoAAMrTJfq1W8B2lw9PUphwKBhrowEBNF
   +IPdqloI8wsBGIKuuCABXZ41Q4Q3MjAkinMsFMFsaMUKb1U/3MDfo6ea3
   Wyq4czypv6Wa/m3LXJ1DOiezhRU8jS1Gil7hBzdAOOW1oSwysQpfMBKik
   EG/Q07+YZmNiw5bEPw5FbSHb2TUL4w21LpLS36t04rLwARSIPd5+ixJJU
   9twNi7BHF415q4/STg/fLM6m4T/LWu68xM8DxSE7yMafOC1rOwKVm3fyz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383546381"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383546381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786500596"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="786500596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 11:16:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtXZE-00000006xAZ-1j2y;
        Thu, 19 Oct 2023 21:16:20 +0300
Date:   Thu, 19 Oct 2023 21:16:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
References: <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 19, 2023 at 09:10:25PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 10:51:18AM -0700, Linus Torvalds wrote:
> > On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > That said, the quota dependency is quite odd, since normally I
> > > wouldn't expect the quota code to really even trigger much during
> > > boot. When it triggers that consistently, and that early during boot,
> > > I would expect others to have reported more of this.
> > >
> > > Strange.
> > 
> > Hmm. I do think the quota list handling has some odd things going on.
> > And it did change with the whole ->dq_free thing.
> > 
> > Some of it is just bad:
> > 
> >   #ifdef CONFIG_QUOTA_DEBUG
> >           /* sanity check */
> >           BUG_ON(!list_empty(&dquot->dq_free));
> >   #endif
> > 
> > is done under a spinlock, and if it ever triggers, the machine is
> > dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
> > disgrace. That should be a WARN_ON_ONCE().
> 
> In my configuration
> 
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> 
> > And it does have quite a bit of list-related changes, with the whole
> > series from Baokun Li changing how the ->dq_free list works.
> > 
> > The fact that it consistently bisects to the merge is still odd.
> 
> Exactly! Imre suggested to test the merge point itself, so
> far I tested the result of the merge in the upstream, but not
> the branch/tag that has been merged.
> 
> Let's see if I have time this week for that. This hunting is a bit exhaustive.

Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
makes that merge affect another (not related to the main contents of the merge)
files? Like upstream has one base, the merge has another which is older/newer
in the history?

-- 
With Best Regards,
Andy Shevchenko


