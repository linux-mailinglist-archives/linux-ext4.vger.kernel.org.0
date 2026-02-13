Return-Path: <linux-ext4+bounces-13690-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKC5G0xrjmnuCAEAu9opvQ
	(envelope-from <linux-ext4+bounces-13690-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 01:07:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144A131E1B
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 01:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E962304D1D6
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA53FCC;
	Fri, 13 Feb 2026 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORryKGMf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D9A92E;
	Fri, 13 Feb 2026 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941254; cv=none; b=up0NTdhLmC4u1pAch+JOn2uOL/LJL+4eNNwKM2kDUll+92xCyXzso949QBn9+k6Mp7WdBjVfCc8VwRfLlAYKXrhxVw+xZ+aV8rSNOAySOMyG4l42Cc/RvmRv34rdWC8hkhhpEWcQauBzrqdpCTzDmXCWYUn3Z574bRTO4DxbLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941254; c=relaxed/simple;
	bh=Y0I07DDtvWJoLuqEt4XtXy6vUlooxYo2XxgYeJDrJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZqglfydQD/BSf7po50UWuCszaQkzZoGjANwQqtrfXBIutqAz1rrTGKAxyVHnxJQrA5KXr5979Dp0zkJMp1HL9aoleMp77LlTQfjZ50EodKJC9zvJik6cZSyx9P1hSGpbr/uNER6ipCQlMswmO/FW2am3n9qVPCRLew9yLbZozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORryKGMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB880C4CEF7;
	Fri, 13 Feb 2026 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770941254;
	bh=Y0I07DDtvWJoLuqEt4XtXy6vUlooxYo2XxgYeJDrJfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORryKGMfv9lUjOIzeJuFvRAmjsWbiq9aobAJ7xvuaULYz7DmM4mRnaJWbm/ETLHjP
	 jKDgOOcPqTvPOMm6hbalKV7uDi936yAvn1yxRbSVLHZmec+eoO6Oy48JoCCRdAbvSW
	 6XljSOgrRZVfNSebTMOJu7vNTqEkmQJf4SvcqpV06uF8cn7XW27X2InwUW7fHVTWQM
	 d1SsA6clj5UpaKR8mZmaY2o5jZcDJM0kObHqPP7zV+BWB6VNTkkcxT1eb5z+VU5jXx
	 S0jaGISCO0itjX0jiD8WoffcLTXbh7AF0E5kV2xpuP7Z1NDQswVptH2rmG+IU9wx/P
	 WddQM5nQiPIew==
Date: Thu, 12 Feb 2026 16:07:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Weber <simon.weber.39@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, tahsin@google.com,
	Anthony Durrer <anthonydev@fastmail.com>
Subject: Re: [PATCH v2] ext4: fix journal credit check when setting fscrypt
 context
Message-ID: <20260213000720.GA2191@quark>
References: <20260207100148.724275-4-simon.weber.39@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207100148.724275-4-simon.weber.39@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13690-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,google.com,fastmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0144A131E1B
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 10:53:03AM +0100, Simon Weber wrote:
>  	if (handle) {
> +		/*
> +		 * Since the inode is new it is ok to pass the XATTR_CREATE flag. This
> +		 * is necessary to match the reamining journal credits check in the
> +		 * set_handle function with the credits allocated for the new inode.
> +		 */

Typo: reamining => remaining

Otherwise this looks good.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

