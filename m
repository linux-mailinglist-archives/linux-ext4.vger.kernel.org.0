Return-Path: <linux-ext4+bounces-11520-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D088C39B1F
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0359F4F5CE1
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13ED309DAF;
	Thu,  6 Nov 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz6Qetui"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7123093C8
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419523; cv=none; b=SbkAtGLejLiS4KThtXD1cxiWC9jGkVbH6Vz6JwUi7dZn7acgDnuA9d1omt6WTa2/4A/EqCUBWtLYP5mtP7zrDH1kcf70GpkiljdQB3fTfdJ/kCj3BqKBtZSXInjY+Jk3Nb5YoxqrbdnPdB16gScLMGTWXC6cESt6ERD/fCn1Lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419523; c=relaxed/simple;
	bh=jZcI5+1Ss6TPvgkAAV76GUd62OE9+TiURdgHBGyzwoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srXERISAJE7ZvFTFWCqI+9V+4QCr/vzCKdWK+dCt2oh9v7+oCi1Rv+4SZYQJqwv8r4bkbNwsgMvTsGXWqhQDxpXqXbUtiLsVfcid3efVLd8qjadkYbIxP1Dk3npae+/tAkK+j+qmZSAAdic2G5YwJcNC4bjtdDd7JxNczpHDFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz6Qetui; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso1059997a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 00:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419520; x=1763024320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck0m8wFZB9XcmaKq8dytQ0ONqq6wW9ZN3Xn7nrKuDWc=;
        b=Sz6QetuiUOHkA3tM+NddvSdrLzzIvP6a/nXsDbGgIdL56l1FE2G16HlcbU8kQ7PFLA
         HfMSQVIEcrsCnz/+YSltV/EHvolDeDWRC10b/XRskjSzE61iY6qDxDSSaBFc2IM4HCyq
         YnmVFnSY+7gslOmfhj7DAIydVezdn+1/AqgPUDUrjqDyHJqOuB4Zc/vhXcCO9pUcayiQ
         Xx+/j33PiEOVlTNfTjhn+ocM5j9Z8HXjN5Pv6J2Ow4N3FaBHZdPesil5a2LODYrj6hhj
         +pCMCg6QEm58dQEGpBnmYanvL3/HQeywq8Fgjy8nkYZpUSkFNWb1eXTH7xcj12VU1Cbm
         iY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419520; x=1763024320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck0m8wFZB9XcmaKq8dytQ0ONqq6wW9ZN3Xn7nrKuDWc=;
        b=s4e29M6TMVMfSTH1KoMGM/+G1T+HmpD+EXtbgT9L8T6HoWd8Cz/XDnRD8MHtff7SkA
         UbvS3zrJANkDvjuI8PsLEAvfnnSJWpjLXMrUYnec+DOGt7jvkj1hT7uZ0OMNZ9fO0S+7
         NQ1KIfJIujgMgwXoaOuBsz/NbGoa2JBM+1mUGXXDvrcY6LBQ/3RVEzd8L7x0VbNuDoOt
         eRxMV9xze6X0l+bHpVe7yZTMUmnM7mGtGFiPmxEk/5SMHFgAczBlV4V3jeg45qVw4yU9
         sCK+5QMClS+NBHOZpEoUSaqWW9/IpIa5CCnZAIzew90hIL2lGKRyyvBc/HZRqQzvRthF
         iD8g==
X-Forwarded-Encrypted: i=1; AJvYcCVj/47YCTOZjXI0PBC8I4GTs00/C4H2VvzulwoObCI7Zz+p+kcWQnDiJ99WwPLg2vw0Ggy2Du3LmjLv@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHJnV4i1B8SzyP8AC68KgbxmPgh76oeELmXYMGZXyU63yXy4m
	cVUbgl5ogOTagd1u5TPkPwU4pQXhsYowDS6lnAZFYW2tHE9xEWjPhVCMjfmD0mIFqJ3nzNQijKx
	Fokhve4PFA16ROgopFm3HE3TikcNaxGU=
X-Gm-Gg: ASbGnctAacwLdXvZHWzpES0UKRyMoho10J+U+6t84Lk9GnKHcPKc6Qs0G88xlYVGKfV
	3oBdro24V7XCuxp6L7F8cBBeGOsOfHW5l7xHJn9hNXYG7iap9gLQRWWhs0fzJe+DniSP4D07kZg
	vnAR9yhpn1NJ7jN0QedwV33OZy0/DoWp5EzF2gOtMDYmWtCBVZILCKPJ8pMJETPH8lHhVIOtiVj
	LtPZSEeKRhGZmRyttbO4tuyt0u5Hb7gUOMpZs6NDbjHXH05X7NcoZPQFgrj70h7Acu4qJQ0mzlm
	OjD6ffSqjXEpliCZKRU=
X-Google-Smtp-Source: AGHT+IEHawD1xB6GQmLFykw+yW+B52duLhBw9u10AbP5tS5Ky2pbjNedqdkSkvdgV804kceaE8LvNF0HWEEdMMxXtws=
X-Received: by 2002:a05:6402:4301:b0:634:ab36:3c74 with SMTP id
 4fb4d7f45d1cf-641058bbcafmr5577723a12.9.1762419519709; Thu, 06 Nov 2025
 00:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com> <20251105225355.GC196358@frogsfrogsfrogs>
In-Reply-To: <20251105225355.GC196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 09:58:28 +0100
X-Gm-Features: AWmQ_bl5E-AoHE-1AuDyZsQmdfkMyiI2gUbeKfvAWpOXmZ3IVywzlGkMPg_nxeA
Message-ID: <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:53=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > It would be useful to be able to run fstests against the userspace
> > > ext[234] driver program fuse2fs.  A convention (at least on Debian)
> > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > disk-based filesystem type XXX.
> > >
> > > Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 to
> > > test ext4 with fuse2fs.  Change all the library code as needed to han=
dle
> > > this new type alongside all the existing ext[234] checks, which seems=
 a
> > > little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also woul=
d
> > > require even more treewide cleanups to work properly because most
> > > fstests code switches on $FSTYP alone.
> > >
> >
> > I agree that FSTYP=3Dfuse.ext4 is cleaner than
> > FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
> > but it is not extendable to future (e.g. fuse.xfs)
> > and it is still a bit ugly.
> >
> > Consider:
> > FSTYP=3Dfuse.ext4
> > MKFSTYP=3Dext4
> >
> > I think this is the correct abstraction -
> > fuse2fs/ext4 are formatted that same and mounted differently
> >
> > See how some of your patch looks nicer and naturally extends to
> > the imaginary fuse.xfs...
>
> Maybe I'd rather do it the other way around for fuse4fs:
>
> FSTYP=3Dext4
> MOUNT_FSTYP=3Dfuse.ext4
>

Sounds good. Will need to see the final patch.

> (obviously, MOUNT_FSTYP=3D$FSTYP if the test runner hasn't overridden it)
>
> Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> /proc/mounts.  The only weirdness with that is that some of the helpers
> will end up with code like:
>
>         case $FSTYP in
>         ext4)
>                 # do ext4 stuff
>                 ;;
>         esac
>
>         case $MOUNT_FSTYP in
>         fuse.ext4)
>                 # do fuse4fs stuff that overrides ext4
>                 ;;
>         esac
>
> which would be a little weird.
>

Sounds weird, but there is always going to be weirdness
somewhere - need to pick the least weird result or most
easy to understand code IMO.

> _scratch_mount would end up with:
>
>         $MOUNT_PROG -t $MOUNT_FSTYP ...
>
> and detecting it would be
>
>         grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
>
> Hrm?

Those look obviously nice.

Maybe the answer is to have all MOUNT_FSTYP, MKFS_FSTYP
and FSTYP and use whichever best fits in the context.

Thanks,
Amir.

