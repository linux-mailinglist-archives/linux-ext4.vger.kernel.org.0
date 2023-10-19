Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568DA7CF322
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJSIrJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjJSIrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 04:47:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9881129;
        Thu, 19 Oct 2023 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697705226; x=1729241226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhvXCMyEWYMwIFdsWR0gUBefdbmD8tWEPpF0paNPlzk=;
  b=abC0HpjqnOxxCFQIVHliZaMZxK63EHbC7x08TYI57wD+6b02RIHV6jWK
   cWkceWylJtBjhHQ5cfQzGb2hvU2dC8j5S7wCdbByweOgqGgXN8Ai6MMQq
   TbGcHfg6LY6pFQMSdyM5Bpm9ktAj5Y5bVjI1DacqIa2rqF7SQESQ5wkSn
   qh7UF5ZC7K7gkGfb9UzghGGPmWQfEyOygiMXLnvAIw5vR0PWEaXMYNc3A
   WQF1V2Nd47kCF0J0+2p7p7OiFzTKKmS2WHFTu8Rn2H3/okRyYhq84p92O
   wtqsZsUbR04AYXE5Vr0cbnqxw37kIGAWJMLcavWyRv6N+2I5iCa9Nqz85
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365555116"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="365555116"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760557572"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760557572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:47:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtOgE-00000006oO5-3zaq;
        Thu, 19 Oct 2023 11:46:58 +0300
Date:   Thu, 19 Oct 2023 11:46:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ferry Toth <ftoth@exalondelft.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
References: <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <ZS50DI8nw9oSc4Or@smile.fi.intel.com>
 <20231017133245.lvadrhbgklppnffv@quack3>
 <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018184613.tphd3grenbxwgy2v@quack3>
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

On Wed, Oct 18, 2023 at 08:46:13PM +0200, Jan Kara wrote:
> On Tue 17-10-23 19:02:52, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 06:34:50PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 06:14:54PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 17, 2023 at 05:50:10PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > > > > > > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > > > > > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > > > > > > >   Hello Linus,

...

> > > > > > > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > > > > > > trigger without a bit of information printed out.
> > > > > > > > 
> > > > > > > > Okay, seems false positive as with different configuration it
> > > > > > > > boots. It might be related to the size of the kernel itself.
> > > > > > > 
> > > > > > > Ah, ok, that makes some sense.
> > > > > > 
> > > > > > I should have mentioned that it boots with the configuration say "A",
> > > > > > while not with "B", where "B" = "A" + "C" and definitely the kernel
> > > > > > and initrd sizes in the "B" case are bigger.
> > > > > 
> > > > > If it's a size (which is only grew from 13M->14M), it's weird.
> > > > > 
> > > > > Nevertheless, I reverted these in my local tree
> > > > > 
> > > > > 85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
> > > > > 786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
> > > > > 76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
> > > > > f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"
> > > > > 
> > > > > and it boots again! So, after this merge something affects one of this?
> > > > > 
> > > > > I'll continuing debugging which one is a culprit, just want to share
> > > > > the intermediate findings.
> > > > 
> > > > CONFIG_DEBUG_LIST with this merge commit somehow triggers this issue.
> > > > Any ideas?
> > 
> > > Dropping CONFIG_QUOTA* helps as well.
> > 
> > More precisely it's enough to drop either from CONFIG_DEBUG_LIST and CONFIG_QUOTA
> > to make it boot again.
> > 
> > And I'm done for today.
> 
> OK, thanks for debugging! So can you perhaps enable CONFIG_DEBUG_LIST
> permanently in your kernel config and then bisect through the quota changes
> in the merge? My guess is commit dabc8b20756 ("quota: fix dqput() to follow
> the guarantees dquot_srcu should provide") might be the culprit given your
> testing but I fail to see how given I don't expect any quotas to be used
> during boot of your platform... BTW, there's also fixup: 869b6ea160
> ("quota: Fix slow quotaoff") merged last week so you could try testing a
> kernel after this fix to see whether it changes anything.

It's exactly what my initial report is about, CONFIG_DEBUG_LIST was there
always with CONFIG_QUOTA as well.

Two bisections (v6.5 .. v6.6-rc1 & something...v6.6-rc6) pointed out to
merge commit! I _had_ tried to simply revert the quota changes (I haven't
said about that before) and it didn't help. I'm so puzzled with all this.

-- 
With Best Regards,
Andy Shevchenko


