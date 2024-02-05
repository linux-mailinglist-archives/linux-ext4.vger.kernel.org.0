Return-Path: <linux-ext4+bounces-1124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1084A980
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43AC296C1F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3431DFD2;
	Mon,  5 Feb 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiIfOCLI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06A482DC
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173025; cv=none; b=qqdX9oQRKanl9vHMw1LnglGOHuKPkaq0lxCsYXGgwm147x5m1vLD5NdOP9FHld1Ln2OaFu4sUMMD70MFMmCE+cQEhJK/EVF4GcQOMDvvi5xRhMUMn6UBhLsKV9w+HQ7LumpFYthk+RH2wQMr3XH+xW8+TNuZKXCd5Hy7be5BXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173025; c=relaxed/simple;
	bh=P6jsH88dVQl2k3TFc9d+OcA130i51RnnnqPRV/d93e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuMnyTzCACXc0yxdI2K58+QTPKD6n/Uk86+LDd7ykclD6IINLENe0zUgmfOqEyZIWkNZ0dvwwYhLuqorq3SRdOZXHYK9ZVrEGqGBs/lf7/N2t8f1ob0slTd8NAUxWv4KgNLeH3Qf8dTgBpQvPSPc1vV4RrnQ3dS1k0oXMYP7Khk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiIfOCLI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 17:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707173021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V535WHzbvh6MboWD4TxDTfLy8x7b35oNP0njlbHg1zk=;
	b=JiIfOCLIjmghQB2/CUlA7W2pLqdUiodJw3BZU+55tegre6WClntaDJCqreOVaTg3RZfiiS
	BAefit8hMaAo0SDdyTkpFdUU/f21bePCfTWhVTRwTuYSKNH+IGHA0XgOrJTXcJFiGYqFII
	R9U8+Irfl61FbMKOxlZJAbLu6/8mwug=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205222732.GO616564@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
> On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> > Add a new ioctl for getting the sysfs name of a filesystem - the path
> > under /sys/fs.
> > 
> > This is going to let us standardize exporting data from sysfs across
> > filesystems, e.g. time stats.
> > 
> > The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
> > where the sysfs identifier may be a UUID (for bcachefs) or a device name
> > (xfs).
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/ioctl.c              | 17 +++++++++++++++++
> >  include/linux/fs.h      |  1 +
> >  include/uapi/linux/fs.h |  5 +++++
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 858801060408..cb3690811d3d 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
> >  	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> >  }
> >  
> > +static int ioctl_getfssysfsname(struct file *file, void __user *argp)
> 
> ackpthspacesplease.
> 
> "ioctl_get_fs_sysfs_name"?

It did feel a bit trolling writing that :)

> 
> > +{
> > +	struct super_block *sb = file_inode(file)->i_sb;
> > +
> > +	if (!strlen(sb->s_sysfs_name))
> > +		return -ENOIOCTLCMD;
> > +
> > +	struct fssysfsname u = {};
> > +
> > +	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);
> 
> Does this actually guarantee that there will be a trailing null in the
> output?  It's really stupid that GETFSLABEL can return an unterminated
> string if the label is exactly the size of the char array.

It's snprintf, so yes.

(queue another "why are we using raw char arrays everywhere in 2024"
rant, I have to double check this stuff too).

> 
> > +
> > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > +}
> > +
> >  /*
> >   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
> >   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> > @@ -861,6 +875,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >  	case FS_IOC_GETFSUUID:
> >  		return ioctl_getfsuuid(filp, argp);
> >  
> > +	case FS_IOC_GETFSSYSFSNAME:
> 
> File System Ioctl Get File System System File System Name.
> 
> Yuck.
> 
> FS_IOC_GETSYSFSPATH?
> 
> Also, do we want to establish that this works for /sys/fs and
> /sys/kernel/debug at the same time?

Yeah, I'll add a comment to that effect.

> 
> > +		return ioctl_getfssysfsname(filp, argp);
> > +
> >  	default:
> >  		if (S_ISREG(inode->i_mode))
> >  			return file_ioctl(filp, cmd, argp);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index ff41ea6c3a9c..7f23f593f17c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1258,6 +1258,7 @@ struct super_block {
> >  	char			s_id[32];	/* Informational name */
> >  	uuid_t			s_uuid;		/* UUID */
> >  	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
> > +	char			s_sysfs_name[UUID_STRING_LEN + 1];
> >  
> >  	unsigned int		s_max_links;
> >  
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 0389fea87db5..6dd14a453277 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -78,6 +78,10 @@ struct fsuuid2 {
> >  	__u8        fsu_uuid[16];
> >  };
> >  
> > +struct fssysfsname {
> > +	__u8			name[64];
> > +};
> > +
> >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
> >  #define FILE_DEDUPE_RANGE_SAME		0
> >  #define FILE_DEDUPE_RANGE_DIFFERS	1
> > @@ -231,6 +235,7 @@ struct fsxattr {
> >  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> >  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> >  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> > +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
> 
> 0x94 is btrfs, don't add things to their "name" space.

Can we please document this somewhere!?

What, dare I ask, is the "namespace" I should be using?

