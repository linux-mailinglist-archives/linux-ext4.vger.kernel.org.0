Return-Path: <linux-ext4+bounces-5906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621ECA02C40
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6543188743F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975C13AD20;
	Mon,  6 Jan 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ni/Uuf3+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qUSaP9BH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ni/Uuf3+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qUSaP9BH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4111DE2DF;
	Mon,  6 Jan 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178712; cv=none; b=WrXV0DS8got/LiPnSO9GF4wndnOwY9PNK7FbpQkiItnejYE0RkQd+eShYE8LSGgmzFnMdz5qvZP6UVVJ4nkiKtnFL2dK8wObfD4Ay/oQCgMP1oki5JP0hJZOW/Qb4DDAlURYU3KMRtMqbpshwj7/yvoyfqFhuciJKpuGLLfhIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178712; c=relaxed/simple;
	bh=bVAOiPNQf+FQanbBxn7/8qE3c1z5N/FHgn0cBz4nFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKk9rlq95G85QFIhMn+A7DJpljfqEEZ+HNQ87tL3K6X+KkK3m8yBHJre51SQLbmIdlqVIHgEbfzvzLmQcSr/5dG7JCsxhbxtleEgNzIP+s3D4LFOYuDUOEzRt+mCNwOzVREmOKeETZZqGofKFWL1NEqDh+K1QteqHZ7Z56paXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ni/Uuf3+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qUSaP9BH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ni/Uuf3+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qUSaP9BH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E453121168;
	Mon,  6 Jan 2025 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7LH7DLZA/kkto7WfMOCn2bj1Jk9Xm+kxLIuaVGATEc=;
	b=Ni/Uuf3+fb1tpDjn8zj8HDpM+2c9x8I3xn/h4Ib5e2LPy8DCvGAsiYzeB9jQ+gvoxDr6hv
	C9m56RRSudKKNZgmo2w2A8VfWg9fazNwUhLmXqNvsp+y3S2hMD6GLF2RBP29DIPHGZulo8
	zTPFLpV6YjrWJKtg++wjxPu2veMjht8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7LH7DLZA/kkto7WfMOCn2bj1Jk9Xm+kxLIuaVGATEc=;
	b=qUSaP9BHPXN/ML+fk9y7hOIZ5+Au1ZF/cPzlh1QvkhvumFkgkYW5dtvaUIBN4gHukKPqK+
	9vtPN/D1RkiycHBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Ni/Uuf3+";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qUSaP9BH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7LH7DLZA/kkto7WfMOCn2bj1Jk9Xm+kxLIuaVGATEc=;
	b=Ni/Uuf3+fb1tpDjn8zj8HDpM+2c9x8I3xn/h4Ib5e2LPy8DCvGAsiYzeB9jQ+gvoxDr6hv
	C9m56RRSudKKNZgmo2w2A8VfWg9fazNwUhLmXqNvsp+y3S2hMD6GLF2RBP29DIPHGZulo8
	zTPFLpV6YjrWJKtg++wjxPu2veMjht8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7LH7DLZA/kkto7WfMOCn2bj1Jk9Xm+kxLIuaVGATEc=;
	b=qUSaP9BHPXN/ML+fk9y7hOIZ5+Au1ZF/cPzlh1QvkhvumFkgkYW5dtvaUIBN4gHukKPqK+
	9vtPN/D1RkiycHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C720C139AB;
	Mon,  6 Jan 2025 15:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XraYMBT8e2csUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:51:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD52DA089C; Mon,  6 Jan 2025 16:51:43 +0100 (CET)
Date: Mon, 6 Jan 2025 16:51:43 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 0/7] ext4: Convert truncated extent data to inline data.
Message-ID: <hcnrjqr4pat6mzp4clxoeu4fuzuldks2qry5ropztfu4makhqe@x5gfsvdgl2ik>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: E453121168
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 23:16:18, Julian Sun wrote:
> Ext4 provides the feature of storing data inline and automatically 
> converts it to extent data when appropriate. However, files stored 
> as extents cannot be converted back to inline data after truncation, 
> even if the file size allows for inline data storage. 
> This patch set implements the feature to store large truncated files 
> as inline data when suitable, improving disk utilization. 
> Patches 1-3 include some cleanups and fixes. 
> Patches 4-6 refactor the functions responsible for writing inline data, 
> consolidating their logic for better code organization.
> Patch 7 implements the feature of storing truncated files as inline data 
> on the next write operation. 

Thanks for the patches! So ext4 inline data feature is a bit problematic
and has some locking issues in the implementation which we didn't manage to
fix [1]. We are even considering just disabling this feature due to the
complications with it. Hence I don't quite like further complicating this
code by adding possibility to create inline data in an inode after it had
data blocks allocated. That being said I like the preparatory cleanups in
this patch series. These are useful regardless of the feature itself.

								Honza

[1] See our attempts in thread:
https://lore.kernel.org/all/d704ce55-321a-9c1d-1f8b-3360a0fdf978@huawei.com

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

