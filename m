Return-Path: <linux-ext4+bounces-10952-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA81BEB5F6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8AB19A560C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434333F8A5;
	Fri, 17 Oct 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMs8NmtX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098133F8B7
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728683; cv=none; b=K7UvytFEHUrrmamYlQDriwsKgX6fP5d9OSErfzmZNsW0zCihtVReFwpxhWCXrzY3aWtgajQXDM3OZyG3vhyAdm+Wxk+7i2lzcY++Mx9pO3RqDy8l1s+cZjRs3LvoStliz9Y9mpbVDAhhoDMW3jl2qGPXF0/PVEKNheyle0gIZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728683; c=relaxed/simple;
	bh=dXfT1sLaW4j/TF2JOBqHy3NtqgQGacSTiAdKkyL94zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqfgmQ/2eJN923As3dlN+UpbkEGpzsuTLBYQXiLhAy8ULV/koETUZ3bDKFFlkJmriKJ1iQ5IV+n0xc96qRUZ9ky+mygcUW91bA6aIgICerVGcicX2bYTQwjdCZBv645dKX0olKAgNF3P5EZ6sjW8EDyB8gXs7T0dvHIf33coRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMs8NmtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA64C4CEE7;
	Fri, 17 Oct 2025 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760728681;
	bh=dXfT1sLaW4j/TF2JOBqHy3NtqgQGacSTiAdKkyL94zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMs8NmtXwck58NtZW3Y7JmoP4TW1VKVTBg0PZmILDG/6EjYaC+YRAS9TWx1L7Gkoz
	 O8qoNyord9Amd0P4+oG7pg0Pf0tVbsgsbmSr6jEsO0ZfF9l85/8uHt0avZXekAWe18
	 PLk42g0fsnUpmkmF+6EGTi9nOqXZGj+Wyk/RSqHxYItLWDCKJM1GrEz72BPs7ZSN85
	 4TKOYWkI38O8uFjmIFlpJrT2kf5LTn2UzPOuxCL+fP16quCch06Qrd4e5NxLQlKKFS
	 IfqwyAEDVpi7i7/vRHhocOWeFcTh+ezo/ZokHW2Z59ApD2iDCBNNv5xYLeNJB1NXrM
	 nhvoO1zIoEtpg==
Date: Fri, 17 Oct 2025 12:18:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dave.dykstra@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <20251017191800.GF6170@frogsfrogsfrogs>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016200903.3508-1-dave.dykstra@cern.ch>

On Thu, Oct 16, 2025 at 03:09:03PM -0500, Dave Dykstra wrote:
> This makes two changes to the message that is shown saying that fuse2fs
> does not support the journal.  First is that it reverts the check to
> what it was before 3875380 to look at the ro option not being set
> instead of checking the RW flag.  That's because I don't think this
> message needs to be shown when the ro option is set even when it was
> opened RW; there should be nothing to corrupt when it is ro.
> 
> Second, it changes the message to say that writing is not supported
> rather than using the journal is not supported.  The current message is
> confusing because in fact the journal is used for recovery when needed
> and possible.
> 
> Also submitted as PR https://github.com/tytso/e2fsprogs/pull/251
> 
> Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
> ---
>  misc/fuse2fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index cb5620c7..c46cc03b 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4774,10 +4774,10 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (global_fs->flags & EXT2_FLAG_RW) {
> +	if (!fctx.ro) {

Again, rw != EXT2_FLAG_RW.

The ro and rw mount options specify if the filesystem mount is writable.
You can mount a filesystem in multiple places, and some of the mounts
can be ro and some can be rw.

EXT2_FLAG_RW specifies that the filesystem driver can write to the block
device.  fuse2fs should warn about incomplete journal support any time
the **filesystem** is writable, independent of the write state of the
mount.

Filesystems are allowed to write to the block device even if the mount
itself is readonly, e.g. kernel ext4 recovering the journal on an ro
mount.

NAK.

--D

>  		if (ext2fs_has_feature_journal(global_fs->super))
>  			log_printf(&fctx, "%s",
> - _("Warning: fuse2fs does not support using the journal.\n"
> + _("Warning: fuse2fs does not support writing the journal.\n"
>     "There may be file system corruption or data loss if\n"
>     "the file system is not gracefully unmounted.\n"));
>  		err = ext2fs_read_inode_bitmap(global_fs);
> -- 
> 2.43.5
> 
> 

