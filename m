Return-Path: <linux-ext4+bounces-6413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3115A30F5A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8322F163727
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA002512EF;
	Tue, 11 Feb 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fY7aMPoF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kij4aL7u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fY7aMPoF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kij4aL7u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C082512C7;
	Tue, 11 Feb 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286820; cv=none; b=bAGFsKiEt0skBuQ4kuKif2FS66b/EpdgjQ+ch+JE0/7cLHzI9m7zQE6QVOEr/OCCqej0yiqur3Ss5Nr4TclFmUW6xwgPq7ZPOSYX7KTF8s74NOGMbO0/f6uFvgncRu63Up1mWm11nD1vTjPpXlR0jHCPeExQy/RZ/NNN+LA2b88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286820; c=relaxed/simple;
	bh=3rchmxc6w2X7e6g+kY+aEf5j7mS7EwQMvXvTeDNIY60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6wBH/JpqWobjBqJ+XOLg+/8LQfjGgP0/m8zHNKUlIRUWji4M/fb5Z7xbPw3yI/RIl6eqgvQPgVqr4dGF5Wu1SR2wv5RPuO7kkTM5gCCI68rv8QKQxGX0ovspPOou2DREkApkWm12hFpJMoReeooPQ1ObfzdFydtQ3lQMgGBE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fY7aMPoF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kij4aL7u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fY7aMPoF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kij4aL7u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AA69223F9;
	Tue, 11 Feb 2025 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739284278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29SWT9WKmcoXdWr7QD8CSXyU8iw0S3dfYxkCJQQTnA=;
	b=fY7aMPoFucAS/1/YvosPa59qyNAwMHOJKEGIVgyqYuX1XdDud+goHMlcYzjtCbjcH5Ox4F
	ZqpDAo4+M5NS6Qh+ErdrKFEY6ZbHOb8Q3al7y8tfTzkg4Jq3s8elJNaeu+amnUXAahd084
	8vMKrE6frse8ExNp3KeeGWQi+qjedE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739284278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29SWT9WKmcoXdWr7QD8CSXyU8iw0S3dfYxkCJQQTnA=;
	b=Kij4aL7usxLX0SWUbSe3fGexxYT9BU+lbFt7NgfwZapuErc5qoqmy1uJtJEHWCQNvvf4DR
	dH4oAkOnkkkrS/BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739284278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29SWT9WKmcoXdWr7QD8CSXyU8iw0S3dfYxkCJQQTnA=;
	b=fY7aMPoFucAS/1/YvosPa59qyNAwMHOJKEGIVgyqYuX1XdDud+goHMlcYzjtCbjcH5Ox4F
	ZqpDAo4+M5NS6Qh+ErdrKFEY6ZbHOb8Q3al7y8tfTzkg4Jq3s8elJNaeu+amnUXAahd084
	8vMKrE6frse8ExNp3KeeGWQi+qjedE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739284278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P29SWT9WKmcoXdWr7QD8CSXyU8iw0S3dfYxkCJQQTnA=;
	b=Kij4aL7usxLX0SWUbSe3fGexxYT9BU+lbFt7NgfwZapuErc5qoqmy1uJtJEHWCQNvvf4DR
	dH4oAkOnkkkrS/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FEAD13782;
	Tue, 11 Feb 2025 14:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCyZDzZfq2f/TwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Feb 2025 14:31:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4841A095C; Tue, 11 Feb 2025 15:31:09 +0100 (CET)
Date: Tue, 11 Feb 2025 15:31:09 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 5/7] ext4: correct behavior under errors=remount-ro
 mode
Message-ID: <v4k7pgwfeaa2drgkdpkyzl2qyemicnwyhvo3zcyn53frj3b2w5@3wpniv2edlfk>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
 <20250122114130.229709-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122114130.229709-6-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,huaweicloud.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 22-01-25 19:41:28, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> And after commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag") in
> v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in ext4_handle_error() under
> errors=remount-ro mode. This causes the read to fail even when the error
> is triggered in errors=remount-ro mode.
> 
> To correct the behavior under errors=remount-ro, EXT4_FLAGS_SHUTDOWN is
> replaced by the newly introduced EXT4_FLAGS_EMERGENCY_RO. This new flag
> only prevents writes, matching the previous behavior with SB_RDONLY.
> 
> Fixes: 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
> Closes: https://lore.kernel.org/all/22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com/
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d8116c9c2bd0..098e62727aec 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -708,11 +708,8 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  	if (test_opt(sb, WARN_ON_ERROR))
>  		WARN_ON_ONCE(1);
>  
> -	if (!continue_fs && !sb_rdonly(sb)) {
> -		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
> -		if (journal)
> -			jbd2_journal_abort(journal, -EIO);
> -	}
> +	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
> +		jbd2_journal_abort(journal, -EIO);
>  
>  	if (!bdev_read_only(sb->s_bdev)) {
>  		save_error_info(sb, error, ino, block, func, line);
> @@ -738,17 +735,17 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  			sb->s_id);
>  	}
>  
> -	if (sb_rdonly(sb) || continue_fs)
> +	if (ext4_emergency_ro(sb) || continue_fs)
>  		return;
>  
>  	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>  	/*
> -	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> -	 * modifications. We don't set SB_RDONLY because that requires
> -	 * sb->s_umount semaphore and setting it without proper remount
> -	 * procedure is confusing code such as freeze_super() leading to
> -	 * deadlocks and other problems.
> +	 * We don't set SB_RDONLY because that requires sb->s_umount
> +	 * semaphore and setting it without proper remount procedure is
> +	 * confusing code such as freeze_super() leading to deadlocks
> +	 * and other problems.
>  	 */
> +	set_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
>  }
>  
>  static void update_super_work(struct work_struct *work)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

