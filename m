Return-Path: <linux-ext4+bounces-14575-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNx4GLoqp2nSfAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14575-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:38:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84D1F5645
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C48AE303A90C
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA4481FCD;
	Tue,  3 Mar 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKGdjKeh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57542F56E;
	Tue,  3 Mar 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563069; cv=none; b=qqAyAvrTmsuKgYR2Ex1W/YDroCEXYco7hQD5+fufAx25IEddL7oq0r/Mf72ynAJ4zOTv0UFgXVg/KONDDkVaXVJWvFsR3TQrnJufiWFWEsSb6opjvtKQCQrzHeRWkoEuTP+wKlhVbGWvmNpDPiWaNhRP+M/e3UZpML4pmlBNGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563069; c=relaxed/simple;
	bh=wIJ05c4dumViA4jq8La9zeB1/j+K31g/Hac6I6TCjdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZk2p4RoGWnkMlZxJUDBpDN3B/Ng2S56B9Cefrh458+rJirBgHf9jUPzoX9A8gNxzdVvTA7N8SC2USFxBnk3KmByX6/Si+Pocd+jKgABTK7bTQYM6DOIlABdSI4TyroiVR5J2PazfXZqvxhlj/gRXwzSQ/BmLTC5yLtxSJU2HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKGdjKeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09104C116C6;
	Tue,  3 Mar 2026 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772563069;
	bh=wIJ05c4dumViA4jq8La9zeB1/j+K31g/Hac6I6TCjdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKGdjKeh/NjNx4i5uDFJnlmF7xr45IrbNHUxfn6u9WPQpdP7khIwZGzbMCqSsGk7+
	 +zJZ6yJVlIGCeizYaX25SI9QvEZt6nMAL3lmnLgG5uG8ghJ1ze4GXKY8OlYpgPVDbk
	 hCozomw6MeVOJz9stI1lzVMqR6UJRR+QH9dKHOzFXoKkdo01+DEZq/RFY/ZZA1RiA/
	 0738ul9ngCogLaIEodEK49vivpJVnZ/IVEgJ90ob5BR5WiDta7B1nWl6+Ke+JwKlh4
	 WZkzeie2QI+5vL90haHByP5vAKoAmq+tuGfoUdr1Ik32YJhfa3+Z3oo4m2BS7SRDYC
	 nv1nNb18NQZdg==
Date: Tue, 3 Mar 2026 10:37:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, Baolin Liu <liubaolin12138@163.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2] ext4: add sysfs attribute err_report_sec to control
 s_err_report timer
Message-ID: <20260303183748.GB13823@frogsfrogsfrogs>
References: <20251211030256.28613-1-liubaolin12138@163.com>
 <176962347637.1138505.16069919738430336386.b4-ty@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176962347637.1138505.16069919738430336386.b4-ty@mit.edu>
X-Rspamd-Queue-Id: 2D84D1F5645
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
	TAGGED_FROM(0.00)[bounces-14575-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,163.com,vger.kernel.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:05:03PM -0500, Theodore Ts'o wrote:
> 
> On Thu, 11 Dec 2025 11:02:56 +0800, Baolin Liu wrote:
> > Add a new sysfs attribute "err_report_sec" to control the s_err_report
> > timer in ext4_sb_info. Writing '0' disables the timer, while writing
> > a non-zero value enables the timer and sets the timeout in seconds.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] ext4: add sysfs attribute err_report_sec to control s_err_report timer
>       commit: d518215c27194486fe13136a8dbbbabeefb5c9b6

Heh, thanks for adding this sysfs knob, now I have a userspace-visible
gadget for detecting fanotify IO error reporting support in ext4. :)

--D

> Best regards,
> -- 
> Theodore Ts'o <tytso@mit.edu>
> 

