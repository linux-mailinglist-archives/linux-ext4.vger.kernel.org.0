Return-Path: <linux-ext4+bounces-1130-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7084AD87
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 05:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A32F283AC3
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 04:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE544779F8;
	Tue,  6 Feb 2024 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmAr9XdI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AD79DB0
	for <linux-ext4@vger.kernel.org>; Tue,  6 Feb 2024 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194001; cv=none; b=VHNfDSOlB5ccsf606vhtRX4MVEGjLU1WIA4Dyajjg0rQRQLETPDdoaKAZtqak6pZ/F8qGNz+7v6xV6V5pe186e8DSkWRW/aGoMxh79Y/naMsc+mX2AWkkd/Av7YCw1vXQLIfvITdiqjtyaMkBvG8jH2JmrOyDAy7TikLF8Qz8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194001; c=relaxed/simple;
	bh=3HMlSFSdCDhMO6gJVMf2WLFfrFcJg3v8tdbkDsERj88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcR4eOQ4Pgs5JOJAy3ZVS9BVIlhmTLbAwxTaTkYMxrsttAuI6CI89egbloNzOgCUgd5vHvSjmGtXoE/ZeyVhqyBfpgNOMEcqmS5n0o0qQ5oaG4tM62oW9ee9UQLkZF64+T91r/mq7ZgsJwE2PPyWZavNzCsTzjpcEG+gs8Djwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmAr9XdI; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 23:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707193996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a66pbZwscvarBnD+4+x9Xp+uM49PnGDOy0Ekbd5y6P0=;
	b=xmAr9XdIaiuSbg7G524OdopdZGJnXlahP/PlKK610rUry8vhvI3uRZhnqzBjQHAZpQTp6I
	/r+h+/gVADl7mS675AFIPCt4p/AADQl2Ti8CNyz+h+PJ2+sdCnwTWOBmIyl9tyEylsYrJg
	oo89TNAKpWJqVHcYMTFSzICDl1ARIbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dsterba@suse.cz, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <xutnab3bbeeyp7gq2wwy36lus275d5tapdclmcg5sl7bfngo6a@ek5u4ja56gut>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
 <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
 <20240206013931.GK355@twin.jikos.cz>
 <ca885dd8-4ac1-43a9-9b0c-79b63cae0620@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca885dd8-4ac1-43a9-9b0c-79b63cae0620@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 08:20:10PM -0800, Randy Dunlap wrote:
> 
> 
> On 2/5/24 17:39, David Sterba wrote:
> > On Mon, Feb 05, 2024 at 05:43:37PM -0500, Kent Overstreet wrote:
> >> On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
> >>> On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> >>>> @@ -231,6 +235,7 @@ struct fsxattr {
> >>>>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> >>>>  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> >>>>  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> >>>> +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
> >>>
> >>> 0x94 is btrfs, don't add things to their "name" space.
> >>
> >> Can we please document this somewhere!?
> >>
> >> What, dare I ask, is the "namespace" I should be using?
> > 
> > Grep for _IOCTL_MAGIC in include/uapi:
> > 
> > uapi/linux/aspeed-lpc-ctrl.h:#define __ASPEED_LPC_CTRL_IOCTL_MAGIC 0xb2
> > uapi/linux/aspeed-p2a-ctrl.h:#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> > uapi/linux/bt-bmc.h:#define __BT_BMC_IOCTL_MAGIC        0xb1
> > uapi/linux/btrfs.h:#define BTRFS_IOCTL_MAGIC 0x94
> > uapi/linux/f2fs.h:#define F2FS_IOCTL_MAGIC              0xf5
> > uapi/linux/ipmi_bmc.h:#define __IPMI_BMC_IOCTL_MAGIC        0xB1
> > uapi/linux/pfrut.h:#define PFRUT_IOCTL_MAGIC 0xEE
> > uapi/rdma/rdma_user_ioctl.h:#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
> > uapi/rdma/rdma_user_ioctl_cmds.h:#define RDMA_IOCTL_MAGIC       0x1b
> > 
> > The label ioctls inherited the 0x94 namespace for backward
> > compatibility but as already said, it's the private namespace of btrfs.
> > 
> 
> or more generally, see Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
> For 0x94, it says:
> 
> 0x94  all    fs/btrfs/ioctl.h                                        Btrfs filesystem
>              and linux/fs.h                                          some lifted to vfs/generic

You guys keep giving the same info over and over again, instead of
anything that would be actually helpful...

Does anyone know what the proper "namespace" is for new VFS level
ioctls?

...Anyone?

