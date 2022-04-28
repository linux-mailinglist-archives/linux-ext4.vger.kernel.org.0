Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD469512C12
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbiD1G7Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 02:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiD1G7X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 02:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DDEB2B261
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651128968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nduXLcslWAVvCC5ntHR5nZtgKZPYQPlfGtLNU9VwIek=;
        b=dkgdBRA8Zw+jeV+wBl+4ruSXDTDSNPJBi0ooeADpUbZftsLLPLP5JeSx6oX5C2el2DLaEY
        xNMCe6E/+oIv7NFVTzB629QlcNMnvSLLidHFKWkRXpTa6lxR1v6xK+ijhrkwq+Xil/fyZe
        ATWnebllu23yCyDR7O0nFPrwqaGbsHg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-OXQCHZf1OSiPlbpuX8BP7w-1; Thu, 28 Apr 2022 02:56:04 -0400
X-MC-Unique: OXQCHZf1OSiPlbpuX8BP7w-1
Received: by mail-qv1-f71.google.com with SMTP id dv6-20020ad44ee6000000b0045642576917so3028642qvb.17
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 23:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nduXLcslWAVvCC5ntHR5nZtgKZPYQPlfGtLNU9VwIek=;
        b=HZrqQUOjRXJk9DWbGxv8fbXhgTTc8xHf2CuFEYx9C2Aayv9rd9P5NXx1+CAboiJZoa
         wENvEAp8ZCilzdFji/Zxot16mXNkdQApPPswURgCO+kAcy2/p3ka5fHIllApxYyEw+lK
         JjxelmFvzeljIlAi3ZBQ8XoC2ssX3KEnggqY1pF02jtG9pHGfZmk0CUcypT9ykSe4Jb+
         PIXjtMD5OHS25/oQjWVXL4V+kiHLqlWdCqkjObR3wA17EB+qxuU3rGn64DMIyLNg0zVX
         0jtjEAnsARJj8yFfA/S2PCMumpCLZC2ddz1hzujGPZuSO2TQbFbpOKO1Mbj8FRjw/+OD
         KJUQ==
X-Gm-Message-State: AOAM531udUWSH+x244dMhwgw9K1C3hjhd429Lky4qVWmo0QU1p5M5C0j
        BBUoNcNEDutaHfqtAIFuZpGCRKAVMtRxPi3U/r5qaWtwgSBj1KxgcaySfjeOXTz1jOaOFt5wZMf
        rw/vlCXuNFyltZQUXPQyzLg==
X-Received: by 2002:ac8:5acd:0:b0:2f3:39e1:8c64 with SMTP id d13-20020ac85acd000000b002f339e18c64mr21977873qtd.640.1651128964048;
        Wed, 27 Apr 2022 23:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjlI0lPqTkkIrZQqib/Dpmy5QSXnfi1wcLv8ZeTgnMQTQeLgHG8xhP6EtyK6YsvImqlqLUew==
X-Received: by 2002:ac8:5acd:0:b0:2f3:39e1:8c64 with SMTP id d13-20020ac85acd000000b002f339e18c64mr21977864qtd.640.1651128963811;
        Wed, 27 Apr 2022 23:56:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w22-20020a05622a135600b002f37f795d81sm3757429qtk.34.2022.04.27.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:56:03 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:55:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220428065556.yt6hm3yzdlxlqo6a@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
 <YmlY5NhDodhRRpkU@mit.edu>
 <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
 <YmmdOvsw7gJXqu9X@mit.edu>
 <20220428045313.kntbytbqlpgummql@zlang-mailbox>
 <20220428055825.GU1544202@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055825.GU1544202@dread.disaster.area>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 28, 2022 at 03:58:25PM +1000, Dave Chinner wrote:
> On Thu, Apr 28, 2022 at 12:53:13PM +0800, Zorro Lang wrote:
> > On Wed, Apr 27, 2022 at 03:44:58PM -0400, Theodore Ts'o wrote:
> > > On Thu, Apr 28, 2022 at 01:19:23AM +0800, Zorro Lang wrote:
> > > > I just noticed that _scratch_mkfs_sized() and _scratch_mkfs_blocksized() both use
> > > > _scratch_mkfs_xfs for XFS, I'm wondering if ext4 would like to use _scratch_mkfs_ext4()
> > > > or even use _scratch_mkfs() directly in these two functions. Then you can do something
> > > > likes:
> > > >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota"
> > > >   _scratch_mkfs_blocksized 1024
> > > > or:
> > > >   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota" _scratch_mkfs_blocksized 1024
> > > 
> > > I'd prefer to keep changing _scratch_mkfs_sized and
> > > _scatch_mkfs_blocksized to use _scratch_mfks_ext4 as a separate
> > > commit.  It makes sense to do that, but it does mean some behavioral
> > > changes; specifically in the external log case,
> > > "_scratch_mkfs_blocksized" will now create a file system using an
> > > external log.  It's probably a good change, but there is some testing
> > > I'd like to do first before makinig that change and I don't have time
> > > for it.
> > 
> > Sure, totally agree :)
> > 
> > > 
> > > > We just provide a helper to avoid someone forget 'dax', I don't object someone would
> > > > like to "exclude dax" by explicit method :) So if you don't have much time to do this
> > > > change, you can just do what you said above, then I'll take another time/chance to
> > > > change _scratch_mkfs_* things.
> > > 
> > > Hmm, one thing which I noticed when searching through things.  xfs/432
> > > does this:
> > > 
> > > _scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
> > > 
> > > So in {gce,kvm}-xfstests we have an exclude file entry in
> > > .../fs/xfs/cfg/dax.exclude:
> > > 
> > > # This test formats a file system with a 1k block size, which is not
> > > # compatible with DAX (at least with systems with a 4k page size).
> > > xfs/432
> > > 
> > > ... in order to suppress a test failure.
> > > 
> > > Arguably we should add an "_exclude_scratch_mount_option dax" to this
> > > test, as opposed to having an explicit test exclusion in my test
> > > runner.  Or we figure out how to change xfs/432 to use
> > > _scratch_mkfs_blocksized.  So there is a lot of cleanup that can be
> > > done here, and I suspect we should do this work incrementally.  :-)
> > 
> > Thanks for finding that, yes, we can do a cleanup later, if you have
> > a failed testing list welcome to provide to be references :)
> > 
> > > 
> > > > Maybe we should think about let all _scratch_mkfs_*[1] helpers use _scratch_mkfs
> > > > consistently. But that will change and affect too many things. I don't want to break
> > > > fundamental code too much, might be better to let each fs help to change and test
> > > > that bit by bit, when they need :)
> > > 
> > > Yep.   :-)
> > > 
> > > 						- Ted
> > > 
> > > P.S.  Here's something else that should probably be moved from my test
> > > runner into xfstests.  Again from .../xfs/cfg/dax.exclude:
> > > 
> > > # mkfs.xfs options which now includes reflink, and reflink is not
> > > # compatible with DAX
> > > xfs/032
> > > xfs/205
> > > xfs/294
> > 
> > Yes, xfs reflink can't work with DAX now, I don't know if it *will*, maybe
> > Darrick knows more details.
> 
> The DAX+reflink patches are almost ready to be merged - everything
> has been reviewed and if I get updated patches in the next week or
> two that address all the remaining concerns I'll probably merge
> them.

Thanks, good to know that. So we don't need to concern DAX+reflink test cases.

> 
> > > Maybe _scratch_mkfs_xfs should be parsing the output of mkfs.xfs to
> > > see if reflink is enabled, and then automatically asserting an
> > > "_exclude_scratch_mount_option dax", perhaps?
> 
> The time to do this was about 4 years ago, not right now when we are
> potentially within a couple of weeks of actually landing the support
> for this functionality in the dev tree and need the fstests
> infrastructure to explicitly support this configuration....

Sure, we'll give it a regression testing too, when DAX+reflink is ready.

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

