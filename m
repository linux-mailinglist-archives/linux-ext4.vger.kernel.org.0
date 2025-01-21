Return-Path: <linux-ext4+bounces-6172-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799BA17D83
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3966A16B6D6
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885021F1908;
	Tue, 21 Jan 2025 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbGOUjmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyuopIOk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbGOUjmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyuopIOk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826511F152D;
	Tue, 21 Jan 2025 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461295; cv=none; b=ZZeekDwfbCGStkS9jUMR3NSvabQNXoVMRUvy8G6GYuzz/1rHcfUSaV4f2a0dhNBhjgkHrnUo/EQulMw5X7kUHrRYTFczt+IoSB10xH/Mz3L+vtmkw7pQxSYg94b7kO4jfA1HWiiIKb4kmu+2sZTHUAgnYyy294DJcJkIKIY33hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461295; c=relaxed/simple;
	bh=FarBAos1yuh1ga4D1ibmNnxMqx9dy7UNAiPaMAmVcRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKGHNJuSx0+k/rFJtJUGiqgxL7ddSZQmF1Ed2arknBLO7XXQY7WETifychGWwkjuG5IybphxP32HwowFg9tH+iwVub3ZvcqdtQXP77sQ1iCZfucmUwuMrE6zA/AgZ/N+KL5m0wUtZ2dsVThjN5WUxvaGQytnGElFuIwRaI9wXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbGOUjmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyuopIOk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbGOUjmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyuopIOk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A3782117A;
	Tue, 21 Jan 2025 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Hyack543TNG+5Zgg/csL58ubgtSTmJF5mYSlCP6xw=;
	b=sbGOUjmPAKYo+ghoT3NDP79RPip8BAcs2qedKgnUasiFuTsYgFp2ReHEPQyiAMiu8pj3ny
	eJ7KxcgVISUrOFy1GqxXqKTtnzBuzSUdwM/E251hlWrz4bARS7o6CsfWbSPmC+5PB5x3c+
	JFxRPbKdgIUJqlCohnODtnG554UsKmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Hyack543TNG+5Zgg/csL58ubgtSTmJF5mYSlCP6xw=;
	b=gyuopIOkmO9QGB0Rzyu311qwfAL9bJR3x8EkToi0ZF1VRHfy8f4msf62zurDize1JgpWNq
	0Tex5z1AxfFVKTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Hyack543TNG+5Zgg/csL58ubgtSTmJF5mYSlCP6xw=;
	b=sbGOUjmPAKYo+ghoT3NDP79RPip8BAcs2qedKgnUasiFuTsYgFp2ReHEPQyiAMiu8pj3ny
	eJ7KxcgVISUrOFy1GqxXqKTtnzBuzSUdwM/E251hlWrz4bARS7o6CsfWbSPmC+5PB5x3c+
	JFxRPbKdgIUJqlCohnODtnG554UsKmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Hyack543TNG+5Zgg/csL58ubgtSTmJF5mYSlCP6xw=;
	b=gyuopIOkmO9QGB0Rzyu311qwfAL9bJR3x8EkToi0ZF1VRHfy8f4msf62zurDize1JgpWNq
	0Tex5z1AxfFVKTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E17513963;
	Tue, 21 Jan 2025 12:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rx7GHiuOj2fGXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 12:08:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 408DBA0889; Tue, 21 Jan 2025 13:08:03 +0100 (CET)
Date: Tue, 21 Jan 2025 13:08:03 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/7] ext4: add EXT4_FLAGS_EMERGENCY_RO bit
Message-ID: <jlmjgo6xm5t3wuomxgo46c22csv6dlqubb35ctaa3u7qizbqmf@qeum4e6ffyoc>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117082315.2869996-3-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,huawei.com:email,suse.cz:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 17-01-25 16:23:10, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> EXT4_FLAGS_EMERGENCY_RO Indicates that the current file system has become
> read-only due to some error. Compared to SB_RDONLY, setting it does not
> require a lock because we won't clear it, which avoids over-coupling with
> vfs freeze. Also, add a helper function ext4_emergency_ro() to check if
> the bit is set.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

The same comment about comma after the last enum member. Otherwise looks
good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 612208527512..c5b775482897 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2235,7 +2235,8 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
>  enum {
>  	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
>  	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
> -	EXT4_FLAGS_BDEV_IS_DAX	/* Current block device support DAX */
> +	EXT4_FLAGS_BDEV_IS_DAX,	/* Current block device support DAX */
> +	EXT4_FLAGS_EMERGENCY_RO	/* Emergency read-only due to fs errors */
>  };
>  
>  static inline int ext4_forced_shutdown(struct super_block *sb)
> @@ -2243,6 +2244,11 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
>  	return test_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
>  }
>  
> +static inline int ext4_emergency_ro(struct super_block *sb)
> +{
> +	return test_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
> +}
> +
>  /*
>   * Default values for user and/or group using reserved blocks
>   */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

