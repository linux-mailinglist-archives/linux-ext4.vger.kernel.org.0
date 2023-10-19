Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CA7CFD29
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjJSOoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJSOoi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 10:44:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0C112;
        Thu, 19 Oct 2023 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697726676; x=1729262676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lUJYqBzKtKqz76h9nJy8kVPdglp0M2GetZVO8v9/pcU=;
  b=aOSK85X6jRvAs04CkNhNO/s78nSd3ScEVSm/30P8JVYXD7oA5VQ+Qj0b
   T4oPwgIQELj0ybefXEFS2/8K6lesmnBSPfaofEuYOajrgI3/Z5UqQMGdR
   qI8TR9G7MwW8F8M8KeIL/k6ZSCgKed7mmq4jkBLhME2SVdmvr1i7s4nXf
   r8opIhHzm8NoXbPYAWsKDnCGuhB66milK3RyWrxvxmG+5YlJWDWnp5usL
   1hVZwBVL7iXJZx2nBTqSTuSwOr7tUn+oJ9tZQ3tBwOR/ddufqUfDk3zhr
   NDKu7RpEjHfw64rkXbL7/dtpxlrLJh5LZyFGm41DoSnkNcX40GYdDp/t0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390155491"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="390155491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="900777932"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="900777932"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:42:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtUGE-00000006u17-2ZAm;
        Thu, 19 Oct 2023 17:44:30 +0300
Date:   Thu, 19 Oct 2023 17:44:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Ferry Toth <ftoth@exalondelft.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
References: <20231017133245.lvadrhbgklppnffv@quack3>
 <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,URIBL_SBL_A autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

+Cc: compiler related guys (as far as my heuristics work).
Any ideas? (see below)

On Thu, Oct 19, 2023 at 03:01:43PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 12:18:54PM +0200, Jan Kara wrote:
> > On Thu 19-10-23 11:46:58, Andy Shevchenko wrote:
> > > On Wed, Oct 18, 2023 at 08:46:13PM +0200, Jan Kara wrote:
> > > > On Tue 17-10-23 19:02:52, Andy Shevchenko wrote:
> > > > > On Tue, Oct 17, 2023 at 06:34:50PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 17, 2023 at 06:14:54PM +0300, Andy Shevchenko wrote:
> > > > > > > On Tue, Oct 17, 2023 at 05:50:10PM +0300, Andy Shevchenko wrote:
> > > > > > > > On Tue, Oct 17, 2023 at 04:42:29PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 03:32:45PM +0200, Jan Kara wrote:
> > > > > > > > > > On Tue 17-10-23 14:46:20, Andy Shevchenko wrote:
> > > > > > > > > > > On Tue, Oct 17, 2023 at 01:32:53PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > > On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > > > > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > > > > > > > > > > > > > >   Hello Linus,

...

> > > > > > > > > > > > > > This merge commit (?) broke boot on Intel Merrifield.
> > > > > > > > > > > > > > It has earlycon enabled and only what I got is watchdog
> > > > > > > > > > > > > > trigger without a bit of information printed out.
> > > > > > > > > > > 
> > > > > > > > > > > Okay, seems false positive as with different configuration it
> > > > > > > > > > > boots. It might be related to the size of the kernel itself.
> > > > > > > > > > 
> > > > > > > > > > Ah, ok, that makes some sense.
> > > > > > > > > 
> > > > > > > > > I should have mentioned that it boots with the configuration say "A",
> > > > > > > > > while not with "B", where "B" = "A" + "C" and definitely the kernel
> > > > > > > > > and initrd sizes in the "B" case are bigger.
> > > > > > > > 
> > > > > > > > If it's a size (which is only grew from 13M->14M), it's weird.
> > > > > > > > 
> > > > > > > > Nevertheless, I reverted these in my local tree
> > > > > > > > 
> > > > > > > > 85515a7f0ae7 (HEAD -> topic/mrfld) Revert "defconfig: enable DEBUG_SPINLOCK"
> > > > > > > > 786e04262621 Revert "defconfig: enable DEBUG_ATOMIC_SLEEP"
> > > > > > > > 76ad0a0c3f2d Revert "defconfig: enable DEBUG_INFO"
> > > > > > > > f8090166c1be Revert "defconfig: enable DEBUG_LIST && DEBUG_OBJECTS_RCU_HEAD"
> > > > > > > > 
> > > > > > > > and it boots again! So, after this merge something affects one of this?
> > > > > > > > 
> > > > > > > > I'll continuing debugging which one is a culprit, just want to share
> > > > > > > > the intermediate findings.
> > > > > > > 
> > > > > > > CONFIG_DEBUG_LIST with this merge commit somehow triggers this issue.
> > > > > > > Any ideas?
> > > > > 
> > > > > > Dropping CONFIG_QUOTA* helps as well.
> > > > > 
> > > > > More precisely it's enough to drop either from CONFIG_DEBUG_LIST and CONFIG_QUOTA
> > > > > to make it boot again.
> > > > > 
> > > > > And I'm done for today.
> > > > 
> > > > OK, thanks for debugging! So can you perhaps enable CONFIG_DEBUG_LIST
> > > > permanently in your kernel config and then bisect through the quota changes
> > > > in the merge? My guess is commit dabc8b20756 ("quota: fix dqput() to follow
> > > > the guarantees dquot_srcu should provide") might be the culprit given your
> > > > testing but I fail to see how given I don't expect any quotas to be used
> > > > during boot of your platform... BTW, there's also fixup: 869b6ea160
> > > > ("quota: Fix slow quotaoff") merged last week so you could try testing a
> > > > kernel after this fix to see whether it changes anything.
> > > 
> > > It's exactly what my initial report is about, CONFIG_DEBUG_LIST was there
> > > always with CONFIG_QUOTA as well.
> > 
> > Ah, ok.
> > 
> > > Two bisections (v6.5 .. v6.6-rc1 & something...v6.6-rc6) pointed out to
> > > merge commit!
> > 
> > I thought CONFIG_DEBUG_LIST arrived through one path, some problematic
> > quota change arrived through another path and because they cause problems
> > only together, then bisecting to the merge would be exactly the outcome.
> > Alas that doesn't seem to be the case :-|.
> > 
> > > I _had_ tried to simply revert the quota changes (I haven't
> > > said about that before) and it didn't help. I'm so puzzled with all this.
> > 
> > Aha, OK. If even reverting quota changes doesn't help, then it's really
> > weird...
> 
> Lemme to confirm that, it might be that I forgot to update configuration in
> between.

So, what I have done so far.
1) I have cleaned ccaches and stuff as I used it to avoid collisions;
2) I have confirmed that CONFIG_DEBUG_LIST affects boot, the repo
   I'm using is published here [0][1];
   3) reverted quota patches until before this merge ([2] - last patch),
      still boots;
4) reverted disabling of CONFIG_DEBUG_LIST [2], doesn't boot;
5) okay, rebased on top of merge, i.e. 1500e7e0726e,  with DEBUG_LIST [3],
	   doesn't boot;
6) rebased [3] on one merge before, i.e. 63580f669d7f [4], voil� -- it boots!;

And (tadaam!) I have had an idea for a while to replace GCC with LLVM
(at least for this test), so [0] boots as well!

So, this merge triggered a bug in GCC, seems like... And it's _the_ merge
commit, which is so-o weird!

$ gcc --version
gcc (Debian 13.2.0-4) 13.2.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[0]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-dbg-list/
[1]: https://bitbucket.org/andy-shev/linux/src/test-mrfld/
[2]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-no-quota-dbg-list/
[3]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-after-merge-dbg-list/
[4]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-before-merge/

-- 
With Best Regards,
Andy Shevchenko


