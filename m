Return-Path: <linux-ext4+bounces-3951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB09637FE
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 03:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B91F23EEB
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5122EF2;
	Thu, 29 Aug 2024 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH737kW8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE68814;
	Thu, 29 Aug 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896245; cv=none; b=HMQtXrqJUGwezUiRFkkdOU6Q8fE70N0Ao2HZmq+tIVlsgL1u0pSp3Kyhus6Otk1OVdz7Cg7s5qP2B/goeuaP7+y/JfWanmTFZDFApHVyth1BcYXzwdcWSFrqFyW1dSm8/Iuo7A8D/Fo0p8JQiZJKCn7IpRlLiCyUbnnzDelvfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896245; c=relaxed/simple;
	bh=A7OpZthYOELSDV1dYFWj78rfBJLsOOtrDuntA6Vi2Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPGQF6MjV+qGwOAqQM56JoClYcdgI9eJQyEGRTQaooNPea96gheIeMY/UflAyA6kve/RJonLf96zEP/64l83ltVyQU1SNc1ijipOnkDrYtERYzbO6Zy4MYXmh/2qVaCG6iYehDINYeqlNe1RrN2vmtI2fq4FAGsryDcLYAXhEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH737kW8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4567edb7dceso689771cf.1;
        Wed, 28 Aug 2024 18:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724896242; x=1725501042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9uj9LVLu2Gy8UKo+nGuraOXO0NSHj32TkuRI+BSWlA=;
        b=gH737kW8XY5OYcK0JGTy9oLtmDEiKpTWdR2dU06eOK7OnGVEtc13JEGYG9VG/hWHoQ
         njoSQ9Bow94yZtebFN5vF8NVYASVur0VfHPhMv/2jwxYDqyUiJsZOYhYViRhwk8CyWaP
         UkP9/Gn2cDKQc3q7zYV2XT7g1t4clrGn0hruMmmffTX8tR/fD+l+fMRoFhCVad5UF5UP
         PovF4jjApi9DmcCvMbQ2SXWrI3AFX2XbD0yeX+BCsG3e09hevcem18MfFXiy2Vp4Re8x
         mNCGLJzgYDvoWNQe0l6Es2pbWtoTj5+gKfetepglc6Afbu2laUiLkj3sNlP95wuOUumu
         hFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724896242; x=1725501042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9uj9LVLu2Gy8UKo+nGuraOXO0NSHj32TkuRI+BSWlA=;
        b=UdeuaLZyyxCaUOGMP0EVdAXGkwK2IkvNYePN3kkLUpJKIROZjNwSyBDnFgUnjFcH9u
         qPYvV0wnt4hUxsY/sXznyNlf18i3bJNaGpn1PNrhffW2jsocRfZxzQoj4nlC8hpYH6io
         mC9aOHslIFLrEqt4e0uU1QJBm+xTNjqLoV1J5JHsGNbY5SAAC6goNA1lmj6O7a+D3yxM
         osbtgAFE62iGqz6MF9chUzvix64n44ZGtmTxL75ytmwqsyfHfCm6miKeexod1iyGB33r
         ToMmT7Ycee0yqAPNnw1mr4sOV44JyVw9dhzzU5t7kxX27H2di8gY/MVmwIzAhjhqtslO
         ZqQA==
X-Forwarded-Encrypted: i=1; AJvYcCU+pIkaEP1rCrbI0nWbfBAvovgnUxXRWRR06sMUUM8o1Vb1tawMsvNwXGOiQZ9YpD8Ox4fJJ1IGlh25@vger.kernel.org, AJvYcCX34QY10J4tliiQJKfzqdpj5a/CgJfZjWB1mAWwES4UqdbzoNX3LfoIuUHcJJW8s5xjxaBAT/yu7MmaqvRp@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEYuPMFIYwnCmDyrhQHFEAIn7kF0+Hho83pAnrKnEtDp3cTOH
	AlpTkZ5jtUx+uUwnc8UhKpcJMEyiv1ZK9PEi9ZBb9xwUwIyH/2FE9JDR7noJY7eDrQt6FLVXQAo
	nQCz+Ni8F1ioRb0rIEkUQ7ijFXYs=
X-Google-Smtp-Source: AGHT+IHiDSVszR82FWP7/ERRIUgyKLBr56ZY/HeJ2w/l5jRq1MWvPDKR1Tvo4nA3iaSEmFrrPg4+LcoezKlvxH48DUo=
X-Received: by 2002:a05:622a:114e:b0:456:6264:1c27 with SMTP id
 d75a77b69052e-4567f6dc44emr16192911cf.40.1724896242286; Wed, 28 Aug 2024
 18:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
 <20240823013329.1996741-3-zhangshida@kylinos.cn> <20240828114513.bzccvcalexwge4d7@quack3>
In-Reply-To: <20240828114513.bzccvcalexwge4d7@quack3>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Thu, 29 Aug 2024 09:50:06 +0800
Message-ID: <CANubcdUZpf1DOVYnqjYBYCYB0J0D=3vk+efC-T98gpO=hPgD4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: fix a potential assertion failure due to
 improperly dirtied buffer
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=91=
=A8=E4=B8=89 19:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 23-08-24 09:33:29, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > On an old kernel version(4.19, ext3, data=3Djournal, pagesize=3D64k),
> > an assertion failure will occasionally be triggered by the line below:
> > -----------
> > jbd2_journal_commit_transaction
> > {
> > ...
> > J_ASSERT_BH(bh, !buffer_dirty(bh));
> > /*
> > * The buffer on BJ_Forget list and not jbddirty means
> > ...
> > }
> > -----------
> >
> > The same condition may also be applied to the lattest kernel version.
> >
> > When blocksize < pagesize and we truncate a file, there can be buffers =
in
> > the mapping tail page beyond i_size. These buffers will be filed to
> > transaction's BJ_Forget list by ext4_journalled_invalidatepage() during
> > truncation. When the transaction doing truncate starts committing, we c=
an
> > grow the file again. This calls __block_write_begin() which allocates n=
ew
> > blocks under these buffers in the tail page we go through the branch:
>                                              ^^ and we...
>
>
> >                         if (buffer_new(bh)) {
> >                                 clean_bdev_bh_alias(bh);
> >                                 if (folio_test_uptodate(folio)) {
> >                                         clear_buffer_new(bh);
> >                                         set_buffer_uptodate(bh);
> >                                         mark_buffer_dirty(bh);
> >                                         continue;
> >                                 }
> >                                 ...
> >                         }
> >
> > Hence buffers on BJ_Forget list of the committing transaction get marke=
d
> > dirty and this triggers the jbd2 assertion.
> >
> > Teach ext4_block_write_begin() to properly handle files with data
> > journalling by avoiding dirtying them directly. Instead of
> > folio_zero_new_buffers() we use ext4_journalled_zero_new_buffers() whic=
h
> > takes care of handling journalling. We also don't need to mark new upto=
date
> > buffers as dirty in ext4_block_write_begin(). That will be either done
> > either by block_commit_write() in case of success or by
> > folio_zero_new_buffers() in case of failure.
> >
> > Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>
> Looks mostly good. Just three small comments:
>
> > @@ -1083,11 +1090,11 @@ int ext4_block_write_begin(struct folio *folio,=
 loff_t pos, unsigned len,
> >                       err =3D get_block(inode, block, bh, 1);
> >                       if (err)
> >                               break;
>
>
> > +                     if (should_journal_data)
> > +                             do_journal_get_write_access(handle, inode=
, bh);
>
> I'd move this inside the buffer_new() branch and add before it a comment:
>                         /*
>                          * We may be zeroing partial buffers or all new
>                          * buffers in case of failure. Prepare JBD2 for
>                          * that.
>                          */
>
> >                       if (buffer_new(bh)) {
> >                               if (folio_test_uptodate(folio)) {
> > -                                     clear_buffer_new(bh);
> >                                       set_buffer_uptodate(bh);
> > -                                     mark_buffer_dirty(bh);
>
> Here I'd add comment:
>                                 /*
>                                  * Unlike __block_write_begin() we leave
>                                  * dirtying of new uptodate buffers to
>                                  * ->write_end() time or
>                                  * folio_zero_new_buffers().
>                                  */
>
> > @@ -1117,7 +1124,11 @@ int ext4_block_write_begin(struct folio *folio, =
loff_t pos, unsigned len,
> >                       err =3D -EIO;
> >       }
> >       if (unlikely(err)) {
> > -             folio_zero_new_buffers(folio, from, to);
> > +             if (should_journal_data)
> > +                     ext4_journalled_zero_new_buffers(handle, inode, f=
olio,
> > +                                                      from, to);
>
> I've realized there's a small bug in ext4_journalled_zero_new_buffers()
> that it calls write_end_fn() only if it zeroed a buffer. But for new
> uptodate buffers we also need to call write_end_fn() to persist the
> uptodate content (similarly as folio_zero_new_buffers() does it). So we
> need another preparatory patch moving write_end_fn() in
> ext4_journalled_zero_new_buffers() to be called also for uptodate pages.
>

Will do. And also thanks for the detailed explanation.

-Stephen

> > +             else
> > +                     folio_zero_new_buffers(folio, from, to);
> >       }
> >  #ifdef CONFIG_FS_ENCRYPTION
> >       else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

