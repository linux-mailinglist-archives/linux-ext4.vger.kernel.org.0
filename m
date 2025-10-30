Return-Path: <linux-ext4+bounces-11366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D61C20AE2
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0EF1896182
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EA274FF5;
	Thu, 30 Oct 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+zzT/UB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo26M07j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+zzT/UB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo26M07j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A026F45A
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834951; cv=none; b=JigpXUrxqJUpzWrQF4SDW+s73oe32TnohRNOvwZM3M/IP7VenBhCDHE1+AkLX8BTqaZSqwqszKlBBlVcgKgfzP2ib7OTfXPH6qzGKMURvY3IBHhxr8bJYLwJsQ08I5M9YqP41s2zFoofNrtBQcB3sB8N+61vPdhrT6z/hx79Fhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834951; c=relaxed/simple;
	bh=1b6TBstDDekRQobMI1Biy75gq1GMDUBiEBSC6Z4b5Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXqlXoSv2alVnwpNzz5QuMyAvk1tPuar1TG14Pdu2oxdJPRLs9sqxquB7VObRT1cJ0+Wcm/5460SHSxbRylXUkhcZmwZ5TOVTybjgCXnA5AVpbh65jQ2shcuNSByPwp0jpg9wfhF1Zg3wldZTotGd6sKv3nUeAkTLyJaomMnunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+zzT/UB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo26M07j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+zzT/UB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo26M07j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E1EA1F88A;
	Thu, 30 Oct 2025 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761834947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJBY+7WN8pUZ7BL5b9TfJ0orEZ9d/pc565rFs0g1Cf0=;
	b=W+zzT/UBbEvDTjbKFqd2EcQDFGmk7FKNscdPOv1I/4wT5dDK1USXSu/0ESRIckmgVnNijo
	WRoJWIYG3lfWmG46tBxUT5i+hl/ZRyg+0YQpP5Kjqd5ZdPCE6Q1/r601U4+kSmRqUEHiHL
	oFLJYPFHS1mVRbThl1mjnVS4/RhwZRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761834947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJBY+7WN8pUZ7BL5b9TfJ0orEZ9d/pc565rFs0g1Cf0=;
	b=Yo26M07jw1OLhnqf0Pa8mezu3jEDm6K7dmtSK8p3SUM0BJgGM9ZUbRtmbspS43/+DBBF59
	ckX/H+bSSaUs1ECA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="W+zzT/UB";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Yo26M07j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761834947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJBY+7WN8pUZ7BL5b9TfJ0orEZ9d/pc565rFs0g1Cf0=;
	b=W+zzT/UBbEvDTjbKFqd2EcQDFGmk7FKNscdPOv1I/4wT5dDK1USXSu/0ESRIckmgVnNijo
	WRoJWIYG3lfWmG46tBxUT5i+hl/ZRyg+0YQpP5Kjqd5ZdPCE6Q1/r601U4+kSmRqUEHiHL
	oFLJYPFHS1mVRbThl1mjnVS4/RhwZRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761834947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJBY+7WN8pUZ7BL5b9TfJ0orEZ9d/pc565rFs0g1Cf0=;
	b=Yo26M07jw1OLhnqf0Pa8mezu3jEDm6K7dmtSK8p3SUM0BJgGM9ZUbRtmbspS43/+DBBF59
	ckX/H+bSSaUs1ECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5053813393;
	Thu, 30 Oct 2025 14:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MNgvE8N3A2mqKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 Oct 2025 14:35:47 +0000
Message-ID: <48170d2a-04ef-41be-97d2-f4927d04b046@suse.cz>
Date: Thu, 30 Oct 2025 15:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 1/7] mm/slab: allow specifying freepointer offset
 when using constructor
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Christian Brauner <brauner@kernel.org>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@linux.com,
 dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
 rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
 shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-2-harry.yoo@oracle.com>
 <CAJuCfpF5gG63njY436vctG-Tzbco8X9a1w3YA=u1AGrRqxVshg@mail.gmail.com>
 <aQG97ocbfd0T-clN@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aQG97ocbfd0T-clN@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7E1EA1F88A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.com,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.cz:dkim,suse.cz:mid,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 10/29/25 08:10, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 10:43:16AM -0700, Suren Baghdasaryan wrote:
>> On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>> >
>> > When a slab cache has a constructor, the free pointer is placed after the
>> > object because certain fields must not be overwritten even after the
>> > object is freed.
>> >
>> > However, some fields that the constructor does not care can safely be
>> > overwritten. Allow specifying the free pointer offset within the object,
>> > reducing the overall object size when some fields can be reused for the
>> > free pointer.
> 
> Hi Suren, really appreciate you looking into it!
> 
>> Documentation explicitly says that ctor currently isn't supported with
>> custom free pointers:
>> https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/slab.h*L318
>> It obviously needs to be updated but I suspect there was a reason for
>> this limitation. Have you investigated why it's not supported?
> 
> commit 879fb3c274c12 ("mm: add kmem_cache_create_rcu()") says:
>> When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
>> must be located outside of the object because we don't know what part of
>> the memory can safely be overwritten as it may be needed to prevent
>> object recycling.
> 
> The reason the slab allocator requires the free pointer to be
> outside the object is the same: we don't know which fields
> should not be overwritten, since users may assume a certain state
> for specific fields in newly allocated objects.
> 
> If users don't initialize certain fields in the constructor, they
> should not assume any particular state for those fields, and they may
> therefore be overwritten.
> 
>> That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
>> new cacheline. This is the case for e.g., struct file. After having it
>> shrunk down by 40 bytes and having it fit in three cachelines we still
>> have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
>> accommodate the free pointer.
>> 
>> Add a new kmem_cache_create_rcu() function that allows the caller to
>> specify an offset where the free pointer is supposed to be placed.
> 
> I'm not sure why Christian added support only for SLAB_TYPESAFE_BY_RCU
> and not for constructors, but I don't see anything that would prevent
> extending it to support constructors as well.

IIRC we considered it and only left it for later because there was no user
yet, so we wouldn't have a proof that it works and we're not missing
something. If you have a user now, it's legit to do it, and there are no
known theoretical obstacles to it. Obviously docs should be updated at the
same time then.
>> I remember looking into it when I was converting vm_area_struct cache to
>> use SLAB_TYPESAFE_BY_RCU but I can't recall the details now...
> 


