Return-Path: <linux-ext4+bounces-14659-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oItiCIWSqWlCAQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14659-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 15:26:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76674213532
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AEB431AE3A2
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCA3A1A44;
	Thu,  5 Mar 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L9qEq08u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A73822BC;
	Thu,  5 Mar 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720490; cv=none; b=E4t15HOVC1QuSvW0MzC6THaK3ur98vA+1JK3TuwEwLuiHDMiUCQrLPGoWL3k2CxParPM0bliu2FnRiJTEUCVu8JoA0Xzyhabrn11VchNojG4r/pjJJV1cFH92WS9nYrXspBn7uUU0u09R39plKVljyd5E7Huh40/MJWuMBW0sdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720490; c=relaxed/simple;
	bh=AwUGOjlCKVPG0f6btFVnEpBsW2KnOyBY55Vv2znOHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A75DWkHamaRzV2uzlBgV43kVSdcAiQVqvt+UHZHAdsdgo3GBeOMxIAOGZ/weS6IwPbSsUMlGoDCLfzCWy/ES0lKsqiNhweAaoFsZhLhHYq1MxF2zEQB8TqIXTrlzdpCMDaM3Nfm/GsQe/0pdkL8LZSaP/AHon/jqCaLBVzRePPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L9qEq08u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AwUGOjlCKVPG0f6btFVnEpBsW2KnOyBY55Vv2znOHfI=; b=L9qEq08u5Rq/AUyQ1vSUnzAaO6
	Isj4VW9IVAshGV1Fwb7ftl9fxwTFxgBcrtG+1p8WWfGyaXLM3o30ZrsQN/ocUHPmGoO0JK2slbAZT
	lCh1sC0nsQPratBPpbR3rrDq+DyDsPWLcL8Ug3osebXucwp2w1UTscEarmt81r3KGegn+xd2YUV4t
	1b2rV3M/N6FLVTorKCphK25SZHUAglJu4Nj2M+LZWmGI4/tzmaoMEqpVPVJ+3axUB4DS92mxWqVfC
	rcJfJN5PBBi7IWQdJ3HlIg5T76qM3IDCE/VRoF1rUSCEcPWJHjw6k6eM0Ob/dQHyik6dUPCHaGPNy
	14WFBObA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy9Zx-00000001whB-07r0;
	Thu, 05 Mar 2026 14:21:29 +0000
Date: Thu, 5 Mar 2026 06:21:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anajain.sg@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] fix s_uuid and f_fsid consistency for cloned
 filesystems
Message-ID: <aamRaJ8PaNyxYUXN@infradead.org>
References: <cover.1772095546.git.asj@kernel.org>
 <aagzcbj_CohXgIXe@infradead.org>
 <9078e07d-5997-41f3-9991-c1f6975c768b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9078e07d-5997-41f3-9991-c1f6975c768b@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 76674213532
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14659-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:32:36PM +0800, Anand Jain wrote:
> The problem is that we won't know which filesystem is the original
> and which is the clone. Generally, the first one mounted is treated
> as the original and the following one as the clone. However, f_fsid
> should remain consistent regardless of mount order, at least for
> the duration that the block device is connected (or until a
> system reboot).

Then maybe we need to make the new sane behavior dependent on a
feature flag so that only newly created file systems use it?


