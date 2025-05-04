Return-Path: <linux-ext4+bounces-7636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71CAA8377
	for <lists+linux-ext4@lfdr.de>; Sun,  4 May 2025 02:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910CA170033
	for <lists+linux-ext4@lfdr.de>; Sun,  4 May 2025 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE63333E7;
	Sun,  4 May 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxwwWyj1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0A380
	for <linux-ext4@vger.kernel.org>; Sun,  4 May 2025 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746319745; cv=none; b=TlL5iQ2zJI5cHwxOnTWHdWg3bRqA+F/3n08S6fujOOYdVkDTmvJGUWMGF+ppgmaPFv1dfq62hESiCWMGV65ypjw0QZiQyYZXtAVIb+kwRCwReLJQgNdkAg/Mi9r/buXGwtFq0heEi0s5SUlQgoBJRcx5/zgKRAPcV62uHJLp6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746319745; c=relaxed/simple;
	bh=pKRaoEaiEo+P4zXU6omopVkduZgeEWKK55P93cObTjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6GGXeGPKDtnU8K5YU52SDTkMre6KeW7NTZ1ApKEhumQNjBzbD3YfaP5askYm63w6ivTLKxEjXgBzOmIybYW4cbH1L8/XCKxFqF1+cRF6Ok5+4nnMD8dnU2UNeHIzYMyeV7xXFVlYLu8Hi/gj1tBcqka173ZuLiWlTZ7Mwnd1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxwwWyj1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2cc57330163so2110971fac.2
        for <linux-ext4@vger.kernel.org>; Sat, 03 May 2025 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746319743; x=1746924543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWM2laCkEuziFYId9srIKC7bk8gLrcevDoaxxwbczds=;
        b=fxwwWyj1yAbvYq+WNiWAHE0oI4YhkTPjUuvPnpZRjMZPLsEWGXwgkWKkFohOF1uUk1
         7Dau9uj8sZj32s+OBUrdTJLtWyJCJSidnlu3jKl1Q04YvXRexbgXRgEn011a1Zm80TMS
         gw0I+AZ2EQrvy91Qv3EeXsU1ESXB7l8yHE2LVDRAMAfMaFj6R1FEPu722wkq/ZJyK5i6
         p6FIfnvXOmtjX61v32zoK6YjibGwzbjo4d3GMigTl3QOfPBOpLopzoZg2kLI/o0A3LxK
         j225ItubazfHTLf/zYZ9wPwu7iy16UXKrB+bEJaIdUZnN/eFsBwpPMLVeaZN5A5FNm/Y
         ltGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746319743; x=1746924543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWM2laCkEuziFYId9srIKC7bk8gLrcevDoaxxwbczds=;
        b=b6eKF38psK3V+0wwBO7jTUUHOW19VmL78dgH17iHjxRkQb9NXSTzMv9wnw6khF2Vpt
         qk4L+DnwV8cQzsn+HmAJGGZZmYpfSjinuHtmW/rq0RFkCASMvGNSXe0jJed7E6DCO8iY
         3xJB2h4ytBg7eLeLiEtYX/VUJCgN3WQVi08DP5ixDPnwZlR3Ao+W3g6Szocwiy4DtLFC
         s5X4qq62cHm4QO/Nc0asJpiU5qAN6z7obl28sPy4/Ve2zruBjb923dL57fii6PewGvRI
         FgtnUExn8zqwzxFMXtNSlGRS63bn9B1PQJiYdUNjUahwhqd4RPUnTR3IpkoDaxTMZD1s
         s+kA==
X-Forwarded-Encrypted: i=1; AJvYcCUvTyqgYJmhtBscpPmsqMTtVIAbi9fb8pilIomiovIWOo3cxRUKr6bIPyfXrRtZO0hzGsGwXiqPN7rz@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHGOTo9q5A1kro5FaypQZqMggGIUNkk/Ub0ZOvcuqBSMG99S7
	g9BqpwRFkIXhe8/QXn6JjkXJwU7vnGhLsaSQBpHY6xnYlTLOys1KvvnrSEsVXIVDO9PPwGpMinX
	0qBZRloCWgs0JVmP7k9r0wmnJDAg=
X-Gm-Gg: ASbGnctZZeoAJqIypI4BCTqKdPuJopHSh/r0NEqsmFASlAbDjQu8VlCC5NhjweZsD6I
	Yiiv/KMXnCG34Szfy1bLVqbub9NA2qPNp14YYLOlobY/RiJe5kuisoPWgsdA7KCVIrCYnrKP6Ou
	ycVrcQPXHR24WH4utz8vMRCA==
X-Google-Smtp-Source: AGHT+IEdfNPJH7N5AyIWxJUg36vfMylvdYU1xhSBzavkYYePqR07v3NOpE2E4dvkaOgiTJsPhk+JPBvEp8fa+nzpBrk=
X-Received: by 2002:a05:6871:7419:b0:2d4:d820:6d82 with SMTP id
 586e51a60fabf-2dab3313467mr4577568fac.26.1746319743051; Sat, 03 May 2025
 17:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502174012.18597-1-bretznic@gmail.com> <20250502203742.GF25655@frogsfrogsfrogs>
 <CAPXz4EO8vbVxksgftCaSXb3UgWa_oxrsiYVCkOQTz+4gYZ5k_A@mail.gmail.com> <20250503164526.GE205188@mit.edu>
In-Reply-To: <20250503164526.GE205188@mit.edu>
From: Nicolas Bretz <bretznic@gmail.com>
Date: Sat, 3 May 2025 17:48:50 -0700
X-Gm-Features: ATxdqUEg5eXZXAOnpLBZxmx9SQDZWDhv9Mz6rNTgY4V5DQ3I_2qqVZMMkPxpNzQ
Message-ID: <CAPXz4EO=94LOxmp6Orbv5P+HMHua-1tV76eh40VStH=bgiDWnA@mail.gmail.com>
Subject: Re: [PATCH] ext4: added missing kfree
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org, jack@suse.cz, 
	adilger.kernel@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 9:45=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, May 02, 2025 at 03:26:22PM -0700, Nicolas Bretz wrote:
> > On Fri, May 2, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > On Fri, May 02, 2025 at 10:40:12AM -0700, Nicolas Bretz wrote:
> > > > Added one missing kfree to fsmap.c
> > > >
> > > > Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
> > > > ---
> > > >  fs/ext4/fsmap.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> > > > index b232c2767534..d41210abea0c 100644
> > > > --- a/fs/ext4/fsmap.c
> > > > +++ b/fs/ext4/fsmap.c
> > > > @@ -304,6 +304,7 @@ static inline int ext4_getfsmap_fill(struct lis=
t_head *meta_list,
> > > >       fsm->fmr_length =3D len;
> > > >       list_add_tail(&fsm->fmr_list, meta_list);
> > > >
> > > > +     kfree(fsm);
> > >
> > > OI: UAF, NAK.
> > >
> > > --D
> >
> > I apologize, it definitely wasn't my intention. I guess not really
> > putting my best foot forward...
> > I don't yet fully get the UAF in this instance, but I'm studying it.
>
> UAF =3D=3D "Use After Free"
>
> What this function does is to allocate a data struture, and then add
> it to a linked list.  This is what list_add_tail() does.
>
> By adding the kfree(), this will result in the callers of
> ext4_getfsap_fill() trying to dereference a pointer to memory that has
> been freed.  So your patch very cleary introduces a bug, and makes it
> clear you (a) don't understand what lst_add_tail() does, and (b)
> dont't understand what the ext4_getfsap_fill()function does, and (c)
> almost certainkly didn't understand how to test a particular code path
> and/or didn't bother to adequately test the code that you were trying
> to modify.
>
> For future reference, the commit description for this patch is also
> not adequate.  Don't replicate in English what the change in the C
> code is.  Explain *why* the change was made; what bug were you trying
> to fix?  Or what performance optimization were you going for?  And
> it's often a good idea to explain how you tested your change.
>
> Cheers,
>
>                                         - Ted

I thought I understood what list_add_tail() does, and also
__list_add(), but obviously I was very wrong.

All your points are well taken. It was outright sloppy of me and I
apologize again for the trouble I caused.
Nic

