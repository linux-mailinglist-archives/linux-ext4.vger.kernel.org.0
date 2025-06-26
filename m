Return-Path: <linux-ext4+bounces-8665-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2067AEA85D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DFB1C4118C
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373982F0E2D;
	Thu, 26 Jun 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQng1dpH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6215A864;
	Thu, 26 Jun 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970683; cv=none; b=hXeBRHDFVukHLBSTsOj08UjkDsxbOkHRqGZ6UCVufe7bhtWeUDdNj6foDhIWjJ/gyddhxpoVEYWnblo280XGvFXUtDf/vM30u4io2iCH5ddbdYFOa6zqP2ynbbClakRVKmM1de88XJOctVGFUWjM/qYOhRi36O3UFOwtkFboggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970683; c=relaxed/simple;
	bh=BOK1EgHZTfgO+s9A5/doaQKendrseDy6yIGpQeQzfpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgP5JCjnvkla09VxXe+qyMQYj3BsCS+wA8DSUUPsd9LxVl5RTx43dq5FaWGnxJN/LagmGbe5NHgDnch9QF/dtN66aYGCV9Yzix5H2YQOP0NErjY5v2MpdBtxVKsSaq8rsIgzZNP18qA4ni8YfDLxbSq+linso5iCFazBxWSNcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQng1dpH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e40e3f316so12879467b3.0;
        Thu, 26 Jun 2025 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750970680; x=1751575480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9Xx96Xvno5SkyEaeDl0xg/mEkU0w2mxnLInutx2LDw=;
        b=IQng1dpH3+bHUlsfqKdZZEcmz4mZ699VriUbXXHRbniGkqHulRYTHNPxrMGPrl8Sxp
         OrGpvd58cvV2kDbLxkj6mhq1JTovx/QVj2cXw1/aL0zGHgClE8q+lOZP5qAGVbmeWS2X
         MC0aht0qrN6/bp7josHhbpNU37HQu+HxgpCcaCjHvLsvG1Fb7ST47Y8mWbKpJNnT/XZa
         1OvDwhVPVXVRABuX47AQqFErqNocgBd/S/8y8R/nxYeklrzqxynxhLI0gcE3fmSFX1W1
         2ZG1/1o1Z3NTvCmj2njn2SCib0vCq9H1Jg4pUl+3gGnWZ5v2UHwxQryOBCEbwb756r5d
         2y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750970680; x=1751575480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9Xx96Xvno5SkyEaeDl0xg/mEkU0w2mxnLInutx2LDw=;
        b=TrPbxlolR2HoIfMN7z2p+VI8K7Q+IyF7Ixmgw7dKLHvIxUg72NqyZkMg3di8/ePB0L
         i8Qw1yAQHH1xJX3e7TmZ4/aD+BH9qM753xTv7lcDMBfeUGRWLk3IZs1xzWgA62B44yP8
         H0gd46pF/cwkk2ExBzGFznu2RaErXhy29cuICUzUnYPeV9t+C0mVUQO/eEk7bwkqtgPd
         66wBx7YbvICI8wymy6MXIE/EAXPhGgF68TzTTSdi+yYfnpKnEIFPJRgY19qCRGvPEBce
         QiCsrdBztuJzjl58Ns/5Jrth+BRlQSh+IZozPsSjeM+1fyPws7+14dDgMCKkTkU99jJ/
         lEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT9O4Q/PQ4EpRt0TgOHJ296XyQm2xMpuy9HtDHzM0F+VLAzU7hkQllngh6glZPxuGELUO5xfmlrIBf@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIOxwxlSaKqGxIZjvf5glrI524evXltuNp4dUeXNn35dt0pWJ
	qAFwua0t2N+hmOeiyFBqgWllNYS+cXKefI4kdx18DvdLS4x7Z/oZbQow5LfXQAEzSAceo8qZl33
	ru6HdBBqLlCDmz75uJfvWQA1ASEYbHkuMNg==
X-Gm-Gg: ASbGncu+LBXGLRhaHoTzJDPC5zCM78JfF5HwhrLvdpdMrrG5yG3eCPnxPBVfUULUtDC
	pQfNhFCJXrrQktyTDRyOrY3RY1tisR3hQtjib1VDg1F5CjfnN6D39NgTgeTeeh/8RMTDii5OTpC
	hF8rcyavDIQkrTWsG7aNMxriY7WHUrT3y2RRLsYnUEVSsuo6vCFn6nUheozv1lI9MeXKJP4Ob0H
	sjRNtmexsqu7KcF
X-Google-Smtp-Source: AGHT+IGPx9CN7s77XSukKKUuUFcv4/+ZLPCW3GNyrWUxob+yGzcT864dV/CZGPixsc7lRpvzlOC7As0Z4fO6fiHA2oA=
X-Received: by 2002:a05:690c:6608:b0:70c:b882:2e9 with SMTP id
 00721157ae682-7151713d518mr12695187b3.3.1750970680146; Thu, 26 Jun 2025
 13:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625212022.35111-1-leah.rumancik@gmail.com> <20250626195304.7ug4jersezhiw5j2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250626195304.7ug4jersezhiw5j2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 26 Jun 2025 13:44:27 -0700
X-Gm-Features: Ac12FXyIS0DoCs1jr1p_Jh0hf-hYY7d4mAEuRHDo05FQF3iofHOCSOI8uDQwjTA
Message-ID: <CACzhbgQSnhsObAqZR-NyS=65UjUF=r-7J_n4MMjNgjt0AK-pUg@mail.gmail.com>
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds great, thanks Zorro!

- leah

On Thu, Jun 26, 2025 at 12:53=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrot=
e:
>
> On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> > There is a descrepancy between the fsck flags for ext4 during
> > filesystem repair and filesystem checking which causes occasional test
> > failures. In particular, _check_generic_filesystems uses -f for force
> > checking, but _repair_scratch_fs does not. In some tests, such as
> > generic/441, we sometimes exit fsck repair early with the filesystem
> > being deemed "clean" but then _check_generic_filesystems finds issues
> > during the forced full check. Bringing these flags in sync fixes the
> > flakes.
> >
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >
> > v2: update to fix for ext2/3 as well
> >
> >  common/rc | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index daf62c92..ddced1b7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1496,19 +1496,24 @@ _repair_scratch_fs()
> >       _check_scratch_fs
> >       ;;
> >      *)
> >       local dev=3D$SCRATCH_DEV
> >       local fstyp=3D$FSTYP
> > +     local fsopts=3D
> >       if [ $FSTYP =3D "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
> >               _repair_overlay_scratch_fs
> >               # Fall through to repair base fs
> >               dev=3D$OVL_BASE_SCRATCH_DEV
> >               fstyp=3D$OVL_BASE_FSTYP
> >               _unmount $OVL_BASE_SCRATCH_MNT
> >       fi
> > +     if [ $FSTYP =3D "ext4" ] || [ $FSTYP =3D "ext3" ] || [ $FSTYP =3D=
 "ext2" ]; then
>
> I think you can use [[ "$FSTYP" =3D=3D ext[234] ]] directly.
>
> > +             fsopts=3D"-f"
> > +     fi
> > +
> >       # Let's hope fsck -y suffices...
> > -     fsck -t $fstyp -y $dev 2>&1
> > +     fsck -t $fstyp -y ${fsopts} $dev 2>&1
> >       local res=3D$?
> >       case $res in
> >       $FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
> >               res=3D0
> >               ;;
> > @@ -1548,12 +1553,16 @@ _repair_test_fs()
> >       yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
> >                                                               $tmp.repa=
ir 2>&1
> >               res=3D$?
> >               ;;
> >       *)
> > +             local fsopts=3D
> > +             if [ $FSTYP =3D "ext4" ] || [ $FSTYP =3D "ext3" ] || [ $F=
STYP =3D "ext2" ]; then
>
> Same here
>
> Others look good to me. If you agree, I can help to do this change
> when I merge it :)
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> > +                     fsopts=3D"-f"
> > +             fi
> >               # Let's hope fsck -y suffices...
> > -             fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> > +             fsck -t $FSTYP -y ${fsopts} $TEST_DEV >$tmp.repair 2>&1
> >               res=3D$?
> >               if test "$res" -lt 4 ; then
> >                       res=3D0
> >               fi
> >               ;;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
> >
>

