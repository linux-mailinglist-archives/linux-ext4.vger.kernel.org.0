Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649132AC5EF
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 21:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgKIU1I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 15:27:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:54912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgKIU1I (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 15:27:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 066A4AB95;
        Mon,  9 Nov 2020 20:27:07 +0000 (UTC)
Date:   Mon, 9 Nov 2020 21:27:05 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <20201109202705.GZ29778@kitsune.suse.cz>
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
 <20201109192419.GC9695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109192419.GC9695@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 09, 2020 at 11:24:19AM -0800, Darrick J. Wong wrote:
> On Mon, Nov 09, 2020 at 08:10:08PM +0100, Michal Suchanek wrote:
> > xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> > options.
> > 
> > Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  fs/xfs/xfs_super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index e3e229e52512..a3b00003840d 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -163,7 +163,7 @@ xfs_fs_show_options(
> >  		{ XFS_MOUNT_GRPID,		",grpid" },
> >  		{ XFS_MOUNT_DISCARD,		",discard" },
> >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> > +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
> 
> NAK, programs that require DAX semantics for files stored on XFS must
> call statx to detect the STATX_ATTR_DAX flag, as outlined in "Enabling
> DAX on xfs" in Documentation/filesystems/dax.txt.
statx can be used to query S_DAX.  NOTE that only regular files will
ever have S_DAX set and therefore statx will never indicate that S_DAX
is set on directories.

The filesystem may not have any files so statx cannot be used.

If you reject this method of detection please provide an actual usable
alternative.

Thanks

Michal

> 
> --D
> 
> >  		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
> >  		{ 0, NULL }
> >  	};
> > -- 
> > 2.26.2
> > 
