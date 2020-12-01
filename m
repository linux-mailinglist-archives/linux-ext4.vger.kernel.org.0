Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9C72CA84C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 17:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgLAQaW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 11:30:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgLAQaW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 1 Dec 2020 11:30:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7642FAE93;
        Tue,  1 Dec 2020 16:29:39 +0000 (UTC)
Date:   Tue, 1 Dec 2020 17:29:37 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201201162937.GL27530@kitsune.suse.cz>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
 <20201109192419.GC9695@magnolia>
 <20201109202705.GZ29778@kitsune.suse.cz>
 <20201109210823.GI7391@dread.disaster.area>
 <20201111102848.GD29778@kitsune.suse.cz>
 <20201112014952.GL7391@dread.disaster.area>
 <20201112111217.GF29778@kitsune.suse.cz>
 <20201112151046.GD27697@quack2.suse.cz>
 <20201112160848.GS3976735@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112160848.GS3976735@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 12, 2020 at 08:08:49AM -0800, Ira Weiny wrote:
> On Thu, Nov 12, 2020 at 04:10:46PM +0100, Jan Kara wrote:
> > On Thu 12-11-20 12:12:17, Michal Suchánek wrote:
> > > On Thu, Nov 12, 2020 at 12:49:52PM +1100, Dave Chinner wrote:
> > > > On Wed, Nov 11, 2020 at 11:28:48AM +0100, Michal Suchánek wrote:
> > > > > On Tue, Nov 10, 2020 at 08:08:23AM +1100, Dave Chinner wrote:
> > > > > > On Mon, Nov 09, 2020 at 09:27:05PM +0100, Michal Suchánek wrote:
> > > > > > > On Mon, Nov 09, 2020 at 11:24:19AM -0800, Darrick J. Wong wrote:
> > > > > > > > On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> > > > > > > > > xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> > > > > > > > > options.
> > > > > > > > > 
> > > > > > > > > Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> > > > > > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > > > > > ---
> > > > > > > > >  fs/xfs/xfs_super.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > > > > > > index e3e229e52512..a3b00003840d 100644
> > > > > > > > > --- a/fs/xfs/xfs_super.c
> > > > > > > > > +++ b/fs/xfs/xfs_super.c
> > > > > > > > > @@ -163,7 +163,7 @@ xfs_fs_show_options(
> > > > > > > > >  		{ XFS_MOUNT_GRPID,		",grpid" },
> > > > > > > > >  		{ XFS_MOUNT_DISCARD,		",discard" },
> > > > > > > > >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > > > > > > > > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> > > > > > > > > +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
> 
> I only caught this thread yesterday sorry about that...
> 
> FWIW I think it odd to have this string.  Because what does 'dax,dax=always'
> mean?  dax=always is not the only way the FS can support DAX.  The default
> 'dax=inode' also means the FS supports DAX.  So I'm not sure this is really
> even giving you what you want.
The dax flag which was accepted previously and is still accepted now
means dax=always. It just shows both the old and new form of the flag.
> 
> > > > > > > > 
> > > > > > > > NAK, programs that require DAX semantics for files stored on XFS must
> > > > > > > > call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
> > > > > > > > DAX on xfs" in Documentation/filesystems/dax.txt.
> > > > > > > statx can be used to query S_DAX.  NOTE that only regular files will
> > > > > > > ever have S_DAX set and therefore statx will never indicate that S_DAX
> > > > > > > is set on directories.
> > > > > > 
> > > > > > Yup, by design.
> > > > > > 
> > > > > > The application doesn't need to do anything complex to make this
> > > > > > work. If the app wants to use DAX, then it should use
> > > > > > FS_IOC_FS{GS}ETXATTR to always set the on disk per inode DAX flags
> > > > > > for it's data dirs and files, and then STATX_ATTR_DAX will *always*
> > > > > > tell it whether DAX is actively in use at runtime. It's pretty
> > > > > > simple, really.
> > > > > > 
> > > > > > > The filesystem may not have any files so statx cannot be used.
> > > > > > 
> > > > > > Really?  The app or installer is about to *write to the fs* and has
> > > > > > all the permissions it needs to modify the contents of the fs. It's
> > > > > > pretty simple to create a tmpdir, set the DAX flag on the tmpdir,
> > > > > > then create a tmpfile in the tmpdir and run STATX_ATTR_DAX on it to
> > > > > > see if DAX is active or not.....
> > > > > 
> > > > > Have you ever seen a 'wizard' style installer?
> > > > 
> > > > I wrote my first one in 1995 on Windows NT 3.51 using Installshield.
> 
> I'm confused about this talk of an installer.  If 1 FS supports DAX and the
> other, say 10, do not; what happens when you install something special which
> to support DAX?  But what if the user of that software uses one of the other
> 10 FS's?
> 
> I think it has already been mentioned that the software needs this check at run
> time to be correct.

Sure. The installer is the first part the gets in contact with the
change. There is no point trying to run the application if your system
does not support dax so the installer chacks that early on. I think that
makes sense. You may need to re-format the filesystem with different
block size or other options to enable dax.

> 
> > > > 
> > > > > Like one that firsts asks what to install, and then presents a list of
> > > > > suitable locations that have enough space, supported filesystem features
> > > > > enabled, and whatnot?
> > > > 
> > > > Hold on, 1995 is calling me. The application I was packaging used
> > > > ACLs. But the NTFS version created by windows NT 3.1 was
> > > > incompatible as ACL support didn't arrive until NT 3.51 and service
> > > > pack 4(?) for NT 3.1. Yes, I had to write code to probe the
> > > > filesystems to detect whether ACL support was available or not by
> > > > -trying to create an ACL-.
> > > > 
> > > > I guess you could say "been there, done that, learnt the lesson".
> > > So we are trying to be as bad as Windows now?
> > > > 
> > > > > So to present a list of mountpoints that support DAX one has to scribble
> > > > > over every mountpoint on the system?
> > > > 
> > > > If you are filtering storage options presented to the user by
> > > > supported features, then you have to probe for them in some way.
> > > > And that means you have to consider that many option filesystem
> > > > features that applications use cannot be detected via mount options
> > > > checking the filesytem config. That is, there are features that can
> > > > only be discovered by actually testing whether they work or not.
> > > > 
> > > > > That sounds ridiculous.
> > > > 
> > > > Reality is a harsh mistress. :/
> > > > 
> > > > [snip the rest because you're being ridiculous]
> > > > 
> > > > Are you aware of ndctl?
> > > > 
> > > > $ ndctl list
> > > > [
> > > >   {
> > > >     "dev":"namespace1.0",
> > > >     "mode":"fsdax",
> > > >     "map":"mem",
> > > >     "size":8589934592,
> > > >     "sector_size":512,
> > > >     "blockdev":"pmem1"
> > > >   },
> > > >   {
> > > >     "dev":"namespace0.0",
> > > >     "mode":"fsdax",
> > > >     "map":"mem",
> > > >     "size":8589934592,
> > > >     "sector_size":512,
> > > >     "blockdev":"pmem0"
> > > >   }
> > > > ]
> > > Yes, that tells me that the device can be configured for dax. Not if the
> > > filesystem will use it.
> > > > 
> > > > Oh, look there are two block devices on this machine that are
> > > > configured for filesystem DAX (fsdax). They are /dev/pmem0 and
> > > > /dev/pmem1.
> > > > 
> > > > What filesytsems are on them?
> > > > 
> > > > $ lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT /dev/pmem0 /dev/pmem1
> > > > NAME  SIZE FSTYPE MOUNTPOINT
> > > > pmem1   8G ext4   /mnt/test
> > > > pmem0   8G xfs    /mnt/scratch
> > > > $
> > > > 
> > > > One XFs, one ext4, both of which will be using DAX capable unless
> > > > the dax=never mount option is set. Which:
> > > Or the bock size does not match page size. Or whatever other requirement
> > > the filesystem might have is not met.
> > > > 
> > > > $ mount  |grep pmem
> > > > /dev/pmem0 on /mnt/scratch type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> > > > /dev/pmem1 on /mnt/test type ext4 (rw,relatime)
> > > > $
> > > > 
> > > > is not set on either mount.
> > > > 
> > > > Hence both filesystems at DAX capable and enabled, and should be
> > > > presented as options to the user as such.
> > > No, it is not the case. That is why it would make sense for the kernel
> > > to make the information about DAX availability accessible somewhere.
> 
> But again at run time the software needs to verify it is being asked to operate
> on a FS which supports DAX.  So I don't think what you are proposing is going
> to work all of the time.
If the kernel makes the information available it will be available both
at installation time and runtime. Currently you can only guess.
> 
> > > > 
> > > > And all this comes about because DAX is a property of the block
> > > > device, not the filesystem. Hence the only time a DAX capable
> > > > filesystem on a block device that is DAX capable will not be DAX
> > > > capable is if the dax=never is set...
> > > See, it is not property of the block device. It is property of the mount
> > > point. The availability on the device is one requirement but the
> > > filesystem options affect availability to the user in the end.
> > 
> > No, it is not really a property of the mountpoint either. If anything it is
> > a property of the inode. Two different inodes on the very same filesystem,
> > one may support DAX the other will not (think for example of XFS real-time
> > volumes, or simply inodes with / without S_DAX flag set). And we are back
> > at what Dave tries to get accross. As inconvenient as it is
> > statx(STATX_ATTR_DAX) is the only way to tell.
That's exactly property of the mount point, nothing else. Technically
inside teh kernels it's probably represented as superblock but that's
impleentation detail.

In the case of dax=always all files presumably behave as if they had the
STATX_ATTR_DAX flag set. Ideally the flag should be returned in this
case even if the inode does not really have it.

In the case of dax=inode you can set this flag if
 - the filesystem driver supports it
 - the filesystem block size matches the
 - the user did not use a ount option that changes the default
 - probably a number of other options
Then the user can set STATX_ATTR_DAX but the files don't magically grow
it. Much like with xattrs, acls, and whatnot. Same thing - the
filesystem must suport it, the on-disk format (if any) must be suitable,
the mount options must enable/not disable teh feature.

What problem do you have with telling the user that filesystem mounted
at /foo supports bar?
> > 
> > > > Of course, this is just encoding how existing filesystems behave -
> > > > it's not a requirement for future filesytsems so they may use other
> > > > mechanisms for enabling/disabling DAX. Which leaves you with the
> > > > only reliable mechanism of creating filesystem and checking
> > > > statx(STATX_ATTR_DAX)....
> > > Or the kernel could just tell the user. But right, information is power,
> > > and keeping the user in the dark is much more entertaining.
> > 
> > I think it would be more productive if you actually answered Ted's
> > question: Exactly which application got broken by the change? I know for a
> > fact that one large DB vendor was parsing mount options in /proc/mounts to
> > determine whether their DB can use DAX or not (and this was already a
> > "cleaned up" method because before this they were parsing VMA flags in
> > /proc/<pid>/smaps which is even worse). But in this case they also seemed
> > OK to switch to statx() once it is available...
> 
> I agree.  I struggled over these options and what to present when I added the
> feature and I never intended to break anything.
> 
> That said, I'm not sure what exactly is broken.  Moreover, I'm concerned that
> there may be more wrong here than just the lack of a 'dax' option string in the
> mount.

Indeed, this attitude of not telling the user if a filesystem supports a
feature and leaving the user with weird hacks to detect it sounds wrong,
irrespective of the application involved.

You know, users use these hacks because the kernel won't tell them in a
sane way.

Thanks

Michal
