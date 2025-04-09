Return-Path: <linux-ext4+bounces-7171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BBA8227F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A0F3AAE18
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5825D8EC;
	Wed,  9 Apr 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCWhznDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rT0KkMH/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HCWhznDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rT0KkMH/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FC1DDC23
	for <linux-ext4@vger.kernel.org>; Wed,  9 Apr 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195372; cv=none; b=k0tJWuDO8JL9OsIFtxKUgZbPPbpVJ4o9AF759YmjDfVb7GT0J6T4djBZwCX/57LPMxDzdNXA4uwNg7XDETdiSdNBPJw0th/D7kxgRfQSR2gYpwd3DHVVbt3b0aRGUuBXpULsM8aYJDnI3x14lu89OXoncG0q1Ljli95FDrsWuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195372; c=relaxed/simple;
	bh=EdCjpD8KSUrLuHs5GvIkdcerRehZ40AK1poflo4d2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djVGLU8TPLuFtu2kCepKi4MViKKV0qmPEv45OV1DbXII1w9kFuab0VE2TQcdsWH3fizROOftDwcrNbxPm05WFZzR4t/VeV1ZPU5BLrcB80QDuUjMcUnH3n+UWOub4jqHjZUL07zjN/UGb2zx1S+r1znx+zTnObbIknBQV/2c1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HCWhznDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rT0KkMH/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HCWhznDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rT0KkMH/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C122421169;
	Wed,  9 Apr 2025 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744195368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yen6uUM+rymVHNJ1ppKOFMdkW13sc3zHqEh7q670KX0=;
	b=HCWhznDUKFBV83n2K/OHI8uPFkO+hBE+L385r6JhK3IVciLS5fWENZYdz8RIu2J9+nzv+p
	Hm9isDnYmA+vpR90moAaR8KugyylDl1ZSoK7CvpZyInHvK4bAW8siJnWj/9gVNTdVA5G8v
	Kzz43O2LYpmJWz+klV00BHQBO2pRtvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744195368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yen6uUM+rymVHNJ1ppKOFMdkW13sc3zHqEh7q670KX0=;
	b=rT0KkMH/b8UG/NRNl/bkB1rAntWBtQsjK3NLBDy/p4I1VlCn7UzIDJFzj69aVK/E969g3+
	qyLqRcEJqB0HN9CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744195368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yen6uUM+rymVHNJ1ppKOFMdkW13sc3zHqEh7q670KX0=;
	b=HCWhznDUKFBV83n2K/OHI8uPFkO+hBE+L385r6JhK3IVciLS5fWENZYdz8RIu2J9+nzv+p
	Hm9isDnYmA+vpR90moAaR8KugyylDl1ZSoK7CvpZyInHvK4bAW8siJnWj/9gVNTdVA5G8v
	Kzz43O2LYpmJWz+klV00BHQBO2pRtvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744195368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yen6uUM+rymVHNJ1ppKOFMdkW13sc3zHqEh7q670KX0=;
	b=rT0KkMH/b8UG/NRNl/bkB1rAntWBtQsjK3NLBDy/p4I1VlCn7UzIDJFzj69aVK/E969g3+
	qyLqRcEJqB0HN9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3EE13691;
	Wed,  9 Apr 2025 10:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aL/EKihP9me3CQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Apr 2025 10:42:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3BFADA0838; Wed,  9 Apr 2025 12:42:48 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:42:48 +0200
From: Jan Kara <jack@suse.cz>
To: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: fix off-by-one error in do_split
Message-ID: <z4fxzkutn3bjrpb4kmezorp6hbbapsvmijoznbny5ll2qajmm5@i5dl3zy2inch>
References: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
 <odgkvml62unm4ux3sbnympgyzj22z7dwjgdvdmlbgtiybq4j7z@gnnaygdp7muw>
 <fc291720-bba7-4799-b451-ae7c84e6697c@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc291720-bba7-4799-b451-ae7c84e6697c@ispras.ru>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 08-04-25 16:38:36, Artem Sadovnikov wrote:
> On 07.04.2025 16:02, Jan Kara wrote:
> > Thanks for debugging this! The fix looks good, but I'm still failing to see
> > the use-after-free / end-of-buffer issue. If we wrongly split to two parts
> > count/2 each, then dx_move_dirents() and dx_pack_dirents() seem to still
> > work correctly. Just they will make too small amount of space in bh but
> > still at least one dir entry gets moved? Following add_dirent_to_buf() is
> > more likely to fail due to ENOSPC but still I don't see the buffer overrun
> > issue? Can you please tell me what I'm missing? Thanks!
> 
> add_dirent_to_buf() only checks for available space if its de parameter
> is NULL, but make_indexed_dir() provides a non-NULL de, so that space
> check is skipped entirely. add_dirent_to_buf() then calls
> ext4_insert_dentry() which will write a filename that's potentially
> larger than entry size and will cause an out-of-bounds write.

Indeed. I didn't notice this detail. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

