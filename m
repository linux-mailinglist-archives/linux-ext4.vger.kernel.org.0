Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4362D512ABD
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiD1E4e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiD1E4e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 00:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BCD9728F;
        Wed, 27 Apr 2022 21:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EAB61C5B;
        Thu, 28 Apr 2022 04:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876F6C385A0;
        Thu, 28 Apr 2022 04:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651121599;
        bh=9bCPfuK2ZtwsmzVYVCLOfTR7rL5e61TW5lNUriM4gEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orxjS9XAaBpxVoFQnE9wsmnTf1WlGnF5YtZ9JN4puN7jXSd+1Hg+eGGLB268CwuoW
         Ss58+yWw17apNUKDWoB+vBwErUe9k2+U7BWofsnYcgOT7jHQ3WPlJHh1HmOk6jhk9Y
         QEMAfUbVj4l1dnnDdJqkvhHEWTyQ6W9A6+w6OgNi7rDaH8fa4xKdq1VdnsOQWHJNt2
         wzJc81oh65S3h/PJLnjudrSwXnS/6RUBSITNKdyL/c+HarzVvHq89ToAgB3+MwshBd
         PV0ijJhoczo+0QfcUz6bLxNfbNdcYMpqmDuB1D1IidHJKvbRhEyV3DlFDiphHb7bCR
         Jc+2BXNyVSCEg==
Date:   Thu, 28 Apr 2022 12:53:13 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220428045313.kntbytbqlpgummql@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
 <YmlY5NhDodhRRpkU@mit.edu>
 <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
 <YmmdOvsw7gJXqu9X@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmdOvsw7gJXqu9X@mit.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 27, 2022 at 03:44:58PM -0400, Theodore Ts'o wrote:
> On Thu, Apr 28, 2022 at 01:19:23AM +0800, Zorro Lang wrote:
> > I just noticed that _scratch_mkfs_sized() and _scratch_mkfs_blocksized() both use
> > _scratch_mkfs_xfs for XFS, I'm wondering if ext4 would like to use _scratch_mkfs_ext4()
> > or even use _scratch_mkfs() directly in these two functions. Then you can do something
> > likes:
> >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota"
> >   _scratch_mkfs_blocksized 1024
> > or:
> >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota" _scratch_mkfs_blocksized 1024
> 
> I'd prefer to keep changing _scratch_mkfs_sized and
> _scatch_mkfs_blocksized to use _scratch_mfks_ext4 as a separate
> commit.  It makes sense to do that, but it does mean some behavioral
> changes; specifically in the external log case,
> "_scratch_mkfs_blocksized" will now create a file system using an
> external log.  It's probably a good change, but there is some testing
> I'd like to do first before makinig that change and I don't have time
> for it.

Sure, totally agree :)

> 
> > We just provide a helper to avoid someone forget 'dax', I don't object someone would
> > like to "exclude dax" by explicit method :) So if you don't have much time to do this
> > change, you can just do what you said above, then I'll take another time/chance to
> > change _scratch_mkfs_* things.
> 
> Hmm, one thing which I noticed when searching through things.  xfs/432
> does this:
> 
> _scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
> 
> So in {gce,kvm}-xfstests we have an exclude file entry in
> .../fs/xfs/cfg/dax.exclude:
> 
> # This test formats a file system with a 1k block size, which is not
> # compatible with DAX (at least with systems with a 4k page size).
> xfs/432
> 
> ... in order to suppress a test failure.
> 
> Arguably we should add an "_exclude_scratch_mount_option dax" to this
> test, as opposed to having an explicit test exclusion in my test
> runner.  Or we figure out how to change xfs/432 to use
> _scratch_mkfs_blocksized.  So there is a lot of cleanup that can be
> done here, and I suspect we should do this work incrementally.  :-)

Thanks for finding that, yes, we can do a cleanup later, if you have
a failed testing list welcome to provide to be references :)

> 
> > Maybe we should think about let all _scratch_mkfs_*[1] helpers use _scratch_mkfs
> > consistently. But that will change and affect too many things. I don't want to break
> > fundamental code too much, might be better to let each fs help to change and test
> > that bit by bit, when they need :)
> 
> Yep.   :-)
> 
> 						- Ted
> 
> P.S.  Here's something else that should probably be moved from my test
> runner into xfstests.  Again from .../xfs/cfg/dax.exclude:
> 
> # mkfs.xfs options which now includes reflink, and reflink is not
> # compatible with DAX
> xfs/032
> xfs/205
> xfs/294

Yes, xfs reflink can't work with DAX now, I don't know if it *will*, maybe
Darrick knows more details.

> 
> Maybe _scratch_mkfs_xfs should be parsing the output of mkfs.xfs to
> see if reflink is enabled, and then automatically asserting an
> "_exclude_scratch_mount_option dax", perhaps?

Hmm... good point, does it make sense to you, Darrick?

This patch can do what we talked in last patch, and welcome later patches from
extN forks:) I can help to deal with XFS part later. I don't know if btrfs has
similar troubles, welcome patches if they need too.

The change on _scratch_mkfs_blocksized will help common part, but can' help all
situations. Maybe better to let each fs change and test their fundamental helper
changes separately, to avoid regression :)

Thanks,
Zorro

> 
