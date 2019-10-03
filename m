Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8794AC9F68
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfJCN3Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 09:29:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47635 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730370AbfJCN3Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 09:29:16 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x93DT9uA022479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Oct 2019 09:29:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF10742088C; Thu,  3 Oct 2019 09:29:09 -0400 (EDT)
Date:   Thu, 3 Oct 2019 09:29:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/19] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20191003132909.GC3226@mit.edu>
References: <20190930104339.24919-17-jack@suse.cz>
 <201909302058.uxNSY0q3%lkp@intel.com>
 <20190930150553.GB4001@mit.edu>
 <20190930162536.GB13973@quack2.suse.cz>
 <20190930212145.GC4001@mit.edu>
 <20191001075908.GB25062@quack2.suse.cz>
 <20191003083316.GA17911@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003083316.GA17911@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 03, 2019 at 10:33:16AM +0200, Jan Kara wrote:
> 
> I'm not yet sure about some failures in ext4/adv and ext4/bigalloc configs.
> Where can I find what mkfs & mount options do you use for these? I've
> looked at xfstests-bld but I didn't find the configs there... Thanks!

The configs are in [1] the mount options for adv and bigalloc are in
[2] and [3], respectively.

[1] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs
[2] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv
[3] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/bigalloc

It shouldn't be terribly difficult for you to use kvm-xfstests on
SuSE, if you just want to try using the test appliance directly.  I'm
happy to update the documentation to include the necessary SuSE
packages needed to run kvm-xfstests; it shouldn't be that hard to
translate them from the Debian prerequisites to SuSE package names.
See [4] for details.

[4] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Note: if you want to run tests manually (which can be handy if you
want to try tweaking the tests, just do this:

% kvm-xfstests shell
...
root@kvm-xfstests:~# FSTESTSET=ext4/301
root@kvm-xfstests:~# FSTESTCFG=adv
root@kvm-xfstests:~# ./runtests.sh

The xfstests installation is in /root/xfstests.  Other valid settings
for FSTESTCFG include: ext4/adv, ext4/all, btrfs/default, btrfs, xfs,
nfs, nfs/loopback_v3, and so on.  See [1] for other fs configs that
you can use for testing.

Cheers,

							- Ted
