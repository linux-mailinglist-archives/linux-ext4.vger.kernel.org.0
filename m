Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB767CC0BB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjJQKdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKc7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 06:32:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5F48E;
        Tue, 17 Oct 2023 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697538777; x=1729074777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILoqvxBEJht4ynMLEnNIRsTYHBFXIaFS2dHMOUDBj5A=;
  b=OAeWo284KAp/IKWa7/Oupm9QEoPhFg0C7DKUqvcq5u25ixhD8Kb/Z08n
   loSCPw4elfo2XWOONs4FThn3COqsDPcx+b5FZCijOfihmMMHYtZHpraZj
   9t8nSIqsUrAxLUb37zOGiYyl9X/tfRDYVLGc2TTG7lrv2/QNuOjjcyk8Z
   Ilu74t4Iu43FeS9OeIZpZXEG/MvetTFP1izXgkUJmi+/tJrFynwVG7Bhx
   V/s9d61dSkK/IRb0+l8YXpwNY4oKDjVDw8mRp9Zl/q6vwEbANgfj+xtmh
   hFcC/LTadMGvfcXbkasSi7jzwnj3t6hjvBgVBz7GuA8RvZFc23OM3O3mC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365103962"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365103962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1003309913"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1003309913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:32:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qshNd-00000006FmL-21h6;
        Tue, 17 Oct 2023 13:32:53 +0300
Date:   Tue, 17 Oct 2023 13:32:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jan Kara <jack@suse.cz>, Ferry Toth <ftoth@exalondelft.nl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 17, 2023 at 01:29:27PM +0300, Andy Shevchenko wrote:
> +Ferry
> 
> On Tue, Oct 17, 2023 at 01:27:19PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 30, 2023 at 12:24:34PM +0200, Jan Kara wrote:
> > >   Hello Linus,
> > > 
> > >   could you please pull from
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
> > > 
> > > to get:
> > > * fixes for possible use-after-free issues with quota when racing with
> > >   chown
> > > * fixes for ext2 crashing when xattr allocation races with another
> > >   block allocation to the same file from page writeback code
> > > * fix for block number overflow in ext2
> > > * marking of reiserfs as obsolete in MAINTAINERS
> > > * assorted minor cleanups
> > > 
> > > Top of the tree is df1ae36a4a0e. The full shortlog is:
> > 
> > This merge commit (?) broke boot on Intel Merrifield.
> > It has earlycon enabled and only what I got is watchdog
> > trigger without a bit of information printed out.
> > 
> > I tried to give a two bisects with the same result.
> > 
> > Try 1:

+ Missed start of this

git bisect start
# status: waiting for both good and bad commits
# good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
# status: waiting for bad commit, 1 good commit known
# bad: [0bb80ecc33a8fb5a682236443c1e740d5c917d1d] Linux 6.6-rc1
git bisect bad 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
# bad: [461f35f014466c4e26dca6be0f431f57297df3f2] Merge tag 'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm


> > git bisect bad 461f35f014466c4e26dca6be0f431f57297df3f2                                                          # good: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> > git bisect good bd6c11bc43c496cddfc6cf603b5d45365606dbd5
> > # good: [ef35c7ba60410926d0501e45aad299656a83826c] Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""
> > git bisect good ef35c7ba60410926d0501e45aad299656a83826c
> > # good: [d68b4b6f307d155475cce541f2aee938032ed22e] Merge tag 'mm-nonmm-stable-2023-08-28-22-48' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > git bisect good d68b4b6f307d155475cce541f2aee938032ed22e
> > # good: [87fa732dc5ff9ea6a2e75b630f7931899e845eb1] Merge tag 'x86-core-2023-08-30-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good 87fa732dc5ff9ea6a2e75b630f7931899e845eb1
> > # good: [bc609f4867f6a14db0efda55a7adef4dca16762e] Merge tag 'drm-misc-next-fixes-2023-08-24' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> > git bisect good bc609f4867f6a14db0efda55a7adef4dca16762e
> > # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> > git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
> > # good: [5221002c054376fcf2f0cea1d13f00291a90222e] Merge tag 'repair-force-rebuild-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
> > git bisect good 5221002c054376fcf2f0cea1d13f00291a90222e
> > # bad: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> > git bisect bad 1500e7e0726e963f64b9785a0cb0a820b2587bad
> > # good: [7a64774add85ce673a089810fae193b02003be24] quota: use lockdep_assert_held_write in dquot_load_quota_sb
> > git bisect good 7a64774add85ce673a089810fae193b02003be24
> > # good: [b450159d0903b06ebea121a010ab9c424b67c408] ext2: introduce new flags argument for ext2_new_blocks()
> > git bisect good b450159d0903b06ebea121a010ab9c424b67c408
> > # good: [9bc6fc3304d89f19c028cb4a8d6af94f9e5faeb0] ext2: dump current reservation window info
> > git bisect good 9bc6fc3304d89f19c028cb4a8d6af94f9e5faeb0
> > # good: [df1ae36a4a0e92340daea12e88d43eeb2eb013b1] ext2: Fix kernel-doc warnings
> > git bisect good df1ae36a4a0e92340daea12e88d43eeb2eb013b1
> > # first bad commit: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> > 
> > Try 2:
> > 
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [58720809f52779dc0f08e53e54b014209d13eebb] Linux 6.6-rc6
> > git bisect bad 58720809f52779dc0f08e53e54b014209d13eebb
> > # status: waiting for good commit(s), bad commit known
> > # good: [5221002c054376fcf2f0cea1d13f00291a90222e] Merge tag 'repair-force-rebuild-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
> > git bisect good 5221002c054376fcf2f0cea1d13f00291a90222e
> > # bad: [c66403f62717e1af3be2a1873d52d2cf4724feba] Merge tag 'genpd-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
> > git bisect bad c66403f62717e1af3be2a1873d52d2cf4724feba
> > # good: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> > git bisect good bd6c11bc43c496cddfc6cf603b5d45365606dbd5
> > # good: [3698a75f5a98d0a6599e2878ab25d30a82dd836a] Merge tag 'drm-intel-next-fixes-2023-08-24' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
> > git bisect good 3698a75f5a98d0a6599e2878ab25d30a82dd836a
> > # good: [1a35914f738c564060a14388f52a06669b09e0b3] Merge tag 'integrity-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> > git bisect good 1a35914f738c564060a14388f52a06669b09e0b3
> > # good: [b36e672b6b6fa4f68fc74c3b85ba9b4a615fc1d9] ASoC: tegra: merge DAI call back functions into ops
> > git bisect good b36e672b6b6fa4f68fc74c3b85ba9b4a615fc1d9
> > # good: [692f5510159c79bfa312a4e27a15e266232bfb4c] Merge tag 'asoc-v6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
> > git bisect good 692f5510159c79bfa312a4e27a15e266232bfb4c
> > # good: [1687d8aca5488674686eb46bf49d1d908b2672a1] Merge tag 'x86_apic_for_6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good 1687d8aca5488674686eb46bf49d1d908b2672a1
> > # bad: [53ea7f624fb91074c2f9458832ed74975ee5d64c] Merge tag 'xfs-6.6-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> > git bisect bad 53ea7f624fb91074c2f9458832ed74975ee5d64c
> > # good: [df1ae36a4a0e92340daea12e88d43eeb2eb013b1] ext2: Fix kernel-doc warnings
> > git bisect good df1ae36a4a0e92340daea12e88d43eeb2eb013b1
> > # bad: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> > git bisect bad 1500e7e0726e963f64b9785a0cb0a820b2587bad
> > # good: [b0504bfe1b8acdcfb5ef466581d930835ef3c49e] ovl: add support for unique fsid per instance
> > git bisect good b0504bfe1b8acdcfb5ef466581d930835ef3c49e
> > # good: [36295542969dcfe7443f8cc5247863ed06a936d5] ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
> > git bisect good 36295542969dcfe7443f8cc5247863ed06a936d5
> > # good: [adcd459ff805ce5e11956cfa1e9aa85471b6ae8d] ovl: validate superblock in OVL_FS()
> > git bisect good adcd459ff805ce5e11956cfa1e9aa85471b6ae8d
> > # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> > git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
> > # first bad commit: [1500e7e0726e963f64b9785a0cb0a820b2587bad] Merge tag 'for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> > 
> > I'm full ears on how to debug this. Note, the earlyprintk doesn't work on this
> > platform as it has no legacy UARTs.

-- 
With Best Regards,
Andy Shevchenko


