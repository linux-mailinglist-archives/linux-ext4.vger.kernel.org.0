Return-Path: <linux-ext4+bounces-13676-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJQRLmCkjGmgrwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13676-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 16:46:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A575125D47
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E824301CDBF
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDF318ECE;
	Wed, 11 Feb 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KNvq8zWk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2369318BAD;
	Wed, 11 Feb 2026 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824779; cv=none; b=cFO7VslbGVM3sBfUgOUFVIh4OUWACowyfu7mMuAO+JkzMqjUJVkhBKyz31934bu61ZeSlmFUTt2zFOe+EZJ6JOWNR9qZknq9nzA6ZD/6NaxAwk423e1PdYJHDosQAsVF3CeAPFxnztN3gFKNGENx4SkRJWB0XLj1ryh0rYRNirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824779; c=relaxed/simple;
	bh=KdIZZJ88SvP9Tk3iR4fcy9Q/6ze1Z+PzjdA+RdQAdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh3Xpvg6laYOW7bh6CGPqCeTInT3SnxR5RqP94oh8z4+D6yR75FY3HyOn7s9rcZKacMBsHrYKgc5PZ05apF+IrsonjNfFyW0khsnLkWxDLesioUZcJLRyIfZNF06rv5mA2lROHt2B3rQoVcvuvBg7+tfxuQlKxH0fTIPAnNq8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KNvq8zWk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VhZyVU+J7igPP7q7YswMX72L/8p/d6PGDV31GmNPguI=; b=KNvq8zWk3bCBBRLgg/n+FFiDgZ
	MAU11kK4bJ6fSPMQtF4hAVoi0I8jmRgE4+KfR9tQb2HsXq27DlHH9uOKOabejHnMu7mydXN35vkyZ
	YkXFGkYlTZYhEriIEnJHFZ1YXjoJH1ddzvPoNfsg4ul1Crk9AFiJkS6SR7sroubfklB7KlK/1DiNR
	YPJWhwu8+Aa5IFD7Dp63HenaV3VA98N5tFLYjPZNlGvS34HvpvmeIR05gyXQZeXBNvA1Li+VdiB7x
	emo0u0Z5tIpJq59hsLubkMhM3u0WPKx3o3fKgaImYOUmlQLAOWbSMuOdpIrJ5AjwNnboLtPoYbqGu
	qSbYpWPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCPw-00000000o1b-3ttz;
	Wed, 11 Feb 2026 15:46:16 +0000
Date: Wed, 11 Feb 2026 07:46:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: convert inline data to extents when truncate
 exceeds inline size
Message-ID: <aYykSCvhtYRGxCi3@infradead.org>
References: <20260207043607.1175976-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207043607.1175976-1-kartikey406@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13676-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4,7de5fe447862fc37576f];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A575125D47
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 10:06:07AM +0530, Deepanshu Kartikey wrote:
> Without this fix, the following sequence causes a kernel BUG_ON():
> 
> 1. Mount filesystem with inode that has inline flag set and small size
> 2. truncate(file, 50MB) - grows size but inline flag remains set
> 3. sendfile() attempts to write data
> 4. ext4_write_inline_data() hits BUG_ON(write_size > inline_capacity)

Can you wirte this up in an xfstests test, please?


