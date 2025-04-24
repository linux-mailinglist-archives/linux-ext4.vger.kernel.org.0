Return-Path: <linux-ext4+bounces-7454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9DA9AFAF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3201B60B6F
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D517A5BD;
	Thu, 24 Apr 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlT0mCTX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+U3Cy5Lz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LO2/gW34";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VKxMf/EG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E618DB1E
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502548; cv=none; b=Y/Y3NMEeI7+F725Qm3JnFmL8J4LBIKjut3jRBCmlXtac6/GhlYK09z3ZeDo9yJd4mliZQYHF+5pUUPZ7Ov7SQvOkpGGe4Fsw+/8/+a//3buBzbqPbk7vuyS0a6RCiMyvMPjBLP2FXBqv0Lb6SQvF+mvGOCndmA2c08pmLvD4RUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502548; c=relaxed/simple;
	bh=s8Xub9KPmT0GoN70xxpFbUUJFPSrSvc4yF73NCXYAD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBLBtkuTCfFtcuCI6sLtUTJStPHvn97fP6Bn2suOa4DoYjj2PUWMKP/ry9CfddwEVdCyN7VjtqUg47E154HOE7f4VXddvnyohDi58+y80c/7fi+OC+qmO8c8VfIiRHU6tuQ+IvwhtZ7Xisg4rL76Dj1WMmGeGkeV6zgvV3WvTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlT0mCTX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+U3Cy5Lz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LO2/gW34; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VKxMf/EG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB711F44E;
	Thu, 24 Apr 2025 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745502544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJjffveC2/sr+iDe7tB9DkSlZhSM4BWpzkKBF4rGaM=;
	b=KlT0mCTXnUj8JyY6Ww2AhjS6QOloxr83pWRMKgx4pQZdpojDqNe7k62wL0ckUvPfiieyNv
	ZZ2WZpu2HwSRH9m72DYDDj27zCuXY+YshAVigMjc5+ihkvVTPtQGr8nE5OIuLV2HTeBuwt
	iSNI1Uzob3nxsU6NXf9jYRWU3RsbaXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745502544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJjffveC2/sr+iDe7tB9DkSlZhSM4BWpzkKBF4rGaM=;
	b=+U3Cy5Lz1uyCtSlqqbSRWiLljlV6ic97qygb1HyC3WS+TeEyhJB/7cuA8WBF3a4W/TW1rD
	6RD+DqDjYxSXEfCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LO2/gW34";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VKxMf/EG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745502543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJjffveC2/sr+iDe7tB9DkSlZhSM4BWpzkKBF4rGaM=;
	b=LO2/gW345RebwNOWHlzUiibmW58cyBtP0jzp59SPRQHYQXwH+Ahj1suJAsaGqg4r6SuBSg
	6d1UqLy7SBQRbH5WuqxGC/YFQXdyatEmI827XUqNWbmWyrGAxfj7v5qGyiEf4+4cwnkv+C
	MGalFnYu7FFnNcOgTU7vE1vo51urDpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745502543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJjffveC2/sr+iDe7tB9DkSlZhSM4BWpzkKBF4rGaM=;
	b=VKxMf/EG4a6JLLL+VQjesLs1a5mvWg0ddLyUMEiz4dsG2jJnPoqZL4Noz1Sfx73qLf5EVE
	3CPeJn6B9W8nk6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB00D1393C;
	Thu, 24 Apr 2025 13:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IsmZLU9BCmj0ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Apr 2025 13:49:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 668AFA0921; Thu, 24 Apr 2025 15:48:59 +0200 (CEST)
Date: Thu, 24 Apr 2025 15:48:59 +0200
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Zhang Yi <yi.zhang@huawei.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shida Zhang <zhangshida@kylinos.cn>, 
	Baokun Li <libaokun1@huawei.com>, Jann Horn <jannh@google.com>, Brian Foster <bfoster@redhat.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: avoid -Wformat-security warning
Message-ID: <2lrekzigagve633hztrttgulu4pjtgjy3chasl35fk53bqybhp@yy27gkgcx6a7>
References: <20250423164354.2780635-1-arnd@kernel.org>
 <6vjo6wo5c5tadvhnrvo2affcqu2cf6ecrx4ol5jxl6mvz7vu3z@6wgvyptlpq4p>
 <b8aab0e1-dd32-4c03-8123-a0df5238558a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8aab0e1-dd32-4c03-8123-a0df5238558a@app.fastmail.com>
X-Rspamd-Queue-Id: CBB711F44E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mit.edu,dilger.ca,huawei.com,linux.ibm.com,infradead.org,gmail.com,kylinos.cn,google.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 24-04-25 14:31:02, Arnd Bergmann wrote:
> On Thu, Apr 24, 2025, at 13:39, Jan Kara wrote:
> > On Wed 23-04-25 18:43:49, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> check_igot_inode() prints a variable string, which causes a harmless
> >> warning with 'make W=1':
> >> 
> >> fs/ext4/inode.c:4763:45: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >>  4763 |         ext4_error_inode(inode, function, line, 0, err_str);
> >> 
> >> Use a trivial "%s" format string instead.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Frankly I don't care much either way but if my memory serves me well year
> > or two ago someone was going through the kernel and was replacing pointless
> > ("%s", str) cases with printing the string directly. So we should make up
> > our minds how we want this... In my opinion this is one of the warnings
> > which may be useful but have false positives too often (like here where
> > err_str is just a selection from several string literals) so I'm not sure
> > it's worth the effort to try to silence it.
> 
> I had a look at the git log now and see no evidence of those
> patches getting merged, but plenty of patches going the same way
> as my patch.

OK, so maybe I'm just confused or the patch indeed got discarded. Thanks
for having a look! With this clarification feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

