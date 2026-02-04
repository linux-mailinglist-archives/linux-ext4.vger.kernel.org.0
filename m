Return-Path: <linux-ext4+bounces-13533-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNo1H0PHg2k/uQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13533-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 23:25:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E0ECFA6
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 378C53011BC8
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876F33A717;
	Wed,  4 Feb 2026 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCKvujoc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFE27F163;
	Wed,  4 Feb 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243896; cv=none; b=fHcFX3a1kX12pJJtLLINdpmuR59fqEX+6waZQ8uWiG5zUnwf+w29T7LysQ8d2zzpp4OLquKt62ua4Yps4WSmrum3rgsoHK3Adesljj/GaMKJjZ9L5zwytdG2AsRp45bsJ2/CiV1skI8AixLxktMdDRDtWBKPMZRMweBM716Oypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243896; c=relaxed/simple;
	bh=9DFnLFXIndaN365DTg0PU8hn3qJYJWGEXOHnIHQqdy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUMBEl3H2PouRvesQt7+AtLRd8UOxSHfvXr10iBQJQwQOWTzOPWwROImew3rZKv9xsQtZ0y0mONLUEFm3U6UbmoYTKIMqPhXozpaAChFNxYqAB5RWu7Rp5t4buB+u9shHSdmORry2/n1OAGSjPF6s7qijVCrzADrI4G6rQxzSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCKvujoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEDDC4CEF7;
	Wed,  4 Feb 2026 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770243895;
	bh=9DFnLFXIndaN365DTg0PU8hn3qJYJWGEXOHnIHQqdy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCKvujoc6xM8QJ/x6PQvNMLcHDC0u9u3hC5AFzH8FuemJHzzNb04/VJfliDHyo3Av
	 erSw48gytCVy6MXW0aPS6ipqsFBZ67fvxAMtMqvpj44U4i6q8ZDfE5zLtKgHYD+wxL
	 XLUjzT/OgcHtGAd5ssPD+CrW7fJ1b1gSVzjHAGWY8N62+fp80ByJELYNjbM6z61x2k
	 iPXX1WmWDXeyTv1vCGxcT8V+dy+33u62VMJXXbLDShCaqBVVhy3rRdTPnSjY8p9RZ2
	 JnxQu9OWb4VyMeA69FdI5V24w5QfptwVQsEdOBCVV0ejSQDDvOSxLwRkAUJerVw3Lb
	 eonnuuA47FfUQ==
Date: Wed, 4 Feb 2026 14:24:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Weber <simon.weber.39@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, anthonydev@fastmail.com
Subject: Re: [PATCH v1] ext4: fix journal credit check when setting fscrypt
 context xattr
Message-ID: <20260204222453.GA5457@quark>
References: <8feeeec8-7330-47ae-9b54-9e789ebdfae5@gmail.com>
 <20260204205903.GA2197@quark>
 <daff127b-08b0-4a3a-8faa-7e44f99189f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daff127b-08b0-4a3a-8faa-7e44f99189f9@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13533-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-ext4@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,fastmail.com];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D6E0ECFA6
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:55:39PM +0100, Simon Weber wrote:
> Thank you for your comments, Eric!
> 
> On 04.02.26 21:59, Eric Biggers wrote:
> > This patch doesn't actually apply to the stated base-commit, likely
> > because of corrupted whitespace.  Make sure to use 'git send-email' as
> > described in Documentation/process/submitting-patches.rst.
> >
> > The commit message should be broken into paragraphs, and ideally
> > shortened a bit.  The code comment maybe could be shortened as well.
> Excuse me for the patch formatting! This is my first kernel contribution, so please bear with me. The patch applied correctly on my end when I sent it to myself, but I seem to have mangled it when sending it to the mailing list. I'll make sure to adapt the patch itself, the commit message and code comment in v2.
> > Since this is a bug fix, please include an appropriate Fixes tag.
> I'm not sure which commit I should put in the "Fixes:" tag, since the bug arises from the combination of two commits: Firstly, commit 2f8f5e76c7da7871 introduced passing the handle through fs_data, and secondly, commit c1a5d5f6ab21eb7e introduced the check for sufficient credits in ext4_xattr_set_handle. Should I put the chronologically later commit (which would be the latter)?

Usually "Fixes" should list the commit that exposed the bug, even if the
code itself is older.

> I think the scenario you describe is somewhat unlikely, but that doesn't mean that we shouldn't be able to deal with it cleanly of course. However the current patch does not have an issue with this scenario, since when ext4_set_context is called through the path from FS_IOC_SET_ENCRYPTION_POLICY, fs_data(=handle) is NULL and therefore my changed line is not executed. The flag would not be set and the ioctl would execute successfully. My commit message was a bit misleading here, making it sound like the ioctl-path actually reaches my suggested change.
> 
> I think the assumption "fs_data!=NULL implies that encryption xattr MUST NOT be present" would have to be documented clearly to prevent future issues. I see a few alternative possible approaches to ensuring this more cleanly, let me know if you think this is necessary, and if yes, which solution fits the best into the existing philosophy:
> - Adapt e2fsck to remove encryption xattrs from inodes which do not have the encrypt flag. This might just be a good idea in general.
> - Adapt fscrypt_get_policy to fix this issue itself on any inodes it is called on, which happens to check before a new context is set in the ioctl-path. I don't like this approach since it would make a getter function have side effects.
> - We could also change the void *fs_data argument of ext4_set_context from a handle_t to a new struct containing a flag int as well as a handle_t. Then the given flag (if present) could simply be passed down to ext4_xattr_set_handle, or 0 if no fs_data is given. __ext4_new_inode could then pass that flag through the detour through fs/crypto. This would somewhat "self-document" away the assumption (if someone passes the struct with a flag int, they will know not to set XATTR_CREATE if the xattr is possibly already present).
> 
> Looking forward to your insights!

If XATTR_CREATE is being used only when an inode is being created, then
yes it should be fine.  Just make sure to explain this clearly.

- Eric

