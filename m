Return-Path: <linux-ext4+bounces-10337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9598B9075D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 942AD4E2172
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D30303A22;
	Mon, 22 Sep 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuVX1AU9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE30594F
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541316; cv=none; b=J+16rxxexHRPHw5JqQFpQtWGPG+OAGKjiBAuqkARHqXkELb56wK1YIlHKYcgWMmWP4+gGJkaTtCztGn6sPddAj+Cc7aVp5m+WktCeZF9TF3ZW3CmwO4L53joOpf56OxhmQDgVb1szRGy1erf9uMaC0vl3dkhlA8FuPonnPtsv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541316; c=relaxed/simple;
	bh=C01t2mpoYeYjnOIRq0tSlGySjgXDSbHsQ5Ik9kqEi38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftnb2+jUzuB0YVhWQafXLfoTOiXRnl8sRtMYTX2xNE82WOIdaXpARIyY+/uzuyoJ8RT7rkOgbA1d9PtVsq3MzVP1t2XW4Hv+pNJfAE29e+0Xz78NWlgXYgRJRwKHdP4ORTG4HYqiHBnXzCUth3nbZ4DvkQmthf16j2lnCQ8TdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuVX1AU9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so4948869a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758541312; x=1759146112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oxOygCk0VGPCeiSDXfT7In4HSAzQPM3WJ9lPT+HFHo=;
        b=WuVX1AU9K8db6Rp3W95D7qD/Qj887l0Vfl7kugqoXU5qrx62hqt6sQVJNNaGHcD7tl
         G4tNt++tceTN5OR3bVD6fOkXDI/Xg9xZ8XI/5g+zUhal3nQeyd7TMJmpY9Q8vqVM5aC9
         j6QeijKVD4uCs2RdfZuPpFHC6AZoZYesQaU7Asln/rtO5VLKN+jXxPOHgikTwL0DBWbg
         oiMhTfxl9saiBGZdouYsyAfqsOsg811tYhsNHVsWLpqUVmkFOEYYlSt+1tCrSqmxjxSv
         Df51QlDaTgY+xmDNHptsjzNcqLOVCa/or/n2HFBCCmqeYGO9svxem1R40yP1S3T5e3rE
         tMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541312; x=1759146112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oxOygCk0VGPCeiSDXfT7In4HSAzQPM3WJ9lPT+HFHo=;
        b=JPg3yNN9Gn+Maqb1eFHy8rbhrkSJiKVYz+q3wycweLMz99UFeeHkjT5BjHeB/pCoVk
         Cf9rarXxW3Ae2rpw5xO7Z5H3/ABVwUr71Sxjd1hi93XI7du0vvSHBVkmW+cC314bxTvi
         XfwZIYaq+pM/PWkFoxfH5bnCG+FQd3zMSqeXpnh18jE8gJm07fqcJcD9BKYINRDMfIW4
         573b2ZLkPf9UaxioJjnPNupgWwi6Y1CS51fGrFCK/2R1QpZ8sXd5basi8c7gvfiF2kdQ
         hcrG54+vBdZ4uqr7KsurHVtlvtoTKJLWapcy9rsZX2Q8KqOMF2IxZhEgcbm/5UFx0zV9
         8VAA==
X-Forwarded-Encrypted: i=1; AJvYcCWOBR8XfnLc79kXZ7sROpmePXoOVBiyTdPOnDmanciVdcFb+8Ox+Z4TJHFCxfQgFc/en3sA7vtNZnbv@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7xKUlHtg5e8fOaRk2ASjBKsuUf1M7TfPz3Jmp2ceugjxKHTG
	p1LJ5hyaOFMUCvZfhUu2qqGY5oe/GHMUrP8c78o04TUYe+4HOSfitT288aTzJzVq+1BhK5oXq6B
	PVeAcGkZuAQmOhKGF8lVh+b1nXRuiYmM=
X-Gm-Gg: ASbGncvhjvdVfpSWmn+FRND7BPzg6GaryAN2tpOoU9S1cg8z7+XN2C1304/DLAQBlu0
	uI2jTVECO6VdYx5NFNV20Zl6q6UHQtr1aJkrjY9kKPfQAj5um4gHXg5KQa1l8SyVK8OxiUEEM/u
	2xNhDQk5fsdpyEpbgvAddtbBqyBSLZJ7TM9T/13xMCR4JmaaZnhXKnQ5YwQdXd3xfayt5KXa3rU
	SPTuNT0IRsd3bl3l0P85GiAWM+E1rmhnC6PKw==
X-Google-Smtp-Source: AGHT+IFkrvZLkom9QBciHs6IeDWT1d22c0w/ez/+uji1phZB9oJtSgu7MJFyeNNpyTK/5sCVjxhsAiXVpi0xe+B+ZLc=
X-Received: by 2002:a05:6402:5355:20b0:62f:6860:2d86 with SMTP id
 4fb4d7f45d1cf-62fc08f2e01mr9371365a12.12.1758541311797; Mon, 22 Sep 2025
 04:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919154905.2592318-1-mjguzik@gmail.com> <20250919154905.2592318-4-mjguzik@gmail.com>
 <ayjwe2moaswosrvcv6mhd2wztwvexfjgy6dfnxxegnhppca7ac@75h6kmoj32e6>
In-Reply-To: <ayjwe2moaswosrvcv6mhd2wztwvexfjgy6dfnxxegnhppca7ac@75h6kmoj32e6>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 22 Sep 2025 13:41:37 +0200
X-Gm-Features: AS18NWDd4DNKu221LBJSwOQahHDo9s8BoIUAMr0lDu2p-ZCeBCjMIxMDm9gSAD0
Message-ID: <CAGudoHF6Q4xh=fiRwJ6+qiQSxovj3BeSdZYANAOQ_NnZg3bOXA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] Manual conversion of ->i_state uses
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 19-09-25 17:49:03, Mateusz Guzik wrote:
> > Takes care of spots not converted by coccinelle.
> >
> > Nothing to look at with one exception: smp_store_release and
> > smp_load_acquire pair replaced with a manual store/load +
> > smb_wmb()/smp_rmb(), see I_WB_SWITCH.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> ...
>
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 0e9e96f10dd4..745df148baaa 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -478,8 +478,8 @@ static bool inode_do_switch_wbs(struct inode *inode=
,
> >        * Paired with load_acquire in unlocked_inode_to_wb_begin() and
> >        * ensures that the new wb is visible if they see !I_WB_SWITCH.
> >        */
> > -     smp_store_release(&inode->i_state,
> > -                       inode_state_read(inode) & ~I_WB_SWITCH);
> > +     smp_wmb();
> > +     inode_state_del(inode, I_WB_SWITCH);
> >
> >       xa_unlock_irq(&mapping->i_pages);
> >       spin_unlock(&inode->i_lock);
>
> Comments need updating here and in backing-dev.h...
>

turns out func name in the comment is also outdated

> > diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> > index e721148c95d0..720e5f8ad782 100644
> > --- a/include/linux/backing-dev.h
> > +++ b/include/linux/backing-dev.h
> > @@ -292,7 +292,8 @@ unlocked_inode_to_wb_begin(struct inode *inode, str=
uct wb_lock_cookie *cookie)
> >        * Paired with store_release in inode_switch_wbs_work_fn() and
> >        * ensures that we see the new wb if we see cleared I_WB_SWITCH.
> >        */
> > -     cookie->locked =3D smp_load_acquire(&inode->i_state) & I_WB_SWITC=
H;
> > +     cookie->locked =3D inode_state_read(inode) & I_WB_SWITCH;
> > +     smp_rmb();
> >
> >       if (unlikely(cookie->locked))
> >               xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags=
);
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

