Return-Path: <linux-ext4+bounces-1665-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41487D176
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDF1C22853
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6045BE7;
	Fri, 15 Mar 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MgqYNQWp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD263D96E
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521449; cv=none; b=YV0BDQCwe0TUWnK7ErImkZTx4hE0GHVrXnyyYS7Kdc3xN6qRKW9hv5eA5i0FsuJeo9V7OOH6aBX2lEQ3gPIs6beRyZC+KYVhgG7bHXEm7z4z1UAXmKSAMNbpH4uepUmjwN9w8pd8bvPkY2xE3KYFnU850nCTAAagMOkp7b7p3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521449; c=relaxed/simple;
	bh=+1zM7cQOmjEK5zeishajGM7/9lDXdEAF+fHjVpsU/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPw83juz8i5BuoN8BCtNeoXgz1qXDmldpyhaYE4lm/zed8TuNw3GqDIBlX5AXFhPyPWHU/LIh1xZwhq3FXqGmSEp+cTuGDOadtDkmsUyg5lw+FGAxt1WfM9bcV8ZhXEoBXe0G7TfgrBuaahNszfuBdf99rdBxDZa/AxAy3bsUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MgqYNQWp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Mar 2024 12:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710521444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zo40Qzdo/CwJ9JXAYKrTmNI4kAnF/70CKG12hoxZK9Q=;
	b=MgqYNQWpAaz6mM9OZjN7rmNmF0vafWaVA8KED7+Ndu/K95ZiQrE2cVoEeiPFjucxxg9B0O
	kHkPtxxI8ntiXVQcbV04nI979FbHGa3TjPLCSzVc/3CvMb32jpwnTJ214U84SExTcMMovV
	jw+oi871WIej0aScuSii64lkDdON3JM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315164550.GD324770@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 15, 2024 at 12:45:50PM -0400, Theodore Ts'o wrote:
> On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> > the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> > filesystem in a fs agnostic way, potentially nudging us towards
> > standarizing some of our reporting.
> > 
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> >  #endif
> >  	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> > +	super_set_sysfs_name_bdev(sb);
> 
> Should we perhaps be hoisting this call up to the VFS layer, so that
> all file systems would benefit?

I did as much hoisting as I could. For some filesystems (single device
filesystems) the sysfs name is the block device, for the multi device
filesystems I've looked at it's the UUID.

