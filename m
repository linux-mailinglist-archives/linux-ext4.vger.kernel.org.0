Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC50135E77
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 17:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbgAIQi3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 11:38:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54101 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387752AbgAIQi3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 11:38:29 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 009Gc2nI015609
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Jan 2020 11:38:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16BD94207DF; Thu,  9 Jan 2020 11:38:02 -0500 (EST)
Date:   Thu, 9 Jan 2020 11:38:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
Message-ID: <20200109163802.GA33929@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109123427.GD22232@quack2.suse.cz>
 <20200109092142.E90E2A4062@b06wcsmtp001.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 09, 2020 at 02:51:42PM +0530, Ritesh Harjani wrote:
> > Dbench was slightly impacted; I didn't see any real differences with
> > compilebench or postmark.  dioread_nolock did improve fio with
> > sequential reads; which is interesting, since I would have expected
> 
> IIUC, this Seq. read numbers are with --direct=1 & bs=2MB & ioengine=libaio,
> correct?
> So essentially it will do a DIO AIO sequential read.

Correct.

>In this run, was encryption or fsverity enabled?
>If yes then in that case I see that ext4_dio_supported() will return
>false and it will fallback to bufferedRead.

No, there was no encryption or fsverity enabled.  These runs were pure
stock ext4, with no additional features or mount options other than
the defaults --- and in the case of the dioread_nolock runs, just the
dioread_nolock mount option was added.


On Thu, Jan 09, 2020 at 01:34:27PM +0100, Jan Kara wrote:
> > 
> > I started running some performance runs last night, and the
> 
> Thanks for the numbers! What is the difference between 'default-1' and
> 'default-2' configurations (and similarly between dioread_nolock-1 and -2
> configurations)?

default-1 and default-2 are two runs using the default mke2fs and ext4
mount options.  So 4k blocks, no encryption, no fs-verity, delayed
allocation, and the kernel version includes the inode locking patches,
but not the dio overwrite patch (that's for the next merge window, and
this was 5.5-rc3).

dioread-1 and dioread-2 are two runs with the exact same file system,
the same VM and PD.  The file system would have been slightly aged
since I did not recreate the file system between each of the four
runs.

File system aging might be explain some of the differences; the other
possbility is some kind of differences caused by differing amounts of
CPU and network availability on the host system (which could have
affected the Persistent Disk performance).  GCE does try to provide
enough isolation and throttling however, and the outliers are
generally in the positive, not negative direction, so I don't *think*
it's caused by host loading issues, but I can't 100% rule it out.

One of the things PTS does do is to increase the number of runs until
the standard deviation drops below some percentage (4 or 5%, I think).
In particular, I've noticed that fsmark sometimes require quite a few
runs before the results fall within that criteria.  So it's quite
possible that the fs-mark variations might have been luck.  That's one
of the reasons why I performed multiple runs, was to try to see if
that was what was going on.

> >  dioread_nolock did improve fio with
> > sequential reads; which is interesting, since I would have expected
> > with the inode_lock improvements, there shouldn't have been any
> > difference.  So that may be a bit of wierdness that we should try to
> > understand.
> 
> Yes, this is indeed strange. I don't see anything the DIO read path where
> dioread_nolock would actually still matter.

The fio runs do tend to be pretty stable, and generally only require
PTS to performe 3 runs to get stable results.  That's why the
variations and differences found when doing runs with and without
dioread_nolock were *very* unexpected.

						- Ted
