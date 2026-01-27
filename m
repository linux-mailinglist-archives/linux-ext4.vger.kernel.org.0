Return-Path: <linux-ext4+bounces-13341-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AGvH2IWeGkynwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13341-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 02:35:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8758EC21
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 02:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705B33012EBF
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634C27EFE9;
	Tue, 27 Jan 2026 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEttfZTo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9E78F26
	for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477719; cv=pass; b=a2LTzV6fhFSdI53MCLxhhg1zYjrwFqA1slIOVQsYsAj/JyX2ygeZtk37ke62Rr03rk7ZkUDiJhB3hHlQSYLFmjq+kUEs1ujZDvQdbGYUf54O6lz8rvt7hUBi3uyDEUyvrtuJ4eHcL0KAPDKoQQnXf2WQwOe3KsNyCjHq10FNvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477719; c=relaxed/simple;
	bh=lYTz8sE+A7fpDIX1d0aoOfwqtJSMZ9rVM0rXwjgyjPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqG4LqvbwxHAGvBJvEPXAUPYhGQGn2bfN2yycYSRx/AMtUqy2Eyk0Bz26hFLXMTCwugLbawOxo43IVh/clw4I4dWiBENU4VOvbz3qPlEbXhDSmGZXqqMnv3Etxho7/OnmEHZnoo7gM4/2OIwd/upVNa3tRYZ9Als4ceY3W6643w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEttfZTo; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-894723da7dfso82331576d6.1
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jan 2026 17:35:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769477716; cv=none;
        d=google.com; s=arc-20240605;
        b=TghnBW79qyb+uANh6ge3NZZwOaG7J8SglY2iqAgZGcMqHj/jAkb2V70i14rjuutsaj
         xOk/bF27ytlJjM9NpupIPOGZJl6pxkwNKm6s9HM8vOv+kUWc04boBbhGsK47ci25wXvZ
         f5k9emJiWZKAKpnaxl56NHST1H/fEEWvfHkRNyf+6u1rmjYyLZu5f/qF+alozwlX3NT/
         nIckZgvRiey+Bg5QTQbnyOzUB83hmZkR8UUxuCcuj8ABHMSOBUc1MhvGRhzZHpogTj7Z
         h89nt3MBNt+AhvwYYBFcgqBzshE2CQwEiMneBHBESan7qneAR5DlFxXbtX9kJ4N4Q+oH
         zNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1Nw72L+uTn635vSp0U783KSap5flZZhbylmi41Hi0k=;
        fh=cP2s2cYOnbhnDGHkG1YroUXzS1qNebzGggi3CNPXs5I=;
        b=VnC+VGjoPNM91FevjApDCxqp5fQcw7AYAGRCYVC4DiIB793DNQTIT5JvE6TfdumkXt
         lV9nn0tMFJ35dIpBlV3f4dk15NuXSjU8kGoeet9Dt6JR0JbkvvsqbDfdvSUDhcdURu+8
         iOfhaxujRhcOWRxegWYT6GRsxr82zKkeshzh3DRJw/3SveKTAQo09rhtOyn3dKpZk0V1
         NS5ABKNqomxadnVEqZGLEQmta6tHDhO0L3ivV8KNIpXky5Nz8d9sd7ge8o8P5mv67R1W
         XQvQIw6MjRRzSG4Tx9VvQqwDUXen/5AURt9cROFKqkyva+OdMtNX5yjmm7y7GGTAOsht
         l7XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769477716; x=1770082516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Nw72L+uTn635vSp0U783KSap5flZZhbylmi41Hi0k=;
        b=gEttfZToVq1aTlWYYiHK9/sic10HIQiS3ROe6er8JW3PPHO473MKG/ro/WY0Y217x7
         GYJo+Dp/DaWCqtTGmMA7gZ5hNnLjmmEnwTCCzQfx66Orhg12orj52Tqzmy8Xa9oI5gFl
         Ss0/VWSESUjSFJ/po28V37i/GmNxmbnj2T7PU+S8mfnAsQhFDp0YxF6+qe5CM7bDN2Wa
         fD7ZDYMYMrzgP1kndFrQnZdeEXMiih8lRCZjdWQixjz91xCVzIqG5B4+At7WUv8ygwSS
         SL/WleSRaTmP7xH8XXy+TjWQD8lGBCAo01fYfGQF5dkPsJGqd24gpmLMOk812DNtl2Rf
         lLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769477716; x=1770082516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1Nw72L+uTn635vSp0U783KSap5flZZhbylmi41Hi0k=;
        b=iYWy0IKJYCn1AM4+EVLy3TZjCJPaRh2srx21sDashXVGCiDoUPR2Savjgbe2bE38i2
         ZwCrACNhLQhLkvAA6MX1+sJRTZlIKSgfbNLgH9v+1x5018bQngVCPtsyNgm4d5pLJAEp
         eEfCvh3XZM6vdib+8ehSUutfDAvrl36UWCxPlh6oq7yHR6tEYtJpXETnTbSw1wyEczCy
         wZ+8nokm6jxQgqh0ftOpySwRpKtBp3ND/4z9Xuf8W5uezbM85SQdo8WnNRTjnjsxZ7vZ
         zxgy7I5+PrBKp2OtRep/18/galwlt1b+Jtujm2L+YshNcR+onZvK0c5NxTDIdVV60jfp
         PjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWk+jAlIhpC6SlhIZTehutBoWZDXDezrUTSsxboJtllqUrP+EQ+kHbVU0IDj1H4tTJ5dOG8i0Pi0LQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kQwC0/zy5cB0vfMikLzLIRkIdaYg1mQjKqde7aSnybPozqo2
	vM4zeMbTP89FTUBCZ3o8PToD/31t3fJIsyupsURZ7Jn7q1dMJnTnQrQJDvTbROA2ld3GUOZHa4g
	PO6bvnpj5id2ImlvvjfUDaVqvXrHy4D48ENz5OOg=
X-Gm-Gg: AZuq6aK/JIoFCuyyeeChC7WB+K/wbbwTZhdBMyg5u34cN9xBNylvM368CqpJBDJ9Xqt
	5sXReA4zTKfcR4xjIh0+RBfhOzXhyiUISKLjWiiuIDvOJwnq0l6ft+UpVGfIB1UL5pe2FjASkkO
	wLlf4c6z9a10I/fkZw9xkWXg4tysHqAgAGuLG7EbYM5c8AeSgkxbKoTt+lEVUQrPVBrDLy5IBOO
	Dlz/EeFXgJvwqKC1SM2uZQBgjgj5JyM85pimHlluh/0y5EqKBQkalA1avqe9D3WlnzbQkLkdviu
	2HTe1GYBhM0=
X-Received: by 2002:a05:6214:23cb:b0:889:b6f1:1f30 with SMTP id
 6a1803df08f44-894cc834d99mr2229366d6.18.1769477716508; Mon, 26 Jan 2026
 17:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com> <20260126235531.GE5900@frogsfrogsfrogs>
In-Reply-To: <20260126235531.GE5900@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 17:35:05 -0800
X-Gm-Features: AZwV_QiFFKxg084Vx1Un9-5jwXPN5pzclSWsf4sjIUG5gB32kvr773wJvTrLRGM
Message-ID: <CAJnrk1ZYF7MG0mBZ4GRdKfmSiEEx3vXxgiH3oYdMS-neWSA2mw@mail.gmail.com>
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with iomap
 pagecache io
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13341-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E8758EC21
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 3:55=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jan 26, 2026 at 02:03:35PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > With iomap support turned on for the pagecache, the kernel issues
> > > writeback to directly to block devices and we no longer have to push =
all
> > > those pages through the fuse device to userspace.  Therefore, we don'=
t
> > > need the tight dirty limits (~1M) that are used for regular fuse.  Th=
is
> > > dramatically increases the performance of fuse's pagecache IO.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > >
> > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > index 0bae356045638b..a9bacaa0991afa 100644
> > > --- a/fs/fuse/file_iomap.c
> > > +++ b/fs/fuse/file_iomap.c
> > > @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing=
_ops =3D {
> > >  void fuse_iomap_mount(struct fuse_mount *fm)
> > >  {
> > >         struct fuse_conn *fc =3D fm->fc;
> > > +       struct super_block *sb =3D fm->sb;
> > > +       struct backing_dev_info *old_bdi =3D sb->s_bdi;
> > > +       char *suffix =3D sb->s_bdev ? "-fuseblk" : "-fuse";
> > > +       int res;
> > > +
> > > +       /*
> > > +        * sb->s_bdi points to the initial private bdi.  However, we =
want to
> > > +        * redirect it to a new private bdi with default dirty and re=
adahead
> > > +        * settings because iomap writeback won't be pushing a ton of=
 dirty
> > > +        * data through the fuse device.  If this fails we fall back =
to the
> > > +        * initial fuse bdi.
> > > +        */
> > > +       sb->s_bdi =3D &noop_backing_dev_info;
> > > +       res =3D super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->d=
ev),
> > > +                                  MINOR(fc->dev), suffix);
> > > +       if (res) {
> > > +               sb->s_bdi =3D old_bdi;
> > > +       } else {
> > > +               bdi_unregister(old_bdi);
> > > +               bdi_put(old_bdi);
> > > +       }
> >
> > Maybe I'm missing something here, but isn't sb->s_bdi already set to
> > noop_backing_dev_info when fuse_iomap_mount() is called?
> > fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() does
> > this already before the fuse_iomap_mount() call, afaict.
>
> Right.
>
> > I think what we need to do is just unset BDI_CAP_STRICTLIMIT and
> > adjust the bdi max ratio?
>
> That's sufficient to undo the effects of fuse_bdi_init, yes.  However
> the BDI gets created with the name "$major:$minor{-fuseblk}" and there
> are "management" scripts that try to tweak fuse BDIs for better
> performance.
>
> I don't want some dumb script to mismanage a fuse-iomap filesystem
> because it can't tell the difference, so I create a new bdi with the
> name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
> gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
> here due to ENOMEM so ... I implemented this weird switcheroo code.

I see. It might be useful to copy/paste this into the commit message
just for added context. I don't see a better way of doing it than what
you have in this patch then since we rely on the init reply to know
whether iomap should be used or not...

If the new bdi setup fails, I wonder if the mount should just fail
entirely then. That seems better to me than letting it succeed with
strictlimiting enforced, especially since large folios will be enabled
for fuse iomap. [1] has some numbers for the performance degradations
I saw for writes with strictlimiting on and large folios enabled.

Speaking of strictlimiting though, from a policy standpoint if we
think strictlimiting is needed in general in fuse (there's a thread
from last year [1] about removing strict limiting), then I think that
would need to apply to iomap as well, at least for unprivileged
servers.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFw=
mJG65ANj1Zv0O0s4_A@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20251010150113.GC6174@frogsfrogsf=
rogs/T/#ma34ff5ae338a83f8b2e946d7e5332ea835fa0ff6

>
> > This is more of a nit, but I think it'd also be nice if we
> > swapped the ordering of this patch with the previous one enabling
> > large folios, so that large folios gets enabled only when all the bdi
> > stuff for it is ready.
>
> Will do, thanks for reading these patches!
>
> Also note that I've changed this part of the patchset quite a lot since
> this posting; iomap configuration is now a completely separate fuse
> command that gets triggered after the FUSE_INIT reply is received.

Great, I'll look at your upstream tree then for this part.

Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > >         /*
> > >          * Enable syncfs for iomap fuse servers so that we can send a=
 final
> > >
> >

