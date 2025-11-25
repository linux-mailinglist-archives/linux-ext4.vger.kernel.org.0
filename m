Return-Path: <linux-ext4+bounces-12028-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899DC84837
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7A2834D8BC
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A403101C5;
	Tue, 25 Nov 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRbtJ9ge";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="THWM0WeZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRbtJ9ge";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="THWM0WeZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EFD271
	for <linux-ext4@vger.kernel.org>; Tue, 25 Nov 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067035; cv=none; b=dVXDLugM4YOIoR1blWd+7GOGWlN31o7pwU8iu1DhpVcB4Ry6MPI0f3HOrsoVgsONLKrnXgZ4Docobhwgty/HwyGnMOw7pBjIiMvdSjdrk3NtBeQLwtmKsT0Prr/iT2/wDK9ezvtcrG4w7OSp0Op128diSsUCNxylJ/2wbGqUEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067035; c=relaxed/simple;
	bh=SySHuaj+HFxearLJUiRudZ/pVfxeVsDgWv7u+RFfY6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVrcSPN7gBnQyTyWGzyTm80qJsf9Uy9Nb3pm87VLPKkSd99CpA0ZWhWII4N4gSL1zgffhusuh7su7wsbBVvZjDaa3odvpAn2isX0p2OSxePp7B6i84wsKJx63NPMpV4YH7hIn8RPp14tBnDUGKxp8l31tePmtccZvdD4ZclcGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRbtJ9ge; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=THWM0WeZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRbtJ9ge; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=THWM0WeZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 615785BD10;
	Tue, 25 Nov 2025 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjvlBe/K9ZB/Qlfjr9mAFkU8IdlJmNX0+Fi4+OANPC4=;
	b=LRbtJ9geDq0GWR9A9BOX8oIp2prRs6r/PCTn0FLCmlcEh479LT4uGHVoNR3T88Qm3+8tkT
	ycP6SrOc2s3WsKj7NhlPeIB5pvFDDOWk1aHsXN9ioYSNrf3GQWqsrCUjNjgZf24gXPSRWO
	F8/I1VzOyWsaY4Ea/slZRA7uNn3pA3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjvlBe/K9ZB/Qlfjr9mAFkU8IdlJmNX0+Fi4+OANPC4=;
	b=THWM0WeZ8QBw8vzaLgo5OYoYbrLvuaSw6e9SnN42BcSPeMk9MaT82A+F1GRWV2kJFnMhDF
	mCpvG6WKcdaORSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjvlBe/K9ZB/Qlfjr9mAFkU8IdlJmNX0+Fi4+OANPC4=;
	b=LRbtJ9geDq0GWR9A9BOX8oIp2prRs6r/PCTn0FLCmlcEh479LT4uGHVoNR3T88Qm3+8tkT
	ycP6SrOc2s3WsKj7NhlPeIB5pvFDDOWk1aHsXN9ioYSNrf3GQWqsrCUjNjgZf24gXPSRWO
	F8/I1VzOyWsaY4Ea/slZRA7uNn3pA3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjvlBe/K9ZB/Qlfjr9mAFkU8IdlJmNX0+Fi4+OANPC4=;
	b=THWM0WeZ8QBw8vzaLgo5OYoYbrLvuaSw6e9SnN42BcSPeMk9MaT82A+F1GRWV2kJFnMhDF
	mCpvG6WKcdaORSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56FA13EA63;
	Tue, 25 Nov 2025 10:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Qs3FdeGJWkUBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 10:37:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0DE9FA0C7D; Tue, 25 Nov 2025 11:37:11 +0100 (CET)
Date: Tue, 25 Nov 2025 11:37:11 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: align max orphan file size with e2fsprogs limit
Message-ID: <zxakbc3a2mwsjmpvvyl5tnaljrpcc4px7r5bh6u3gwe4xarg7d@zrxmpvfhugvs>
References: <20251120134233.2994147-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120134233.2994147-1-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 20-11-25 21:42:33, libaokun@huaweicloud.com wrote:
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
> To prevent this issue and allow previously created 64KB filesystems to
> mount, we updates the maximum allowed orphan file size in the kernel to
> 512 filesystem blocks.
> 
> Fixes: 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

OK, makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/orphan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 82d5e7501455..fb57bba0d19d 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -8,6 +8,8 @@
>  #include "ext4.h"
>  #include "ext4_jbd2.h"
>  
> +#define EXT4_MAX_ORPHAN_FILE_BLOCKS 512
> +
>  static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
>  {
>  	int i, j, start;
> @@ -588,7 +590,7 @@ int ext4_init_orphan_info(struct super_block *sb)
>  	 * consuming absurd amounts of memory when pinning blocks of orphan
>  	 * file in memory.
>  	 */
> -	if (inode->i_size > 8 << 20) {
> +	if (inode->i_size > (EXT4_MAX_ORPHAN_FILE_BLOCKS << inode->i_blkbits)) {
>  		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
>  			 (unsigned long long)inode->i_size);
>  		ret = -EFSCORRUPTED;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

