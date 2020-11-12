Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613382AFE65
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 06:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgKLFhv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 00:37:51 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47170 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbgKLBuA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Nov 2020 20:50:00 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9861458B977;
        Thu, 12 Nov 2020 12:49:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kd1kG-00ADL6-Sy; Thu, 12 Nov 2020 12:49:52 +1100
Date:   Thu, 12 Nov 2020 12:49:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201112014952.GL7391@dread.disaster.area>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
 <20201109192419.GC9695@magnolia>
 <20201109202705.GZ29778@kitsune.suse.cz>
 <20201109210823.GI7391@dread.disaster.area>
 <20201111102848.GD29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111102848.GD29778@kitsune.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=8nJEP1OIZ-IA:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=VtnXJFtyVPRg2aRurhEA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 11, 2020 at 11:28:48AM +0100, Michal Suchánek wrote:
> On Tue, Nov 10, 2020 at 08:08:23AM +1100, Dave Chinner wrote:
> > On Mon, Nov 09, 2020 at 09:27:05PM +0100, Michal Suchánek wrote:
> > > On Mon, Nov 09, 2020 at 11:24:19AM -0800, Darrick J. Wong wrote:
> > > > On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> > > > > xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> > > > > options.
> > > > > 
> > > > > Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > >  fs/xfs/xfs_super.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > > index e3e229e52512..a3b00003840d 100644
> > > > > --- a/fs/xfs/xfs_super.c
> > > > > +++ b/fs/xfs/xfs_super.c
> > > > > @@ -163,7 +163,7 @@ xfs_fs_show_options(
> > > > >  		{ XFS_MOUNT_GRPID,		",grpid" },
> > > > >  		{ XFS_MOUNT_DISCARD,		",discard" },
> > > > >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > > > > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> > > > > +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
> > > > 
> > > > NAK, programs that require DAX semantics for files stored on XFS must
> > > > call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
> > > > DAX on xfs" in Documentation/filesystems/dax.txt.
> > > statx can be used to query S_DAX.  NOTE that only regular files will
> > > ever have S_DAX set and therefore statx will never indicate that S_DAX
> > > is set on directories.
> > 
> > Yup, by design.
> > 
> > The application doesn't need to do anything complex to make this
> > work. If the app wants to use DAX, then it should use
> > FS_IOC_FS{GS}ETXATTR to always set the on disk per inode DAX flags
> > for it's data dirs and files, and then STATX_ATTR_DAX will *always*
> > tell it whether DAX is actively in use at runtime. It's pretty
> > simple, really.
> > 
> > > The filesystem may not have any files so statx cannot be used.
> > 
> > Really?  The app or installer is about to *write to the fs* and has
> > all the permissions it needs to modify the contents of the fs. It's
> > pretty simple to create a tmpdir, set the DAX flag on the tmpdir,
> > then create a tmpfile in the tmpdir and run STATX_ATTR_DAX on it to
> > see if DAX is active or not.....
> 
> Have you ever seen a 'wizard' style installer?

I wrote my first one in 1995 on Windows NT 3.51 using Installshield.

> Like one that firsts asks what to install, and then presents a list of
> suitable locations that have enough space, supported filesystem features
> enabled, and whatnot?

Hold on, 1995 is calling me. The application I was packaging used
ACLs. But the NTFS version created by windows NT 3.1 was
incompatible as ACL support didn't arrive until NT 3.51 and service
pack 4(?) for NT 3.1. Yes, I had to write code to probe the
filesystems to detect whether ACL support was available or not by
-trying to create an ACL-.

I guess you could say "been there, done that, learnt the lesson".

> So to present a list of mountpoints that support DAX one has to scribble
> over every mountpoint on the system?

If you are filtering storage options presented to the user by
supported features, then you have to probe for them in some way.
And that means you have to consider that many option filesystem
features that applications use cannot be detected via mount options
checking the filesytem config. That is, there are features that can
only be discovered by actually testing whether they work or not.

> That sounds ridiculous.

Reality is a harsh mistress. :/

[snip the rest because you're being ridiculous]

Are you aware of ndctl?

$ ndctl list
[
  {
    "dev":"namespace1.0",
    "mode":"fsdax",
    "map":"mem",
    "size":8589934592,
    "sector_size":512,
    "blockdev":"pmem1"
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"mem",
    "size":8589934592,
    "sector_size":512,
    "blockdev":"pmem0"
  }
]

Oh, look there are two block devices on this machine that are
configured for filesystem DAX (fsdax). They are /dev/pmem0 and
/dev/pmem1.

What filesytsems are on them?

$ lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT /dev/pmem0 /dev/pmem1
NAME  SIZE FSTYPE MOUNTPOINT
pmem1   8G ext4   /mnt/test
pmem0   8G xfs    /mnt/scratch
$

One XFs, one ext4, both of which will be using DAX capable unless
the dax=never mount option is set. Which:

$ mount  |grep pmem
/dev/pmem0 on /mnt/scratch type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/pmem1 on /mnt/test type ext4 (rw,relatime)
$

is not set on either mount.

Hence both filesystems at DAX capable and enabled, and should be
presented as options to the user as such.

And all this comes about because DAX is a property of the block
device, not the filesystem. Hence the only time a DAX capable
filesystem on a block device that is DAX capable will not be DAX
capable is if the dax=never is set...

Of course, this is just encoding how existing filesystems behave -
it's not a requirement for future filesytsems so they may use other
mechanisms for enabling/disabling DAX. Which leaves you with the
only reliable mechanism of creating filesystem and checking
statx(STATX_ATTR_DAX)....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
