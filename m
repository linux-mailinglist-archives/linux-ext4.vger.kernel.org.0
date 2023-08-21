Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFF7830C0
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Aug 2023 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjHUS5F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Aug 2023 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHUS5F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Aug 2023 14:57:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693494C15
        for <linux-ext4@vger.kernel.org>; Mon, 21 Aug 2023 11:56:36 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37LIcoS1002082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692643133; bh=Q9HRYUxT/GYoPNpzIiar8hoNWIC0r2Ug0nzgdQo1v0Q=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=WUZQGXDs/WiHzsrBItVzc1zKJN8lb11egYyYmLsLQOscifr7lifnMto/6OHSDdW6p
         ZpbvbM1DFKAeBXnJTnXKXZYuh4QuCCGu9qMUX/7R5oqUNSV+In4BON1+ZLraqdMFSf
         xCwM+KFC2Ep6ERVaGZRWEMGs3YE1NcFLEZmIQtMzHrKX0iTGHMTVP4+a/64heiRtM3
         OtuB+qBgn/iwURRM9TWH5M98qDrHHNH0PaTDZbz+f3Ro7UYfBzWMpLvB+POzyHEh+0
         AtQq8qSJJQX+s9Ycd9c1D50FCkLkLV9TARc9N1iR1IAxs6jZT5ev+F/hzX0xnA2S9w
         ETm/OoxODnOeg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id E8D5E8C07C7; Mon, 21 Aug 2023 14:38:49 -0400 (EDT)
Date:   Mon, 21 Aug 2023 14:38:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Lu, Davina" <davinalu@amazon.com>
Cc:     "Bhatnagar, Rishabh" <risbhat@amazon.com>, Jan Kara <jack@suse.cz>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Re: Tasks stuck jbd2 for a long time
Message-ID: <ZOOvOT4dL1SCHQDz@mit.edu>
References: <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
 <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
 <d82df68eb8514951a7f7acc923132796@amazon.com>
 <20230818024144.GD3464136@mit.edu>
 <099884899291490caf6c529929339e50@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099884899291490caf6c529929339e50@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 21, 2023 at 01:10:58AM +0000, Lu, Davina wrote:
> 
> > [2] https://lore.kernel.org/r/53153bdf0cce4675b09bc2ee6483409f@amazon.com
> 
> Thanks for pointed out, I almost forget I did this version 2.  How
> to replicate this issue : CPU is X86_64, 64 cores, 2.50GHZ, MEM is
> 256GB (it is VM though). Attached with one NVME device (no lvm, drbd
> etc) with IOPS 64000 and 16GiB. I can also replicate with 10000 IOPS
> 1000GiB NVME volume....

Thanks for the details.  This is something that am interested in
trying to potentially to merge, since for a sufficiently
coversion-heavy workload (assuming the conversion is happening across
multiple inodes, and not just a huge number of random writes into a
single fallocated file), limiting the number of kernel threads to one
CPU isn't always going to be the right thing.  The reason why we had
done this way was because at the time, the only choices that we had
was between a single kernel thread, or spawning a kernel thread for
every single CPU --- which for a very high-core-count system, consumed
a huge amount of system resources.  This is no longer the case with
the new Concurrency Managed Workqueue (cmwq), but we never did the
experiment to make sure cmwq didn't have surprising gotchas.

> > Finally, I'm a bit nervous about setting the internal __WQ_ORDERED
> > flag with max_active > 1.  What was that all about, anyway?
> 
> Yes, you are correct. I didn't use "__WQ_ORDERED" carefully, it
> better not use with max_active > 1 . My purpose was try to guarantee
> the work queue can be sequentially implemented on each core.

I won't have time to look at this before the next merge window, but
what I'm hoping to look at is your patch at [2], with two changes:

a)  Drop the _WQ_ORDERED flag, since it is an internal flag.

b) Just pass in 0 for max_active instead of "num_active_cpus() > 1 ?
   num_active_cpus() : 1", for two reasons.  Num_active_cpus() doesn't
   take into account CPU hotplugs (for example, if you have a
   dynmically adjustable VM shape where the number of active CPU's
   might change over time).  Is there a reason why we need to set that
   limit?

Do you see any potential problem with these changes?

Thanks,

						- Ted
