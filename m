Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C171DD96C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgEUV00 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV0Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 May 2020 17:26:24 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EEC061A0E
        for <linux-ext4@vger.kernel.org>; Thu, 21 May 2020 14:26:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v4so6762212qte.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 May 2020 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mO0P/F4ePADvuck2PJKFh7AyzOOCb+O076IyCb7LnYM=;
        b=dlTs/1liL4YcrYk8JtiIe6jZe97uqldxrDfzd1VMPFhTCPBqxLRgUXc0HBcqZGUVb5
         adVcAeg2Z3iyl7Y1sxN8zx305PWE+YiL2vCddfps1r/1H9xAZH4hpeFeohQpcx9DMGb0
         dPZk49tCToIJtoWsKQ7TqCt3DRmC/PToiyR32jH9+QZrmerj3v+KsWxt/n8V4VMjkPhA
         kTip5P6TuSl1ZRIX6/nHPQTUXZc+sHiM1n7aHS8Arvx5cH7zXR9wPbegfiFdr8/flsxg
         k7fY2knGCqB9Etd1eDSC2TBxN26QjRYVSLLbxDnWwRg8gu7ernr7KLfjaCCVYYuiMiH/
         m5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mO0P/F4ePADvuck2PJKFh7AyzOOCb+O076IyCb7LnYM=;
        b=tfh+iZMZmSC3CLBF4lUxclJUp2gyp+SO6IqtNcDotvl/ZbWR0+1zniz6FaY1CGxCAa
         1TyTxSwhQo7Wj9TCWrdVsraia7FPfaKd2kc8iKhyWrl8Mov1aXDEbv3oMO0wZTf3Syf3
         aY9y60jo3QMIB8dsftR9OOw1yXJbqODgZ9D6oA1JOyhHs2zUX76Mv1jLqP7LscnwDDDn
         G2qBeqNyI835eRN0sLYFiJ9tcrvyX+AS04iRg5rZexch1hJRCiFBgJ7GxZm7Xur1ukWb
         l/meQ3Nt2WMszSTfv946gfWKperkxIEkNDtj3dRXNM84WhToWcEXod+TIgwjp/K7QpU/
         o5hQ==
X-Gm-Message-State: AOAM5313fjqpkHUvppe+OHaQYuqch23++N1Fq11BMaazRbwdsM3ycQZ9
        tOV405zDLBTDu5NLMuMOtr8=
X-Google-Smtp-Source: ABdhPJyp3QRLUYbZ8ikof1Gd25xRaRFXbFlozVQvC4mjsbGI+9+X0NJ0eAj86E7YDFlHihI7qPs1CA==
X-Received: by 2002:aed:374a:: with SMTP id i68mr12618097qtb.69.1590096382202;
        Thu, 21 May 2020 14:26:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id r25sm4345968qtc.16.2020.05.21.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:26:21 -0700 (PDT)
Date:   Thu, 21 May 2020 17:26:19 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RFC] ext4: fix partial cluster initialization when
 splitting extent
Message-ID: <20200521212619.GA10473@localhost.localdomain>
References: <1589444097-38535-1-git-send-email-jefflexu@linux.alibaba.com>
 <20200514222120.GB4710@localhost.localdomain>
 <20200518220804.GA20248@localhost.localdomain>
 <9b526ae9-cba6-35dd-0424-61e8fa5ab016@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b526ae9-cba6-35dd-0424-61e8fa5ab016@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* JeffleXu <jefflexu@linux.alibaba.com>:
> 
> On 5/19/20 6:08 AM, Eric Whitney wrote:
> > Hi, Jeffle:
> > 
> > What kernel were you running when you observed your failures?  Does your
> > patch resolve all observed failures, or do any remain?  Do you have a
> > simple test script that reproduces the bug?
> > 
> > I've made almost 1000 runs of shared/298 on various bigalloc configurations
> > using Ted's test appliance on 5.7-rc5 and have not observed a failure.
> > Several auto group runs have also passed without failures.  Ideally, I'd
> > like to be able to reproduce your failure to be sure we fully understand
> > what's going on.  It's still the case that the "2" is wrong, but I think
> > that code in rm_leaf may be involved in an unexpected way.
> > 
> > Thanks,
> > Eric
> 
> Hi Eric,
> 
> Following on is my test environment.
> 
> 
> kernel: 5.7-rc4-git-eb24fdd8e6f5c6bb95129748a1801c6476492aba
> 
> e2fsprog: latest release version 1.45.6 (20-Mar-2020)
> 
> xfstests: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git, master
> branch, latest commit
> 
> 
> 1. Test device
> 
> I run the test in a VM and the VM is setup by qemu. The size of vdb is 1G,
> 
> ```
> 
> #lsblk
> 
> NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> vdb    254:16   0   1G  0 disk
> 
> ```
> 
> 
> and is initialized by:
> 
> ```
> 
> qemu-img create -f qcow2 /XX/disk1.qcow2 1G
> 
> qemu-kvm -drive file=/XX/disk1.qcow2,if=virtio,format=qcow2 ...
> 
> ```
> 
> 
> 2. Test script
> 
> 
> local.config of xfstests is like:
> 
> export TEST_DEV=/dev/vdb
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/vdc
> export SCRATCH_MNT=/mnt/scratch
> 
> 
> Following on is an example script to reproduce the failure:
> 
> ```sh
> 
> #!/bin/bash
> 
> for i in `seq 100`; do
>         echo y | mkfs.ext4 -O bigalloc -C 16K /dev/vdb
> 
>         ./check shared/298
>         status=$?
> 
>         if [[ $status == 1 ]]; then
>                 echo "$i exit"
>                 exit
>         fi
> done
> 
> ```
> 
> 
> Indeed the failure occurs occasionally. Sometimes the script stops at
> iteration 4, or sometimes
> 
> at iteration 2, 7, 24.
> 
> 
> The failure occurs with the following dmesg report:
> 
> ```
> 
> [  387.471876] EXT4-fs error (device vdb): mb_free_blocks:1457: group 1,
> block 158084:freeing already freed block (bit 6753); block bitmap corrupt.
> [  387.473729] EXT4-fs error (device vdb): ext4_mb_generate_buddy:747: group
> 1, block bitmap and bg descriptor inconsistent: 19550 vs 19551 free clusters
> 
> ```
> 
> 
> 3. About the applied patch
> 
> The applied patch does fix the failure in my test environment. At least the
> failure doesn't occur after running the full 100 iterations.
> 
> 
> Thanks
> 
> Jeffle
> 
> 
>

Hi, Jeffle:

Thanks for that information.  I'm still unable to reproduce your failure,
but by inspection your patch clearly fixes a bug, and of course, you're seeing
that.  I suspect the code in rm_leaf that also sets the partial cluster nofree
state is masking the bug in my testing.  In your case, my best guess is that
your testing is occasionally getting into the retry loop for EAGAIN in
remove_space.  This would effectively expose the bug again and could lead to
the failure you've described.

Your patch has survived all the heavy testing I've thrown at it.  So, please
repost your RFC patch as a fix, and feel free to add:
Reviewed-by: Eric Whitney <enwlinux@gmail.com>

This points out that the cluster freeing code really needs to be cleaned up,
so I'm working on a patch series that does that.

Thanks for your patience,
Eric

