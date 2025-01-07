Return-Path: <linux-ext4+bounces-5917-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E1A0359A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BA1882D36
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB8157493;
	Tue,  7 Jan 2025 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY3VKnTp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0A80BFF;
	Tue,  7 Jan 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218740; cv=none; b=ZTVGaB8ojWhip0azgUdPJlO5IzeYuUxuLd3Wu8cnX71r0T63jTBMIaCQZaInrZXqfWzwlp3WcICHj7rTNgHm218h4fMKHUC3SB63spxWRxm2pJzspYCJOo2KhjCPQ2KIOUGxSzfWrwW5n0/hmVt1xupeyq5BpXsqx01qc/6qCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218740; c=relaxed/simple;
	bh=n1RKbzoazEKN4eksbruwN5SvAmk64p2S7bwKiqRsLAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCgTepKeF8uQ++nKLjHb6GlE/da/RJ6tm+WaPPlODmtfkAxPUlDbz0aKe5lRY+zNUP6h2esxav5tEImbUB6TDGk2wXLiPtXziNkxYdbE93qi6UI+ZkgPbyb9p+eOwTg7opmGR0T5/EIy553+0X9vlZ5ILE1X8mQ9Q2BuSv3NDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY3VKnTp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3c47434eso15414650e87.3;
        Mon, 06 Jan 2025 18:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736218736; x=1736823536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVSfD6vM1ybjTDnVinRiIhCJrEnyGL1+g9grDnmo22k=;
        b=ZY3VKnTpQJZ8ZqSS3SPPk+noePc6uEpZK35mTXnaXCDUNNb/Y49x3gx6SJG6POOa51
         eba0QV9OQ36xUM/Uibra2nJ5fZLU9eEKge+jyrsLGDmAmcU4CY6BedSyMkkvdu1OiJrU
         TnsHxF45SPeBbgIhk+mUexdlURZrHX8XelhLjfwayyUkpUZ5Tp1yaby1YhrqJaHZIcoB
         ZqgfHyqVdWrHlrRKqqrVh6SPTLFmFti+I1qyRkkMszYvgfaaSLkZADl3Yu9AvAZ0GpTP
         Rp6HUL0Gz4FxFFXoFq9aiih72Zh03pQyui/lPpBIXic7bSoe93uGyfO7fDoLxCW6KFXh
         zVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218736; x=1736823536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVSfD6vM1ybjTDnVinRiIhCJrEnyGL1+g9grDnmo22k=;
        b=VBi9841wa1scxDJ/dFbecOdgWN99PUTeNPswhr3XAoE9NmNUbgQqL3DCO4aF46Trjz
         r4fD2YkaH/vQGYL+XoOsc2JHcf0TXzJDb9nNDtVkXzCzUDWyj1dd35+Bvm2GVdmVsNcA
         oRzHLlzu6qvm4UtwztmkEBADAvV4up0Wtqmty3c4LLbi4k0I9SWMAHme0dqF0a/IBTzl
         cRlEkMzuT6xSc7J3Jqejtp0miJTQFYqiOq21MKCpZ2ndGRfFFW57rhQmqIhkVosYMUfo
         m4kNIjUSXinCJ2nqW8NB8WB3oA76x+pJ45FV1MRnU/na1m7KQ58urhCHnTSGaR5G5DGJ
         xYFg==
X-Forwarded-Encrypted: i=1; AJvYcCWIp25Qv3F6aJv/32qQS6pU2GD/meB5HXhp8fb/mgWuFwJbyifq0zdQS4lxDEw+kEf9ruUIaHbdjd/o188=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yDr5hoBL+9GhyNq0lNwxkEidNTTS22NZ7ZQ40t4W2R/pkQR3
	ta5RRXrBlg0Dt/aJ3RsHER8+8K06JSJr4J1f8tGGl9KwaiGU2WPl4V2E1PSnYkAPxDuIim33aeN
	9ifXAFS9utQ0cRK+tVDnN05q3cseJq4NaAec=
X-Gm-Gg: ASbGncu/tLr7jCNaidb+lH5W9AHbcHLker8VUGAhgZIkG+tXrHhSdLjyYaPdueSQFeN
	Itmu9N9dbbcDnZA8tOXpuigUtTIXXnKM0o8XDdrk=
X-Google-Smtp-Source: AGHT+IH8sSHUq6RjrVgZcQ5AIVkNUki8cpIRKuVXIRZs6Fe+Qh3YgNakR+bsfquRILa58/h9UsGo5mYz3+Qe4Q5uEOk=
X-Received: by 2002:a05:6512:3ba4:b0:53e:3a43:9245 with SMTP id
 2adb3069b0e04-542295404f9mr18469075e87.28.1736218735393; Mon, 06 Jan 2025
 18:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-6-sunjunchao2870@gmail.com> <dwlsyn3d3fji327ocf6mg3p74lfxxqoxlmhffti5lw4bop4ihr@sseuzwi7dhkd>
In-Reply-To: <dwlsyn3d3fji327ocf6mg3p74lfxxqoxlmhffti5lw4bop4ihr@sseuzwi7dhkd>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 7 Jan 2025 10:58:44 +0800
X-Gm-Features: AbW1kvYZkuLNg_NvOgokIvYYK0QR0ESSZ2E5HtUujJ0t5CJIBjeRzTO6RtP50V0
Message-ID: <CAHB1NahE1K--Ym_hUxW7yzXcrbTQjjXDNV9MViNsRf8c=JqiZA@mail.gmail.com>
Subject: Re: [PATCH 5/7] ext4: Refactor out ext4_da_write_inline_data_begin()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, boyu.mt@taobao.com, tm@tao.ma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2025=E5=B9=B41=E6=9C=886=E6=97=A5=E5=91=A8=
=E4=B8=80 23:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 20-12-24 23:16:23, Julian Sun wrote:
> > Refactor ext4_da_write_inline_data_begin() to simplify its
> > implementation by directly invoking ext4_generic_write_inline_data().
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/ext4/inline.c | 74 ++----------------------------------------------
> >  1 file changed, 2 insertions(+), 72 deletions(-)
> >
> > diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> > index 7eaa578e1021..5dd91524b2ca 100644
> > --- a/fs/ext4/inline.c
> > +++ b/fs/ext4/inline.c
> > @@ -979,78 +979,8 @@ int ext4_da_write_inline_data_begin(struct address=
_space *mapping,
> >                                   struct folio **foliop,
> >                                   void **fsdata)
> >  {
>
> Since there's a single caller of this function, I guess there's no point
> for this wrapper now. Just call ext4_generic_write_inline_data() directly
> from the call site. Otherwise the patch looks good.

Reasonable. I will fix it in the next version. Thanks!
>
>                                                                 Honza
>
> > -     int ret;
> > -     handle_t *handle;
> > -     struct folio *folio;
> > -     struct ext4_iloc iloc;
> > -     int retries =3D 0;
> > -
> > -     ret =3D ext4_get_inode_loc(inode, &iloc);
> > -     if (ret)
> > -             return ret;
> > -
> > -retry_journal:
> > -     handle =3D ext4_journal_start(inode, EXT4_HT_INODE, 1);
> > -     if (IS_ERR(handle)) {
> > -             ret =3D PTR_ERR(handle);
> > -             goto out;
> > -     }
> > -
> > -     ret =3D ext4_prepare_inline_data(handle, inode, pos + len);
> > -     if (ret && ret !=3D -ENOSPC)
> > -             goto out_journal;
> > -
> > -     if (ret =3D=3D -ENOSPC) {
> > -             ext4_journal_stop(handle);
> > -             ret =3D ext4_da_convert_inline_data_to_extent(mapping,
> > -                                                         inode,
> > -                                                         fsdata);
> > -             if (ret =3D=3D -ENOSPC &&
> > -                 ext4_should_retry_alloc(inode->i_sb, &retries))
> > -                     goto retry_journal;
> > -             goto out;
> > -     }
> > -
> > -     /*
> > -      * We cannot recurse into the filesystem as the transaction
> > -      * is already started.
> > -      */
> > -     folio =3D __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NO=
FS,
> > -                                     mapping_gfp_mask(mapping));
> > -     if (IS_ERR(folio)) {
> > -             ret =3D PTR_ERR(folio);
> > -             goto out_journal;
> > -     }
> > -
> > -     down_read(&EXT4_I(inode)->xattr_sem);
> > -     if (!ext4_has_inline_data(inode)) {
> > -             ret =3D 0;
> > -             goto out_release_page;
> > -     }
> > -
> > -     if (!folio_test_uptodate(folio)) {
> > -             ret =3D ext4_read_inline_folio(inode, folio);
> > -             if (ret < 0)
> > -                     goto out_release_page;
> > -     }
> > -     ret =3D ext4_journal_get_write_access(handle, inode->i_sb, iloc.b=
h,
> > -                                         EXT4_JTR_NONE);
> > -     if (ret)
> > -             goto out_release_page;
> > -
> > -     up_read(&EXT4_I(inode)->xattr_sem);
> > -     *foliop =3D folio;
> > -     brelse(iloc.bh);
> > -     return 1;
> > -out_release_page:
> > -     up_read(&EXT4_I(inode)->xattr_sem);
> > -     folio_unlock(folio);
> > -     folio_put(folio);
> > -out_journal:
> > -     ext4_journal_stop(handle);
> > -out:
> > -     brelse(iloc.bh);
> > -     return ret;
> > +     return ext4_generic_write_inline_data(mapping, inode, pos, len,
> > +                                           foliop, fsdata, true);
> >  }
> >
> >  #ifdef INLINE_DIR_DEBUG
> > --
> > 2.39.5
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Julian Sun <sunjunchao2870@gmail.com>

