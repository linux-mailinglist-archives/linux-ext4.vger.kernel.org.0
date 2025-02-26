Return-Path: <linux-ext4+bounces-6578-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F42A4675C
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D980C7A98F4
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDA2248B3;
	Wed, 26 Feb 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zCxcJ9hx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bzBiBK1y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zCxcJ9hx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bzBiBK1y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7971DE2A9
	for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589438; cv=none; b=oalUTSe4Wy41JjBmQhf79u2lSjTzj7gihivvGrzAeCIDBDgWLcrfm8ntDv8zWC3ftc6SN+rDUnuNKVLRL6k+H5/bmn08FeN/MYQHtEJyDB4a+dmNvFBGiQE12fcBRq66msiQ84y89QA4SnvoX7joiX+pAby/u+aNt9oQO1YeE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589438; c=relaxed/simple;
	bh=vCN/BAa0LBpqW9hAtWwnZlpWuyb28VcZXp8WHid+WyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHpCn439grWj1J39IEtXBiGjSIS9EXCSoypMyyq5ZuNpVc/I/eC/Vy8lVLPEKETlZx8oUdYwg23sZikIEUDd4qpbQWNzAZ3bzNvFY0upYoVct6ZPm8OE9cRPKbdoJ6MqxgUjUXstpY2BUkHEy/NtnTkpwxGilaMNg9CHvqm99GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zCxcJ9hx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bzBiBK1y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zCxcJ9hx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bzBiBK1y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2E3F1F38A;
	Wed, 26 Feb 2025 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740589433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yySr0gLCaV9Evf3yp5Yv/r0cooh0lEPYRAz8B+Am8e8=;
	b=zCxcJ9hxBXbOENQOi/AKNI1S0wiLL6aYLqM8BIad6imfGMneUj0sR+EGvGOjCqNokIBfVn
	x7mILKTfhhd6DnKu6ixwT9+N/4cgR7dq1RytPa6g1hbbCBIFg8rJPqbjbF5Z1T/6WnKTeG
	Dp5raggCT93vuwGk4luCnY4xrwkbMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740589433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yySr0gLCaV9Evf3yp5Yv/r0cooh0lEPYRAz8B+Am8e8=;
	b=bzBiBK1yO0E8XBEBtYN7p8GzRBX5WHZcwG8WWqRwhYJUq8GjG8RBTJaG5Sh5R6Mpb7QOsn
	XXdKf1x/U/oUnJDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740589433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yySr0gLCaV9Evf3yp5Yv/r0cooh0lEPYRAz8B+Am8e8=;
	b=zCxcJ9hxBXbOENQOi/AKNI1S0wiLL6aYLqM8BIad6imfGMneUj0sR+EGvGOjCqNokIBfVn
	x7mILKTfhhd6DnKu6ixwT9+N/4cgR7dq1RytPa6g1hbbCBIFg8rJPqbjbF5Z1T/6WnKTeG
	Dp5raggCT93vuwGk4luCnY4xrwkbMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740589433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yySr0gLCaV9Evf3yp5Yv/r0cooh0lEPYRAz8B+Am8e8=;
	b=bzBiBK1yO0E8XBEBtYN7p8GzRBX5WHZcwG8WWqRwhYJUq8GjG8RBTJaG5Sh5R6Mpb7QOsn
	XXdKf1x/U/oUnJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9EC51377F;
	Wed, 26 Feb 2025 17:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2bZiLXlJv2eregAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Feb 2025 17:03:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 71E9FA08B5; Wed, 26 Feb 2025 18:03:53 +0100 (CET)
Date: Wed, 26 Feb 2025 18:03:53 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>, 
	jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2: convert to the new mount API
Message-ID: <icjrsdd2irambcw4woz7p7m2ebwonpr6dqwzczyalz5d2iwmie@wn25mu252mcr>
References: <20250223201014.7541-1-sandeen@redhat.com>
 <20250223201014.7541-2-sandeen@redhat.com>
 <goynv3cssrrdpykmtwon63xiye4qdzbmvpwq6gjzwine63r25n@4mfgf2ycqzql>
 <ca1f1899-455f-4e69-a302-c01acfd565f3@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1f1899-455f-4e69-a302-c01acfd565f3@sandeen.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 26-02-25 10:42:11, Eric Sandeen wrote:
> On 2/24/25 8:02 AM, Jan Kara wrote:
> > On Sun 23-02-25 13:57:40, Eric Sandeen wrote:
> >> Convert ext2 to the new mount API.
> >>
> >> Note that this makes the sb= option more accepting than it was before;
> >> previosly, sb= was only accepted if it was the first specified option.
> >> Now it can exist anywhere, and if respecified, the last specified value
> >> is used.
> >>
> >> Parse-time messages here are sent to ext2_msg with a NULL sb, and
> >> ext2_msg is adjusted to accept that, as ext4 does today as well.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > Looks good to me. Thanks!
> 
> Thanks Jan - You probably saw the minor nit from the kernel test robot,
> "const struct fs_parameter_spec ext2_param_spec" should be static, too.

Yep, fixed now.

> Sorry about that! 

No problem :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

