Return-Path: <linux-ext4+bounces-1357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B485F578
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C09284CE6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468A39AC2;
	Thu, 22 Feb 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ds1fvHgZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/ZLcfRp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ds1fvHgZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/ZLcfRp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6839AD7;
	Thu, 22 Feb 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597092; cv=none; b=ONEi1IjX9718zDIxoiaLAHs+GCWp5bBqDrHWbE4evTAFeDsIZTnR+ULxvpW339LoVO84ZeP0ZSIkGCOcK91wm8MlGdhiGa4WbOE9y5imkBalOwSxktIzGbc7r/alksyesR+/4NR+jYF+TORyLmDg5Ve0SDZrjwhmJ5Nb8tyCcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597092; c=relaxed/simple;
	bh=oOR8jmKiR3Z0bG5p4Qjx/ANit+QiUMk7afIR/go4cYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3NfhDR3wqy+bMAa/xUEW6aB9cT1Wu7BJFTTKcsLmbLgRjiG51YcT41+pMt2oN8XtfZyQmZybNC8DC0c0v8DDMmS82jPRd+xEkqlotOjfykauuswaeonSPjpYiURBtv3PFOl2PgeetLKKW1Bloggw6JHXWeC9VPUAZSFIZYsJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ds1fvHgZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/ZLcfRp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ds1fvHgZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/ZLcfRp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7503D21EEF;
	Thu, 22 Feb 2024 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708597088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WleimZ4dFaFbSJPgf7OWTIbGCgCw5AeIfnj/EQtUT3U=;
	b=ds1fvHgZag8C/JWIoPDuux7+XMfr3fzhGd4Tm93+TxTNOGXBLRghOy3Fei1sIU5LEjTYlW
	QE8uq1uQcA3CN/hVbcUvygM2eHQI8XnlHPBAFjxK/gVW1lwUEafj0zKWlJqF+K9qhrplOD
	OcpLGQWOHeIySRjE2c6oHBpdnrYOKiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708597088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WleimZ4dFaFbSJPgf7OWTIbGCgCw5AeIfnj/EQtUT3U=;
	b=h/ZLcfRpSeorW1P/7KYUJ5ANfoT578QQ7N9Qf/Jmb00wCorNPHjaou24ul5F5QgJrmi4aQ
	DA96QfH1Xo1B0LAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708597088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WleimZ4dFaFbSJPgf7OWTIbGCgCw5AeIfnj/EQtUT3U=;
	b=ds1fvHgZag8C/JWIoPDuux7+XMfr3fzhGd4Tm93+TxTNOGXBLRghOy3Fei1sIU5LEjTYlW
	QE8uq1uQcA3CN/hVbcUvygM2eHQI8XnlHPBAFjxK/gVW1lwUEafj0zKWlJqF+K9qhrplOD
	OcpLGQWOHeIySRjE2c6oHBpdnrYOKiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708597088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WleimZ4dFaFbSJPgf7OWTIbGCgCw5AeIfnj/EQtUT3U=;
	b=h/ZLcfRpSeorW1P/7KYUJ5ANfoT578QQ7N9Qf/Jmb00wCorNPHjaou24ul5F5QgJrmi4aQ
	DA96QfH1Xo1B0LAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6964113A6B;
	Thu, 22 Feb 2024 10:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rSivGWAf12VHLAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 10:18:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7071A0807; Thu, 22 Feb 2024 11:18:07 +0100 (CET)
Date: Thu, 22 Feb 2024 11:18:07 +0100
From: Jan Kara <jack@suse.cz>
To: michael.opdenacker@bootlin.com
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: mark as deprecated
Message-ID: <20240222101807.omdurbkvbf5vmqaj@quack3>
References: <20240222095001.137660-1-michael.opdenacker@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222095001.137660-1-michael.opdenacker@bootlin.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bootlin.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Thu 22-02-24 10:50:01, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Add a DEPRECATED keyword to the kernel parameter description,
> to warn users that this filesystem doesn't support dates beyond 2038.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Thanks! I've modified the help text to:

          Ext2 is a standard Linux file system for hard disks.

          This filesystem driver is deprecated because it does not properly
          support inode time stamps beyond 03:14:07 UTC on 19 January 2038.

          Ext2 users are advised to use ext4 driver to access their filesystem.
          The driver is fully compatible, supports filesystems without journal
          or extents, and also supports larger time stamps if the filesystem
          is created with at least 256 byte inodes.

          This code is kept as a simple reference for filesystem developers.

          If unsure, say N.

and added it to my tree.

								Honza

> ---
>  fs/ext2/Kconfig | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
> index 74d98965902e..49e4660ae436 100644
> --- a/fs/ext2/Kconfig
> +++ b/fs/ext2/Kconfig
> @@ -1,16 +1,30 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config EXT2_FS
> -	tristate "Second extended fs support"
> +	tristate "Second extended fs support (DEPRECATED)"
>  	select BUFFER_HEAD
>  	select FS_IOMAP
>  	select LEGACY_DIRECT_IO
>  	help
>  	  Ext2 is a standard Linux file system for hard disks.
>  
> -	  To compile this file system support as a module, choose M here: the
> -	  module will be called ext2.
> +	  It is deprecated because even if the filesystem is created with
> +	  256 byte inodes (mkfs.ext2 -I 256), the filesystem driver will stick
> +	  to 32 bit dates. Because of this, this filesystem does not support
> +	  dates beyond 03:14:07 UTC on 19 January 2038.
>  
> -	  If unsure, say Y.
> +	  Ext2 users are advised to migrate their partitions to ext4:
> +
> +	  $ tune2fs -O extents,uninit_bg,dir_index,has_journal /dev/sda1
> +	  $ e2fsck -pf /dev/sda1
> +
> +	  Ext4 is also a working solution for very small partitions
> +	  as it can be created without a journal:
> +
> +	  $ mkfs.ext4 -O ^has_journal /dev/sda1
> +
> +	  This code is kept as a simple reference for filesystem developers.
> +
> +	  If unsure, say N.
>  
>  config EXT2_FS_XATTR
>  	bool "Ext2 extended attributes"
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

