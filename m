Return-Path: <linux-ext4+bounces-6421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42164A33136
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 22:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5F91628C9
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF385202C51;
	Wed, 12 Feb 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cPilweUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NvTmYvBI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OEmKdRAB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SfKf981G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CF201269
	for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394151; cv=none; b=ulLAACOp6iYDshXOrIdcpVfMOPtWVUUAYKw6dx7E1F/O5cWg3yki3I9Lvo1ah+SxqHKBsTXCYv/Kyb8GLJwvUF1UI4gOlSt8kkbMvaCtsjjh3WSQhTnzwHsrKCsPKEPSzbtexIgwUhOsZCiguijTG1uZmNYsdRNZm6C5toZP6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394151; c=relaxed/simple;
	bh=dx27bQiDzq3UCEg6slDvY2/vRv6WAXt2iPKDmZVQqmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtZhdXnWDsWVm4mXfhs/FxD6i62KC078bsd7wM+t6Wz3kWl3AJ+71KeTOm5JdZHXe2SRJ8qznDWy0kblwRKn23BRE4FYobYFM7WbBYp4UUbVlNY1Xer3GdlsxoeG2s7nA79bmsZ+3mvfpZe5ae9TXLGw7enz0F2u0ThSMifmqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cPilweUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NvTmYvBI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OEmKdRAB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SfKf981G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD0EC1F44E;
	Wed, 12 Feb 2025 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739394148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xztWGCWOjKjC/VI7pyv+ozcaJ1YxqrHmiXuF8IjQY=;
	b=cPilweUYmayL/qvpXNWKh55EdkN9yQpzQIZNM2q0V9KKANRP8g/Bh4FGx5g/MMAALOO244
	SFFQws7IFLR2rekSK4KRqjbt77tyATn7jC1gwugvN6zNO7pefPc/zXpgnDS/FMaScKkvRz
	v+mr4dU81CDPnSgkmtKh5+Bo+oBl2Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739394148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xztWGCWOjKjC/VI7pyv+ozcaJ1YxqrHmiXuF8IjQY=;
	b=NvTmYvBIv7valSTiGOxoysViYpbwNYrD+TC7w7oq1CsPFw5rnhQYBdh64w3Vemw2Hc6Vc5
	zLYY0sQT27w/fkAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739394147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xztWGCWOjKjC/VI7pyv+ozcaJ1YxqrHmiXuF8IjQY=;
	b=OEmKdRABznxiFBwQ+V9INQi77KsYu402vMl5l12Tdy7N5LeBwKTLEhgmLUNenmPWMl3XpX
	sfHD9KjPFKD4eXVUPmv38682aLVFs3nytWEyt2+S6c+l7IpFS1lO4cBFsof5EUgNQn2Ddb
	0dNSp5rbH1b6H6OsV0OIx1LGR02Fu7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739394147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xztWGCWOjKjC/VI7pyv+ozcaJ1YxqrHmiXuF8IjQY=;
	b=SfKf981GNDgB8O4CbNqIkJskroKOxzQ1hWXwuVhj9g+uVjuczC9dFuiA8tzNn1FDwC/DmR
	Cxtiv1BBxlmpPKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A26A713874;
	Wed, 12 Feb 2025 21:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B31qG2MMrWewMgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 12 Feb 2025 21:02:27 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,  drosen@google.com
Subject: Re: [PATCH] ext4: introduce linear search for dentries
In-Reply-To: <20250212164448.111211-1-tytso@mit.edu> (Theodore Ts'o's message
	of "Wed, 12 Feb 2025 11:44:48 -0500")
Organization: SUSE
References: <20250212164448.111211-1-tytso@mit.edu>
Date: Wed, 12 Feb 2025 16:02:21 -0500
Message-ID: <87h64yx4f6.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

"Theodore Ts'o" <tytso@mit.edu> writes:

> This patch addresses an issue where some files in case-insensitive
> directories become inaccessible due to changes in how the kernel
> function, utf8_casefold(), generates case-folded strings from the
> commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
> points").
>
> There are good reasons why this change should be made; it's actually
> quite stupid that Unicode seems to think that the characters =E2=9D=A4 an=
d =E2=9D=A4=EF=B8=8F
> should be casefolded.  Unfortimately because of the backwards
> compatibility issue, this commit was reverted in 231825b2e1ff.
>
> This problem is addressed by instituting a brute-force linear fallback
> if a lookup fails on case-folded directory, which does result in a
> performance hit when looking up files affected by the changing how
> thekernel treats ignorable Uniode characters, or when attempting to
> look up non-existent file names.  So this fallback can be disabled by
> setting an encoding flag if in the future, the system administrator or
> the manufacturer of a mobile handset or tablet can be sure that there
> was no opportunity for a kernel to insert file names with incompatible
> encodings.
>
> Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

--=20
Gabriel Krisman Bertazi

