Return-Path: <linux-ext4+bounces-1338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D976085E2E8
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0875D1C24693
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7A8172F;
	Wed, 21 Feb 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7+0Nnyb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJIVNmx3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="khlseSJ6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2G3oVn4k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A881721
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532399; cv=none; b=maKhOWYtdtbL2zYxrAIlKG0xJnMbuT0lMFJEzFX3IaQwCV0jwUSUDZCtFL4igv+PL4VHGQV6uudHnO//PqsAawZr8sRcPDalJgMWB+cAVZx8ipfSo5x/cE0GuuIMEHudubLOA1S8POxbjPHDychQspyqmMJTJ/+o3STDeALMogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532399; c=relaxed/simple;
	bh=eVtW4Dj0OeaAOK3QoIlewiuuaNOWCzdGShT0rKRsFfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/cLg9dMbB/rUmIihkOfEom6yaJFpR5zIVY4bqN7OcAkN9BHfAtNo3C7WXEiEa2WTZT+D/9Hu3nNW8sxn2cTOIH4A27ISyScmdVrgBSeXFzFzdhYupbvB2zqcUs2cNTS61H0plw/Nq4eaqk9y2jAoK27bYkvetFLFqhqbrMahgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7+0Nnyb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJIVNmx3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=khlseSJ6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2G3oVn4k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEC7C22118;
	Wed, 21 Feb 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708532395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjuKh+aDaMgUgy/jXkuG+SbtumT78t/PO05kyavt/v8=;
	b=s7+0NnybMCEOz6NiK9Ex89sgCGYcKfqDFnxbEIF9KdBlhCVi1q313eoVFHwudK5yHCCcGr
	DAE5RYLaYnWb/nwRdnwru79Y+D1kOtoLLK8S2Q9F1+jMq7ZXfdrnP2QzxfHl1zvEgrFG3L
	0x+V4sZxlMRwX5hxBtKSBwhekZmE1TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708532395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjuKh+aDaMgUgy/jXkuG+SbtumT78t/PO05kyavt/v8=;
	b=DJIVNmx3Do1bglFtGToCjT9wBb7aUGhChXt4iszoo9QQAPDk35J3eGBkl7vIg5ijDQ246t
	APCsPIhRX62OM2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708532394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjuKh+aDaMgUgy/jXkuG+SbtumT78t/PO05kyavt/v8=;
	b=khlseSJ6t9XZkWTLx9+O/OAcjrB466lzo37y+P0UhcYlUYe+bHn32cULypcJLUgvSGF1SI
	uAG2jSq7AaJ/hwy4OSLg8CyqtNWHeN1cwTfL5nggpTVSye61qaqe3dMzieCfSx+Cc7AAui
	ChSfDLvD117ye6JIlqNGHFU2MWbjShY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708532394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjuKh+aDaMgUgy/jXkuG+SbtumT78t/PO05kyavt/v8=;
	b=2G3oVn4kCT1d859vcUMW9CaEqBxOkScDHMner+bLPGvI3jl9R+/MisJ3t1tl1KeoZXgilC
	nXgGRy5YZaP3mMBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B405A139D1;
	Wed, 21 Feb 2024 16:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id B7fsK6oi1mWqZAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 16:19:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5659FA0807; Wed, 21 Feb 2024 17:19:54 +0100 (CET)
Date: Wed, 21 Feb 2024 17:19:54 +0100
From: Jan Kara <jack@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: A problem about BLK_OPEN_RESTRICT_WRITES
Message-ID: <20240221161954.zwx34k5rvoevpe7o@quack3>
References: <CAHB1NahoCEsw-vtu=6AUgG8oL0tTVV3gbP121zTgvdBzrMUo8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NahoCEsw-vtu=6AUgG8oL0tTVV3gbP121zTgvdBzrMUo8w@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hello,

On Wed 21-02-24 23:29:39, JunChao Sun wrote:
> I saw that ext4 has supported BLK_OPEN_RESTRICT_WRITES in commits
> aca740cecbe("fs: open block device after superblock creation")  and
> afde134b5bd0("ext4: Block writes to journal device"). I'm not certain
> whether these commits caused the following issue.
> 
> Environment:
> 6.8.0-rc3-00279-g4a7bbe7519b6-dirty(commit 4a7bbe7519b6a5).
> sjc@sjc-laptop:~/linux$ mkfs.ext4 -V
> mke2fs 1.47.0 (5-Feb-2023)
> Using EXT2FS Library version 1.47.0
> sjc@sjc-laptop:~/linux$ mount -V
> mount from util-linux 2.39.1 (libmount 2.39.1: selinux, smack, btrfs,
> verity, namespaces, idmapping, assert, debug)
> 
> Problem:
> When I mounted the ext4 file system in the qemu system, I encountered
> the following error:
> root@q:~/linux# mount -t ext4 ext4.img  /mnt/ext4/
> [  848.897532] loop1: detected capacity change from 0 to 2097152
> [  848.905535] /dev/loop1: Can't open blockdev
> mount: /mnt/ext4: /dev/loop1 already mounted or mount point busy.
>        dmesg(1) may have more information after failed mount system call.
> 
> I reviewed the relevant code and found that the mount program first
> calls the openat system call to open the /dev/loop1 file, followed by
> the mount system call (with /dev/loop1 as the first parameter).
> 
> As for the former openat system call, it eventually reaches the chain
> of (vfs_open->do_dentry_open->blkdev_open->bdev_open_by_dev->bdev_claim_write_access).
> In bdev_claim_write_access, the following logic applies:
>             /* Claim exclusive or shared write access. */
>             if (mode & BLK_OPEN_RESTRICT_WRITES)
>                     bdev_block_writes(bdev);
>             else if (mode & BLK_OPEN_WRITE)
>                     bdev->bd_writers++;
> The argument mode here doesn't set BLK_OPEN_RESTRICT_WRITES flag, so
> goes bdev->bd_writers++.
> 
> And in the latter mount system call, the following logic is followed:
> (vfs_get_tree->get_tree_bdev->setup_bdev_super->bdev_open_by_dev->bdev_may_open).
> In bdev_may_open, the following logic applies:
>             if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers > 0)
>                     return false;
> 
> Due to the fact that the argument mode has already been set with the
> BLK_OPEN_RESTRICT_WRITES flag in the setup_bdev_super function, and
> since bdev->bd_writers is already 1 at this point, the function
> returns false. This ultimately leads to the mount system call
> returning the EBUSY error.

Yes, this is correct. How mount(8) sets up loop devices gets broken by when
BLK_OPEN_RESTRICT_WRITES is enabled.

> Is this indeed a problem, or is there a misunderstanding in my
> comprehension? If it is indeed a problem, can we resolve it by
> removing the BLK_OPEN_RESTRICT_WRITES from the sb_open_mode macro
> definition?

No. Cases like above are the reason why there's still a config option
CONFIG_BLK_DEV_WRITE_MOUNTED and it defaults to 'y'. We need to be fixing
userspace - util-linux in this case - to avoid having writeable file handle
open to block devices that are being mounted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

