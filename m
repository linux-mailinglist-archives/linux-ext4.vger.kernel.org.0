Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9736CB175
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 23:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfJCVuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 17:50:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfJCVuO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 17:50:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3BE3AFC1;
        Thu,  3 Oct 2019 21:50:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 705781E4812; Thu,  3 Oct 2019 23:50:34 +0200 (CEST)
Date:   Thu, 3 Oct 2019 23:50:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/19] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20191003215034.GF17911@quack2.suse.cz>
References: <20190930104339.24919-17-jack@suse.cz>
 <201909302058.uxNSY0q3%lkp@intel.com>
 <20190930150553.GB4001@mit.edu>
 <20190930162536.GB13973@quack2.suse.cz>
 <20190930212145.GC4001@mit.edu>
 <20191001075908.GB25062@quack2.suse.cz>
 <20191003083316.GA17911@quack2.suse.cz>
 <20191003132909.GC3226@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003132909.GC3226@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 03-10-19 09:29:09, Theodore Y. Ts'o wrote:
> On Thu, Oct 03, 2019 at 10:33:16AM +0200, Jan Kara wrote:
> > 
> > I'm not yet sure about some failures in ext4/adv and ext4/bigalloc configs.
> > Where can I find what mkfs & mount options do you use for these? I've
> > looked at xfstests-bld but I didn't find the configs there... Thanks!
> 
> The configs are in [1] the mount options for adv and bigalloc are in
> [2] and [3], respectively.
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs
> [2] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv
> [3] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/bigalloc

Thanks. Somehow I didn't see them.

> It shouldn't be terribly difficult for you to use kvm-xfstests on
> SuSE, if you just want to try using the test appliance directly.  I'm
> happy to update the documentation to include the necessary SuSE
> packages needed to run kvm-xfstests; it shouldn't be that hard to
> translate them from the Debian prerequisites to SuSE package names.
> See [4] for details.
> 
> [4] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Yeah, I guess I should do that. The only problem with this is that I have
my own VM setup I use for xfstests runs (and other kernel debugging) and it
just works good enough that switching to using kvm-xfstests never gets high
enough on my todo list :). I'll give it more priority...

								Honza


> Note: if you want to run tests manually (which can be handy if you
> want to try tweaking the tests, just do this:
> 
> % kvm-xfstests shell
> ...
> root@kvm-xfstests:~# FSTESTSET=ext4/301
> root@kvm-xfstests:~# FSTESTCFG=adv
> root@kvm-xfstests:~# ./runtests.sh
> 
> The xfstests installation is in /root/xfstests.  Other valid settings
> for FSTESTCFG include: ext4/adv, ext4/all, btrfs/default, btrfs, xfs,
> nfs, nfs/loopback_v3, and so on.  See [1] for other fs configs that
> you can use for testing.
> 
> Cheers,
> 
> 							- Ted
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
