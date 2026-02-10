Return-Path: <linux-ext4+bounces-13650-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPgBMnr0imn2OwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13650-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 10:03:54 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D951187F0
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF19C304D263
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AB33D6FF;
	Tue, 10 Feb 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KPoaIoMx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0D27AC4D;
	Tue, 10 Feb 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714221; cv=none; b=cAR0YJtF4isllZhCNpi+5hGD+H2NXf9upbSXhgCaq9b6is1K3elQD4SXSR6GbmZgUHIgPlLw/2RaJRP+VUJAmtAEWwCBT5DHqOzvFctx/POUzTZaHkQE17jb/6n5IYo3O5821CTrYKi2NxkIG829vzCwsqCMVeKL4aOeNDx6Arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714221; c=relaxed/simple;
	bh=Nng69iqAPw+o32S33yUBs45sHPkloSOPTy0Plxsl+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOLBl3jnVCKyu4xbcz3jLC2DBO3NyYTk6PR8nUyT+0fzi1WLi5mXIvecBNsSKRghAc/TQQMj1utbEScr1FpsRhF3YQvg48exeAVgoH/Xu/iLyyN7K6eqaLtFtESe4rIwnGlByEOVY7qvJtuRd3yaNuT2krIoOdGL8ubhsHrDgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KPoaIoMx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [79.139.249.127])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0C943413A4D8;
	Tue, 10 Feb 2026 09:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C943413A4D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1770714216;
	bh=AnkvOa2Gky14QzjdML5HzhN5tDlpfoHiOi44Pmq3hK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPoaIoMxpd6vXRjhP2OACAUGwFZBrofXtzHNd4bxVMINcrsPwtseRfUEj7ORqKVsF
	 t3KlUmdBhci+LL4puxpoNJ0um3QBn8y8ZFuExB0SPZgAlf3NlA+HZsGjqRshAJ5C8H
	 DG+XgSxWYL4I6POg98HyNce+uzoCyKwN+Zq57GNc=
Date: Tue, 10 Feb 2026 12:03:35 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <20260210115731-8a60c77ca684b6684fb8955f-pchelkin@ispras>
References: <20260206212654.work.035-kees@kernel.org>
 <20260209193945-80d9bfc8aa82b0eb1b764c7f-pchelkin@ispras>
 <202602091148.EDBFECE686@keescook>
 <20260210050124.GR7686@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210050124.GR7686@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13650-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,dilger.ca,intel.com,vger.kernel.org,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ispras.ru:dkim]
X-Rspamd-Queue-Id: 46D951187F0
X-Rspamd-Action: no action

On Mon, 09. Feb 21:01, Darrick J. Wong wrote:
> On Mon, Feb 09, 2026 at 12:00:36PM -0800, Kees Cook wrote:
> > Okay, great. I figure I can do two things:
> > 
> > 1) rework this patch with adjusted commit log to reflect the notes
> >    raised so far, so that we reject mounts that lack a NUL-terminated
> >    s_mount_opts (as silent truncation may induce an unintended option
> >    string, e.g. "...,journal_path=/dev/sda2" into "...,journal_path=/dev/sda"
> >    or something weird like that).
> > 
> > 2) Leave everything as-is, live with above corner case since it should
> >    be unreachable with userspace tooling as they have always existed.
> > 
> > I'm fine either way! :)
> 
> I'd pick #1, unless someone knows of a userspace program that could have
> set a 64-byte s_mount_ops string with no null terminator.  I didn't find
> any, but there are many implementations of ext4 out there. :/
> 
> (and yes, it's better to reject an unterminated s_mount_opts than
> accidentally point the kernel at the wrong block device)

If I understand the issue correctly, it's already being rejected with the
existing check:

	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
		return -E2BIG;

If the source string is truncated at least by one symbol (which is the
case for unterminated string), strscpy_pad() returns -E2BIG and the mount
fails.

