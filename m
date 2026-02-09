Return-Path: <linux-ext4+bounces-13627-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGs5BCIZimkjHAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13627-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 18:28:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D61130BC
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 18:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 016BB3006783
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86938945E;
	Mon,  9 Feb 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Yg/TF4C0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D333806DB;
	Mon,  9 Feb 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658079; cv=none; b=O419sUJrTstoJM6J3oAxz6q0Bs/1fqfQ9KnRJEzn820qemW7+fZ8kBR+79gztCuyQr7dant1QqBe8zM11STjL7zJlPYoMR9J2SOTIlTM08MERWPXNnu1iKdqEYozwm7gbcHIKyzsqfu1h9N3ApK7o2ErzpG4twXx/osGGNEEXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658079; c=relaxed/simple;
	bh=EckDzIB85OPtZ0L5+pn/y9RZ7eyE+62oJwvMpI+aS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oSfFh78iTXyGiWZ99ldQA0SLTToW2aPR4BWtlR2t5sOQ53hkG48IGggoigSl8D5FZEfl6w+Ru/bJl0LCNDhgxlTTANASGMxDhuF/4sv4svhqXmxmY0s9zPsKnAx3rQN5DfQu9a7ohdhw0Orv6ek8aeFakvZBnRum571Gu3hspO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Yg/TF4C0; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.15])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3CB0F413A4B0;
	Mon,  9 Feb 2026 17:27:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3CB0F413A4B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1770658070;
	bh=0xXj+JToMkkECdVZ1BvtzQ1KbVz5+Tpi2h68cDWOvwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yg/TF4C0cnPglddrgnY8O8xojHJPCOLyQQ74WM4F+ptT7JvltozqbddkvY7Xzx0nb
	 C0c735o2pcoRQ/dgCJJJQ96Y4seZqUK78bRDzxg6CFU6YqfSTvc5OvAYiSM+5Lw1GG
	 kwLT0bIrYqKUvhV2U1/Mcw/Ww5Wfy6DOi6SnKZvw=
Date: Mon, 9 Feb 2026 20:27:50 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Kees Cook <kees@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <20260209193945-80d9bfc8aa82b0eb1b764c7f-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206212654.work.035-kees@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13627-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[mit.edu,gmail.com,dilger.ca,intel.com,vger.kernel.org,suse.cz];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 995D61130BC
X-Rspamd-Action: no action

Kees Cook wrote:
> ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
>   Notices the loud failures of strscpy_pad() introduced by 8ecb790ea8c3,
>   and attempted to silence them by making the destination 64 and rejecting
>   too-long strings from the on-disk copy of s_mount_opts, but didn't
>   actually solve it at all, since the problem was always the over-read
>   of the source seen by strnlen(). (Note that the report quoted in this
>   commit exactly matches the report today.)
> 

[...]

> Reported-by: 李龙兴 <coregee2000@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com/
> Fixes: ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")

Hi there,

[ I'd better be Cc'ed as the author of the commit in Fixes ]

The mentioned reports are for v6.18.2 kernel while ee5a977b4e77 ("ext4:
fix string copying in parse_apply_sb_mount_options()") landed in v6.18.3.
Back at the time I've tested the patch with different bogus s_mount_opts
values and the fortify warnings should have been gone.

I don't think there is an error in ee5a977b4e77 unless these warnings
actually appear on the latest kernels with ee5a977b4e77 applied.

> @@ -2485,6 +2485,13 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	if (!sbi->s_es->s_mount_opts[0])
>  		return 0;
>  
> +	if (strnlen(sbi->s_es->s_mount_opts, sizeof(sbi->s_es->s_mount_opts)) ==
> +	    sizeof(sbi->s_es->s_mount_opts)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Mount options in superblock are not NUL-terminated");
> +		return -EINVAL;
> +	}

strscpy_pad() returns -E2BIG if the source string was truncated.  This
happens for the above condition as well - the last byte is truncated and
replaced with a NUL-terminator.

The check at 3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in
ext4_ioctl_set_tune_sb()") was done in that manner as there is currently
no way to propagate strscpy_pad() return value up from ext4_sb_setparams().
So the string is independently checked inside ext4_ioctl_set_tune_sb()
directly.


As for the 64/65 byte length part, now the rationale of the checks works
as Darrick Wong described at the other part of this thread and corresponds
to how relevant userspace stuff treats the s_mount_opts field: the buffer
is at most 63 payload characters long + NUL-terminator.  Jan Kara also
shared similar thoughts during the discussion of ee5a977b4e77 [1].

[1]: https://lore.kernel.org/linux-ext4/yq6rbx54jt4btntsh37urd6u63wwcd3lyhovbrm6w7occaveea@riljfkx5jmhi/

> +
>  	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
>  		return -E2BIG;
>  
> -- 
> 2.34.1

