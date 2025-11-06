Return-Path: <linux-ext4+bounces-11521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8CDC39BAC
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 10:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D988E1A23EB9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70607309EED;
	Thu,  6 Nov 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTuwoHs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DE272E4E
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419792; cv=none; b=n8umNcxJNsgt4UjCzHvyHyroUiOdKKbDP2HkefYB49enB48/dteWIHAv8ic92mk7/Dww/NLWTSHxQvlIEED7kBLW/Cdvfedj2jisVBHpt1mrn0Zo+PeZDBn2y3+YGf4PX9nFi2C2/pz3BF03MTbm//T0WQXsB7iBpopZOMuZVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419792; c=relaxed/simple;
	bh=0EKAehxKkI/bTw9WUORbVkGz8/nS+B2Kso4BX+bmOcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXjcVDWebTFlaj6PXGv+gykzWNGw2PDDwxbtRnJt1ANAdf+YnfHUhGeuKDHJkBc/bhGZru+8U4H6cnC4cwqonhXjtdL3wnI683nEjB1ZkDH+a+BB06ajm6eKP87qyPGJ4CfgJiO1zZFS/cMGu15Y/yGAYmlwuuj8XjlJqXC9yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYTuwoHs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1100774a12.3
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419789; x=1763024589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=WYTuwoHswTDQdrk2J9Byqj7f/Husd4nnYTfT5hDwYM9qbNvMrqzk3jWBqpFf5pF9IZ
         xzOtmQrbMenNPXGpT4RowxdsBgEo6JvsQhAR1wbpO//4K7gzZeCyE75Wpf/NeEP4k/iT
         VbQO44VulP2dMtkPiivIc/uRMrYO5qbcx3rNe471ERaRKb1SVvMz61pm5UKvSAA8D7nb
         AR9GSbYzwdw5ZQYPqfoAuRZLbkUTooohJKnjOjfmLeJ8srPqEDgBSge2sJx/uMciNPgf
         d+gF5HL/2mL8yg1lylzuq1scROxUHlX2IhXfKjGIl0dm+8hGFrkqvkcp1z69l1Jgf0Y2
         5KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419789; x=1763024589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=KaCYGkJTajw3sG+ZsAFsdCuadKmYvEMhmNveVH4s233QDngImnjwEMOib5hzXkNOlz
         w6KD3/bECDiZCxNiyBZhUGRNyt9Sm3k9D+Y52xJsJ/GhUnuGEFu0U25uG4yTv7kR5xy0
         miluHEiXWpQOcsU1UlPS/pBRZ8yMmkDmXyDKM4v2vToUbDUym/tyeOnaqk6AKInj9orw
         hrcZERXr1VLdVSKe1xNyyhIragUAmhGN+p52jN+pA/Y2iC2iFsOGVGGQFnLguTmwn8V+
         QGA4mTBFHoGWpTNzhXbreEKHxhCqTt6u/j0azaLWuFk+jjOvEL/gkIFTygSzMGZwCqr0
         lLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXixHS4JHqAlcZg0VGLxRH6sDrXYoHYfWtG+Y7RmyFu6ME1tknHDfw0D032KKkGx2TUVU0igzFmdVfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRf//mz3/QF+3na7d7i4sJdL1nfjhW5wOR80vGQ6GeJ2gxjdc
	aWrKdDl3fIRtf3Y3XoZbW9/CcZMniokHUm2YsrjYo1dxx0T/zgIHaO3yfFQGu3PugPMpyoriFup
	2r08raDQArnNUDnNqUKXDh0LJf8QOvfY=
X-Gm-Gg: ASbGncu2p+K6IZ5SthkEEeXiTrrrFdb0p9ajd0bHb9FqAN0aGAVaADCG15mDh/srCeY
	RgIcLgl9EFQdtAEKu1FOaK52emNwuPo9sK97msCj/O3iOIpJj0mejAXKr31O/ktCqDEs7VHS7cA
	90AldriC9lk1c5Fv2DgW9Q3aYe6jlFSsxEIBE4hv2ElHjitHK/LtBWMr3Tf4vKapUzrNvJ78v58
	OjeYzLAjfSYQ1TDpIwEY3DMd5uKSK4oHAY3ib7g9ZgGo38pf75vs7MXdQgvV6zKLcPZ+GTs5Cbt
	Mi/jBLDCHA6HavSC0P+Pl2y9D6IJtA==
X-Google-Smtp-Source: AGHT+IGzG4L1zsLSrPolVgz53k8qLjyW8wdBsccQu20dip4z2Ulliwm8dDW4Lw75AwMHZ0hiIPIToqA/2u2N+i4Tu34=
X-Received: by 2002:a05:6402:34c6:b0:640:abd5:8642 with SMTP id
 4fb4d7f45d1cf-64105a477d4mr5755119a12.21.1762419788438; Thu, 06 Nov 2025
 01:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
 <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com> <20251105225609.GD196358@frogsfrogsfrogs>
In-Reply-To: <20251105225609.GD196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 10:02:57 +0100
X-Gm-Features: AWmQ_bn2fAKjP1LvxTPOzsC5eSdfONWi8mVFNaKjNuG1RFoEXsyn3eS71zosukU
Message-ID: <CAOQ4uxhqVQYZvgNp=yN_u9rqoEw4wZ_YuAfwnpgrnduBruNMbg@mail.gmail.com>
Subject: Re: [PATCH 02/33] generic/740: don't run this test for fuse ext* implementations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:56=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:59:00AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > mke2fs disables foreign filesystem detection no matter what type you
> > > pass in, so we need to block this for both fuse server variants.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  common/rc         |    2 +-
> > >  tests/generic/740 |    1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 3fe6f53758c05b..18d11e2c5cad3a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1889,7 +1889,7 @@ _do()
> > >  #
> > >  _exclude_fs()
> > >  {
> > > -       [ "$1" =3D "$FSTYP" ] && \
> > > +       [[ $FSTYP =3D~ $1 ]] && \
> > >                 _notrun "not suitable for this filesystem type: $FSTY=
P"
> >
> > If you accept my previous suggestion of MKFSTYP, then could add:
> >
> >        [[ $MKFSTYP =3D~ $1 ]] && \
> >                _notrun "not suitable for this filesystem on-disk
> > format: $MKFSTYP"
> >
> >
> > >  }
> > >
> > > diff --git a/tests/generic/740 b/tests/generic/740
> > > index 83a16052a8a252..e26ae047127985 100755
> > > --- a/tests/generic/740
> > > +++ b/tests/generic/740
> > > @@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
> > >  _exclude_fs ext2
> > >  _exclude_fs ext3
> > >  _exclude_fs ext4
> > > +_exclude_fs fuse.ext[234]
> > >  _exclude_fs jfs
> > >  _exclude_fs ocfs2
> > >  _exclude_fs udf
> > >
> > >
> >
> > And then you wont need to add fuse.ext[234] to exclude list
> >
> > At the (very faint) risk of having a test that only wants to exclude ex=
t4 and
> > does not want to exclude fuse.ext4, I think this is worth it.
>
> I guess we could try to do [[ $MKFSTYP =3D~ ^$1 ]]; ?

Yeh of course, either that or [ $MKFSTYP =3D $1 ]
if we do not care to add pattern matching.

Thanks,
Amir.

