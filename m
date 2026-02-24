Return-Path: <linux-ext4+bounces-13985-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDRQH6a6nWklRgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13985-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 15:50:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA8188ACF
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206B33198B8D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E93806A6;
	Tue, 24 Feb 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7aYI2uY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C23A0B29;
	Tue, 24 Feb 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944441; cv=none; b=qeeiAc5YNzT8f73nzB0LaXJ65WClyNfr1xcSsM3d5KdJvrXt7jEMfevJKtRmF3zirggTisntZC2WmsMbuEDYnMz0+VOn6HcWb/Oxsou+Ro4l4UKZZZRo7gkd7J/djcIezWryzCWLlBsPOhQN0FYoWBLN0qGiTpW10vRIP4fqFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944441; c=relaxed/simple;
	bh=U5w1wlKo5acTDmY9WBr/TK5+1bfT+kvVFz81l1R9bw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRmScKFkMaGJpug9ny9Zna7reONQLqMitvdakGSxOmBi26FEOaVSRDZyjKuF9CiCJSEPKb5XOT/RE1O9YVBm+SoCb06jCjNU/2X0Qgm3ahSHjmruA2fgZN4dtch36fC2tohrKZDwhCRBjcbExdbu39sF55tR0Gy5HxM1E4RNdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o7aYI2uY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gMZszdzDXVXKpm6MGZK1kQkif74wVORTRDlmSBlZN9Y=; b=o7aYI2uYWmfB9hZbB5Rgv1vTQ6
	2GwDsgJv80GGEckwo5HGVL3146/lA+QuIhwu6NRMCoxF5Szsjdk/q7quIxD9fL24/RNShRFq6NgWG
	Qnmhf1PKBsTC/Kna78V1eahQ1HB6ssjcbeh/35+IdJJZvJj0XhIjqLeEdnKEr8UeGZ/F78ShqTJE0
	parUAGaHZfPP7XarcYmP6JBnlrCW+7/58fodCkUgLFunRZaGeGV+SO+NvPtPjIiXoFU9c/xS539eZ
	2CYy59MYydMX/tZ0Dy6LmIwpO9zJAfLNM6FPeOGTfPQsXdGbmewUwxxBE5d0j2RcQNWFr1+5+byhh
	2yZ+tlMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuth1-00000002GMx-2mjT;
	Tue, 24 Feb 2026 14:47:19 +0000
Date: Tue, 24 Feb 2026 06:47:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <aZ2599dwNuqPQgzB@infradead.org>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13985-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6CA8188ACF
X-Rspamd-Action: no action

A lot of folks have already explained the O_SYNC semantics correctly,
but I have another major question about your test case.

On Wed, Feb 18, 2026 at 04:29:30PM +0300, Vyacheslav Kovalevsky wrote:
> Detailed description
> ====================
> 
> Hello, there seems to be an issue with ext4 crash behavior:
> 
> 1. Create and sync a new file.
> 2. Open the file and write some data (must be more than 4096 bytes).
> 3. Close the file.
> 4. Open the file with O_SYNC flag and write some data.
> 
> After system crash the file will have the wrong size and some previously
> written data will be lost.

The wrong size here seems incorrect.  Even if the old data written
through the non-O_SYNC fd wasn't written out I absolutely can't see how
the file would have an incorrect size here.  Can you please share your
test case?


