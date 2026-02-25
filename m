Return-Path: <linux-ext4+bounces-14007-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE5DLqsGn2nnYgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14007-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 15:26:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32349198B87
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37E330157E4
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3123D348E;
	Wed, 25 Feb 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IKqrcGHA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D0387362;
	Wed, 25 Feb 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029244; cv=none; b=iFxsPpTZ16WRqL8VKqCvB7HVaNY8Thk3rXQ7tU9loLkNBJA1/+S+e4EYOCCt776S8DsekLUKCpk7dXFMN/7BNo66HrWT1n94BRcI3CD7yBjqXhGx8uYQx+8W2Be9f61/9iZdu4DbHPlzIBc7VjktXY1HVptireyENPMPngv0wrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029244; c=relaxed/simple;
	bh=IN52F3Q+kDaVpJdJvOMh9uIoa24HkEH5ayrYESSOUeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAWjXJ4p3/VJLMcbMf9mDcTVt7kacMf8fASlII+TXkVBH0pl8DE1eyNT0Xq4KHX1UB68Zqcuid5VHMz552S1+g560JvEXF6ueT0OGrxkDYnPKmVtI7edwSoZNAwogllN74rkYP41BQKsjoy76Rjha5oHB1z6STtZsiW22xTk/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IKqrcGHA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p+I1WBIA9XuUaR/q9NvpkB8vKQ1KePEcHq/hzuc52fM=; b=IKqrcGHAT0EM6UfAS5OvTyNDpV
	qq4O+Zfkj1ni8okg/5rGab1Z/BU2B6r608EKfvFUPRzbYGGMimELaJzcJmL51GY3wyCvEb/dwZ+So
	0pIcHrLemOjrlwDRSnZDfFvWCglu0FwG7cXezeptXmGTt1EoJcr0pj+uOqdiDNLMVSxuBxkhHXlnI
	VIZmlRBspI4NoHuicm0dVqiBuIoWkxcZN8ehbjFb2gVNRbJwmNk78f9fENwJeZPaZkVAWujYhg2pi
	IIfK5e8k06jhY/Jjx576TkRrpxSMbyKB5S4lDX+SFGP1xKkvuw0zYB+mvbC+T6ooCRweFnkIcexJQ
	gFWKCvKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvFkn-00000004BT9-3xF7;
	Wed, 25 Feb 2026 14:20:41 +0000
Date: Wed, 25 Feb 2026 06:20:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <aZ8FOX4S6bXYS8VZ@infradead.org>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <aZ2599dwNuqPQgzB@infradead.org>
 <20260224222339.GA13823@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224222339.GA13823@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,mit.edu,dilger.ca,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14007-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32349198B87
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:23:39PM -0800, Darrick J. Wong wrote:
> He did, way at the beginning: open a file, write 5000 bytes, close it,
> open again with O_SYNC, write 300 bytes, close it, force-reboot, and
> watch the file come back up with only 4096 bytes written.

Oh, I misunderstood the load and thought it would write the 300 bytes
after the previous 5000 bytes.  If it overwrites the result is totally
expected.


