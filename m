Return-Path: <linux-ext4+bounces-1486-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F286F810
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC7D1F212A0
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EC15A4;
	Mon,  4 Mar 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="11HHWeVG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1764D
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709513947; cv=none; b=uNoAgYgj3POWit5cuMsLZqi24U87LdLQO8ZTspGubQrfg7hCRrECgKDyLnK2qQd8zKf1mbHPc3pldsy07mVnH1A/LBHXS8PFXPK9JUpJLpB5QZWnEGxNtZkzk9rYCl1wbVAvd6Xa8Z8T2XNxbaJUHYYl/PqCtlCq78zGhnJs340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709513947; c=relaxed/simple;
	bh=vmMzcAfGvCkXbsU8USGSmsMg/wLu5bi0+cC2QoDpiRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHtRW2pq5AW8xXBkgUoIIeqAXkeYJ3kpuXxxBYp86gbDZFoTFXA7Zq7CRBORy4U6BeCF5HkGfsT0VItRB8DOLeHF/wMwsj5ggZG2CaLgisiPdRq6ZxxN12warP1YVLxE0q0L5uMc1poaimpB2dROJiSPg/eXw5FgtzZIPRkwUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=11HHWeVG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da202aa138so2870700b3a.2
        for <linux-ext4@vger.kernel.org>; Sun, 03 Mar 2024 16:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709513945; x=1710118745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC9KIDoqLgnUwNB01EuOkVizIcdw1syIP3iSHYTggAc=;
        b=11HHWeVGMtiGm3XXH0Vfn/JMFnc9ggywk8pI9IplGfwr7vKC80gypd5YZihKxVpsu6
         WYk7OkZrGA8BZeeQ5Gj31kk1G18q2jsF8NsMeoYRJ1Em7UOALZtzlayxKLOJmtkUmff0
         tILr50fW9kNUtDR3gvIfwXwWJJNR02VpalVcGj0Kh1zW38P1U2h+60ihj4oG1S5DLHsj
         ofmbGUee/erq/nZYgZheQRzgBYQsCni7iUjRAczZaJ8BE5svUACG4aKqmhJEDXbGM5Gg
         07xyTRLsRvq4DDNBR7GVGEI5GCTUmfRsKXei/gnEKO4zGZjMY8Srdz2Y4tCnQ4qRp5II
         fgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709513945; x=1710118745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC9KIDoqLgnUwNB01EuOkVizIcdw1syIP3iSHYTggAc=;
        b=jmTJ5Aflvird+dEHgCdEdzU1bzro7D5150DUjaeYNlBGN7RIIoZP3AVuxjG/zisUQo
         X5G8Pcu/pG8E22Bma4OogbDix80BRlIkxz5ULypVECt7HX88a+xlRNuuytaTRkv92xq7
         u7qFEQ2VFn3obact4+Ugzw7oOPW0h86gTBrXqm1XwE0AV+KdvAtzdIECZ9aOwgfyJ9Dc
         EXylSrEoMTQgBuQL/ZYFp1RxoQUfMcHFXXuc9z7RjWmJ76WiCAsBm356/zTuxAntAvky
         2J2X7vK32dimjJFmvjPxC6wWzyVMG1jFp+a4H/HfzjHzn/3/xSYbB+B/P+rri/nUjnQg
         rSxg==
X-Forwarded-Encrypted: i=1; AJvYcCWWbVJZMICQSynLBojkK1dtudQyl7Avl8OV8HyWZMEOjOI52zBWWlkzFge4P8pEVvf53ZsGMPlbVOk4z63rsSUfHiX5fC2GV1Opjg==
X-Gm-Message-State: AOJu0YxGp8B5wQ1pvLcPZfsyHrzYXTOZifDS8/bKhMygcqDzh0Fuf2L9
	paXEPmq0WlUd0z2Bu4PmKHh3kuEqruwg/OXkgdOTPlHrDxAUzbl2so3UkHZCML4=
X-Google-Smtp-Source: AGHT+IG27AYgzFU0Yu0WzNJotu4BKgh15vtk77T5eEn44fkM0aQDIEu49B1W6UpjN5vci2K24FnThA==
X-Received: by 2002:a05:6a21:3288:b0:1a0:9ab5:1e83 with SMTP id yt8-20020a056a21328800b001a09ab51e83mr11526289pzb.24.1709513945314;
        Sun, 03 Mar 2024 16:59:05 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b0029a73913ae8sm7303118pja.40.2024.03.03.16.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 16:59:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rgwfW-00Egjs-0w;
	Mon, 04 Mar 2024 11:59:02 +1100
Date: Mon, 4 Mar 2024 11:59:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] fs: Reserve inode flag FS_ATOMICWRITES_FL for atomic
 writes
Message-ID: <ZeUc1ipKMrh+pOn6@dread.disaster.area>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
 <4c687c1c5322b4eaf0bb173f0b5d58b38fdaa847.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c687c1c5322b4eaf0bb173f0b5d58b38fdaa847.1709361537.git.ritesh.list@gmail.com>

On Sat, Mar 02, 2024 at 01:11:59PM +0530, Ritesh Harjani (IBM) wrote:
> This reserves FS_ATOMICWRITES_FL for flags and adds support in
> fileattr to support atomic writes flag & xflag needed for ext4
> and xfs.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ioctl.c               | 4 ++++
>  include/linux/fileattr.h | 4 ++--
>  include/uapi/linux/fs.h  | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..e0f7fae4777e 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -481,6 +481,8 @@ void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
>  		fa->flags |= FS_DAX_FL;
>  	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
>  		fa->flags |= FS_PROJINHERIT_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES)
> +		fa->flags |= FS_ATOMICWRITES_FL;
>  }
>  EXPORT_SYMBOL(fileattr_fill_xflags);
>  
> @@ -511,6 +513,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
>  		fa->fsx_xflags |= FS_XFLAG_DAX;
>  	if (fa->flags & FS_PROJINHERIT_FL)
>  		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
> +	if (fa->flags & FS_ATOMICWRITES_FL)
> +		fa->fsx_xflags |= FS_XFLAG_ATOMICWRITES;
>  }
>  EXPORT_SYMBOL(fileattr_fill_flags);
>  
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 47c05a9851d0..ae9329afa46b 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -7,12 +7,12 @@
>  #define FS_COMMON_FL \
>  	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
>  	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> -	 FS_PROJINHERIT_FL)
> +	 FS_PROJINHERIT_FL | FS_ATOMICWRITES_FL)
>  
>  #define FS_XFLAG_COMMON \
>  	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
>  	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
> -	 FS_XFLAG_PROJINHERIT)
> +	 FS_XFLAG_PROJINHERIT | FS_XFLAG_ATOMICWRITES)

I'd much prefer that we only use a single user API to set/clear this
flag.

This functionality is going to be tied to using extent size hints on
XFS to indicate preferred atomic IO alignment/size, so applications
are going to have to use the FS_IOC_FS{G,S}ETXATTR APIs regardless
of whether it's added to the FS_IOC_{G,S}ETFLAGS API.

Also, there are relatively few flags left in the SETFLAGS 32-bit
space, so this duplication seems like a waste of the few flags
that are remaining.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

