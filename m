Return-Path: <linux-ext4+bounces-1361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98285FABB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09971F27BA7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46E1474DA;
	Thu, 22 Feb 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dpz0jo4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v7TLU91I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dpz0jo4m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v7TLU91I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7A137C29;
	Thu, 22 Feb 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610727; cv=none; b=FmoMp+RMPOYLD9cmiZRl816ULxadJZo1nzSnO4GWW4Sjn77LVaqSgvLq7ARA033LKqaVbdC6eRgadN7/6+73ncn28ZjamDbGQAocuu/dqn7vn2XV9Y9O+emBNZOHvNc+ftq3Py32Z7wWJguhHL53rjc0dVKdAvP/nlRJ9Q+f7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610727; c=relaxed/simple;
	bh=d0+tCb/QtYVyzE5lfltiNEbxt0MX4U/rUWnBvxPJxl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o99DYwCJSi8ZXHDKqqWV+H4ghXMAi+ei+A8NrccJRL1bhAhgLu2251g9SbhYkD+kAUKq0M3oqQxFbXCq/OkQuSmI/PDRULWyRghTu4/DjMZgdtVaWla8uCKojGDYgnRzb/vRYgQglZMuisrJR1hNbbt1zQ3PtAFn6H+U8uVTxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dpz0jo4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v7TLU91I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dpz0jo4m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v7TLU91I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20AA72116C;
	Thu, 22 Feb 2024 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708610722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acdZ8LVcWSMGBTMewHHNBiVmcYPLb6CWq9Vzh/DADVw=;
	b=dpz0jo4m6arGGFDkpaaJtRpHLZiHOCB8cpKKJYP6fbrj0YJhxilLJQnwNQMCBsD5R5uWUZ
	y6DXrk3bCNvygk3da6ozEFEMxMklzcYn+Ba77jR9VbCjhRhjyJFZaoFWshmfneeF3kLjBy
	bcOw6LBuNIOJLG9WlqcNvGqGhkjcBRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708610722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acdZ8LVcWSMGBTMewHHNBiVmcYPLb6CWq9Vzh/DADVw=;
	b=v7TLU91IGUxYqVbsoh+/QlAHpNC8K3YAQLx/StHp6HU1h8cwZ5WGBY4KJWgyl1Ajjg/kbQ
	IguoC1hiHtRJcUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708610722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acdZ8LVcWSMGBTMewHHNBiVmcYPLb6CWq9Vzh/DADVw=;
	b=dpz0jo4m6arGGFDkpaaJtRpHLZiHOCB8cpKKJYP6fbrj0YJhxilLJQnwNQMCBsD5R5uWUZ
	y6DXrk3bCNvygk3da6ozEFEMxMklzcYn+Ba77jR9VbCjhRhjyJFZaoFWshmfneeF3kLjBy
	bcOw6LBuNIOJLG9WlqcNvGqGhkjcBRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708610722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acdZ8LVcWSMGBTMewHHNBiVmcYPLb6CWq9Vzh/DADVw=;
	b=v7TLU91IGUxYqVbsoh+/QlAHpNC8K3YAQLx/StHp6HU1h8cwZ5WGBY4KJWgyl1Ajjg/kbQ
	IguoC1hiHtRJcUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4CE133DC;
	Thu, 22 Feb 2024 14:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 995fKqFU12VzQwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 22 Feb 2024 14:05:21 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 225b0458;
	Thu, 22 Feb 2024 14:05:20 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>,  linux-ext4@vger.kernel.org,
  fstests@vger.kernel.org
Subject: Re: [PATCH] vfs: fix check for tmpfile support
In-Reply-To: <20240222-mango-batterie-505564cecb69@brauner> (Christian
	Brauner's message of "Thu, 22 Feb 2024 14:23:06 +0100")
References: <87jzmxisqm.fsf@suse.de>
	<20240222-mango-batterie-505564cecb69@brauner>
Date: Thu, 22 Feb 2024 14:05:20 +0000
Message-ID: <87cysoh9wf.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dpz0jo4m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v7TLU91I
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 20AA72116C
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> When ext4 is used with quota support the test fails with EINVAL because
> it is run after we idmapped the mount. If the caller's fs{g,u}ids aren't
> mapped then we fail and log a misleading error. Move the checks for
> tmpfile support right at the beginning of the test in all tests.
>
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Link: https://lore.kernel.org/r/20240222-knast-reifen-953312ce17a9@brauner
> Signed-off-by: Christian Brauner <brauner@kernel.org>

FWIW I've just tested this patch and I can confirm it fixes the failures I
was seeing in ext4.  Again, thanks a lot, Christian.

Cheers,
--=20
Lu=C3=ADs


> ---
>  src/vfs/idmapped-mounts.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 547182fe..e490f3d7 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -3815,6 +3815,8 @@ int tcore_setgid_create_idmapped(const struct vfste=
st_info *info)
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -3838,8 +3840,6 @@ int tcore_setgid_create_idmapped(const struct vfste=
st_info *info)
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	pid =3D fork();
>  	if (pid < 0) {
>  		log_stderr("failure: fork");
> @@ -3991,6 +3991,8 @@ int tcore_setgid_create_idmapped_in_userns(const st=
ruct vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -4014,8 +4016,6 @@ int tcore_setgid_create_idmapped_in_userns(const st=
ruct vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	pid =3D fork();
>  	if (pid < 0) {
>  		log_stderr("failure: fork");
> @@ -7715,6 +7715,8 @@ static int setgid_create_umask_idmapped(const struc=
t vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -7738,8 +7740,6 @@ static int setgid_create_umask_idmapped(const struc=
t vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	pid =3D fork();
>  	if (pid < 0) {
>  		log_stderr("failure: fork");
> @@ -7929,6 +7929,8 @@ static int setgid_create_umask_idmapped_in_userns(c=
onst struct vfstest_info *inf
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -7952,8 +7954,6 @@ static int setgid_create_umask_idmapped_in_userns(c=
onst struct vfstest_info *inf
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	/*
>  	 * Below we verify that setgid inheritance for a newly created file or
>  	 * directory works correctly. As part of this we need to verify that
> @@ -8163,6 +8163,8 @@ static int setgid_create_acl_idmapped(const struct =
vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -8186,8 +8188,6 @@ static int setgid_create_acl_idmapped(const struct =
vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	pid =3D fork();
>  	if (pid < 0) {
>  		log_stderr("failure: fork");
> @@ -8518,6 +8518,8 @@ static int setgid_create_acl_idmapped_in_userns(con=
st struct vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
> +
>  	/* Changing mount properties on a detached mount. */
>  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>  	if (attr.userns_fd < 0) {
> @@ -8541,8 +8543,6 @@ static int setgid_create_acl_idmapped_in_userns(con=
st struct vfstest_info *info)
>  		goto out;
>  	}
>=20=20
> -	supported =3D openat_tmpfile_supported(open_tree_fd);
> -
>  	/*
>  	 * Below we verify that setgid inheritance for a newly created file or
>  	 * directory works correctly. As part of this we need to verify that
> --=20
>
> 2.43.0
>


