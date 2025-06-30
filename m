Return-Path: <linux-ext4+bounces-8721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64070AEE607
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BE1899DEB
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537A2C031B;
	Mon, 30 Jun 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DR19nqDT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iM0UBs/8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0rr6qM2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mQo3tjy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5529009A
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305306; cv=none; b=APkPxlBOcTGUMe5d4BVzqBFcNpeA5zuEgpTAGeWwwkDmKhFirhjjxoYvvg1IY5Z3j6iYWS5X3uFZ+z6QvVLjSj/s0bP6oynuyL8mtgfq7UbK2FYRXtG8xoe8671pbSXgTXJTDKArl7aLNLLiIps3GiFPsQux7B7FX8klky8Q+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305306; c=relaxed/simple;
	bh=MKC6WgTK53IkV2utREflpT+8t0y2MRP28JRtYbd3T/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaZl7vyv7F4Vt68aHxFtBaeN5kSv+5lJi1Ao7dArAQ4a6AUAsui+gWHZTWNHxoe2rip7AOCK6dE5XWaYJSeJQ8+SEkBNStHlSeN7gug/PUpbqP/Yw1m1Pou7t23tkM1i4q+Jal4wazegLQU88NzoWoMcQ7yKb8eeQrHosr0uBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DR19nqDT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iM0UBs/8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0rr6qM2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mQo3tjy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE31921163;
	Mon, 30 Jun 2025 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751305303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DduZmfIRYnUE6a825bqzfBebQAdLHgav/Uc/BQtMODE=;
	b=DR19nqDTijWhJeX4xPeGV44KlrwL2eGV6JR5Xv1gRw6g64pUYQ88MTsQssHsw3ds92fMjN
	HTajtB/wfOil/3H/qrr2MaQbEPkN3TRYY2RFkNAWLUc8TRn6Xc8IlP8WayaOFq91A5jJON
	ajIQ6HUk9NYqD8/ZpPtrarvOpEsle9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751305303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DduZmfIRYnUE6a825bqzfBebQAdLHgav/Uc/BQtMODE=;
	b=iM0UBs/8C6I1QPNWt5sK+4iEh9VLDUo13U7Df2t4PfWMkXkEbX2zKLq85Yu3BFLdyELVR1
	U+6wwkdlfgqrDDAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c0rr6qM2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1mQo3tjy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751305301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DduZmfIRYnUE6a825bqzfBebQAdLHgav/Uc/BQtMODE=;
	b=c0rr6qM2HRK65PiynbHtAo6ET06R3c3PUeMVRoKKM+xOaAYeelQI81pa1P2z5MfarwdzAo
	DBYeApdotaBzNiv0x6D4Qzq84mDZs+O21TdfMKgVb2lI8cLIGdQ3vLFR0DBENLWcOWx93n
	CxOnBuOExLm0F6iM8CTEb+ZwWQd0Ttk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751305301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DduZmfIRYnUE6a825bqzfBebQAdLHgav/Uc/BQtMODE=;
	b=1mQo3tjyazJuJNrxsY21lFDbDUXLKrZktDHDzok+lHiIrfzFuyJzuoCkpk1307tfmpD2ib
	qpfreVDyO6b3KSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C833C1399F;
	Mon, 30 Jun 2025 17:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YeeSMFXMYmhPLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 17:41:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 592DEA0A31; Mon, 30 Jun 2025 19:41:41 +0200 (CEST)
Date: Mon, 30 Jun 2025 19:41:41 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 04/16] ext4: utilize multiple global goals to reduce
 contention
Message-ID: <trjf7lqckchx6bc3p4lwh5yy3bqczo6yvdll7ujguhvvezwtja@cpfhj6ai7gzp>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-5-libaokun1@huawei.com>
 <xmhuzjcgujdvmgmnc3mfd45txehmq73fiyg32vr6h7ldznctlq@rosxe25scojb>
 <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
 <qtdxe2rmnvrxdjmp26ro4l5erwq5lrbvmvysxfgqddadnpr7x4@xrkrdjkgsh67>
 <4f15d0aa-39e0-42ef-a9ca-ddbb3ff36060@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f15d0aa-39e0-42ef-a9ca-ddbb3ff36060@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DE31921163
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 30-06-25 18:02:49, Baokun Li wrote:
> On 2025/6/30 16:38, Jan Kara wrote:
> > We could make streaming goal to be ext4_fsblk_t so that also offset of the
> > last big allocation in the group is recorded as I wrote above. That would
> > tend to pack big allocations in each group together which is benefitial to
> > combat fragmentation even with higher proportion of groups that are streaming
> > goals (and likely becomes more important as the blocksize and thus group
> > size grow). We can discuss proper number of slots for streaming allocation
> > (I'm not hung up on it being quarter of the group count) but I'm convinced
> > sb->s_groups_count is too much :)
> > 
> > 								Honza
> 
> I think sbi->s_groups_count / 4 is indeed acceptable. However, I don't
> believe recording offsets is necessary. As groups become larger,
> contention for groups will intensify, and adding offsets would only
> make this contention worse.

I agree the contention for groups will increase when the group count goes
down. I just thought offsets may help to find free space faster in large
groups (and thus reduce contention) and also reduce free space
fragmentation within a group (by having higher chances of placing large
allocations close together within a group) but maybe that's not the case.
Offsets are definitely not requirement at this point.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

