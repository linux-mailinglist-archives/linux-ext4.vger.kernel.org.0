Return-Path: <linux-ext4+bounces-1333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BF85D64F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261761C22598
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D53FB0A;
	Wed, 21 Feb 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tl0GPLcL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhwOOoNR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tl0GPLcL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhwOOoNR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A83FB07
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513252; cv=none; b=dhuvqZX/RzfCr2Dyu5z0NNetSZ1KlurDjRn5sZKlI3KytVii/zU7HZCmW0wRNaqusZWfQ/aUXID2dZNV67Q9BNFJdpuCRIEMLWMxtyZxPKZYfMOvVQsYVc0Vjy5QfR/a8FqMKIsknshnnxt793tclnOKWRK5UeMBSHnzIX0cG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513252; c=relaxed/simple;
	bh=htzu7J5WB1LcB/H2KC1ITEohei6DTBbw9JxNlRFMkNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUqIu3bg2SSCQF47sBSBCyBZBsSTPreuCkdZ6Tr9jQCBQSaoBiX9Sx40FD4yN+tCr9c1Xtl74/oGEgDdeoFqxQcbdEDMk62qqWjiarYTAjIwJ/on9Vqw9osgtV6m/R/8cmzLzvyVz/NYbvVOllQt3xoi9154KVMGRaQga3nILQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tl0GPLcL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhwOOoNR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tl0GPLcL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhwOOoNR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44EC922231;
	Wed, 21 Feb 2024 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708513248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKfnoL4q9DL1uMjTuztVrLJlj6mVPji1eRQDsbSukIQ=;
	b=tl0GPLcLkqmzcsPj6rbmowDWuuuBcDWXq+d9BwPjsHeTTxc50EV8JKPcEQ/2ccFyy1v1Fv
	EyUa6lzBX9S8G6uC8UvpWR2mTvzUPeaFq/xYUkvJk8EqQG2tjGCjRRcwxMp8X+LZnfU/Ed
	cof/MjI8cJwjfH8v7Od5fx8bu9kkLxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708513248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKfnoL4q9DL1uMjTuztVrLJlj6mVPji1eRQDsbSukIQ=;
	b=YhwOOoNR7dW2sJv3+ef8lwkuFl5d7+xCmi0YlS5B+qdOzsouFwF/4R7vcBzaRIkY4hwWaA
	BRFbXB3YUm9qfhBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708513248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKfnoL4q9DL1uMjTuztVrLJlj6mVPji1eRQDsbSukIQ=;
	b=tl0GPLcLkqmzcsPj6rbmowDWuuuBcDWXq+d9BwPjsHeTTxc50EV8JKPcEQ/2ccFyy1v1Fv
	EyUa6lzBX9S8G6uC8UvpWR2mTvzUPeaFq/xYUkvJk8EqQG2tjGCjRRcwxMp8X+LZnfU/Ed
	cof/MjI8cJwjfH8v7Od5fx8bu9kkLxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708513248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKfnoL4q9DL1uMjTuztVrLJlj6mVPji1eRQDsbSukIQ=;
	b=YhwOOoNR7dW2sJv3+ef8lwkuFl5d7+xCmi0YlS5B+qdOzsouFwF/4R7vcBzaRIkY4hwWaA
	BRFbXB3YUm9qfhBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C39C139D1;
	Wed, 21 Feb 2024 11:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kc6yDuDX1WU2HQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 11:00:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0EB8A0807; Wed, 21 Feb 2024 12:00:43 +0100 (CET)
Date: Wed, 21 Feb 2024 12:00:43 +0100
From: Jan Kara <jack@suse.cz>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Message-ID: <20240221110043.mj4v25a2mtmo54bw@quack3>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tl0GPLcL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YhwOOoNR
X-Spamd-Result: default: False [1.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.93%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.19
X-Rspamd-Queue-Id: 44EC922231
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hello,

On Wed 21-02-24 10:33:04, Michael Opdenacker wrote:
> I'm wondering why ext2 isn't marked as deprecated yet as it has 32 bit dates
> and dates will rollover in 2038 (in 14 years from now!).
> 
> I'm asking because ext4, when used without a journal, seems to be a worthy
> replacement and has 64 bit dates.
> 
> I'll be happy to send a patch to fs/ext2/Kconfig to warn users.

For all practical purposes I agree we expect users to use ext4 driver on a
filesystem without a journal instead of ext2 driver. We are still keeping
ext2 around mostly as a simple reference filesystem for other fs
developers. I agree we should improve the kconfig text to reference users
to ext4.

Regarding y2038 problem - this is really the matter of on-disk format as
created by mke2fs, not so much of the kernel driver. And the kernel will be
warning about that when you mount ext2 so I don't think special handling is
needed for that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

