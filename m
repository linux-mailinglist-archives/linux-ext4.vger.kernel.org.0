Return-Path: <linux-ext4+bounces-13642-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cz+MPA8immsIgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13642-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 21:00:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239791144FD
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA88302268F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128F329376;
	Mon,  9 Feb 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abi57cb4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B48462;
	Mon,  9 Feb 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667237; cv=none; b=DqU5NEa/nuNRqnRliIJXpNmJNunpDwqt851/uKZcEViCY2W6b+d5sfAy/1LkTnMjyLPbaniuHlWxDtTnZkRBibzod6pHloyMwGsA8ylY05A68aKUsc1iDTHvYqAf5MSYiHdhwSravrymIe8efyKdqnqVQYo/K2s1/5f5ZEeBWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667237; c=relaxed/simple;
	bh=e1VzeWhPdeP5JFIdpLKYDk8dv3QlXB2THbWx0X/qaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNQZFh07YSv0Ul5ot80JlnWfl59mxR7utHJeW7kHN0i+TsYjtpOe4Qp+JsqNbSofO9XWPRmUxBvYf1YW1dBfv2NBopoegbt6NBV2Bl9hlGpBJLYDunlkBPPFag1ofTfkv2GUYeKMXH9TLv/U3nyMGTFyGzahYbliaOaeWO5CJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abi57cb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F462C116C6;
	Mon,  9 Feb 2026 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770667237;
	bh=e1VzeWhPdeP5JFIdpLKYDk8dv3QlXB2THbWx0X/qaNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abi57cb4MygsaT+uLFxq1WZU5sPnXeuvMnzloejDU8RtgctEQWLDnwtcdGxvB4dqJ
	 B1rk+rMtsdzrzIhDxoTTkaPhhwouG0qA+qJD7yF8QVlpa4ks5KRsWswWqlYu1VFM/p
	 7H+WyeW6v/JBqu/Sf82DXrolFl1VvrW90cf3bko18KRCdmCtyZjUu4Vhhgeu64zKH5
	 XwiWN/ne5lPAi2rkmj5XhYK0cdtoHnRWUwBnMRe3pcIpiR6z1I6jHm+gvzfXZQM7cQ
	 aqlwgCstvsL+7uau8pn2RUwfmjEd/rv2MTGn8n+OwrsqBbT/BbgFJTRKoH9uHVL9rS
	 jB4q+YBZmgAQg==
Date: Mon, 9 Feb 2026 12:00:36 -0800
From: Kees Cook <kees@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <202602091148.EDBFECE686@keescook>
References: <20260206212654.work.035-kees@kernel.org>
 <20260209193945-80d9bfc8aa82b0eb1b764c7f-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209193945-80d9bfc8aa82b0eb1b764c7f-pchelkin@ispras>
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
	TAGGED_FROM(0.00)[bounces-13642-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[mit.edu,gmail.com,dilger.ca,intel.com,vger.kernel.org,suse.cz];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 239791144FD
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:27:50PM +0300, Fedor Pchelkin wrote:
> Kees Cook wrote:
> > ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
> >   Notices the loud failures of strscpy_pad() introduced by 8ecb790ea8c3,
> >   and attempted to silence them by making the destination 64 and rejecting
> >   too-long strings from the on-disk copy of s_mount_opts, but didn't
> >   actually solve it at all, since the problem was always the over-read
> >   of the source seen by strnlen(). (Note that the report quoted in this
> >   commit exactly matches the report today.)
> > 
> 
> [...]
> 
> > Reported-by: 李龙兴 <coregee2000@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com/
> > Fixes: ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
> 
> Hi there,
> 
> [ I'd better be Cc'ed as the author of the commit in Fixes ]

Agreed! Sorry I missed adding you to Cc.

> The mentioned reports are for v6.18.2 kernel while ee5a977b4e77 ("ext4:
> fix string copying in parse_apply_sb_mount_options()") landed in v6.18.3.
> Back at the time I've tested the patch with different bogus s_mount_opts
> values and the fortify warnings should have been gone.

Ah-ha! Okay, thank you for catching this versioning issue. I had been
scratching my head over how it could have been the same warning. This
report is effectively a duplicate of the report you fixed with
ee5a977b4e77.

> I don't think there is an error in ee5a977b4e77 unless these warnings
> actually appear on the latest kernels with ee5a977b4e77 applied.
> 
> > @@ -2485,6 +2485,13 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
> >  	if (!sbi->s_es->s_mount_opts[0])
> >  		return 0;
> >  
> > +	if (strnlen(sbi->s_es->s_mount_opts, sizeof(sbi->s_es->s_mount_opts)) ==
> > +	    sizeof(sbi->s_es->s_mount_opts)) {
> > +		ext4_msg(sb, KERN_ERR,
> > +			 "Mount options in superblock are not NUL-terminated");
> > +		return -EINVAL;
> > +	}
> 
> strscpy_pad() returns -E2BIG if the source string was truncated.  This
> happens for the above condition as well - the last byte is truncated and
> replaced with a NUL-terminator.

Yeah, I've double-checked this now. The second half of the overflow
check in the fortified strnlen eluded by eyes when I went through this
originally. Thanks for sanity checking this!

> The check at 3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in
> ext4_ioctl_set_tune_sb()") was done in that manner as there is currently
> no way to propagate strscpy_pad() return value up from ext4_sb_setparams().
> So the string is independently checked inside ext4_ioctl_set_tune_sb()
> directly.
> 
> 
> As for the 64/65 byte length part, now the rationale of the checks works
> as Darrick Wong described at the other part of this thread and corresponds
> to how relevant userspace stuff treats the s_mount_opts field: the buffer
> is at most 63 payload characters long + NUL-terminator.  Jan Kara also
> shared similar thoughts during the discussion of ee5a977b4e77 [1].
> 
> [1]: https://lore.kernel.org/linux-ext4/yq6rbx54jt4btntsh37urd6u63wwcd3lyhovbrm6w7occaveea@riljfkx5jmhi/

Okay, great. I figure I can do two things:

1) rework this patch with adjusted commit log to reflect the notes
   raised so far, so that we reject mounts that lack a NUL-terminated
   s_mount_opts (as silent truncation may induce an unintended option
   string, e.g. "...,journal_path=/dev/sda2" into "...,journal_path=/dev/sda"
   or something weird like that).

2) Leave everything as-is, live with above corner case since it should
   be unreachable with userspace tooling as they have always existed.

I'm fine either way! :)

-Kees

-- 
Kees Cook

