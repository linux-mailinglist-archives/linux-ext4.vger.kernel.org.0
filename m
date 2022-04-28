Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C744512B35
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 07:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbiD1GBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiD1GBm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 02:01:42 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F9AB7C79B;
        Wed, 27 Apr 2022 22:58:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-62-197.pa.nsw.optusnet.com.au [49.195.62.197])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F1FDA10E5F3C;
        Thu, 28 Apr 2022 15:58:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1njxAX-005RPS-QI; Thu, 28 Apr 2022 15:58:25 +1000
Date:   Thu, 28 Apr 2022 15:58:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220428055825.GU1544202@dread.disaster.area>
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
 <YmlY5NhDodhRRpkU@mit.edu>
 <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
 <YmmdOvsw7gJXqu9X@mit.edu>
 <20220428045313.kntbytbqlpgummql@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428045313.kntbytbqlpgummql@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=626a2d03
        a=KhGSFSjofVlN3/cgq4AT7A==:117 a=KhGSFSjofVlN3/cgq4AT7A==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=iEgHlEzsFWBexfCrGBsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 28, 2022 at 12:53:13PM +0800, Zorro Lang wrote:
> On Wed, Apr 27, 2022 at 03:44:58PM -0400, Theodore Ts'o wrote:
> > On Thu, Apr 28, 2022 at 01:19:23AM +0800, Zorro Lang wrote:
> > > I just noticed that _scratch_mkfs_sized() and _scratch_mkfs_blocksized() both use
> > > _scratch_mkfs_xfs for XFS, I'm wondering if ext4 would like to use _scratch_mkfs_ext4()
> > > or even use _scratch_mkfs() directly in these two functions. Then you can do something
> > > likes:
> > >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota"
> > >   _scratch_mkfs_blocksized 1024
> > > or:
> > >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota" _scratch_mkfs_blocksized 1024
> > 
> > I'd prefer to keep changing _scratch_mkfs_sized and
> > _scatch_mkfs_blocksized to use _scratch_mfks_ext4 as a separate
> > commit.  It makes sense to do that, but it does mean some behavioral
> > changes; specifically in the external log case,
> > "_scratch_mkfs_blocksized" will now create a file system using an
> > external log.  It's probably a good change, but there is some testing
> > I'd like to do first before makinig that change and I don't have time
> > for it.
> 
> Sure, totally agree :)
> 
> > 
> > > We just provide a helper to avoid someone forget 'dax', I don't object someone would
> > > like to "exclude dax" by explicit method :) So if you don't have much time to do this
> > > change, you can just do what you said above, then I'll take another time/chance to
> > > change _scratch_mkfs_* things.
> > 
> > Hmm, one thing which I noticed when searching through things.  xfs/432
> > does this:
> > 
> > _scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
> > 
> > So in {gce,kvm}-xfstests we have an exclude file entry in
> > .../fs/xfs/cfg/dax.exclude:
> > 
> > # This test formats a file system with a 1k block size, which is not
> > # compatible with DAX (at least with systems with a 4k page size).
> > xfs/432
> > 
> > ... in order to suppress a test failure.
> > 
> > Arguably we should add an "_exclude_scratch_mount_option dax" to this
> > test, as opposed to having an explicit test exclusion in my test
> > runner.  Or we figure out how to change xfs/432 to use
> > _scratch_mkfs_blocksized.  So there is a lot of cleanup that can be
> > done here, and I suspect we should do this work incrementally.  :-)
> 
> Thanks for finding that, yes, we can do a cleanup later, if you have
> a failed testing list welcome to provide to be references :)
> 
> > 
> > > Maybe we should think about let all _scratch_mkfs_*[1] helpers use _scratch_mkfs
> > > consistently. But that will change and affect too many things. I don't want to break
> > > fundamental code too much, might be better to let each fs help to change and test
> > > that bit by bit, when they need :)
> > 
> > Yep.   :-)
> > 
> > 						- Ted
> > 
> > P.S.  Here's something else that should probably be moved from my test
> > runner into xfstests.  Again from .../xfs/cfg/dax.exclude:
> > 
> > # mkfs.xfs options which now includes reflink, and reflink is not
> > # compatible with DAX
> > xfs/032
> > xfs/205
> > xfs/294
> 
> Yes, xfs reflink can't work with DAX now, I don't know if it *will*, maybe
> Darrick knows more details.

The DAX+reflink patches are almost ready to be merged - everything
has been reviewed and if I get updated patches in the next week or
two that address all the remaining concerns I'll probably merge
them.

> > Maybe _scratch_mkfs_xfs should be parsing the output of mkfs.xfs to
> > see if reflink is enabled, and then automatically asserting an
> > "_exclude_scratch_mount_option dax", perhaps?

The time to do this was about 4 years ago, not right now when we are
potentially within a couple of weeks of actually landing the support
for this functionality in the dev tree and need the fstests
infrastructure to explicitly support this configuration....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
