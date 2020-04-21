Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C931B318B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDUVGQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 17:06:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:28010 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVGQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 17:06:16 -0400
IronPort-SDR: lOhI0e8OcXG212Kq0E0NuZhH3vLTKYq5qgiCXMVQR54xFNZ78zjQFBShZvKjIsvjawu1DreW3C
 onaJLfqrUfqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:06:14 -0700
IronPort-SDR: 2CCZkszox3eLfft6skKgsMLCysekRUQChTi8gMQDFijz0K7gNcG2u2vyC9DV8GUDk75cR7sPbU
 ogHM84hCGDZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="291722870"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2020 14:06:14 -0700
Date:   Tue, 21 Apr 2020 14:06:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     ira.weiny@intel.comg, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 05/11] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200421210613.GA3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-6-ira.weiny@intel.com>
 <20200421201641.GA6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421201641.GA6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 21, 2020 at 01:16:41PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 21, 2020 at 12:17:47PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> > continues to operate the same.  We add 'always', 'never', and 'inode'
> > (default).
> > 
> > [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v8:
> > 	Move NEVER bit to 27
> > 	Use xfs signature style
> > 	use xfs_dax_mode enum
> > 
> > Changes from v7:
> > 	Change to XFS_MOUNT_DAX_NEVER
> > 
> > Changes from v6:
> > 	Use 2 flag bits rather than a field.
> > 	change iflag to inode
> > 
> > Changes from v5:
> > 	New Patch
> > ---
> >  fs/xfs/xfs_mount.h |  1 +
> >  fs/xfs/xfs_super.c | 51 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index f6123fb0113c..37bfb50db809 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -238,6 +238,7 @@ typedef struct xfs_mount {
> >  						   allocator */
> >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> >  #define XFS_MOUNT_DAX_ALWAYS	(1ULL << 26)
> > +#define XFS_MOUNT_DAX_NEVER	(1ULL << 27)
> >  
> >  /*
> >   * Max and min values for mount-option defined I/O
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index ce169d1c7474..0d0f74786799 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -47,6 +47,39 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
> >  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
> >  #endif
> >  
> > +enum xfs_dax_mode {
> > +	XFS_DAX_INODE = 0,
> > +	XFS_DAX_ALWAYS = 1,
> > +	XFS_DAX_NEVER = 2,
> > +};
> > +
> > +static void
> > +xfs_mount_set_dax_mode(
> > +	struct xfs_mount *mp,
> > +	enum xfs_dax_mode mode)
> 
> Indent between the type name and the variable name, please.
> 
> static void
> xfs_mount_set_dax_mode(
> 	struct xfs_mount	*mp,
> 	enum xfs_dax_mode	mode)

Done.

> 
> > +{
> > +	switch (mode) {
> > +		case XFS_DAX_INODE:
> > +			mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
> > +			break;
> > +		case XFS_DAX_ALWAYS:
> > +			mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> > +			mp->m_flags &= ~XFS_MOUNT_DAX_NEVER;
> > +			break;
> > +		case XFS_DAX_NEVER:
> > +			mp->m_flags |= XFS_MOUNT_DAX_NEVER;
> > +			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> > +			break;
> 
> You can skip one level of indentation, e.g.
> 
> 	switch (mode) {
> 	case XFS_DAX_INODE:
> 		mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
> 		break;

done.

> 
> > +	}
> > +}
> > +
> > +static const struct constant_table dax_param_enums[] = {
> > +	{"inode",	XFS_DAX_INODE },
> > +	{"always",	XFS_DAX_ALWAYS },
> > +	{"never",	XFS_DAX_NEVER },
> > +	{}
> > +};
> > +
> >  /*
> >   * Table driven mount option parser.
> >   */
> > @@ -59,7 +92,7 @@ enum {
> >  	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
> >  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
> >  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
> > -	Opt_discard, Opt_nodiscard, Opt_dax,
> > +	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
> >  };
> >  
> >  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> > @@ -103,6 +136,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
> >  	fsparam_flag("discard",		Opt_discard),
> >  	fsparam_flag("nodiscard",	Opt_nodiscard),
> >  	fsparam_flag("dax",		Opt_dax),
> > +	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
> >  	{}
> >  };
> >  
> > @@ -129,7 +163,6 @@ xfs_fs_show_options(
> >  		{ XFS_MOUNT_GRPID,		",grpid" },
> >  		{ XFS_MOUNT_DISCARD,		",discard" },
> >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
> >  		{ 0, NULL }
> >  	};
> >  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> > @@ -185,6 +218,13 @@ xfs_fs_show_options(
> >  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
> >  		seq_puts(m, ",noquota");
> >  
> > +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> > +		seq_puts(m, ",dax=always");
> > +	else if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
> > +		seq_puts(m, ",dax=never");
> > +	else
> > +		seq_puts(m, ",dax=inode");
> 
> No need to report dax=inode, since that's the default.

done.

thanks,
Ira

> 
> --D
> 
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1261,7 +1301,10 @@ xfs_fc_parse_param(
> >  		return 0;
> >  #ifdef CONFIG_FS_DAX
> >  	case Opt_dax:
> > -		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> > +		xfs_mount_set_dax_mode(mp, XFS_DAX_ALWAYS);
> > +		return 0;
> > +	case Opt_dax_enum:
> > +		xfs_mount_set_dax_mode(mp, result.uint_32);
> >  		return 0;
> >  #endif
> >  	default:
> > @@ -1468,7 +1511,7 @@ xfs_fc_fill_super(
> >  		if (!rtdev_is_dax && !datadev_is_dax) {
> >  			xfs_alert(mp,
> >  			"DAX unsupported by block device. Turning off DAX.");
> > -			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> > +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> >  		}
> >  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> >  			xfs_alert(mp,
> > -- 
> > 2.25.1
> > 
