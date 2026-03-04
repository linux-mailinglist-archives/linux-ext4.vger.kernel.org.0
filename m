Return-Path: <linux-ext4+bounces-14599-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOOwJ+gHqGnSnQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14599-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 11:22:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 159161FE403
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DE3D301A172
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D23A1A5F;
	Wed,  4 Mar 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEBPn++p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1E4VrZ4z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEBPn++p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1E4VrZ4z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9739A068
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619597; cv=none; b=qA5iFbxDsKZTeC7tknO2AT1ral9kPhkc2tBQwc7MoYfxCj3V0TmGRhlqJoN1KYbnvu0mQrcTGZi+nhxfOfzvRMxc/H/b0QenIN+0qWz7HbA33V1CuN0SIx6ZgOe/Bb2IIQrOt5kEITr6SRz6NBHndSlYRPwArkMu0LcziovQjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619597; c=relaxed/simple;
	bh=dpY0qOrQWN/nkptgXwsR5b7l9Lk3V7Ag/77fLUaGvhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFWbs2qHixslbmRd1rHECoJN2rXk50IBKCfpdEbsHbB6WjS1aq+7/qtMq+yqUTgOuN3btBNSr8E5eKeBf5eg7yx3/Y15wWNLt/7dXfPYPyWeQonVL5ls9fTU+hMOX3bh5/6tD8ziwmyvQcBZZgJU3ojvee80zS7vMdr/6Igowhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEBPn++p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1E4VrZ4z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEBPn++p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1E4VrZ4z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22A853F8D3;
	Wed,  4 Mar 2026 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772619594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdNF1YIP5o4QSdMScbwtBPYeFJ0P1YwLxvqA4Vs8xUQ=;
	b=EEBPn++pL92sJVsuOW5hx9ho4GUwGTn2O+6A9aFJDEfrm21E6eE1PkulWf8d2EYAOuZPD3
	t3jhvwnFs6NPjvrz5f5yKfiyE9eNo+bA/oMVanHxwaeK4vAm0ZCyZ4bVSpn7ACRO+XFU1Y
	AUcJhr5BPgxEBp3ZmFW4hdgsc+H8GHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772619594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdNF1YIP5o4QSdMScbwtBPYeFJ0P1YwLxvqA4Vs8xUQ=;
	b=1E4VrZ4zI9GZ15BE29tLbl3RSU4CYdQ3GcrxlfpettU3XyzY+2W9sbwyA2G95smgFp5dnH
	rldhG8XkBeAdZcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772619594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdNF1YIP5o4QSdMScbwtBPYeFJ0P1YwLxvqA4Vs8xUQ=;
	b=EEBPn++pL92sJVsuOW5hx9ho4GUwGTn2O+6A9aFJDEfrm21E6eE1PkulWf8d2EYAOuZPD3
	t3jhvwnFs6NPjvrz5f5yKfiyE9eNo+bA/oMVanHxwaeK4vAm0ZCyZ4bVSpn7ACRO+XFU1Y
	AUcJhr5BPgxEBp3ZmFW4hdgsc+H8GHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772619594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdNF1YIP5o4QSdMScbwtBPYeFJ0P1YwLxvqA4Vs8xUQ=;
	b=1E4VrZ4zI9GZ15BE29tLbl3RSU4CYdQ3GcrxlfpettU3XyzY+2W9sbwyA2G95smgFp5dnH
	rldhG8XkBeAdZcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 189173EA69;
	Wed,  4 Mar 2026 10:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cm/+BUoHqGkNBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 10:19:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEBD2A0A1B; Wed,  4 Mar 2026 11:19:45 +0100 (CET)
Date: Wed, 4 Mar 2026 11:19:45 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH -next v3] ext4: test if inode's all dirty pages are
 submitted to disk
Message-ID: <2yhgpemj3uapus647p7anjtr33dvscpnqeznnr462vtlhsjfle@7eey7koee76p>
References: <20260303012242.3206465-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303012242.3206465-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 159161FE403
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14599-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 03-03-26 09:22:42, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> The commit aa373cf55099 ("writeback: stop background/kupdate works from
> livelocking other works") introduced an issue where unmounting a filesystem
> in a multi-logical-partition scenario could lead to batch file data loss.
> This problem was not fixed until the commit d92109891f21 ("fs/writeback:
> bail out if there is no more inodes for IO and queued once"). It took
> considerable time to identify the root cause. Additionally, in actual
> production environments, we frequently encountered file data loss after
> normal system reboots. Therefore, we are adding a check in the inode
> release flow to verify whether all dirty pages have been flushed to disk,
> in order to determine whether the data loss is caused by a logic issue in
> the filesystem code.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

OK, I guess the warning is better than the stacktrace. BTW, what did
trigger the false positive warnings this time (I didn't really look at
syzbot reproducers)? Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 396dc3a5d16b..d4d65593bce2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -184,6 +184,14 @@ void ext4_evict_inode(struct inode *inode)
>  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
>  		ext4_evict_ea_inode(inode);
>  	if (inode->i_nlink) {
> +		/*
> +		 * If there's dirty page will lead to data loss, user
> +		 * could see stale data.
> +		 */
> +		if (unlikely(!ext4_emergency_state(inode->i_sb) &&
> +		    mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)))
> +			ext4_warning_inode(inode, "data will be lost");
> +
>  		truncate_inode_pages_final(&inode->i_data);
>  
>  		goto no_delete;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

