Return-Path: <linux-ext4+bounces-13667-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEbpGJbgi2kVcgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13667-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 02:51:18 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA6C120898
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 02:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C04307EC62
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 01:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88872C15BB;
	Wed, 11 Feb 2026 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttlvbUIG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859C239E9A;
	Wed, 11 Feb 2026 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774601; cv=none; b=IbwdojFOTMlSuCtOCDi5Fg7ZFUDxrhA1PEZKtXPhcTqsf1u2qYFvi1Re5BbbMRKbFxXPiMduUbIhP6D1JMoUAu3Dp1xueX8Blcp9NNESGfxHWun5dlVnuJO7hnVd0qIm9AuXs1lNvLN93I67sYOR1vhqawBXZgOLVStgAdCwjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774601; c=relaxed/simple;
	bh=9DpbWfY9/tuwF0tWoezq5LLP0eYFa9VS94LE8d07iQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IACtte73NNjevQLN9/cqx8O4BpIuBcWKBQ0Fk7zd0uD4oIpdveEN6la3WN6Sw5tRf67bVTmWX9iL/hOgbAE28454wjHu6kBi6DAPzzozzGrnj+wn+j2hIMD+JRalI2EOEwCBJAOKQWm27b1C6toyUHDM7uuvMO0GgK32hSyl0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttlvbUIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECAFC116C6;
	Wed, 11 Feb 2026 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770774601;
	bh=9DpbWfY9/tuwF0tWoezq5LLP0eYFa9VS94LE8d07iQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ttlvbUIGthtrXP0Ow8SAkHoocj3SM9r+pLPNjqo+1a5aSH6m/wXXlwNQhv7l6XF71
	 4vxe9OJLtIviKiH6T7ZzMfjQqEXEfucnfvmEZ4mkVu/43CA8RcRvqpkvzxt2eK5DK3
	 lWNUhx6eYcpHJ59ZR1du9DqEJU01HUW7cBb6LUdDQc/EqYGE1RbobAKgMa9Wt7o9Dn
	 95a4v/WIerrK7E7so/ul+EakfmvF8AWOigCswQCPcpzM/r2q3tCTlfEGM3GX5Fa1Fd
	 AB+y8s+oQ4nfWhax/Ezign0x5RspGMG7Nr9vhUfootAqqsrFcz8ymZCZ/bZ/OGpJWW
	 RJNRM/kSfK2Wg==
Date: Tue, 10 Feb 2026 17:50:00 -0800
From: Kees Cook <kees@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <202602101749.40E8AB05@keescook>
References: <20260206212654.work.035-kees@kernel.org>
 <20260209193945-80d9bfc8aa82b0eb1b764c7f-pchelkin@ispras>
 <202602091148.EDBFECE686@keescook>
 <20260210050124.GR7686@frogsfrogsfrogs>
 <20260210115731-8a60c77ca684b6684fb8955f-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210115731-8a60c77ca684b6684fb8955f-pchelkin@ispras>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13667-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,dilger.ca,intel.com,vger.kernel.org,suse.cz];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAA6C120898
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:03:35PM +0300, Fedor Pchelkin wrote:
> If I understand the issue correctly, it's already being rejected with the
> existing check:
> 
> 	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
> 		return -E2BIG;
> 
> If the source string is truncated at least by one symbol (which is the
> case for unterminated string), strscpy_pad() returns -E2BIG and the mount
> fails.

Agreed. Sorry for the noise! Things appear to be fine as-is. I had
missed the version tested in the original report.

-- 
Kees Cook

