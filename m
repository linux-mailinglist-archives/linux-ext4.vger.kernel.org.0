Return-Path: <linux-ext4+bounces-1598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781FC87884F
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 19:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1791B2352F
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F15820C;
	Mon, 11 Mar 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zmOzdwSi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k3Ek2dYy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nVBa5A9y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwxyjPUs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C905D737
	for <linux-ext4@vger.kernel.org>; Mon, 11 Mar 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182769; cv=none; b=aEs3KAg7jdHECu/QWmXCR/dm8mvlMf8s4qxGaVynebR0MOue+VW/WX6KmsIoYOA2H4UjaJONHQbawh1fDnmr0cbO7/3HpA7LOI0yH+4bE6yIU0Rcs19DG7NfZrbTj7b3CQhCSh/qr34GB//rpeH+93gjCTdF+CHZBiH7SW0rVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182769; c=relaxed/simple;
	bh=IPkeIKLyeezRlKhwt0WQAaBm6B/AGs7CH1DZnJdN0Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObmF0anibdCsfuH7P16htLkyeA4Tyi4BE4aS+l6CBBZnBV+x+VQEZ+1Ap1ypNsX1QvBkJOFIdp12Fm41jK3uSwAXSzTAD7RLbwJNrKAlOQ34JxT4r1POCwLH76IhRM7d1xhdhM9EgdS6SMxm2+A4/1VyaNmeArUGn4KOgleUXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zmOzdwSi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k3Ek2dYy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nVBa5A9y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwxyjPUs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B72EF34F80;
	Mon, 11 Mar 2024 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcjwda627rqysjAn/ec+Lv5MxtoJz5h4petVIK+1VgI=;
	b=zmOzdwSiA6rjAbZDuhoZyvFyRWVbDBea/sbmynlq4cFHW3YR/QuxSbEtQJo6RUsWeaW22u
	S21eiyjPWNvhmK52B+WjfE34ZG17vf8JQ70aJqpwz4AN1b7yA1k+/m5ULf8fhoKiA34lJi
	AiSGqXm+z+SU/x2gms36JX42OvAix1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcjwda627rqysjAn/ec+Lv5MxtoJz5h4petVIK+1VgI=;
	b=k3Ek2dYyfTC+Tc4ZI9ujGX1c20kCjRYQ9sv+u/Cew6cr7i+TOAE98/MhHL8oBAMIhKMOkE
	oZ8trWQmyKGLIpAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcjwda627rqysjAn/ec+Lv5MxtoJz5h4petVIK+1VgI=;
	b=nVBa5A9yORToR6RkyOxPjWNeeXft6aDaGsb9tGqHGEVIUBC02SiiHUS3UjYFodiDYbl3Em
	v+rvwh8mATosccWYxzZbnDR5QVtDcW+YjCzQkcvftqys9bY0p0HukdSqthA9CaupExzY6p
	mSLk0pKxbPcCfx0DR3Spcv1iUVzYOtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcjwda627rqysjAn/ec+Lv5MxtoJz5h4petVIK+1VgI=;
	b=zwxyjPUsWABUcher0vTLAJveJLb3TsVYFV5qXQX/20JGJXwSAJkUrqUdxbtvg1A/tyJ/P5
	vxdZOhByncr0GMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1D713695;
	Mon, 11 Mar 2024 18:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D4YDKmxR72W5QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 18:46:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90395A080A; Mon, 11 Mar 2024 19:45:57 +0100 (CET)
Date: Mon, 11 Mar 2024 19:45:57 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: Fixes len calculation in
 mpage_journal_page_buffers
Message-ID: <20240311184557.3apdu2nhen3cgbjn@quack3>
References: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nVBa5A9y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zwxyjPUs
X-Spamd-Result: default: False [1.58 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.11)[65.99%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.58
X-Spam-Level: *
X-Rspamd-Queue-Id: B72EF34F80
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 29-02-24 11:40:13, Ritesh Harjani (IBM) wrote:
> Truncate operation can race with writeback, in which inode->i_size can get
> truncated and therefore size - folio_pos() can be negative. This fixes the
> len calculation. However this path doesn't get easily triggered even
> with data journaling.
> 
> Cc:  <stable@kernel.org> # v6.5
> Fixes: 80be8c5cc925 ("Fixes: ext4: Make mpage_journal_page_buffers use folio")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 537803250ca9..bab9223d94ac 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2334,7 +2334,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
>  
>  	if (folio_pos(folio) + len > size &&
>  	    !ext4_verity_in_progress(inode))
> -		len = size - folio_pos(folio);
> +		len = size & (len - 1);
>  
>  	return ext4_journal_folio_buffers(handle, folio, len);
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

