Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7728808F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgJIC4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 22:56:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgJIC4b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 22:56:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0992sjaS037370;
        Fri, 9 Oct 2020 02:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CHRaVO0CBgjMwUyrji7MhS3Dy5p/8MF1KBRXQcNeNC4=;
 b=WOHHXRZ/QANNC0rZ57She5vYbrZfAayTUfewsX1Xi8cHKEXgl+8nogC+TI0wvcdIJMuP
 k8kbvy6Zuz6dEdtvBsq52cV6zg0VRh+t9VKW7f9QRqrX30iOFj5ujJ6dlxnHlSyr4lHH
 fIj/7xgxHOhbWE+/z1f7VmhuCVJYqb3MwCcp3ESMug8SPu/n/DxKanZURxRW3bUDy8AJ
 FlpH9p8ij4A9A4rjcCh4vCnRwukzhOfjWIeSKBrYWJo3IhYtJtsl22ZdFIbInxLNbXEF
 QJgRl3EHw34LOqv9fzWPGwdFOSenhNeFkdZM0BK/DTmvocTMEZYbeoljCbbcABZVBh3x RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3429jus623-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 02:56:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0992ovNp004198;
        Fri, 9 Oct 2020 02:54:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3429kas4dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 02:54:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0992sBlO028634;
        Fri, 9 Oct 2020 02:54:11 GMT
Received: from localhost (/10.159.154.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 19:54:11 -0700
Date:   Thu, 8 Oct 2020 19:54:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201009025409.GB6532@magnolia>
References: <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008175448.GA6532@magnolia>
 <20201008223858.GC45658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008223858.GC45658@localhost>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090020
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 03:38:58PM -0700, Josh Triplett wrote:
> On Thu, Oct 08, 2020 at 10:54:48AM -0700, Darrick J. Wong wrote:
> > IMO, the prominent free software filesystem projects offer (at least)
> > four layers of social structures to keep everyone on the same page,
> > including people writing competing implementations.
> 
> (I certainly hope that this isn't a *competing* implementation. It's
> more that it serves a different purpose than the existing tools.)

I hope so too, but external implementations tend to have staying power
once people starting using them.  You'd think e2fsdroid would have been
merged into mke2fs by now, but no...

> > The first is "Does
> > everything we write still work with the kernel", which I guess you
> > clearly did since you're complaining about this change in 5.9-rc2.
> 
> Right.
> 
> > The second layer is "Does it pass fsck?" which, given that you're asking
> > for changes to e2fsck elsewhere in this thread and I couldn't figure out
> > how to generate a shared-bitmaps ext4 fs that didn't also cause e2fsck
> > to complain about the overlap doesn't make me confident that you went
> > beyond the first step before shipping something.
> 
> I did ensure that, other than the one top-level complaint that the
> bitmaps overlapped, I got no complaints from e2fsck. I also confirmed
> that with a patch to that one item, e2fsck passed with no issues.

<cough> even a single top level complaint still means it doesn't pass.

> > The third layer is consulting the ondisk format documentation to see if
> > it points out anything that the kernel or fsck didn't notice.  That
> > one's kind of on Ted for not updating Documentation/ to spell out what
> > SHARED_BLOCKS actually means, but that just leads me to the fourth thing.
> 
> I've been making *extensive* use of Documentation/filesystems/ext4 by
> the way, and I greatly appreciate it. I know you've done a ton of work
> in that area.
> 
> > The fourth layer is emailing the list to ask "Hey, I was thinking of
> > ___, does anyone see a problem with my interpretation?".  That clearly
> > hasn't been done for shared bitmaps until now, which is all the more
> > strange since you /did/ ask linux-ext4 about the inline data topic
> > months ago.
> 
> That one was on me, you're right. Because Ted is the maintainer of
> e2fsprogs in Debian, and conversations about ext4 often happen in the
> Debian BTS, reporting a bug on e2fsprogs there felt like starting an
> upstream conversation. That was my mistake; in the future, I'll make
> sure that things make it to linux-ext4. I already did so for
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=971014 , and I
> *should* have gone back and done so for the shared bitmap blocks issue.

<nod> Thanks.

> > ext* and XFS have been around for 25 years.  The software validation of
> > both is imperfect and incomplete because the complexity of the ondisk
> > formats is vast and we haven't caught up with the technical debt that
> > resulted from not writing rigorous checks that would have been very
> > difficult with mid-90s hardware.  I know, because I've been writing
> > online checking for XFS and have seen the wide the gap between what the
> > existing software looks for and what the ondisk format documentation
> > allows.
> > 
> > The only chance that we as a community have at managing the complexity
> > of a filesystem is to use those four tools I outlined above to try to
> > keep the mental models of everyone who participates in close enough
> > alignment.  That's how we usually avoid discussions that end in rancor
> > and confusion.
> > 
> > That was a very long way of reiterating "If you're going to interpret
> > aspects of the software, please come talk to us before you start writing
> > code".  That is key to ext4's long history of compatibility, because a
> > project cannot maintain continuity when actors develop conflicting code
> > in the shadows.  Look at all the mutations FAT and UFS that have
> > appeared over the years-- the codebases became a mess as a result.
> 
> Understood, agreed, and acknowledged. I'll make sure that any future
> potentially "adventurous" filesystem experiments get discussed on
> linux-ext4 first, not just in a distro bugtracker with a limited
> audience.
> 
> > > > the head", and continued with the notion that anything other than
> > > > e2fsprogs making something to be mounted by mount(2) and handled by
> > > > fs/ext4 is being "inflicted", and if the goal didn't still seem to be
> > > > "how do we make it go away so that only e2fsprogs and the kernel ever
> > > > touch ext4". I started this thread because I'd written some userspace
> > > > code, a new version of the kernel made that userspace code stop working,
> > > > so I wanted to report that the moment I'd discovered that, along with a
> > > > potential way to address it with as little disrupton to ext4 as
> > > > possible.
> > 
> > Ted: I don't think it's a good idea to make SHARED_BLOCKS disable block
> > validity checking by default.  You could someday enable users to write
> > to block-sharing files by teaching ext4 how to COW, at which point you'd
> > need correct bitmaps and block validity to prevent accidental overwrite
> > of critical metadata.  At that point you'd either be stuck with the
> > precedent that SHARED_BLOCKS implies noblock_validity, or you'd end up
> > breaking Josh's images again.
> 
> That's a fair point (though I think a writable COW version of
> SHARED_BLOCKS would need a different flag). It'd make more sense to key
> this logic off of RO_COMPAT_READONLY or similar. But even better:

It wouldn't require a new flag -- "rocompat" features bits mean that
"it's safe to allow userspace to read files off the disk if software
doesn't recognize this feature bit".

We're (ab)using the "doesn't recognize" part of that sentence, since the
kernel doesn't recognize RO_COMPAT_READONLY (or SHARED_BLOCKS) when it
compares the superblock ro compat field to EXT4_FEATURE_RO_COMPAT_SUPP.
It therefore only allows reading files.

If someone /did/ add the code to write to files safely in the presence
of shared blocks, all they'd have to do to light up the functionality is
add it to the _SUPP define.  Also, it's strange that the kernel source
doesn't even know of SHARED_BLOCKS, but that's also on Ted...

> > "noblock_validity" in the superblock mount options field of the images
> > you create.
> 
> Yeah, I can do that. That's a much better solution, thank you. It would
> have been problematic to have to change the userspace that mounts the
> filesystem to pass new mount options ("noblock_validity") for the new
> kernel. But if I can embed it in the filesystem, that'll work.
> 
> I'll do that, and please feel free to drop the original proposed patch
> as it's no longer needed. Thanks, Darrick.

NP.

--D

> 
> - Josh Triplett
