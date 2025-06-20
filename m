Return-Path: <linux-ext4+bounces-8573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3EAE1F96
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D754B3BC7E8
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF32D3A7A;
	Fri, 20 Jun 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvc2nOpN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X8PA2Vj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvc2nOpN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X8PA2Vj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A72D4B42
	for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434961; cv=none; b=KdzP9V0x24f47Vdh2/agt7tSUAjg4DsypDNNmO+sduXnhnKMDZgKlHYHFboxQB7AODn3Z2rnZIjOwhY/+ts/K0yB+aSAGrqw1zap4eZD1sHP7FueNIEcGteqMxCqk74nXAEyjFf0y5RceDjUbF4SqRckef3jH9YShAOfGBonLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434961; c=relaxed/simple;
	bh=p7Nb0khwUEHR5yfrT3OfmE2VkDA7t7oJqSg5spcJcIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j365v4JVxde9LCO08wCnr0Gf5cWeEr+vHiXX9orpOO2TciLpPUH6n+p3nxb3S5K6eAe4NwoVuVHQJ5XPZV2ytD1UmWPCdygdxRp3n7C+x12+e7uQIY1GG7KyBszbq0pU+9lTf5r/4CPElOKPaazpPG3i6XXUw4DZ551ANhWXDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvc2nOpN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X8PA2Vj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvc2nOpN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X8PA2Vj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1D7821216;
	Fri, 20 Jun 2025 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750434958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q74bddg/Lybxm3bPnUkwZDUfV+Qbp/SK7AIO2GcrpD8=;
	b=wvc2nOpNUWLDHTCZA7mJH0d5qm4AgAIFufDZ/CjDMI2dros2kjjDyF7Er8HjtYRAsAVxci
	JA3akLAS4ONiOdXekbiul/kXh8hBGuGPYKuushPG2XAwOGTvQHItYP1m6ylTLs3vMbMEc2
	2pxRv1OPE3dtMllNLfF3jtl3sKeqOXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750434958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q74bddg/Lybxm3bPnUkwZDUfV+Qbp/SK7AIO2GcrpD8=;
	b=1X8PA2VjM9UJZYM14ZOuh6lSi8Xt06w5XFXrpgCq7ixX3C91roz6Fk0ECqCWh2OlnzCs6X
	dbpx2rQs+u9L6aDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750434958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q74bddg/Lybxm3bPnUkwZDUfV+Qbp/SK7AIO2GcrpD8=;
	b=wvc2nOpNUWLDHTCZA7mJH0d5qm4AgAIFufDZ/CjDMI2dros2kjjDyF7Er8HjtYRAsAVxci
	JA3akLAS4ONiOdXekbiul/kXh8hBGuGPYKuushPG2XAwOGTvQHItYP1m6ylTLs3vMbMEc2
	2pxRv1OPE3dtMllNLfF3jtl3sKeqOXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750434958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q74bddg/Lybxm3bPnUkwZDUfV+Qbp/SK7AIO2GcrpD8=;
	b=1X8PA2VjM9UJZYM14ZOuh6lSi8Xt06w5XFXrpgCq7ixX3C91roz6Fk0ECqCWh2OlnzCs6X
	dbpx2rQs+u9L6aDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A8213736;
	Fri, 20 Jun 2025 15:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u5CBJI6EVWiSZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Jun 2025 15:55:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CF70A08DD; Fri, 20 Jun 2025 17:55:58 +0200 (CEST)
Date: Fri, 20 Jun 2025 17:55:58 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>
Subject: Re: LBS support for EXT4
Message-ID: <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
X-Spam-Flag: NO
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

[added ext4 list and Zhang to CC]

Hi,

On Thu 19-06-25 15:05:14, Pankaj Raghav wrote:
> Hello Jan and Ted,
> 
> As you might know, I added LBS support to XFS sometime back. And after
> that Luis added LBS support to block devices/buffer head path.
> 
> And now that EXT4 supports large folios, it should be possible to add LBS
> support to EXT4.
> 
> I started digging in to the code, and it looks like it might require some
> rework throughout EXT4 and lot of testing.
> 
> My question is:
> 
> I have seen patches from Zhang Yi to add iomap buffered IO support to EXT4.
> If that happens, then adding LBS support should become trivial.
> 
> Do you think it might happen soon or it is going to take more time?
> Seeing the patches it is hard for me to say what the status is as the
> last patches posted for them was last year.

Well, time is always relative so it's difficult to tell what do you mean by
"soon" :). We are definitely interested in converting ext4 to iomap.
Currently we are fixing up some remaining issues caused by conversion to
support large order folios but after that iomap conversion would be a next
logical step. Zhang Yi had patches for that, I'm not sure how much from
them is left to apply after the large order folios have landed.

> The reason I am asking is, should I take up the challenge to add LBS
> support with buffer heads in EXT4, or should I wait until iomap patches
> are merged.

I think better spent time would be to help with the iomap conversion. I
don't think there will be that much coding left (perhaps some more exotic
features need attention) but there's definitely testing needed and review
is always welcome and most needed...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

