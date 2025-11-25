Return-Path: <linux-ext4+bounces-12029-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2761C84840
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 11:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF84E2EB9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FA3112BE;
	Tue, 25 Nov 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwOJFnRZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sneQB8bX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwOJFnRZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sneQB8bX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A131065A
	for <linux-ext4@vger.kernel.org>; Tue, 25 Nov 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067083; cv=none; b=JxHzZpSgvs516WEtVAvqlrCPt6qGpuGf23bRO2pWaD6HJA8wgR8+xQtXHZfEvA5SqmDvVM1KQPkwHWhqudrjZ+VWYLkC1NQu4RX+8+hXEb2fVKZX1lnCE6JKWi5q6pDV0+rarZW91bpA0NN9zlTY252GSe5L3zzZipvyQyWOCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067083; c=relaxed/simple;
	bh=yDfTdA6oWuCRsZp/iDNMdUk71CPjj5E47HZTSd+G048=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9xqvz1yP47y3WyQBI+onUo1NVRC/avoMotQEeOMbgT/ybEX/L4ZksI8Yd6BoR4OuGTjboFv2FBmlZTxGjVzb/S+n+ekU9SEvmdgL3F6j5Cat8LxYXshksj4Rzavz3E2HaMQCHg9NPeH3B98umvqpEmDgeNvvIV/7zGNuRhcFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwOJFnRZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sneQB8bX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwOJFnRZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sneQB8bX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0193522814;
	Tue, 25 Nov 2025 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N57y9K/JncFiSgKDJlEcCE03YLQd6zdLPbmKSz229LE=;
	b=AwOJFnRZD1s/Al4FJ0rzSd/eHuh//7jYfklECePFu0bb90/mn2tnLc4zNxEw8ayYws+x8P
	WRTwqfHEq2O0FReG/iRUXrQXnV4K6hKS9RUOGVxl1jDd8FHu9nYQHQSnmvygmyloZdlOTh
	iLd+J4PQZ6zNc3SovM0EuIljKvuyY9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N57y9K/JncFiSgKDJlEcCE03YLQd6zdLPbmKSz229LE=;
	b=sneQB8bXrv4ppQEFDjrquqheXn6A/eXqlcNO2SfiXeJH75aK1UPH3XAv4kL8l5Keu83JDS
	HvUTnw71Ezcvb5Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N57y9K/JncFiSgKDJlEcCE03YLQd6zdLPbmKSz229LE=;
	b=AwOJFnRZD1s/Al4FJ0rzSd/eHuh//7jYfklECePFu0bb90/mn2tnLc4zNxEw8ayYws+x8P
	WRTwqfHEq2O0FReG/iRUXrQXnV4K6hKS9RUOGVxl1jDd8FHu9nYQHQSnmvygmyloZdlOTh
	iLd+J4PQZ6zNc3SovM0EuIljKvuyY9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N57y9K/JncFiSgKDJlEcCE03YLQd6zdLPbmKSz229LE=;
	b=sneQB8bXrv4ppQEFDjrquqheXn6A/eXqlcNO2SfiXeJH75aK1UPH3XAv4kL8l5Keu83JDS
	HvUTnw71Ezcvb5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA21E3EA63;
	Tue, 25 Nov 2025 10:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILQmOQeHJWnMBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 10:37:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACA9BA0C7D; Tue, 25 Nov 2025 11:37:59 +0100 (CET)
Date: Tue, 25 Nov 2025 11:37:59 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH e2fsprogs v3] libext2fs: fix orphan file size > kernel
 limit with large blocksize
Message-ID: <n6cfp7kep2fue5qqka7unco2mufbprsahvklip3itt36pfb4dd@lap5hlskhyif>
References: <20251120135514.3013973-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120135514.3013973-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[huawei.com:email,suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 20-11-25 21:55:14, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> limits the maximum supported orphan file size to 8 << 20.
> 
> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
> blocks when creating a filesystem.
> 
> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
> than the kernel allows, so mount prints an error and fails:
> 
>     EXT4-fs (vdb): orphan file too big: 8650752
>     EXT4-fs (vdb): mount failed
> 
> Thus, orphan file size is capped at 512 filesystem blocks in both e2fsprogs
> and the kernel.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

So finally we should have this consistent :). Thanks for working on this.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
> v1->v2:
>  * Revert the changes in ext2fs_default_orphan_file_blocks()
> 
> v2->v3:
>  * Aligning with the old default of 512 filesystem blocks for
>    max orphan file size allows existing 64KB block filesystems
>    (created under 64KB page size) to mount without error.
> 
> v1: https://lore.kernel.org/r/20251112122157.1990595-1-libaokun@huaweicloud.com
> v2: https://lore.kernel.org/r/20251113090122.2385797-1-libaokun@huaweicloud.com
> 
>  lib/ext2fs/orphan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
> index 14ac3569..0f1889cb 100644
> --- a/lib/ext2fs/orphan.c
> +++ b/lib/ext2fs/orphan.c
> @@ -15,6 +15,8 @@
>  #include "ext2_fs.h"
>  #include "ext2fsP.h"
>  
> +#define EXT4_MAX_ORPHAN_FILE_BLOCKS 512
> +
>  errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs)
>  {
>  	struct ext2_inode inode;
> @@ -129,6 +131,9 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
>  	struct ext4_orphan_block_tail *ob_tail;
>  	time_t now;
>  
> +	if (num_blocks > EXT4_MAX_ORPHAN_FILE_BLOCKS)
> +		num_blocks = EXT4_MAX_ORPHAN_FILE_BLOCKS;
> +
>  	if (ino) {
>  		err = ext2fs_read_inode(fs, ino, &inode);
>  		if (err)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

