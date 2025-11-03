Return-Path: <linux-ext4+bounces-11424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23AC2DB82
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 19:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E2D3BAC0B
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447628D8D9;
	Mon,  3 Nov 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsm2mDd1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DBB28D836
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195408; cv=none; b=q3qqXjmz8wiQ83iffXq1Xk25DI787IyKvkwuJWtiz5VmpBKTXPiAMqC4zdKojb3enU8oJxdxyOt8mu1xKgaj1fkbV/poJegNdTKpep8qaAtzvteWgz91dRdnXP6XpxZDlkoiewL9+JpjkJdM4RIf2Vl3HhOBkr6WJrmdKhsbLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195408; c=relaxed/simple;
	bh=JRvEfwdNrH1jWa7Nt9cTkKPH9OSy4b97bdzQ5qIg5/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fleTodnB1RHVfmDCN+YkT3F2Tr3K0SdFcldn62LniF54CFl+J3hTWzoekN6pDOYVGq5pYgEW+38GdpQJXzJeGrf0JvkILzxDqbYS4jVdZ7Dj139M9u/2ln5AaVa0399cF9j7757gHvQsNLjZsW5J88MH7KEi3adccDlXOrTfCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsm2mDd1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecee8ce926so45166421cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 03 Nov 2025 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195403; x=1762800203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPRq0/jLykorT35rYQJikOHRvZCzdbVAx+CzfNAZXtk=;
        b=nsm2mDd1+FhVnVigMvemk0aJRFbtxZ18gA+Te7IQkYMViknSEU8ct9PXD2XJhHxJRy
         8vZQVF06zrPRzeUkHyefsZwzZpqiXmBA8lt1zTR/RHJ3VAx+R+P8WxbIlXQEOlF7WRfr
         +cdlb0uwb62XKOmJLkqLlXOoF2qrFLhvZwYDMWSpt/t+bZlKLIXSoDnz5p3u+Xby4gwq
         l66kU4gu7DxYoh2FZnriIajrhtmLXcO86J0nxfCNoFagdSAOPnawKkGAJACPrUY166DZ
         zohAyGdt6hqezE4r1chzJj6jpvpYpfRkoah0SLbzYVkIrz+r9G+zS8xFSQaD6/UMS8bk
         Wysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195403; x=1762800203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPRq0/jLykorT35rYQJikOHRvZCzdbVAx+CzfNAZXtk=;
        b=GRgiXP0MXc2DKxnDQiLvcunnmNV0au2by75dGqeaFsw8IJ8iiedNPcKxGe1/qk/LIp
         qOLgokNcqpV5Skn3+F60O6sRChEuDQdIa0qEDAWowPYj6RmtzRxi6m2earqhz3hMkpzF
         JZib8Qj1P0HEOEmGgAgoG5WNfA6Zy9X5nZewX/Huse9DqaVCOME+VrOhksS5MHadERN+
         lpWbDpTGYG2Na++fMGakdTBHY2fXp1B0pUJERVBw9MPztFQfm96gdMkGQj0JhGnGcGek
         2t3wumw2eD4FJJNr3yJaABhPHOt4z+p1qBSNuod8Cx78pqDCdLmFmkazMAm2F5viaVHD
         27SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMkmbApSdtV0GX1LYaNc0TcuwG+pJPP7f8lJoebCJoNmH4DoO2v2QiqpmjXIlo4fB2p7udohWXi3fF@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyALumUmfLOAI36NgL6r2GII3aAmew/en+A8TeCU+YwfDjtLN
	lft5OwRK2td2gzVe3KR8PNhmaEJ4F8d0EhFmh2EQ5iOVzjsH0Qv2Mz+Ap685ghU+GifKvkSk0ff
	+l19lYmNmisxB4jAGRx6Di6uH97vSRXQ=
X-Gm-Gg: ASbGnctRZ7AMAPpgrFut4r9RCItjpsVHC44MzOPi+lFzES/W13yRg6POOQiiPDK0ci/
	bL2r8ZwFe5GIS4fjxE7J6yK0VtC6XL4KCVn2mCh3hlv6+8LtgwJueDu+mfNFp9ADIet3bpvbN6w
	IAXftaNlqG4y6fhXciaiIvvi/AgT+Mi2fIcNwyQH4nXVduv3e4QQzxgfDB9SHUKYvGPv67DvnzW
	jIyqTnHGqCawslEnuT5N7ata/3LHSYu1mR0HWBzTdpeyFwz5XPf6Ck4wq6qwVw7TROGDZkAPk+3
	3NbZywna7q9KVNyiMlCDy0r9OhETD/pv
X-Google-Smtp-Source: AGHT+IErPEdNx0wqHWwFqPPvC6I8WnttkIybTSpvpGzXyM/MnNuYE2oKaiMZ6SYAlHWG3wtzYjNQsAw/xPgkyJ54Z+g=
X-Received: by 2002:a05:622a:15c6:b0:4c4:dfac:683f with SMTP id
 d75a77b69052e-4ed310dc12emr184521571cf.56.1762195403358; Mon, 03 Nov 2025
 10:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs> <CAJnrk1ZgQy7osiYfb6_Ra=a4-G4nxiiFJZgNLLZYnGtL=a7QBg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZgQy7osiYfb6_Ra=a4-G4nxiiFJZgNLLZYnGtL=a7QBg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Nov 2025 10:43:10 -0800
X-Gm-Features: AWmQ_bl8_b5M8z7y7iTRjCOgLlfUlrV_P9O5FvOprblPvPhDuc_qsxYw589fdVM
Message-ID: <CAJnrk1b+0B5h4A4=5zRJ04Kdw-OxbGW_m9s+5U=HZpw+q1umqg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:30=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index a8068bee90af57..8c47d103c8ffa6 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -140,6 +140,10 @@ struct fuse_inode {
> >         /** Version of last attribute change */
> >         u64 attr_version;
> >
> > +       /** statx file attributes */
> > +       u64 statx_attributes;
> > +       u64 statx_attributes_mask;
> > +
> >         union {
> >                 /* read/write io cache (regular file only) */
> >                 struct {
> > @@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode =
*inode, struct fuse_attr *attr,
> >                                    u64 attr_valid, u32 cache_mask,
> >                                    u64 evict_ctr);
> >
> > +/*
> > + * These statx attribute flags are set by the VFS so mask them out of =
replies
> > + * from the fuse server for local filesystems.  Nonlocal filesystems a=
re
> > + * responsible for enforcing and advertising these flags themselves.
> > + */
> > +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> > +                                        STATX_ATTR_APPEND)
>
> for STATX_ATTR_IMMUTABLE and STATX_ATTR_APPEND, I see in
> generic_fill_statx_attr() that they get set if the inode has the
> S_IMMUTABLE flag and the S_APPEND flag set, but I'm not seeing how
> this is relevant to fuse. I'm not seeing anywhere in the vfs layer
> that sets S_APPEND or STATX_ATTR_IMMUTABLE, I only see specific
> filesystems setting them, which fuse doesn't do. Is there something
> I'm missing?

Ok, I see. In patchset 6/8 patch 3/9 [1],
FUSE_ATTR_SYNC/FUSE_ATTR_IMMUTABLE/FUSE_ATTR_APPEND flags get added
which signify that S_SYNC/S_IMMUTABLE/S_APPEND should get set on the
inode.  Hmm I'm confused why we would want to mask them out for local
filesystems. If FUSE_ATTR_SYNC/FUSE_ATTR_IMMUTABLE/FUSE_ATTR_APPEND
are getting passed in by the fuse server and getting enforced, why
don't we want them to show up in stax?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/176169811656.1426244.114744490879=
22753694.stgit@frogsfrogsfrogs/
>
> Thanks,
> Joanne

