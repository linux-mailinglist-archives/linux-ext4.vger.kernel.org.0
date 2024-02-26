Return-Path: <linux-ext4+bounces-1388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E41866EB1
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 10:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE992876F5
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45E67E9D;
	Mon, 26 Feb 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tsRSY52w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UfvIIU9B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bpq0HGn0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fZfHNK0t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C067E96;
	Mon, 26 Feb 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937817; cv=none; b=htB03rY5RfL7UuBJi8Ts0jS6J/3sZ4VK8pvnuJHyl7TTuj9B2BdTujEc8ap8XPr++9jcWBhDoHamtyZNMRDTGbuOTv0ZkxCM1xFx/E3c4tvsIQ6KAcCveqovFh8Eb19HpMjoPjsslx/ToSunMCy50RKVfg0gnYozXZJJDC4zIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937817; c=relaxed/simple;
	bh=j3jQOjfyPOtE2YQnPs/VXE4MDlrAN2V5BFxBNgD4QDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7soaLO/Scl4hVcUo2WJx3YUYDa7QHkpXKcwkqCEpaPPXh1q6BxcFd8asXCuJZq+uyNGmaRZrbpezYoq5BORFRpFnUvyXCPMP3gwCMrMcZXkqSwIxb0q6zZyFe6VE33RLqWDKA8ILrohkMMww5PPZK4bgsneXtiqgQzckJd10b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tsRSY52w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UfvIIU9B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bpq0HGn0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fZfHNK0t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B3DC1FB3C;
	Mon, 26 Feb 2024 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708937814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl0c+mVdc0GJb9vzvhqq6VQauGkma+sAeF02W8Azrz8=;
	b=tsRSY52whCF9KgqCVTMMZXRK+tecV0QuqSBOn7MXSkpSJZbzTZa6SZ1uhH/U7GoAYflUNj
	FP6JMNT7p6tTBGX+eC9nIYZIaQFk7BB1bULD7mLwkxVwgrXc8IJvKGGjnaH/GC8vEDGayy
	H5j+rkyiiZoHx4PKsc/YB9gNnfkisDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708937814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl0c+mVdc0GJb9vzvhqq6VQauGkma+sAeF02W8Azrz8=;
	b=UfvIIU9BnGEGSMEGG48f06VhHSgNhiMyvn3qio4qRwzM4NgfdKsOuVtP/Vni1+Z1Ag1l3t
	NVxozXEsB0yO5wBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708937813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl0c+mVdc0GJb9vzvhqq6VQauGkma+sAeF02W8Azrz8=;
	b=Bpq0HGn0q0mMWs1xH9UfxohpqrKhS04uc5vxX4USXBzkEDsQNajzJE6f8VUYmDDofFIyXK
	rMEYmu3FE86mQzsU5YtNsrzcFoi3HfsRxLgypQ0oFbiBbgBP8JybXl2jjoJSDmJbT8SBt7
	CMsLDvPXHpzN2UkVYXYRG0+vCAl8ONI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708937813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl0c+mVdc0GJb9vzvhqq6VQauGkma+sAeF02W8Azrz8=;
	b=fZfHNK0txnS69ris+tZ1m7evxsL2P7OejMNIeGHHurL9C4+z2e2BsduE0SJ6vB6hrBx7mf
	xjSTfR/fMGmtBoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DA5C13A58;
	Mon, 26 Feb 2024 08:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DaEvO1RS3GWNGAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 26 Feb 2024 08:56:52 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id b3419c9c;
	Mon, 26 Feb 2024 08:56:50 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,  linux-ext4@vger.kernel.org,
  fstests@vger.kernel.org
Subject: Re: [PATCH] vfs: fix check for tmpfile support
In-Reply-To: <20240225155656.yjqyuyjxsbtiqvb2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	(Zorro Lang's message of "Sun, 25 Feb 2024 23:56:56 +0800")
References: <87jzmxisqm.fsf@suse.de>
	<20240222-mango-batterie-505564cecb69@brauner>
	<87cysoh9wf.fsf@suse.de>
	<20240225155656.yjqyuyjxsbtiqvb2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Mon, 26 Feb 2024 08:56:50 +0000
Message-ID: <87frxfhact.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

Zorro Lang <zlang@redhat.com> writes:

> On Thu, Feb 22, 2024 at 02:05:20PM +0000, Luis Henriques wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>>=20
>> > When ext4 is used with quota support the test fails with EINVAL because
>> > it is run after we idmapped the mount. If the caller's fs{g,u}ids aren=
't
>> > mapped then we fail and log a misleading error. Move the checks for
>> > tmpfile support right at the beginning of the test in all tests.
>> >
>> > Reported-by: Luis Henriques <lhenriques@suse.de>
>> > Link: https://lore.kernel.org/r/20240222-knast-reifen-953312ce17a9@bra=
uner
>> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>>=20
>> FWIW I've just tested this patch and I can confirm it fixes the failures=
 I
>> was seeing in ext4.  Again, thanks a lot, Christian.
>
> Thanks for your confirm, I think we can have your "Tested-by" if you don't
> mind.

Ah, yes of course.  I should have sent it explicitly.

Tested-by: Luis Henriques <lhenriques@suse.de>

Cheers,
--=20
Lu=C3=ADs


>>=20
>> > ---
>> >  src/vfs/idmapped-mounts.c | 24 ++++++++++++------------
>> >  1 file changed, 12 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
>> > index 547182fe..e490f3d7 100644
>> > --- a/src/vfs/idmapped-mounts.c
>> > +++ b/src/vfs/idmapped-mounts.c
>> > @@ -3815,6 +3815,8 @@ int tcore_setgid_create_idmapped(const struct vf=
stest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -3838,8 +3840,6 @@ int tcore_setgid_create_idmapped(const struct vf=
stest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	pid =3D fork();
>> >  	if (pid < 0) {
>> >  		log_stderr("failure: fork");
>> > @@ -3991,6 +3991,8 @@ int tcore_setgid_create_idmapped_in_userns(const=
 struct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -4014,8 +4016,6 @@ int tcore_setgid_create_idmapped_in_userns(const=
 struct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	pid =3D fork();
>> >  	if (pid < 0) {
>> >  		log_stderr("failure: fork");
>> > @@ -7715,6 +7715,8 @@ static int setgid_create_umask_idmapped(const st=
ruct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -7738,8 +7740,6 @@ static int setgid_create_umask_idmapped(const st=
ruct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	pid =3D fork();
>> >  	if (pid < 0) {
>> >  		log_stderr("failure: fork");
>> > @@ -7929,6 +7929,8 @@ static int setgid_create_umask_idmapped_in_usern=
s(const struct vfstest_info *inf
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -7952,8 +7954,6 @@ static int setgid_create_umask_idmapped_in_usern=
s(const struct vfstest_info *inf
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	/*
>> >  	 * Below we verify that setgid inheritance for a newly created file =
or
>> >  	 * directory works correctly. As part of this we need to verify that
>> > @@ -8163,6 +8163,8 @@ static int setgid_create_acl_idmapped(const stru=
ct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -8186,8 +8188,6 @@ static int setgid_create_acl_idmapped(const stru=
ct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	pid =3D fork();
>> >  	if (pid < 0) {
>> >  		log_stderr("failure: fork");
>> > @@ -8518,6 +8518,8 @@ static int setgid_create_acl_idmapped_in_userns(=
const struct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > +	supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>> > +
>> >  	/* Changing mount properties on a detached mount. */
>> >  	attr.userns_fd	=3D get_userns_fd(0, 10000, 10000);
>> >  	if (attr.userns_fd < 0) {
>> > @@ -8541,8 +8543,6 @@ static int setgid_create_acl_idmapped_in_userns(=
const struct vfstest_info *info)
>> >  		goto out;
>> >  	}
>> >=20=20
>> > -	supported =3D openat_tmpfile_supported(open_tree_fd);
>> > -
>> >  	/*
>> >  	 * Below we verify that setgid inheritance for a newly created file =
or
>> >  	 * directory works correctly. As part of this we need to verify that
>> > --=20
>> >
>> > 2.43.0
>> >
>>=20
>>=20
>


