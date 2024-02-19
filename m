Return-Path: <linux-ext4+bounces-1282-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37285A974
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D69B2178D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985D44388;
	Mon, 19 Feb 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ca9iegZ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WIaFzA04";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ca9iegZ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WIaFzA04"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3E40BEF
	for <linux-ext4@vger.kernel.org>; Mon, 19 Feb 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361962; cv=none; b=G9J8yD98D6n12XzRye66lVrhl5ZbEPFqPmIrkLwPD3QVyAnf1JxhfsGjIbD8yOpnTCd+Rl5bu6qrZkMWi5wJXaGyfEY8+wSSB0VSFCIDGptrsvqT48syIoefGFb4o7OA1CpapMFykQBENNcmcqWfysl/n4L2xzJCBqWpJskTbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361962; c=relaxed/simple;
	bh=frYXtZHPBTVTmumrvadz0GHkuzrTxG5w+sCpMtDA2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHRvx9i4x4AcyXbAKy2/nydcZ0i+9jdQ7l5nvfZXo4NJ1bMZ84xCQ0DwI3G5dgih45qe0vGeNS3rZFcHi1r5KP0hPWQIJWbKNclCZGxhJdyAmw5IeJE+iRII+5/SbC/l9ihsjQkqfcNggau94hRi+EPBUCfrG1YLEZVsOFwhtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ca9iegZ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WIaFzA04; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ca9iegZ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WIaFzA04; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1661F80E;
	Mon, 19 Feb 2024 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708361959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uBbudS1gtwKw0eu0a8pkhpaKCNj4+tMftlyqLwF15U=;
	b=ca9iegZ+boNSsXEysebb4Av80hLufcOqmHFUIems7JgiFSBBtL1CiYT1gCkTsfXPp3HW0T
	SjOviVOiCMNH/EzsFKTqiz8FFINRjztii+WotUruuMZBbJ9IF8JtVHWIG2n/UA4Qy2ZBDv
	hRUYdfnF8XtIHQZdn6Z2CTBsAfUaAD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708361959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uBbudS1gtwKw0eu0a8pkhpaKCNj4+tMftlyqLwF15U=;
	b=WIaFzA04XeeAMu2nWGVTB9dbD9la+eKjfamR9KSzH9na03gsXufYRt6/uoCi10PxhtVRf+
	ETnlSDdNOfKTW+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708361959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uBbudS1gtwKw0eu0a8pkhpaKCNj4+tMftlyqLwF15U=;
	b=ca9iegZ+boNSsXEysebb4Av80hLufcOqmHFUIems7JgiFSBBtL1CiYT1gCkTsfXPp3HW0T
	SjOviVOiCMNH/EzsFKTqiz8FFINRjztii+WotUruuMZBbJ9IF8JtVHWIG2n/UA4Qy2ZBDv
	hRUYdfnF8XtIHQZdn6Z2CTBsAfUaAD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708361959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uBbudS1gtwKw0eu0a8pkhpaKCNj4+tMftlyqLwF15U=;
	b=WIaFzA04XeeAMu2nWGVTB9dbD9la+eKjfamR9KSzH9na03gsXufYRt6/uoCi10PxhtVRf+
	ETnlSDdNOfKTW+Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E96FA139C6;
	Mon, 19 Feb 2024 16:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pe74OOaI02WHNgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 16:59:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91EC1A0807; Mon, 19 Feb 2024 17:59:18 +0100 (CET)
Date: Mon, 19 Feb 2024 17:59:18 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH] ext4: Verify s_clusters_per_group even without bigalloc
Message-ID: <20240219165918.4fkei72hlcjxs4ol@quack3>
References: <20240213101515.17328-1-jack@suse.cz>
 <d448648e-29dd-6f43-d141-f424c594fae2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d448648e-29dd-6f43-d141-f424c594fae2@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ca9iegZ+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WIaFzA04
X-Spamd-Result: default: False [0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.04%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.17
X-Rspamd-Queue-Id: 0B1661F80E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sun 18-02-24 10:16:40, Zhang Yi wrote:
> Hello!
> 
> On 2024/2/13 18:15, Jan Kara wrote:
> > Currently we ignore s_clusters_per_group field in the on-disk superblock
> > if bigalloc feature is not enabled. However e2fsprogs don't even open
> > the filesystem is s_clusters_per_group is invalid. This results in an
>                  ^^
>                  if
> > odd state where kernel happily works with the filesystem while even
> > e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
> > even if bigalloc feature is not enabled to make things consistent. Due
> > to current e2fsprogs behavior it is unlikely there are filesystems out
> > in the wild (except for intentionally fuzzed ones) with invalid
> > s_clusters_per_group counts.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/super.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 0f931d0c227d..522683075067 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4451,7 +4451,15 @@ static int ext4_handle_clustersize(struct super_block *sb)
> >  				 sbi->s_blocks_per_group);
> >  			return -EINVAL;
> >  		}
> > -		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
> > +		sbi->s_clusters_per_group =
> > +			le32_to_cpu(es->s_clusters_per_group);
> > +		if (sbi->s_blocks_per_group != sbi->s_clusters_per_group) {
> > +			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
> > +				 "clusters per group (%lu) inconsistent",
> > +				 sbi->s_blocks_per_group,
> > +				 sbi->s_clusters_per_group);
> > +			return -EINVAL;
> > +		}
> 
> This is almost the same with the code snippet in bigalloc branch, would
> it be better to factor them out and reuse this hunk in both branch, just
> like the check e2fsprogs does?

Yeah, good point. Let me send v2.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

