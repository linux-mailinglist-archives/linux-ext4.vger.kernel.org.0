Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92CE2AEEBE
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgKKK2v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 05:28:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgKKK2v (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Nov 2020 05:28:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2474EADC1;
        Wed, 11 Nov 2020 10:28:50 +0000 (UTC)
Date:   Wed, 11 Nov 2020 11:28:48 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201111102848.GD29778@kitsune.suse.cz>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
 <20201109192419.GC9695@magnolia>
 <20201109202705.GZ29778@kitsune.suse.cz>
 <20201109210823.GI7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109210823.GI7391@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 10, 2020 at 08:08:23AM +1100, Dave Chinner wrote:
> On Mon, Nov 09, 2020 at 09:27:05PM +0100, Michal Suchánek wrote:
> > On Mon, Nov 09, 2020 at 11:24:19AM -0800, Darrick J. Wong wrote:
> > > On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> > > > xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> > > > options.
> > > > 
> > > > Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >  fs/xfs/xfs_super.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > index e3e229e52512..a3b00003840d 100644
> > > > --- a/fs/xfs/xfs_super.c
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -163,7 +163,7 @@ xfs_fs_show_options(
> > > >  		{ XFS_MOUNT_GRPID,		",grpid" },
> > > >  		{ XFS_MOUNT_DISCARD,		",discard" },
> > > >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > > > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> > > > +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
> > > 
> > > NAK, programs that require DAX semantics for files stored on XFS must
> > > call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
> > > DAX on xfs" in Documentation/filesystems/dax.txt.
> > statx can be used to query S_DAX.  NOTE that only regular files will
> > ever have S_DAX set and therefore statx will never indicate that S_DAX
> > is set on directories.
> 
> Yup, by design.
> 
> The application doesn't need to do anything complex to make this
> work. If the app wants to use DAX, then it should use
> FS_IOC_FS{GS}ETXATTR to always set the on disk per inode DAX flags
> for it's data dirs and files, and then STATX_ATTR_DAX will *always*
> tell it whether DAX is actively in use at runtime. It's pretty
> simple, really.
> 
> > The filesystem may not have any files so statx cannot be used.
> 
> Really?  The app or installer is about to *write to the fs* and has
> all the permissions it needs to modify the contents of the fs. It's
> pretty simple to create a tmpdir, set the DAX flag on the tmpdir,
> then create a tmpfile in the tmpdir and run STATX_ATTR_DAX on it to
> see if DAX is active or not.....

Have you ever seen a 'wizard' style installer?

Like one that firsts asks what to install, and then presents a list of
suitable locations that have enough space, supported filesystem features
enabled, and whatnot?

So to present a list of mountpoints that support DAX one has to scribble
over every mountpoint on the system?

That sounds ridiculous.
> 
> However, keep in mind that from a system design perspective having
> the installer detect DAX properties to make application level
> install/config decisions is problematic from a lot of different
> angles.
> 
> - DAX is property of the *block device*, not the filesystem, so the
>   filesystem can make arbitrary decisions on whether to use DAX or
>   not to access data and these can change at any time without
>   warning.
It is property of the mount point. Device supporting DAX is useless on
its own - the filesystem must support and enable it as well. Filesystem
support on its own is useless - it must be on a device that supports
DAX, has matching block sise, it must be enabled at mount time.

Then don't be surprised that the users use 'creative' ways to determine
the information the kernel chooses to not share with them.
> 
> - Some filesystems may not have any user visible signs they are
>   using DAX to access data except for STATX_ATTR_DAX because they
>   always use DAX and only work on DAX capable block devices. e.g
>   NVFS.
That's broken indeed.
> 
> - For filesystems where DAX is optional, the user can -always-
>   change the dax state of the fs (mount options) or even parts of
>   the filesystem (per inode flags) at any time after the installer
>   has run.
The user can do a lot of thing indeed. They can even unmount the
filesystem.
> 
> - The application might be storing it's data on a different
>   filesystem that isn't mounted at install time, so the installer
>   has no chance of detecting that the application is going to use
>   DAX enabled storage.
> 
> IOWs, the installer cannot make decisions based on DAX state on
> behalf of applications because it does not know what environment the
> application is going to be configured to run in.  DAX can only be
> deteted reliably by the application at runtime inside it's
> production execution environment.
It can check that the mount point is suitable at the time of
installation. Of course, if the system is reconfigured afterwards the
application might fail. However, checking the requirements prior to
installtion still provides valuable feedback to the user. They can be
sure that the system was configured properly.

Thanks

Michal
