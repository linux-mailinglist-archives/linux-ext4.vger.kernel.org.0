Return-Path: <linux-ext4+bounces-6625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D4A4950C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 10:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A321895AF4
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960C25CC8C;
	Fri, 28 Feb 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djHC7xeM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C32528FA
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735023; cv=none; b=sWf9E4YXXKxrFZLKqxH79/bSAUAuooRzmPCRtdDaHLszqKn+s5OgGfWo3e/26dFnAq0/BsH/M0wfVLIPEeKBq7p9yPOU1B2smCwx68wPnrtLtR36CgTeJyPeOS/29WzN8FfXMrUek21tkc2cyGUQfs54t3Tf2mYOBlR5swjny5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735023; c=relaxed/simple;
	bh=nqdlP85SObIYPI13YN6cHLtvd/2G6Xb5CK2ONlGlWF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/g8cTpmgDGvqcjZpaLBB2Nh0xGA+CUnqFavzhTYbCmPvJDwQtwo4T/RgKsJfdHx43YVUWbP1iBvaRDiO7Q8j8fN5F+hqYdXL5vPkaIyipHL6MFyrEWjXwBVdhHMmzpxV0iTt6ah7QFxAeeFcsbRb8fZqY0KJgTDBTQjoSmX+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djHC7xeM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fcfso20711521fa.0
        for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740735018; x=1741339818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbNNBr7YtOVw1sZaUQtmq0At9jDOrHUI6krwOlq3a6U=;
        b=djHC7xeM94IHmlz5P197gwPzKzzAIbzxebiAJTHQqCrsWgbd36LfXT8Gd+FjFDzkJk
         C1PfVFaflFvalO60roNyXFbF69XZrLgwOJEriC/xNWHo/zk25Y4yraI9P7WCmfeZV8P+
         uQpViWQLi/y2zhAvY4lz2Zu/rGV5BJPlBDe4/xRUOnReGkmdZTzxYL0Fnqhomhm92uLV
         +D5yRgBwWw755v0UbkMPBExeANZ1nxUOjdFrKcQxf+KN66ra3P0Dskb3vEPki5q1QpeE
         7ZUcW4FV85vIgY9ZzDzmgnc2GDNnady5S1LXcH7dJ1hKA/wWd6Rm3GHcjIANLNr5HZM2
         HxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735018; x=1741339818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbNNBr7YtOVw1sZaUQtmq0At9jDOrHUI6krwOlq3a6U=;
        b=H+a6lnB8Ip+cs9hLfGoq0JHxj1fJB+LheN0Lm6E1CfwYm9ZvR5pwMopCa7ykcVHK85
         ML0lSPDfwIssfQRnH+EhGhNQ0UkcX0/85EwroMyWbvnNsQ8FeD8i6DFOzZ5RUeBsl2s4
         iZ/b67CVHaADNVdqt1cNROjVpiu/L80dpYzSLcwPgURPffqj258SaB0yH/4c5QnI/JUY
         soNEWTppEh4J2Bw6qiyO1UGL35J7aYKgxHVlG8F5YwREpUb3TQe5hWMktchlgipgCsx6
         d0+wwMpipKtDqDorgxou9Paw15DceXqLNU+PetXQtDDzg7UsxXiWivbZKak7dczPHwkf
         CbeQ==
X-Gm-Message-State: AOJu0YztESjTkFVMWP6/HiNFjj/9KFHRLy7bJkm2btBzI35RA/3kB/qZ
	wozTSfwcV7MRlcCTc19iIm6Qh4VGharGCZOCKmvPGmHfjSZ+GxheXn3im1Cq9D7gWc1sL49PVCL
	tJ4lAhj2ZY8egLsqRBeOc1u3nErIePBKlt2zz3lXr
X-Gm-Gg: ASbGncv/CfqCz23qb0/6Vj0gSwVUyeUbOoPgKU/fSIGneMq+9kiroML/iozL8ovWeww
	r0JSfXzP5dEZPDhjIZKPPTIf+xKkm3Y0jdZWlviU/5B9vBlkDr2vy4h2D5vngPl2iCFhK3eCMLD
	przD/KlLX7
X-Google-Smtp-Source: AGHT+IEvYU3ByDopEZ7jvPs+2p9lB5MJMLPm2Y3kl+iRbpQXbzvb1XBr1XNhvxtf0eUSbTeg/+Aa2HuaQ3tq6I/qhms=
X-Received: by 2002:a05:6512:281d:b0:545:5d:a5d8 with SMTP id
 2adb3069b0e04-5494c10c5efmr877687e87.7.1740735017831; Fri, 28 Feb 2025
 01:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228081126.2634480-1-sunjunchao2870@gmail.com> <9be439b3-fd43-4a4b-96e5-0d0ec5fb1509@huawei.com>
In-Reply-To: <9be439b3-fd43-4a4b-96e5-0d0ec5fb1509@huawei.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Fri, 28 Feb 2025 17:30:06 +0800
X-Gm-Features: AQ5f1JpfqEAhMheKPHovLZAuMmqrvRd6JVJEnFWm_ikTzhrsXmjXbXnqYueOYQc
Message-ID: <CAHB1NaigQx0HW3Oxd2P9uujGk221WjxeKOgaNj-p2WqMJaQZiA@mail.gmail.com>
Subject: Re: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL allocation.
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Baokun.
Thanks for your review and comments.

On Fri, Feb 28, 2025 at 4:44=E2=80=AFPM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> On 2025/2/28 16:11, Julian Sun wrote:
> > The __GFP_NOFAIL flag ensures that allocation will not fail.
> > So remove the unnecessary checks.
> Actually, even with __GFP_NOFAIL set, kcalloc() can still return NULL,
> such as when the input parameters overflow.
>
Yeah, agreed. But IMO an overflow shouldn=E2=80=99t happen in this situatio=
n.

If there's something I'm missing, please let me know.
>
> Baokun
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >   fs/ext4/extents.c | 4 ----
> >   1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index a07a98a4b97a..95debd5d6506 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -2940,10 +2940,6 @@ int ext4_ext_remove_space(struct inode *inode, e=
xt4_lblk_t start,
> >       } else {
> >               path =3D kcalloc(depth + 1, sizeof(struct ext4_ext_path),
> >                              GFP_NOFS | __GFP_NOFAIL);
> > -             if (path =3D=3D NULL) {
> > -                     ext4_journal_stop(handle);
> > -                     return -ENOMEM;
> > -             }
> >               path[0].p_maxdepth =3D path[0].p_depth =3D depth;
> >               path[0].p_hdr =3D ext_inode_hdr(inode);
> >               i =3D 0;
>
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

