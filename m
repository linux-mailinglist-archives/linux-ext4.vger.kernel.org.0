Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB826B25B
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 00:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgIOWqR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 18:46:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39918 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727582AbgIOWpz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 18:45:55 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08FMjf7x012451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 18:45:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE27C42004D; Tue, 15 Sep 2020 18:45:41 -0400 (EDT)
Date:   Tue, 15 Sep 2020 18:45:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200915224541.GB38283@mit.edu>
References: <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915073303.GA754106@T590>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 15, 2020 at 03:33:03PM +0800, Ming Lei wrote:
> Hi Theodore,
> 
> On Tue, Sep 15, 2020 at 12:45:19AM -0400, Theodore Y. Ts'o wrote:
> > On Thu, Sep 03, 2020 at 11:55:28PM -0400, Theodore Y. Ts'o wrote:
> > > Worse, right now, -rc1 and -rc2 is causing random crashes in my
> > > gce-xfstests framework.  Sometimes it happens before we've run even a
> > > single xfstests; sometimes it happens after we have successfully
> > > completed all of the tests, and we're doing a shutdown of the VM under
> > > test.  Other times it happens in the middle of a test run.  Given that
> > > I'm seeing this at -rc1, which is before my late ext4 pull request to
> > > Linus, it's probably not an ext4 related bug.  But it also means that
> > > I'm partially blind in terms of my kernel testing at the moment.  So I
> > > can't even tell Linus that I've run lots of tests and I'm 100%
> > > confident your one-line change is 100% safe.
> > 
> > I was finally able to bisect it down to the commit:
> > 
> > 37f4a24c2469: blk-mq: centralise related handling into blk_mq_get_driver_tag
> 
> 37f4a24c2469 has been reverted in:
> 
> 	4e2f62e566b5 Revert "blk-mq: put driver tag when this request is completed"
> 
> And later the patch is committed as the following after being fixed:
> 
> 	568f27006577 blk-mq: centralise related handling into blk_mq_get_driver_tag
> 
> So can you reproduce the issue by running kernel of commit 568f27006577?

Yes.  And things work fine if I try 4e2f62e566b5.

> If yes, can the issue be fixed by reverting 568f27006577?

The problem is it's a bit tricky to revert 568f27006577, since there
is a merge conflict in blk_kick_flush().  I attempted to do the bisect
manually here, but it's clearly not right since the kernel is not
booting after the revert:

https://github.com/tytso/ext4/commit/1e67516382a33da2c9d483b860ac4ec2ad390870

branch:

https://github.com/tytso/ext4/tree/manual-revert-of-568f27006577

Can you send me a patch which correctly reverts 568f27006577?  I can
try it against -rc1 .. -rc4, whichever is most convenient.

> Can you share the exact mount command line for setup the environment?
> and the exact xfstest item?

It's a variety of mount command lines, since I'm using gce-xfstests[1][2]
using a variety of file system scenarios --- but the basic one, which
is ext4 using the default 4k block size is failing (they all are failing).

[1] https://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

It's also not one consistent xfstests which is failing, but it does
tend to be tests which are loading up the storage stack with a lot of
small random read/writes, especially involving metadata blocks/writes.
(For example, tests which run fsstress.)

Since this reliably triggers for me, and other people running
kvm-xfstests or are running xfstests on their own test environments
aren't seeing it, I'm assuming it must be some kind of interesting
interaction between virtio-scsi, perhaps with how Google Persistent
Disk is behaving (maybe timing related?  who knows?).  Darrick Wong
did say he saw something like it once using Oracle's Cloud
infrastructure, but as far as I know it hasn't reproduced since.  On
Google Compute Engine VM's, it reproduces *extremely* reliably.

I expect that if you were to set up gce-xfstests, get a free GCE
account with the initial $300 free credits, you could run
"gce-xfstests -c ext4/4k -g auto" and it would reproduce within an
hour or so.  (So under a dollar's worth of VM credits, so long as you
notice that it's hung and shut down the VM after gathering debugging
data.)

The instructions are at [2], and the image xfstests-202008311554 in
the xfstests-cloud project is a public copy of the VM test appliance I
was using.

% gcloud compute images describe --project xfstests-cloud xfstests-202008311554
archiveSizeBytes: '1720022528'
creationTimestamp: '2020-09-15T15:09:30.544-07:00'
description: Linux Kernel File System Test Appliance
diskSizeGb: '10'
family: xfstests
guestOsFeatures:
- type: VIRTIO_SCSI_MULTIQUEUE
- type: UEFI_COMPATIBLE
id: '1558420969906537845'
kind: compute#image
labelFingerprint: V-2Qgcxt2uw=
labels:
  blktests: g8a75bed
  e2fsprogs: v1_45_6
  fio: fio-3_22
  fsverity: v1_2
  ima-evm-utils: v1_3_1
  nvme-cli: v1_12
  quota: g13bb8c2
  util-linux: v2_36
  xfsprogs: v5_8_0-rc1
  xfstests: linux-v3_8-2838-geb439bf2
  xfstests-bld: gb5085ab
licenseCodes:
- '5543610867827062957'
licenses:
- https://www.googleapis.com/compute/v1/projects/debian-cloud/global/licenses/debian-10-buster
name: xfstests-202008311554
selfLink: https://www.googleapis.com/compute/v1/projects/xfstests-cloud/global/images/xfstests-202008311554
sourceDisk: https://www.googleapis.com/compute/v1/projects/xfstests-cloud/zones/us-east1-d/disks/temp-xfstests-202008311554
sourceDiskId: '5824762850044577124'
sourceType: RAW
status: READY
storageLocations:
- us

Cheers,

					- Ted

P.S.  As you can see, I can also easily run blktests using this VM
Test Appliance.  If you think it would be helpful for me to try
running one or more of the blktests test groups, I can do that.

I've been focusing on using xfstests mainly because this is my primary
way of running regression tests, and I'm blocked on ext4 testing until
I can figure out this particular problem.  Which is why a proper
revert of 568f27006577 would be extremely helpful, if only so I can
apply that on top of the ext4 git tree temporarily so I can run my
file system regression tests.
