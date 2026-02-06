Return-Path: <linux-ext4+bounces-13608-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tiwzDa5jhmmYMgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13608-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:57:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F41039BD
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 22:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442513039885
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA231328C;
	Fri,  6 Feb 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8TLSAwm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616526D4CD;
	Fri,  6 Feb 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415013; cv=none; b=nXAGoCwPP19pufek7R35yilnvgQrpiUaR74toWYsi6WNQfjacbUcDxBONtjfJJLPFMC5ZK7ccIei2DRfPtcpCphBzsX+oXQrDa3A8OhAXjrm0eyCZoujhkd5dAQAVJnpzXghh7wZITRO/d/q/NBNwlpDN7Om6bXUo3POcO4qHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415013; c=relaxed/simple;
	bh=+WsnVmBJMus9eaeC/StU+mPQYgz6Tuk5JsAY+sm8LE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgHeF8jkU9AD/IXKqx65OiZ8RaHy2Be88Dub9S5vO2AQI/sOLAXZeEgras8M+fYWJ9I3nTjwfzbVpI3gN7ux24+DCUxzNkk2aIMTi+WxIowx8Ps8oZG+ZsoluIb0QthDA/X2dKgUrk8XIhp+B2UzN3xEIOhVC0qKC8bMzvNpd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8TLSAwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109A7C116C6;
	Fri,  6 Feb 2026 21:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770415013;
	bh=+WsnVmBJMus9eaeC/StU+mPQYgz6Tuk5JsAY+sm8LE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8TLSAwms+VlF4U58JrEgGSVjTPE1xRtJsqUjLCgT17uLM81aKG7DYnd/PUSm32Fx
	 FD1+MWaNt15CGerUkzTBZwOi7GCJhC5yoylt5D0GxM6+qlFPLkjljczgJSyC8/9tC3
	 7/f0pd2QeOp8urdF41u2/Cqxc6+RWFdBq7z3CV1wHoKW5Ofj3ViiQvdJbkzsSrqekS
	 nAeKq6hCOIjbSLH9zmFtcdPzH5fn3ukkIv1c1MQsA3JaLh/M1Slo+3i6TKYiF+cj4y
	 Jyf1wq5PlmLT+jdGWiqgQyoFZPI/1h5BWMa+SnSNrWK8RuoQAEt6OGZcPTxfXajp6I
	 4qoHMN8I1vlgg==
Date: Fri, 6 Feb 2026 13:56:52 -0800
From: Kees Cook <kees@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <202602061347.2046B806C5@keescook>
References: <20260206212654.work.035-kees@kernel.org>
 <20260206214502.GP7686@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206214502.GP7686@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13608-lists,linux-ext4=lfdr.de];
	FREEMAIL_CC(0.00)[mit.edu,gmail.com,dilger.ca,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 783F41039BD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:45:02PM -0800, Darrick J. Wong wrote:
> On Fri, Feb 06, 2026 at 01:27:03PM -0800, Kees Cook wrote:
> > When mounting an ext4 filesystem, the on-disk superblock's s_mount_opts
> > field (which stores default mount options set via tune2fs) is read and
> > parsed. Unlike userspace-provided mount options which are validated by
> > the VFS layer before reaching the filesystem, the on-disk s_mount_opts
> > is read directly from the disk buffer without NUL-termination validation.
> > 
> > The two option paths use the same parser but arrive differently:
> > 
> >   Userspace mount options:
> >     VFS -> ext4_parse_param()
> > 
> >   On-disk default options:
> >     parse_apply_sb_mount_options() -> parse_options() -> ext4_parse_param()
> > 
> > When s_mount_opts lacks NUL-termination, strscpy_pad()'s internal
> > fortified strnlen() detects reading beyond the 64-byte field, triggering
> > an Oops:
> > 
> >   strnlen: detected buffer overflow: 65 byte read of buffer size 64
> >   WARNING: CPU: 0 PID: 179 at lib/string_helpers.c:1035 __fortify_report+0x5a/0x100
> >   ...
> >   Call Trace:
> >    strnlen+0x71/0xa0 lib/string.c:155
> >    sized_strscpy+0x48/0x2a0 lib/string.c:298
> >    parse_apply_sb_mount_options+0x94/0x4a0 fs/ext4/super.c:2486
> >    __ext4_fill_super+0x31d6/0x51b0 fs/ext4/super.c:5306
> >    ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
> >    get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
> >    vfs_get_tree+0x8e/0x340 fs/super.c:1758
> >    fc_mount fs/namespace.c:1199
> >    do_new_mount fs/namespace.c:3718
> >    path_mount+0x7b9/0x23a0 fs/namespace.c:4028
> >    ...
> > 
> > Reject the mount with an error instead. While there is an existing similar
> > check in the ioctl path (which validates userspace input before writing
> > TO disk), this check validates data read FROM disk before parsing.
> > 
> > The painful history here is:
> > 
> > 8b67f04ab9de ("ext4: Add mount options in superblock")
> >   s_mount_opts is created and treated as __nonstring: kstrndup is used to
> >   make sure all 64 potential characters are available for use (i.e. up
> >   to 65 bytes may be allocated).
> > 
> > 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> >   Created ext4_tune_sb_params::mount_opts as 64 bytes in size but
> >   incorrectly treated it and s_mount_opts as a C strings (it used
> >   strscpy_pad() to copy between them).
> > 
> > 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
> >   As a prerequisite to the ioctl treating s_mount_opts as a C string, this
> >   attempted to switch to using strscpy_pad() with a 65 byte destination
> >   for the case of an unterminated s_mount_opts. (But strscpy_pad() will
> >   fail due to the over-read of s_mount_opts by strnlen().)
> > 
> > 3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()")
> >   As a continuation of trying to solve the 64/65 mismatch, this started
> >   enforcing a 63 character limit (i.e. 64 bytes total) to incoming values
> >   from userspace to the ioctl API. (But did not check s_mount_opts coming
> >   from disk.)
> > 
> > ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
> >   Notices the loud failures of strscpy_pad() introduced by 8ecb790ea8c3,
> >   and attempted to silence them by making the destination 64 and rejecting
> >   too-long strings from the on-disk copy of s_mount_opts, but didn't
> >   actually solve it at all, since the problem was always the over-read
> >   of the source seen by strnlen(). (Note that the report quoted in this
> >   commit exactly matches the report today.)
> 
> Looking through the history of tune2fs, I see v1.42 has commit
> 9a976ac732a7e9 ("tune2fs: Fix mount_opts handling"), which always set
> byte 63 to a null, which implies that s_mount_opts is supposed to be a
> 64-byte field that contains a null-terminated string.  It also doesn't
> appear that slack space after the null terminator is set to any
> particular value.

Okay, so the userspace side is treating it as a C string. Then ignore my
"PATCH ALTERNATIVE" I just sent. ;)

> In e2fsprogs v1.41.13, commit 9345f02671fd39 ("tune2fs, debugfs,
> libext2fs: Add support for ext4 default mount options") added the
> ability to set s_mount_opts, and it rejects any string whose length
> is greater than or equal to 64 bytes.  This validation is still in
> place.

Great, thanks for tracking that down. That looks to be Dec 2010.

> My guess is that the ext4 code should go back to requiring a null
> terminated string, and the __nonstring annotations dropped.

It does already; no __nonstring annotations currently exist for
s_mount_opts. The trouble was that it was originally treated as
effectively __nonstring between 8b67f04ab9de (v2.6.36, Oct 2010) and
04a91570ac67 (v6.18, Nov 2025).

> I guess the hard part is, were there any filesystems written out with a
> 64-byte unterminated s_mount_opts?  It looks like 04a91570ac67 used
> strscpy_pad to copy the string to the superblock and that function
> always zero-terminates the destination, so perhaps we can stick with
> "the ondisk superblock s_mount_opts is always a null terminated string"?

Yeah, if the userspace tools always wrote images with a NUL-terminated
s_mount_opts, then it should be perfectly sane to reject mounts that
don't follow that. (i.e. this patch.)

-- 
Kees Cook

