Return-Path: <linux-ext4+bounces-401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3580EEA5
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F43280EBD
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578B73188;
	Tue, 12 Dec 2023 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKuOqzEh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4/1Pp2g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKuOqzEh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4/1Pp2g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76492CD;
	Tue, 12 Dec 2023 06:25:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 860B422512;
	Tue, 12 Dec 2023 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4adbCx1T16ZMiU9KQhuQLFju1f4y3eDfGaolsH/mGo=;
	b=dKuOqzEhOjI7MDLjj4Y/D876HjvNd2he8j3TqZH0dq0CwIl+IM47kp6tM8rn1x9oiGjXrV
	Xx83VxBaW9GetBZUB94594CQq+HgFvYWth7Kp6pIt1/JbJXQhvQeI5QlXebQvzPskrgJKL
	5v7CJiEQMQhv6QNpV3lQ5pxqoW9BXcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4adbCx1T16ZMiU9KQhuQLFju1f4y3eDfGaolsH/mGo=;
	b=I4/1Pp2gm/l3VmYZcn3x9yF8Mlb+76enmviSxE2vsM294FaEuhcpch1BL4Yr+dGzmXfEaE
	y5VP42v9EB0OcIAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4adbCx1T16ZMiU9KQhuQLFju1f4y3eDfGaolsH/mGo=;
	b=dKuOqzEhOjI7MDLjj4Y/D876HjvNd2he8j3TqZH0dq0CwIl+IM47kp6tM8rn1x9oiGjXrV
	Xx83VxBaW9GetBZUB94594CQq+HgFvYWth7Kp6pIt1/JbJXQhvQeI5QlXebQvzPskrgJKL
	5v7CJiEQMQhv6QNpV3lQ5pxqoW9BXcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4adbCx1T16ZMiU9KQhuQLFju1f4y3eDfGaolsH/mGo=;
	b=I4/1Pp2gm/l3VmYZcn3x9yF8Mlb+76enmviSxE2vsM294FaEuhcpch1BL4Yr+dGzmXfEaE
	y5VP42v9EB0OcIAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 63C53139E9;
	Tue, 12 Dec 2023 14:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +WBXGGhteGUqUwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:25:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D983AA06E5; Tue, 12 Dec 2023 15:25:43 +0100 (CET)
Date: Tue, 12 Dec 2023 15:25:43 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, akpm@linux-foundation.org,
	ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231212142543.jrortgje22traesa@quack3>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231204144106.fk4yxc422gppifsz@quack3>
 <70b274c2-c19a-103b-4cf4-b106c698ddcc@huawei.com>
 <20231206193757.k5cppxqew6zjmbx3@quack3>
 <ZXfjXZWK4HlJi6pg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXfjXZWK4HlJi6pg@casper.infradead.org>
X-Spam-Score: 1.89
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.00)[suse.cz];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,huawei.com,kvack.org,vger.kernel.org,mit.edu,dilger.ca,linux-foundation.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 860B422512
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dKuOqzEh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="I4/1Pp2g";
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Bar: +
X-Spam-Score: 1.69

On Tue 12-12-23 04:36:45, Matthew Wilcox wrote:
> On Wed, Dec 06, 2023 at 08:37:57PM +0100, Jan Kara wrote:
> > Within the same page buffered reads and writes should be consistent because
> > they are synchronized by the page lock. However once reads and writes
> > involve multiple pages, there is no serialization so you can get contents
> > of some pages before write and some pages after being written. However this
> > doesn't seem to be your particular case here. I just wanted to point out
> > that in general even buffered reads vs writes are not fully consistent.
> 
> Buffered reads don't take the page/folio lock.  We only use the folio
> lock to avoid reading stale data from the page cache while we're
> fetching the data from storage.  Once the uptodate flag is set on the
> folio, we never take the folio lock for reads.

Right, I've noticed once I've reread the code but thanks for correction
anyway. :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

