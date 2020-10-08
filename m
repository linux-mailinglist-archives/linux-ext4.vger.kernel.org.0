Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0C287B3F
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Oct 2020 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgJHRzM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 13:55:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHRzM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 13:55:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098HsSgr096698;
        Thu, 8 Oct 2020 17:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Nk/3rjxspe7OwEEfsoIeBessN6zvaVflVmxVYReRyLI=;
 b=HcW0a1L66hP1M3jPspUJhbBXvFgw+KUZijdi/v8g3LuWNAorKnjApMXuJYFSYKCIEg79
 LN1s9XQers23AKJpAPtjdvXf7GqAckgueCZE8hClBKaqFwM0D0kQQ+cx5nn99OZUE7A8
 Jn/NUEXMQUvFPeE0ItLHI3ozpYy/gTnczP+qAu0LbdLsiForpDLI5sGM0oX9mx0aszKJ
 K1mt+W8YOgNyf1y/2BdE8qxB+3Z4ze7wmv2kKPtmEj1WEsrX4P+JEgLIAueLsqLnXaEO
 mqKQTnb+X2ycp93BxBhH707DRVvEIauSirx4Ccokb2tcTC0qv4wLr9BZKKIavo6lnc0c Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33xetb9a88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 17:55:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098HsxZf006319;
        Thu, 8 Oct 2020 17:54:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3410k1frgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 17:54:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 098HsoGZ025901;
        Thu, 8 Oct 2020 17:54:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 10:54:49 -0700
Date:   Thu, 8 Oct 2020 10:54:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201008175448.GA6532@magnolia>
References: <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008021017.GD235506@mit.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=5 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=5 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080131
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 07, 2020 at 10:10:17PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Oct 07, 2020 at 01:14:24PM -0700, Josh Triplett wrote:
> > 
> > That sounds like a conversation that would have been a lot more
> > interesting and enjoyable if it hadn't started with "can we shoot it in

This whole conversation would have been a lot less tense and defensive
had I not started by thinking "Did Ted quietly slip more meaning into
SHARED_BLOCKS (i.e. shared metadata blocks) than I had previously known
about?" and then "No, e2fsprogs is still the same as it always was" and
finally "OH, Josh wrote some weird userspace tool that we've never heard
of which makes design assumptions that he's being cagey about".

To reiterate what Ted said: General purpose filesystems are massively
complex beasts.  The kernel can do simple spot checks (checksums, record
validation) but at least with XFS and ext4, we defer the larger
relational checks between data structures (if this block is marked free,
is it unclaimed by the inode table and all file block maps?) to
userspace fsck.

IMO, the prominent free software filesystem projects offer (at least)
four layers of social structures to keep everyone on the same page,
including people writing competing implementations.  The first is "Does
everything we write still work with the kernel", which I guess you
clearly did since you're complaining about this change in 5.9-rc2.

The second layer is "Does it pass fsck?" which, given that you're asking
for changes to e2fsck elsewhere in this thread and I couldn't figure out
how to generate a shared-bitmaps ext4 fs that didn't also cause e2fsck
to complain about the overlap doesn't make me confident that you went
beyond the first step before shipping something.

The third layer is consulting the ondisk format documentation to see if
it points out anything that the kernel or fsck didn't notice.  That
one's kind of on Ted for not updating Documentation/ to spell out what
SHARED_BLOCKS actually means, but that just leads me to the fourth thing.

The fourth layer is emailing the list to ask "Hey, I was thinking of
___, does anyone see a problem with my interpretation?".  That clearly
hasn't been done for shared bitmaps until now, which is all the more
strange since you /did/ ask linux-ext4 about the inline data topic
months ago.

ext* and XFS have been around for 25 years.  The software validation of
both is imperfect and incomplete because the complexity of the ondisk
formats is vast and we haven't caught up with the technical debt that
resulted from not writing rigorous checks that would have been very
difficult with mid-90s hardware.  I know, because I've been writing
online checking for XFS and have seen the wide the gap between what the
existing software looks for and what the ondisk format documentation
allows.

The only chance that we as a community have at managing the complexity
of a filesystem is to use those four tools I outlined above to try to
keep the mental models of everyone who participates in close enough
alignment.  That's how we usually avoid discussions that end in rancor
and confusion.

That was a very long way of reiterating "If you're going to interpret
aspects of the software, please come talk to us before you start writing
code".  That is key to ext4's long history of compatibility, because a
project cannot maintain continuity when actors develop conflicting code
in the shadows.  Look at all the mutations FAT and UFS that have
appeared over the years-- the codebases became a mess as a result.

> > the head", and continued with the notion that anything other than
> > e2fsprogs making something to be mounted by mount(2) and handled by
> > fs/ext4 is being "inflicted", and if the goal didn't still seem to be
> > "how do we make it go away so that only e2fsprogs and the kernel ever
> > touch ext4". I started this thread because I'd written some userspace
> > code, a new version of the kernel made that userspace code stop working,
> > so I wanted to report that the moment I'd discovered that, along with a
> > potential way to address it with as little disrupton to ext4 as
> > possible.

Ted: I don't think it's a good idea to make SHARED_BLOCKS disable block
validity checking by default.  You could someday enable users to write
to block-sharing files by teaching ext4 how to COW, at which point you'd
need correct bitmaps and block validity to prevent accidental overwrite
of critical metadata.  At that point you'd either be stuck with the
precedent that SHARED_BLOCKS implies noblock_validity, or you'd end up
breaking Josh's images again.

Frankly, Josh, if you're not going to show us /your/ code and/or
creating an incompat flag for shared-bitmaps, then just set
"noblock_validity" in the superblock mount options field of the images
you create.

--D

> What is really getting my dander up is your attempt to claim that the
> on-disk file system format is like the userspace/kernel interface,
> where if we break any file system that file system that was
> "previously accepted by an older kernel", this is a bug that must be
> reverted or otherwise fixed to allow file systems that had previously
> worked, to continue to work.  And this is true even if the file system
> is ***invalid***.
> 
> And the problem with this is that there have been any number of
> commits where file systems which were previously invalid, but which
> could be caused to trigger a syzbot whine, which was fixed by
> tightening up the validity tests in the kernel.  In some cases, I had
> to also had to fix up e2fsck to detect the invalid file system which
> was generated by the file system fuzzer.  Yes, it's unfortunate that
> we didn't have these checks earlier, but a file system has a huge
> amount of state.
> 
> The principle you've articulated would make it impossible for me to
> fix these bugs, unless I can prove that the failure to check a
> particular invalid file system corruption could lead to a security
> vulnerability.  (Would it be OK for me to make the kernel more strict
> and reject an invalid file system if it triggers a WARN_ON, so I get
> the syzbot complaint, but it doesn't actually cause a security issue?)
> 
> So this conversation would have been a lot more pleasant for *me* if
> you hadn't tried to elevate your request to a general principle, where
> if someone is deliberately generating an invalid file system, I'm not
> allowed to make the kernel more strict to detect said invalidity and
> to reject the invalid / corrupted / fuzzed file system.
> 
> And note that sometimes the security problem happens when there are
> multiple file system corruptions that are chained together.  So
> enabling block validity *can* sometimes prevent the fuzzed file system
> from proceeding further.  Granted, this is less likely in the case of
> a read-only file system, but it really worries me when there are
> proprietary programs (maybe your library isn't proprietary, but I note
> you haven't send me a link to your git repo, but instead have offered
> sending sample file systems) which insist on generating their own file
> systems, which might or might not be valid, and then expecting them to
> receive first class support as part of an iron-bound contract where
> I'm not even allowed to add stronger sanity checks which might reject
> said invalid file system in the future.
> 
> > The short version is that I needed a library to rapidly turn
> > dynamically-obtained data into a set of disk blocks to be served
> > on-the-fly as a software-defined disk, and then mounted on the other
> > side of that interface by the Linux kernel. Turns out that's *many
> > orders of magnitude* faster than any kind of network filesystem like
> > NFS. It's slightly similar to a vvfat for ext4. The less blocks it can
> > generate and account for and cache, the faster it can run, and
> > microseconds matter.
> 
> So are you actually trying to dedup data blocks, or are you just
> trying to avoid needing to track the block allocation bitmaps?  And
> are you just writing a single file, or multiple files?  Do you know
> what the maximum size of the file or files will be?  Do you need a
> complex directory structure, or just a single root directory?  Can the
> file system be sparse?
> 
> So for example, you can do something like this, which puts all of the
> metadata at beginning of the file system, and then you could write to
> contiguous data blocks.  Add the following in mke2fs.conf:
> 
> [fs_types]
>     hugefile = {
>         features = extent,huge_file,bigalloc,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
>         cluster_size = 32768
>         hash_alg = half_md4
>         reserved_ratio = 0.0
>         num_backup_sb = 0
>         packed_meta_blocks = 1
>         make_hugefiles = 1
>         inode_ratio = 4194304
>         hugefiles_dir = /storage
>         hugefiles_name = huge-file
>         hugefiles_digits = 0
>         hugefiles_size = 0
>         hugefiles_align = 256M
>         hugefiles_align_disk = true
>         num_hugefiles = 1
>         zero_hugefiles = false
> 	inode_size = 128
>     }
> 
>    hugefiles = {
>         features = extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
>         hash_alg = half_md4
>         reserved_ratio = 0.0
>         num_backup_sb = 0
>         packed_meta_blocks = 1
>         make_hugefiles = 1
>         inode_ratio = 4194304
>         hugefiles_dir = /storage
>         hugefiles_name = chunk-
>         hugefiles_digits = 5
>         hugefiles_size = 4G
>         hugefiles_align = 256M
>         hugefiles_align_disk = true
>         zero_hugefiles = false
>         flex_bg_size = 262144
> 	inode_size = 128
>     }
> 
> ... and then run "mke2fs -T hugefile /tmp/image 1T" or "mke2fs -T
> hugefiles /tmp/image 1T", and see what you get.  In the case of
> hugefile, you'll see a single file which covers the entire storage
> device.  Because we are using bigalloc with a large cluster size, this
> minimizes the number of bitmap blocks.
> 
> With hugefiles, it will create a set of 4G files to fill the size of
> the disk, again, aligned to 256 MiB zones at the beginning of the
> disk.  In both cases, the file or files are aligned to 256 MiB
> relative to beginning of the disk, which can be handy if you are
> creating the file system, on, say, a 14T SMR disk.  And this is a
> niche use case if there ever was one!  :-)
> 
> So if you had come to the ext4 list with a set of requirements, it
> could have been that we could have come up with something which uses
> the existing file system features, or come up with something which
> would have been more specific --- and more importantly, we'd know what
> the semantics were of various on-disk file system formats that people
> are depending upon.
> 
> > If at some point I'm looking to make ext4 support more than it already
> > does (e.g. a way to omit bitmaps entirely, or a way to express
> > contiguous files with smaller extent maps, or other enhancements for
> > read-only filesystems),
> 
> See above for a way to significantly reduce the number of bitmaps.
> Adding a way to omit bitmaps entirely would require an INCOMPAT flag,
> so it might not be worth it.
> 
> The way to express contiguous files with smaller extent files would be
> to extend the kernel to allow file systems with block_size > page_size
> read-only.  This would allow you to create a file system with a block
> size of 64k, which will reduce the size of the extent maps by a factor
> of 16, and it wouldn't be all that hard to teach ext4 to support these
> file systems.  (The reason why it would be hard for us to support file
> systems with block sizes > page size is dealing with page cache when
> writing files while allocating blocks, especially when doing random
> writes into a sparse file.  Read-only would be much easier to
> support.)
> 
> So please, talk to us, and *tell* us what it is you're trying to do
> before you try to do it.  Don't rely on some implementation detail
> where we're not being sufficiently strict in checking for an invalid
> file system, especially without telling us in advance and then trying
> to hold us to the lack of checking forever because it's "breaking
> things that used to work".
> 
> Cheers,
> 
> 					- Ted
