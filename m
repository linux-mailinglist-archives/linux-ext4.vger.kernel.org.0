Return-Path: <linux-ext4+bounces-7573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD237AA450D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 10:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068854A7147
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107FC218E81;
	Wed, 30 Apr 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtbNnbGd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NljBk0hx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtbNnbGd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NljBk0hx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1A216605
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001150; cv=none; b=VebZunr+I6QEpViecroWKvPPhew9e5Eb3dJ6N5CUXTmUpYMicG87c/r/2Ux/Un9xmGyrusPaRKSB2aqT3d2wqDBMeJcV1mhkk8ONZUp+Qyh1gRu34o/1hCIAK0u4Qqb+//m83cfhn1Op+fmA/ivPjfSH5Agp/Fie9gC/bR7AR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001150; c=relaxed/simple;
	bh=fZ/MYVbLqY0OeUa9PQrWNIxmBYwca4exX0OpU3bifHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da0spOr7KzYfSCygnHqS0h49oEv53wcW5V9nAQ5Kb//aHC+ZEqODVanKSqQKG/nCGoM9fNQowtFuAunpQy25fcQ76kRmGrksW9PU6Y40SmZcazR4I9N+aoNYoJHtTNoAKZpnemzpLWK4It+K3Dp7uNwVEJvvJpNgjYpP1gEmI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtbNnbGd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NljBk0hx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtbNnbGd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NljBk0hx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20CBB1F7CC;
	Wed, 30 Apr 2025 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746001147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3bkF3kbJkw9SyS9aDetvTvyDlSv2dhlIRzNF669X3U=;
	b=AtbNnbGdDRHPH1ATDpa5RdwJe4x0BTIsDRsdLunAsLWGzjTyAXhiQr8cNs2VSBR1r2iX3a
	ffKqJwPBuGMsB7tum+v01LhUwHyxgzcbQjioO25u6I4zhR7bPWRdYo4S7T8TbjILO9p3VY
	xM+U3OB2iT1EG5IwcNinVPsNsqJSlaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746001147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3bkF3kbJkw9SyS9aDetvTvyDlSv2dhlIRzNF669X3U=;
	b=NljBk0hxl46d0Zpm/6kIPvcNGq4MVqNpeGpXGgTTYE+j+zUBtYXnJfo51c1WgEV2kVWHxJ
	diCoEzB7df3MhkDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AtbNnbGd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NljBk0hx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746001147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3bkF3kbJkw9SyS9aDetvTvyDlSv2dhlIRzNF669X3U=;
	b=AtbNnbGdDRHPH1ATDpa5RdwJe4x0BTIsDRsdLunAsLWGzjTyAXhiQr8cNs2VSBR1r2iX3a
	ffKqJwPBuGMsB7tum+v01LhUwHyxgzcbQjioO25u6I4zhR7bPWRdYo4S7T8TbjILO9p3VY
	xM+U3OB2iT1EG5IwcNinVPsNsqJSlaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746001147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3bkF3kbJkw9SyS9aDetvTvyDlSv2dhlIRzNF669X3U=;
	b=NljBk0hxl46d0Zpm/6kIPvcNGq4MVqNpeGpXGgTTYE+j+zUBtYXnJfo51c1WgEV2kVWHxJ
	diCoEzB7df3MhkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1554A139E7;
	Wed, 30 Apr 2025 08:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RMYtBfvcEWh/DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 08:19:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C502AA0AF0; Wed, 30 Apr 2025 10:18:58 +0200 (CEST)
Date: Wed, 30 Apr 2025 10:18:58 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 2/4] ext4: fix incorrect punch max_end
Message-ID: <ykm27jvrnmhgd4spslhn4mano452c6z34fab7r3776dmjkgo7q@cv2lvsiteufa>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 20CBB1F7CC
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 30-04-25 09:12:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For the extents inodes, the maxbytes should be sb->s_maxbytes instead of
> sbi->s_bitmap_maxbytes. Correct the maxbytes value to correct the
> behavior of punch hole.
> 
> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thinking about this some more...

> @@ -4015,6 +4015,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		max_end = sb->s_maxbytes;
> +	else
> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
> +	max_end -= sb->s_blocksize;

I think the -= sb->s_blocksize is needed only for indirect-block based
scheme (due to an implementation quirk in ext4_ind_remove_space()). But
ext4_ext_remove_space() should be fine with punch hole ending right at
sb->s_maxbytes. And since I find it somewhat odd that you can create file
upto s_maxbytes but cannot punch hole to the end, it'd limit that behavior
as much as possible. Ideally we'd fix ext4_ind_remove_space() but I can't
be really bothered for the ancient format...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

