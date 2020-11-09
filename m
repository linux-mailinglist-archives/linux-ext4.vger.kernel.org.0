Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3132AC6A2
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 22:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgKIVIb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 16:08:31 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55818 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgKIVIb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Nov 2020 16:08:31 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 54FE93A9BEC;
        Tue, 10 Nov 2020 08:08:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kcEOl-009S69-Nj; Tue, 10 Nov 2020 08:08:23 +1100
Date:   Tue, 10 Nov 2020 08:08:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201109210823.GI7391@dread.disaster.area>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
 <20201109192419.GC9695@magnolia>
 <20201109202705.GZ29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109202705.GZ29778@kitsune.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=8nJEP1OIZ-IA:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=CQYWRiYaPWfilY99f3kA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 09, 2020 at 09:27:05PM +0100, Michal Suchánek wrote:
> On Mon, Nov 09, 2020 at 11:24:19AM -0800, Darrick J. Wong wrote:
> > On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> > > xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> > > options.
> > > 
> > > Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  fs/xfs/xfs_super.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index e3e229e52512..a3b00003840d 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -163,7 +163,7 @@ xfs_fs_show_options(
> > >  		{ XFS_MOUNT_GRPID,		",grpid" },
> > >  		{ XFS_MOUNT_DISCARD,		",discard" },
> > >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> > > +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
> > 
> > NAK, programs that require DAX semantics for files stored on XFS must
> > call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
> > DAX on xfs" in Documentation/filesystems/dax.txt.
> statx can be used to query S_DAX.  NOTE that only regular files will
> ever have S_DAX set and therefore statx will never indicate that S_DAX
> is set on directories.

Yup, by design.

The application doesn't need to do anything complex to make this
work. If the app wants to use DAX, then it should use
FS_IOC_FS{GS}ETXATTR to always set the on disk per inode DAX flags
for it's data dirs and files, and then STATX_ATTR_DAX will *always*
tell it whether DAX is actively in use at runtime. It's pretty
simple, really.

> The filesystem may not have any files so statx cannot be used.

Really?  The app or installer is about to *write to the fs* and has
all the permissions it needs to modify the contents of the fs. It's
pretty simple to create a tmpdir, set the DAX flag on the tmpdir,
then create a tmpfile in the tmpdir and run STATX_ATTR_DAX on it to
see if DAX is active or not.....

However, keep in mind that from a system design perspective having
the installer detect DAX properties to make application level
install/config decisions is problematic from a lot of different
angles.

- DAX is property of the *block device*, not the filesystem, so the
  filesystem can make arbitrary decisions on whether to use DAX or
  not to access data and these can change at any time without
  warning.

- Some filesystems may not have any user visible signs they are
  using DAX to access data except for STATX_ATTR_DAX because they
  always use DAX and only work on DAX capable block devices. e.g
  NVFS.

- For filesystems where DAX is optional, the user can -always-
  change the dax state of the fs (mount options) or even parts of
  the filesystem (per inode flags) at any time after the installer
  has run.

- The application might be storing it's data on a different
  filesystem that isn't mounted at install time, so the installer
  has no chance of detecting that the application is going to use
  DAX enabled storage.

IOWs, the installer cannot make decisions based on DAX state on
behalf of applications because it does not know what environment the
application is going to be configured to run in.  DAX can only be
deteted reliably by the application at runtime inside it's
production execution environment.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
