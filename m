Return-Path: <linux-ext4+bounces-3970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB8796550B
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC506B224F4
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 02:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D48175B;
	Fri, 30 Aug 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrnUM4r8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2D7405A;
	Fri, 30 Aug 2024 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983429; cv=none; b=eYRvWNTzbRZkwQIMDkh3lIaYCcXFINSvqaTOXzJUz98vITC3lb+Qs2+sMwJlpxs8+b9FW2LVJmtPgGv7JC5t4ZNRJyJFhB8J3bsqQze9tmJr3jjZmi6yQFtUdHacAAbLZzIfURm6OR8XznAZI5BTqVbbkOEJm++5nzUNna9o5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983429; c=relaxed/simple;
	bh=2/hrP97uKSUxYXk+0HWrnVlWMA7qgC51+qStXXQdoRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkyEDxxvAJcXrZhySnLy6BQbWG4hOPo1dua+ZDRH60LJ4ET4NXAB7IXfF98TNuMS2it1p8i3u3QGN5xZd5SIc+GYW9/STyK7Mi/qr6arETBc2h1MF1AyIIJ0H90WwFsOPvzNnSAGaGZ1EbTxgtiXr9KYuSzTvMQdyaWNXhqn6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrnUM4r8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45684218d61so7517011cf.1;
        Thu, 29 Aug 2024 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983426; x=1725588226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3d2wDcfGPGppTMHPfZWCUW61/TDaOLMPF/FQoC3eqs=;
        b=PrnUM4r8wln9gAFXoQf6U92I6231ghkRmIJxq3COl2E0Vle+Up/jmpormeqkmVW+Av
         V+7AeKBLrF1OlY9WUbT+KIA9BXoyqbuvR+Dneg9sSC0HEW1Pezv/4wD3vL7JRvcv3pIo
         mGchThB88VCzXViuOWu3Kwxh49fdfKoYP96XKwylWNS6tGkEJg7lG/d+IxDdmQvqiqPl
         5oVkIKrtKJETtXxpSK+QjxuG5rjeszsgZ9UMc9FpZDN0WPuCf6JS2BPPhcvnUferZ0Nw
         lyfBaL2GlmmuQTDuxp0Wt8CVS18cyC1ok1Z97gHo/qUvB9/cbtV9c1yG424YVPLPMDJM
         0Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983426; x=1725588226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3d2wDcfGPGppTMHPfZWCUW61/TDaOLMPF/FQoC3eqs=;
        b=m9Yl9IniEAF5OJKaA+paSotAgECIG2Dtrq84Lca0/hFiaunar7ma2Yw3iHE5jsoRBz
         DfYrHNooJNQz2izT7ESxJMjAj3YhZ4hVrA1HCvpjKhWI/YwN2oBf1wLKfjlpXOM4L58r
         TtJpzlTCKzEqtI64QvaDQYnkhLsoHiT9j0wW+pULOnz2txuGscpVlbcA1L5bJd4kYZH0
         6+fYvqgfwDVA3e8+ziLxkq0MBXve45kf13wlBNTbggEESuuDblgOCcHk0D0q+8lcfmmC
         s6y5Ogq2XneLSDVTOoCmS1SXOCPE/ILcof53nFG7lNRTi0eZst7z2ex5GeVYi/qQ5dn+
         xgOA==
X-Forwarded-Encrypted: i=1; AJvYcCX+98DP6JYTdFAEQfT/JpytgJLvU9vZqHqKYifG6PvX5aE/h04cR0ON8Uf6RIyLvYxzkz8m+V7+gEBJ+iAB@vger.kernel.org, AJvYcCXNhu7736nNMuSuw2aH6WdrC+OnJMe33BYbpxjdJAinuMCnPheMb6lwqRMYHywzyKF4ocuUJhtcZp9X@vger.kernel.org
X-Gm-Message-State: AOJu0YwmabFRRZAF28pcMRQJSSOVUjfogiJGxU3GVdd0UyXCH+oEp/od
	L+y0jJauIS06uk99NwKbEpc6cHwLHDaK/WEZXYd7lWva00/DAL1RvUauMHEjK196HgMIj9Y/Zvj
	uP1ZXvLEg2PWUfpNg6yCqF6CUY/I=
X-Google-Smtp-Source: AGHT+IEWa4YyYXyZDk6PMTmlEnIutSmka4/xrCP78p0L4zTkvYJE+d8YOayBLLzzB0hvwNThzrvmqqNgQm78SUM7jT8=
X-Received: by 2002:a05:622a:558b:b0:446:6053:e47e with SMTP id
 d75a77b69052e-4567f527179mr72217411cf.23.1724983426189; Thu, 29 Aug 2024
 19:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
 <20240829085407.3331490-4-zhangshida@kylinos.cn> <20240829093013.nxwi4axz3hvelmti@quack3>
In-Reply-To: <20240829093013.nxwi4axz3hvelmti@quack3>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 30 Aug 2024 10:03:10 +0800
Message-ID: <CANubcdWgSxFzWWw9hOJTpEwE8ajLDC6bVGGqDBjQJs8iqqkTyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ext4: fix a potential assertion failure due to
 improperly dirtied buffer
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com, 
	ebiggers@kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B48=E6=9C=8829=E6=97=A5=E5=91=
=A8=E5=9B=9B 17:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu 29-08-24 16:54:07, zhangshida wrote:
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
> >
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
> One small comment below but regardless whether you decide to address it o=
r
> not, feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> > @@ -1083,11 +1090,22 @@ int ext4_block_write_begin(struct folio *folio,=
 loff_t pos, unsigned len,
> >                       err =3D get_block(inode, block, bh, 1);
> >                       if (err)
> >                               break;
> > +                     /*
> > +                      * We may be zeroing partial buffers or all new
> > +                      * buffers in case of failure. Prepare JBD2 for
> > +                      * that.
> > +                      */
> > +                     if (should_journal_data)
> > +                             do_journal_get_write_access(handle, inode=
, bh);
>
> Thanks for adding comments! I also mentioned this hunk can be moved insid=
e
> the if (buffer_new(bh)) check below to make it more obvious that this is
> indeed about handling of newly allocated buffers. But this is just a nit
> and the comment explains is well enough so I don't insist.
>

Feel free to tell me if you have other issues/nits/ideas.
Because even with your detailed explanation, I may take it in a wrong way. =
:p

And Thanks for your patience.

-Stephen

> >                       if (buffer_new(bh)) {
> >                               if (folio_test_uptodate(folio)) {
> > -                                     clear_buffer_new(bh);
> > +                                     /*
> > +                                      * Unlike __block_write_begin() w=
e leave
> > +                                      * dirtying of new uptodate buffe=
rs to
> > +                                      * ->write_end() time or
> > +                                      * folio_zero_new_buffers().
> > +                                      */
> >                                       set_buffer_uptodate(bh);
> > -                                     mark_buffer_dirty(bh);
> >                                       continue;
> >                               }
> >                               if (block_end > to || block_start < from)
>
> Thanks!
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

