Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C522A105E1B
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2019 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVBTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 20:19:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVBTV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 20:19:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1JFAc086952;
        Fri, 22 Nov 2019 01:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=p47twZnYDmEk9p8LqLC3/KsAvHN+9PYlUd3C3DvNwek=;
 b=BIlNsTiWEX04s9KhvvtPRf4bUkpapxY/5EHr246rOZD7pgPkAIHyfeb+v/AZbaWGYa8o
 zhz3qp43fjxv2KpI7BMwg+0RyW0Bw1xE0WcYDR7e/2YM3P6rjwNS9NU57L1a94k8g/t0
 OAS/WDfxdfmXK/POm4sE59JLJE+HNUOZ/cpAxXNVjygMlCS++r1GLVe3nZP5SVEEKso1
 illltnaOKFVO2+09cyMZ/QfLLHmXqQpqUgUDynLfo0nE32yEKlXRDLXTE4S8LdEwIAmh
 65Hn1cV2U7r7To/7XJKx93Dt0FwKEwBDmdVLcz3h42/CZCllryGfa9B9SIDr/rWNeDN1 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqypu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:19:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1J8a9141882;
        Fri, 22 Nov 2019 01:19:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wda0716ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:19:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM1IZww015936;
        Fri, 22 Nov 2019 01:18:35 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 17:18:35 -0800
Date:   Thu, 21 Nov 2019 17:18:34 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: simulate various I/O and checksum errors when
 reading metadata
Message-ID: <20191122011834.GH6213@magnolia>
References: <20191121183036.29385-1-tytso@mit.edu>
 <20191121183036.29385-2-tytso@mit.edu>
 <20191122000933.GG6213@magnolia>
 <20191122010026.GK4262@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122010026.GK4262@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220009
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 21, 2019 at 08:00:26PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Nov 21, 2019 at 04:09:33PM -0800, Darrick J. Wong wrote:
> > > +static inline int ext4_simulate_fail(struct super_block *sb,
> > > +				     unsigned long flag)
> > 
> > Nit: bool?
> 
> Sure, I'll do this for the next version.
> 
> > If I'm reading this correctly, this means that userspace sets a
> > s_simulate_fail bit via sysfs knob, and the next time the filesystem
> > calls ext4_simulate_fail with the same bit set in @flag we'll return
> > true to say "simulate the failure" and clear the bit in s_simulate_fail?
> > 
> > IOWs, the simulated failures have to be re-armed every time?
> 
> Yes, that's correct.
> 
> > Seems reasonable, but consider the possibility that in the future it
> > might be useful if you could set up periodic failures (e.g. directory
> > lookups fail 10% of the time) so that you can see how something like
> > fsstress reacts to less-predictable failures?
> 
> So in theory, we could do that with dm_flakey --- but that's a pain in
> the tuckus, since you have to specify the LBA for the directory blocks
> that you might want to have fail.

Funny, I've been working on a fstests helper function to make it easy to
set up dm-flakey based on fiemap/getfsmap output and such. :)

> I implemented this so I could have
> a quick and dirty way of testing the first patch in this series (and
> in fact, I found a bug in the first version of the previous patch, so
> I'm glad I spent the time to implement the test patch :-).

Heh, cool!

> What might be interesting to do is some kind of eBPF hook where we
> pass in the block #, inode #, and metadata type, and the ePBF program
> could do use a much more complex set of criteria in terms of whether
> or not to trigger an EIO, or how to fuzz a particular block to either
> force a CRC failure, or to try to find bugs ala Hydra[1] (funded via a
> Google Faculty Research Award grant), but using a much more glass-box
> style test approach.

That would be fun.  Attach an arbitrary eBPF program to a range of
sectors.  I wonder how loud the howls of protest would be for "can we
let ebpf programs scribble on a kernel io buffer pleeze?"...

...a couple of years ago I sent out an RFCRAP patch so that you could
use eBPF's "new" ability to change function return values, which
Christoph immediately NAKd.  I think Josef's original purpose was so
that he could inject arbitrary debugging knobs all over btrfs.

> [1] https://gts3.org/~sanidhya/pubs/2019/hydra.pdf
> 
> This would be a lot more work, and I'm not sufficiently up to speed
> with eBPF, and I just needed a quick and dirty testing scheme.
> 
> The reason why I think it's worthwhile to land this patch (as opposed
> to throwing it away after doing the development work for the previous
> patch) is that it's a relatively small set of changes, and all of the
> code disappears if CONFIG_DEBUG_EXT4 is not enabled.  So it has no
> performance cost on production kernels, and it's highly unlikely that
> users would have a reason to use this feature on production use cases,
> so ripping this out if and when we have a more functional eBPF testing
> infrastructure to replace it shouldn't really be a problem.

Admittedly it's a debug knob so I don't see it as a big deal if you
merge this and some day rip it out or supersede it.  The XFS knobs have
undergone a few, uh, interface revisions.

> 					- Ted
> 
> P.S.  A fascinating question is whether we could make the hooks for
> this hypothetical eBPF hook general enough that it could work for more
> than just ext4, but for other file systems.  The problem is that the
> fs metadata types are not going to be same across different file
> systems, so that makes the API design quite tricky; and perhaps not
> worth it?

Yeah.  I mean, it's eBPF glomming onto random parts of the kernel, so I
don't think there's ever going to be a General API For Brain Slugs[3].

OTOH I need LSF topics so sure lets roll.

--D

[2] https://lore.kernel.org/linux-xfs/20171213061825.GO19219@magnolia/
[3] https://futurama.fandom.com/wiki/Brain_Slug
