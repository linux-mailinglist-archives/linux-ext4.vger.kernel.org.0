Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2713125DDB2
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgIDP2L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 11:28:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgIDP2H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 11:28:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FJi3i188512;
        Fri, 4 Sep 2020 15:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oisI33Zpu5BicchVLKMPafK1jiLJVKXmuASoEoz4pKQ=;
 b=FjGzQ3Bgrhfw5U6SmoO0rXJaE2YqfhO1B3Fv07YuD8KaHwoZVPZlHZCJ76J7gEUpp8MR
 4F+kTT0ma5v59fAi/cJ5hS/u9fPyXBMDLqIpRpGr0rk4v0WiYIKVtH+pKw7TL/6hvoeK
 MV3cL91q8emn5J+mWwXIzL04pLJYPWzpTtsSjs04XTlgVdx2GBR35vgzj47snfcdhTLU
 odgFgNscdvHfVF1NQRz9/LAN1CFsUtf1SCAhblZ6V6SbVcncNTGGvpvKQPbZX/EWPk9Q
 LXyzwfQA1TdhqA6X4FTabNaVy618QQLmKIduaPqBl125xSkm+hhMTtwdhlKAG9UL6haI jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmndgut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 15:28:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FLE6x117158;
        Fri, 4 Sep 2020 15:26:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33bhs4mxc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 15:26:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084FQ0xh003470;
        Fri, 4 Sep 2020 15:26:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 08:26:00 -0700
Date:   Fri, 4 Sep 2020 08:25:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <20200904152559.GB6088@magnolia>
References: <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <73f14124-e660-de0d-95ad-7fb21f18cdef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f14124-e660-de0d-95ad-7fb21f18cdef@kernel.dk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040134
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 04, 2020 at 08:51:24AM -0600, Jens Axboe wrote:
> On 9/3/20 9:55 PM, Theodore Y. Ts'o wrote:
> > Hi Jens,
> > 
> > Sorry, the past few months have been *crazy* insane.  Between Linux
> > Plumbers Conference organizing, having to deal with some interns at
> > $WORK, performance reviews, etc.., etc., it's been a perfect storm.
> > As a result, I was late getting the primary ext4 pull request to
> > Linus, and he's already yelled at me for a late pull request.
> > 
> > As a result, I'm being super paranoid about asking Linus for anything,
> > even a one-time change, if it's not a bug fix.  And what you are
> > asking for isn't a bug fix, but enabling a new feature.
> 
> That's fine, we blew past the 5.9 window long ago imho. As mentioned,
> back in May we could have solved this by just adding your acked-by
> or reviewed-by to the patch like we did for xfs/btrfs. That removes the
> ext4 tree dependency. Obviously that's no longer a concern for 5.10, but
> I need to know if we're going one of two routes:
> 
> a) I'm queueing this up, in which case I'll still need that ack/review
> b) you're queueing it up, in which case you can just grab it
> 
> I just don't want to end up in the same situation for 5.10, and then
> we're pushing this out 2 releases at that point...
> 
> > Worse, right now, -rc1 and -rc2 is causing random crashes in my
> > gce-xfstests framework.  Sometimes it happens before we've run even a
> > single xfstests; sometimes it happens after we have successfully
> > completed all of the tests, and we're doing a shutdown of the VM under
> > test.  Other times it happens in the middle of a test run.  Given that
> > I'm seeing this at -rc1, which is before my late ext4 pull request to
> > Linus, it's probably not an ext4 related bug.  But it also means that
> > I'm partially blind in terms of my kernel testing at the moment.  So I
> > can't even tell Linus that I've run lots of tests and I'm 100%
> > confident your one-line change is 100% safe.
> > 
> > Next week after Labor Day, I should be completely done with the
> > performance review writeups that are on my plate, and I will hopefully
> > have a bit more time to try to debug these mysterious failures.  Or
> > maybe someone else will be able to figure out what the heck is going
> > wrong, and perhaps -rc3 will make all of these failures go away.

FWIW I saw a strange crash in the xfs/iomap directio code that I could
never reproduce again, but none of my newly onlined ext4 fstests vms
have died, and I've been running a combination of 5.9-rc1 and 5.9-rc3 +
other xfs goodies.  Good luck!

--D

> > I'm sorry your frustrated; I'm frustrated too!  But until I can find
> > the time to do a full bisect (v5.8 works just fine.  v5.9-rc1 is
> > flakey as hell when booting my test config in a GCE VM), I'm not in a
> > position to send anything to Linus.
> 
> That looks nasty, good luck! Hopefully the bisect will be helpful. FWIW,
> in the testing I've done (with this patch) on ext4 and with XFS, I
> haven't seen anything odd. That's using real hardware though, and qemu
> on the laptop, no GCE.
> 
> -- 
> Jens Axboe
> 
