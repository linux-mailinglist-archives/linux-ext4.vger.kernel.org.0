Return-Path: <linux-ext4+bounces-13701-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJpRDq3kkmndzgEAu9opvQ
	(envelope-from <linux-ext4+bounces-13701-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 10:34:37 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE25141FBD
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2741A3004F1B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC002DB7A9;
	Mon, 16 Feb 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eOFVj+nH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e9h6n7W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eOFVj+nH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e9h6n7W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6342D2495
	for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234473; cv=none; b=t3tMvnUWwGD9e6QGHFbWyUyKU/Duv425RMsqUHQ7SlIEd/egBWQSsrSldotCvQCPk0ITc9EqBiwW6t0cFgZ+ga3MBktfpTy09ft/hEzqs8PKok1uwHSE3KAUFpV6HW+c71FS5K3HZ70oCjtau7TMtVfLlvwGZWFWP9czW8VkKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234473; c=relaxed/simple;
	bh=jhMntOyS8kfKSMCQX1szEC2w1VIVF0WqxofuxaLd/tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJpxPEb3BlUf6eN4efBwQsh7VDojNoNvH43DvDt+sjrU441sUyQzwoAgqGr+fWDsFvpLyZNbLKf8eKMYrjN5y7/QfmSO3B39rSvv3Vu6nswVqxEea2xKz1c/vkxNKZjkh6R/t2zmRyECJUtgBklbRrO3yBZv29n/iHdXBj8szNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eOFVj+nH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e9h6n7W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eOFVj+nH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e9h6n7W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A81685CE53;
	Mon, 16 Feb 2026 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771234469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCszzZsjqv86kyDYo8qvw9YJ7L3pIGbbLC2tAnq4Pik=;
	b=eOFVj+nHMTli7bxHkOQDoz5KPXwPx6diiDMWUdiey/emVGuV9NGaHcKp0FkAG0sxLdb/7x
	IPPv7p3288qFxdMaQDGfAntctiAcNANUC4S2Vlr9ldRl0MxOlgwzGx4E1bjD421YLXT0ZK
	7WJI2vRPJQpytoP9jMp72vMXn0b8qYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771234469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCszzZsjqv86kyDYo8qvw9YJ7L3pIGbbLC2tAnq4Pik=;
	b=0e9h6n7Wkxi13NMHcyZbXPESR9pmHQn2j1iaue7dVcxM7jAgbW/UYKnO5qaR+9mqRIej9Y
	Zbv/Aj3avysTEbCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eOFVj+nH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0e9h6n7W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771234469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCszzZsjqv86kyDYo8qvw9YJ7L3pIGbbLC2tAnq4Pik=;
	b=eOFVj+nHMTli7bxHkOQDoz5KPXwPx6diiDMWUdiey/emVGuV9NGaHcKp0FkAG0sxLdb/7x
	IPPv7p3288qFxdMaQDGfAntctiAcNANUC4S2Vlr9ldRl0MxOlgwzGx4E1bjD421YLXT0ZK
	7WJI2vRPJQpytoP9jMp72vMXn0b8qYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771234469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCszzZsjqv86kyDYo8qvw9YJ7L3pIGbbLC2tAnq4Pik=;
	b=0e9h6n7Wkxi13NMHcyZbXPESR9pmHQn2j1iaue7dVcxM7jAgbW/UYKnO5qaR+9mqRIej9Y
	Zbv/Aj3avysTEbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 924023EA62;
	Mon, 16 Feb 2026 09:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aM+vI6Xkkml+dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 09:34:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19E6CA0AA5; Mon, 16 Feb 2026 09:56:07 +0100 (CET)
Date: Mon, 16 Feb 2026 09:56:07 +0100
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Zorro Lang <zlang@redhat.com>, 
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <bgtrbxzrwih2j2bgoanwf5sgl4go5xy6fxnvknkgnugqtkl5pt@iy6bcuqrx5ku>
References: <20260210111707.17132-1-jack@suse.cz>
 <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <zh372qbq2tq722476eaqrirmi55hxwzfs6msmzxfj6zv3jws5y@rdip5a6twsf6>
 <20260212164402.tbjcalfmeq6jfwum@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212164402.tbjcalfmeq6jfwum@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13701-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CFE25141FBD
X-Rspamd-Action: no action

On Fri 13-02-26 00:44:02, Zorro Lang wrote:
> On Thu, Feb 12, 2026 at 11:41:59AM +0100, Jan Kara wrote:
> > > I initially considered calling _require_metadata_journaling directly inside
> > > _require_scratch_shutdown. However, I decided against it because some cases might
> > > only need the shutdown ioctl and don't strictly require a journal.
> > 
> > Absolutely. I think they should stay separate.
> > 
> > So to summarize I think we should still add _require_metadata_journaling to:
> > 
> > overlay/087
> > g/536
> > g/622
> > g/722
> 
> Agree :)

Should I send patches or will you do this modification?

> > and we might add fsync of parent directory before shutdown to g/737 and
> > overlay/078. Does this sound good?
> 
> I'm concerned that adding broader sync or fsync operations might interfere with the
> test's original intent. We should probably evaluate the impact further. Alternatively,
> we could simply use _require_metadata_journaling to ensure we at least keep the
> coverage for the original bug :)

I agree with the approach to just leave the test as is for now and invest time
into deciding what's the proper solution once someone complains :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

