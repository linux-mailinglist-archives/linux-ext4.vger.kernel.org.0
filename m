Return-Path: <linux-ext4+bounces-13530-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALhYCDSzg2k0tAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13530-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 21:59:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B8EC9EA
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E76D301D04B
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B743C072;
	Wed,  4 Feb 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkM7QfTO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C437F8BD;
	Wed,  4 Feb 2026 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238746; cv=none; b=RAYf1lNuSY/t6Xg/HDh/IPGDH8k40IC7eWCDW9ZU7J1Fe37FX6YdJaCMYUcPgmJnLCzC5wDrhVigczHncPQLUUCB0W50T/sAnAH5PESHh8yplIylhGhyUKpO2Wm4PWiy7Xchw04wskoZIlOL6qcPJtZtShhCvMKQbFMvVHxYGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238746; c=relaxed/simple;
	bh=B6thRlc2RbHGNG+djMX0Je2bmbWqh2XpAabSWDB4qok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDXLGK5tGO1M0TRVy2OVQu+ktIlOs2pBkhlsPG05LF4BfLrM9QNDSfECUf8WIbLQkiH+RodF58K+71ZAo28V4FekqMuOFkSRk0fxVXBsZ7nmNbHUnBHUHx3+zARCKCsdgqSiRf34cTEV4bT4dB7f26LzX4Y47akWPKPMtivDbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkM7QfTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B47C4CEF7;
	Wed,  4 Feb 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770238745;
	bh=B6thRlc2RbHGNG+djMX0Je2bmbWqh2XpAabSWDB4qok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkM7QfTOqM3BIAzzC/hpgJ9HpxFVCy4w//AtvtSbh5N8291R1aPFWS30fM6w/u5ed
	 piPxsH8J3IKkHn+SbGxwzBhl2wvUia2thL/iyAgvziEd1+u96woqaxyP4KeNAOdW7M
	 c0fIuPwJROUcPgFKaY1FGINPrCHVWVmYVmyDouYAutrn0PH8f1/d0+8uaEdnRVY10O
	 TVA432gXYQMnqn/8PetCR6zQaNwJ4Mg9tiWcQuCUpdUy9tPQPHFLZg5ccMqioRiySD
	 Lfl7bXshqdF88eUxL/nCQIQqdmb5WHqg6l5aRDwrNgyepCJAr/zaaQAwHv76fiwnbP
	 QgR22p83fSXQA==
Date: Wed, 4 Feb 2026 12:59:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Weber <simon.weber.39@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, anthonydev@fastmail.com
Subject: Re: [PATCH v1] ext4: fix journal credit check when setting fscrypt
 context xattr
Message-ID: <20260204205903.GA2197@quark>
References: <8feeeec8-7330-47ae-9b54-9e789ebdfae5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8feeeec8-7330-47ae-9b54-9e789ebdfae5@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-13530-lists,linux-ext4=lfdr.de];
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
X-Rspamd-Queue-Id: 837B8EC9EA
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 04:09:02PM +0100, Simon Weber wrote:
> From: Simon Weber <simon.weber.39@gmail.com>
> 
> When creating a new inode, the required number of jbd2 journalling credits
> is conservatively estimated by summing up the credits required for various
> actions. This includes setting the xattrs for example for ACLs and the
> fscrypt context. Since the inode is new and has no xattrs, the estimation
> of credits needed for creating these xattrs is performed by passing
> is_create=true into the function __ext4_xattr_set_credits, which yields a
> lower number of credits than when is_create is false. However, following
> the control flow until the fscrypt context xattr is actually set, the
> XATTR_CREATE flag is not passed by ext4_set_context to
> ext4_xattr_set_handle. This causes the latter function to compare the
> remaining credits against the value of __ext4_xattr_set_credits(...,
> is_create=false), which may be too much. This flawed design does not
> usually cause any issues unless the filesystem features has_journal,
> ea_inode, and encrypt are all present at the same time. In this case,
> creating a file in any fscrypt-encrypted directory will always return
> ENOSPC.
> This patch fixes this issue by passing the XATTR_CREATE flag in the
> ext4_set_context function. This is safe since ext4_set_context is only
> called when creating a new inode (in which case the context xattr is not
> present yet) or when setting the encryption policy on an existing file
> using the FS_IOC_SET_ENCRYPTION_POLICY ioctl, which however first checks
> that the file does not currently have an encryption policy set. When
> calling ext4_set_context it is therefore not undesirable behaviour to
> possibly fail with an EEXIST error due to the XATTR_CREATE flag and the
> context xattr already being present.
> 
> Co-developed-by: Anthony Durrer <anthonydev@fastmail.com>
> Signed-off-by: Anthony Durrer <anthonydev@fastmail.com>
> Signed-off-by: Simon Weber <simon.weber.39@gmail.com>
> ---
>  fs/ext4/crypto.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
> index cf0a0970c095..5b665f85f6a7 100644
> --- a/fs/ext4/crypto.c
> +++ b/fs/ext4/crypto.c
> @@ -163,10 +163,20 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>       */
>  
>      if (handle) {
> +        /*
> +         * Set the xattr using the XATTR_CREATE flag, since this function should
> +         * only be called on inodes that do not have an encryption context yet.
> +         * Since when estimating the number of credits needed for the new inode
> +         * we called ext4_xattr_set with is_create = true, we need to pass this
> +         * flag, otherwise the check for remaining credits is too conservative
> +         * and may fail.
> +         * If for some reason the inode already has an encryption context, this
> +         * fails with EEXIST, which is desirable behaviour.
> +         */
>          res = ext4_xattr_set_handle(handle, inode,
>                          EXT4_XATTR_INDEX_ENCRYPTION,
>                          EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
> -                        ctx, len, 0);
> +                        ctx, len, XATTR_CREATE);
>          if (!res) {
>              ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
>              ext4_clear_inode_state(inode,
> 

Thanks!  A few comments:

This patch doesn't actually apply to the stated base-commit, likely
because of corrupted whitespace.  Make sure to use 'git send-email' as
described in Documentation/process/submitting-patches.rst.

The commit message should be broken into paragraphs, and ideally
shortened a bit.  The code comment maybe could be shortened as well.

Since this is a bug fix, please include an appropriate Fixes tag.

As for the actual change, it's *probably* fine.  The equivalent code in
f2fs already uses XATTR_CREATE.

However, I'm wondering a bit more about the possibility of inodes that
have an encryption xattr but not the encrypt flag.  ext4 sets these
together in a journal transaction, so normally it indeed isn't possible.

However, ext4 also supports a no-journal mode.  In no-journal mode,
e2fsck is relied on to correct filesystem inconsistencies.

It looks like e2fsck doesn't currently remove loose encryption xattrs.
So I'm wondering if that would need to be added.

The specific scenario I'm concerned about is:

    - FS_IOC_SET_ENCRYPTION_POLICY tries to set a directory to encrypted
    - A crash occurs (in no-journal mode), leaving the inode having an
      encryption xattr on-disk but not the encrypt flag
    - e2fsck doesn't correct the inconsistency
    - Userspace sees that the directory isn't encrypted yet and retries
      FS_IOC_SET_ENCRYPTION_POLICY.  Due to XATTR_CREATE, it fails.

Any thoughts on whether this could be a problem?

- Eric

