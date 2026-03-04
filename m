Return-Path: <linux-ext4+bounces-14609-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G03MMw0qGm+pQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14609-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 14:34:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FF2007B5
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F4B4317EF64
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F6367F52;
	Wed,  4 Mar 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9wXMS43"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CE352F95;
	Wed,  4 Mar 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630898; cv=none; b=MaFjLMHqUHRVwMKPm32KE+U0YQfQ6LRPV46VjvVwiVnL0wYsQXWKMHi8RYVZEVwQz5h/1kIy5Wx5fY/KMfItSfIvuB6bw/ZoHRkUKEQRAadLNePx3UJARJntOYWEm2NqcH8lYz6VY58cOwcgXqbhjyDJn1qY6gq4ukcS81ck71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630898; c=relaxed/simple;
	bh=SVOIZ+ZQm6umt0dgDvXK33VRlElbT4kLC7JaxnoN+0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/6Urr3Ti3NM40Nf1jae4BhUtxzqT4D1gjH+y82TlVd4D/X17JM9HbBJ1IXHGWGobpasFq4O3igH4xvzqntsMdZL8hOWocA3PyOizOGY6yWipzgw1pw6+TrGLWJK5kUWqHuSR6RW5YkBXE8QwFZAdkSc9rzk3fLn1ecTPaXQsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B9wXMS43; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u4tDNrsfmkN1jCpPN9zt23p6IPrJrTgXec+c+UsxUz0=; b=B9wXMS43baSn2tXBwUe7m8IBeu
	5IXVC89bWglrmU2qDRUbibxmLfgTXUoaasP32IEISDvcx05r3AOf7sDiKMsdl5kUXYOph2nLd5tTG
	buu4i4HnIELFf30YTYO6QHIUYLpKA9M8qBWH3s752P9SbJQ83MsgEQS3BJoyXZtz8YxRtQN5YCGF/
	J0JOLbLCppR4AenYRt+btPFy189yONESl5VvZrUzk6eTxvjfEXWqHziyWHs8XateJ07X5qW0sylRH
	nhweam1Y8mQHwfbYpk8OjEId4m0R/rufevmN6Sh6k1UCVa/V0W/yAu5Rm45XDrQ/NFY9y0TD8wWS+
	pXmadYAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxmGv-0000000HFKG-0F3o;
	Wed, 04 Mar 2026 13:28:17 +0000
Date: Wed, 4 Mar 2026 05:28:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <asj@kernel.org>
Cc: linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] fix s_uuid and f_fsid consistency for cloned
 filesystems
Message-ID: <aagzcbj_CohXgIXe@infradead.org>
References: <cover.1772095546.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772095546.git.asj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 214FF2007B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-14609-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:23:32PM +0800, Anand Jain wrote:
> This series resolves the tradeoff by aligning btrfs and ext4 behaviour
> with XFS: f_fsid incorporates device identity (devt) to remain unique
> across clones, while s_uuid is preserved consistently matching the on-disk
> uuid.

While I like fixing this up, switching the f_fsid construction to a
different method might break things.  Is there a way to only change
it for cloned file systems to reduce the surface of this change?

> Patches
> -------
> Patch 1/3: btrfs: fix f_fsid to include rootid and devt
> Patch 2/3: btrfs: fix s_uuid to be stable across mounts for cloned filesystems  
> Patch 3/3: ext4: fix f_fsid to use devt instead of s_uuid

I don't really see that patch 3 in my inbox on linux-btrfs.


