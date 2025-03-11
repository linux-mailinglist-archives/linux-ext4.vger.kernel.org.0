Return-Path: <linux-ext4+bounces-6764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7DA5CA5E
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 17:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CE13B1212
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF825F990;
	Tue, 11 Mar 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQ22nfPK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQgv6RMh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQ22nfPK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQgv6RMh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33542260A4F
	for <linux-ext4@vger.kernel.org>; Tue, 11 Mar 2025 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709324; cv=none; b=kcnGhlF6Hl9BvJTO43wClXJ463dLnHDc+zm5uKieiWoa0r3nv3thCKw1v5kgqGvomQhvT46Syn/dOCo86A8wEWu861QiP/iq4h9nQtvP93CwGAYMvF/MjqpZ/bm/JkYUcjGC3sSGfXNUf+xRjCLMBW7FyaahBxUFMjio3Hgc1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709324; c=relaxed/simple;
	bh=98ezhbvXsCMkQvSTYXlUUuB1Lv0Nldel879BVM3lwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXcK2i1w0Nysgs2neeuOHu3+F1k1zRCfwxurQvcKmZVn4fiQscu16wSMmPYJHc+JmYnTpeccX5ULCF6WXmhGl6fpJ5o1dRg1oJd3UzC6WxALERp2xYVzLnoM9a7l417HQlk9gnO3eZOR1TIK8H/Qy10Afaq1vzU2VktpyvlLJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQ22nfPK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQgv6RMh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQ22nfPK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQgv6RMh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 152D41F770;
	Tue, 11 Mar 2025 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741709321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9NwsRWR200DwDP0p9x+ZIvlCC9eo++z7Ix8uy1hsIM=;
	b=SQ22nfPKdPwlVzKHE8naV67hkSAayI/yw3hkh2/9/1tnvU7TXTXR5YJySD527bAaaqH6Hd
	8/3tOjdYeMyFFFbo8WTSrybuavsme2LjuiAS3Mx3f+HqT9do8wbQHta0k7badDWyGQjPSd
	dBUtZKbII+nGteOLGFF8kg8rfwlhnk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741709321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9NwsRWR200DwDP0p9x+ZIvlCC9eo++z7Ix8uy1hsIM=;
	b=rQgv6RMh/nnPbFZFZemOXmfpCX1Y3Ti5OM9edOC9U3BK4Wa/MnU7R7LFt9Jx7rATx72mVd
	08yK8saX6fzNg5Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SQ22nfPK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rQgv6RMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741709321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9NwsRWR200DwDP0p9x+ZIvlCC9eo++z7Ix8uy1hsIM=;
	b=SQ22nfPKdPwlVzKHE8naV67hkSAayI/yw3hkh2/9/1tnvU7TXTXR5YJySD527bAaaqH6Hd
	8/3tOjdYeMyFFFbo8WTSrybuavsme2LjuiAS3Mx3f+HqT9do8wbQHta0k7badDWyGQjPSd
	dBUtZKbII+nGteOLGFF8kg8rfwlhnk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741709321;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9NwsRWR200DwDP0p9x+ZIvlCC9eo++z7Ix8uy1hsIM=;
	b=rQgv6RMh/nnPbFZFZemOXmfpCX1Y3Ti5OM9edOC9U3BK4Wa/MnU7R7LFt9Jx7rATx72mVd
	08yK8saX6fzNg5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01FD3134A0;
	Tue, 11 Mar 2025 16:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dDs/AAlg0GfveQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 16:08:41 +0000
Date: Tue, 11 Mar 2025 17:08:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311160839.GG32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <69d8b100-f65d-470f-a957-2819795e82a4@gmx.com>
 <20250310153744.GD8837@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310153744.GD8837@mit.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 152D41F770
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 11:37:44AM -0400, Theodore Ts'o wrote:
> On Mon, Mar 10, 2025 at 02:11:13PM +0000, Artem S. Tashkinov wrote:
> > 
> > I'm not going to argue with your reasoning but being able to set btime
> > could be beneficial for backup and restore purposes/utilities.

From my experience and use case: for archiving purposes the creation
time has a meaning and it gets lost when the files get moved to bigger
storage. Sometimes the creation is stored in the file metadata (like jpeg
or video files), but ultimately the creation time is stored in the file
inode metadata itself regardless of the format.

Another use case is for send/receive that transfers snapshots from one
btrfs filesystem to another. In protocol v2 we added the creation time
(otime) to the stream so the receiving side can read it, but cannot
write it yet.

Question about ability to change otime/btime can be found around
internet, there was attempt to make it a utimensat() operation
(https://lore.kernel.org/linux-btrfs/cover.1550136164.git.osandov@fb.com).

In that thread there's a disagreement with providing that and I
disagreed as well back then, but over the time I changed my mind also
because I found a use case for myself.  So I have a WIP to add it as
ioctl to btrfs. I understand it's a niche use case and won't attempt to
implement it on the VFS level. At least for btrfs and the send/receive
use case it's slightly more justified than in other filesystems.

