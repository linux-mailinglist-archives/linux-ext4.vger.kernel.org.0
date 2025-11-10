Return-Path: <linux-ext4+bounces-11733-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA4C486E1
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51A734E949F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9D2E62D0;
	Mon, 10 Nov 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUVUnEPR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E692E613B
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797071; cv=none; b=pdDnLNAoKZNhvkGqFsquP5F79Z5pQ3GCAMOq4jsv1WzlqzBr0f6fTLEuB4lpKtrqNyZrC+4Px2J/qw22xrfQE5puzlUay8iqJY0mWsYGW0H0utb+m6Xmr2ORlp5A6wd9/xA8VWrtv1Xq3FzcJLP5twkFNCHCkXXCABT5NbQFNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797071; c=relaxed/simple;
	bh=Z00P5yj/6BlBG2LECtSkPYUoEcjUTeW7cOtDFMB5KUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II2xO08NRj3OL6xPBLKbO375TWzrevo52vj78RCqEHXFenFiTA2u2C4sYxfVgXYzm9RjchK52CRCGZBwdf6PTUf/J+BAeI5tkjBJiX9sE0baKHZxU9BvV/TMSnhiDPm3ayTJfmhgYnILjh1zehJ6+nZraMVCfFBso1TqLcIZNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUVUnEPR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8804650ca32so32384136d6.0
        for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762797067; x=1763401867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIsQzfPqNiam9/uRQAB4qVY7PXY1gsnUSroRNg4mqiE=;
        b=kUVUnEPR7Uo6V3Ip+m+IoTaV2Ddk42qSGNuzIC4AkJOTejbMdwWoCkYXou7YYo5eD9
         bxtYoY99lAoohgy25wUTA7xxJM2YuyuX0XlLzOCRDkgj8SNB5hwsoJSHiRxERxjX/i0s
         NE3gMea7ejVMpa6YjwVm0Ml8bbzuTrLVcOIrozf14IFTLGVZKFxcOVpJ6rJ4j1jpWSBV
         05nIpT4eA/u7QwijagHdSQynx6S4/I9c00ShfW2iMp7OOixFcTobq5lUGRgaZdHTQbJf
         1/p0o6y1udRW6SX4PLVram3EtMLgQ/YF0FA1QVIEw1wFcuxirnNB9SYhZBjnMaGM8OG5
         P+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797067; x=1763401867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIsQzfPqNiam9/uRQAB4qVY7PXY1gsnUSroRNg4mqiE=;
        b=jOjHmP/L/vAfpj9wnc55EW48qKI1JWTmUby3Ogzwvvpi4IXJQXHC9wMuVTbbFCtGx0
         s586q8bb02JtCBS/n/rxN2HGWixTTs50Qwex0ud30d5AxhHLAZhQteaSrIW6JER2el95
         Uipp1Sm5Jrr92biSxGEJhRmuNhCYMzbyAyTrRqJBZv64eAbPkUi9iruRdJ6Qf/Zyug9c
         w6irDabVB9R7MpwC5l/UTaOATQu46GKKKG1MnhJiy6/8BaFHqPRRT4lY9vaLflh3cfjG
         FgZLcN9L/6YxXt6GgWXBOscquDAArSJlgBuPiox09bOvnODGL3TcYxyRRZ/g/70w8Sgw
         tCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVapt/YC6tssFDA2Iur8DbxeH2meyE7Asz5kAqpqhaN0AOyTXAJujRGePQ8DaBRHJaQ1Tl1LrlzFr88@vger.kernel.org
X-Gm-Message-State: AOJu0YxdS/HdwjlEh2u8IraAsSJZ2lsvy5diHJWMSKgPOnPdX87vNLTC
	DQ30bZHQMXjk2+myRydFE+4pb5srO1gLR5ZAK71efHrvw/XAIo6JMayI9fRI4m36U3XFhuBORC4
	7hYBwhlNusmmEJxQEaT7unUcmSCrXYto=
X-Gm-Gg: ASbGncuHKUPOyns+sUcK2reQSX5ocx0RzvsgRr2czqpNh/GCJpPP9/szVHJ7tdJVRC9
	KbAOiuorv2wJ+IwPhUBsRomTXc4Uu+1+B6piFvg01lke6yTVHPVFT1d3KXa9wkhrtGeRkv1Y1y6
	Et6OAxtyoxUlpikfwWzVqiCoe8CPAoFsX7sHBM1j+nLEFqDUQx8b1+kgXdppAq6Hg7D1itt4Bot
	pWME25FhnHeLLBY2VE/8m3MSRpajhvZq/kS53FjfT0c4M4JMyQHXdGLzuiJuzBk/1aIVSCEAxVb
	tVGt9a0/Nwav7TE=
X-Google-Smtp-Source: AGHT+IHlfzZjUojiCofwT2xdQieWm4pKhgoWTnNUkiMHelpNmjoBWeNG1LQzvHirqtBPnh6Lqb3V3zXDj5uiOCT0aBg=
X-Received: by 2002:a05:6214:19ec:b0:882:4be6:9ad2 with SMTP id
 6a1803df08f44-8824be6aa0emr76742326d6.33.1762797067208; Mon, 10 Nov 2025
 09:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
 <176169809851.1424693.14006418302806790576.stgit@frogsfrogsfrogs>
 <CAJnrk1YJP9z2k7zy-NyirMV-Rs8md4WF1MSNJOAfKNaB-Lv_yg@mail.gmail.com> <20251108002412.GM196391@frogsfrogsfrogs>
In-Reply-To: <20251108002412.GM196391@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 10 Nov 2025 09:50:55 -0800
X-Gm-Features: AWmQ_blJtLlJR-Od-xBgamLuZPTfmClynn9INFllZ7OcVAZhGQrEMXqqtcFoP2o
Message-ID: <CAJnrk1Z+yA+jd_wmEz1sxEpFEvqL2VLU6up-DCmMO0ozHOS2HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse_trace: move the passthrough-specific code back
 to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:24=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Nov 07, 2025 at 12:55:39PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:44=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Add tracepoints for the previous patch.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
> > >  fs/fuse/backing.c    |    5 +++++
> > >  2 files changed, 40 insertions(+)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> > > index bbe9ddd8c71696..286a0845dc0898 100644
> > > --- a/fs/fuse/fuse_trace.h
> > > +++ b/fs/fuse/fuse_trace.h
> > > @@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
> > >                   __entry->unique, __entry->len, __entry->error)
> > >  );
> > >
> > > +#ifdef CONFIG_FUSE_BACKING
> > > +TRACE_EVENT(fuse_backing_class,
> > > +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> > > +                const struct fuse_backing *fb),
> > > +
> > > +       TP_ARGS(fc, idx, fb),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(dev_t,                  connection)
> > > +               __field(unsigned int,           idx)
> > > +               __field(unsigned long,          ino)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               struct inode *inode =3D file_inode(fb->file);
> > > +
> > > +               __entry->connection     =3D       fc->dev;
> > > +               __entry->idx            =3D       idx;
> > > +               __entry->ino            =3D       inode->i_ino;
> > > +       ),
> > > +
> > > +       TP_printk("connection %u idx %u ino 0x%lx",
> > > +                 __entry->connection,
> > > +                 __entry->idx,
> > > +                 __entry->ino)
> > > +);
> > > +#define DEFINE_FUSE_BACKING_EVENT(name)                \
> > > +DEFINE_EVENT(fuse_backing_class, name,         \
> > > +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> > > +                const struct fuse_backing *fb), \
> > > +       TP_ARGS(fc, idx, fb))
> > > +DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
> > > +DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
> > > +#endif /* CONFIG_FUSE_BACKING */
> > > +
> > >  #endif /* _TRACE_FUSE_H */
> > >
> > >  #undef TRACE_INCLUDE_PATH
> > > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > > index f5efbffd0f456b..b83a3c1b2dff7a 100644
> > > --- a/fs/fuse/backing.c
> > > +++ b/fs/fuse/backing.c
> > > @@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, vo=
id *data)
> > >
> > >         WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> > >
> > > +       trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
> > >         fuse_backing_free(fb);
> > >         return 0;
> > >  }
> > > @@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struc=
t fuse_backing_map *map)
> > >                 fb =3D NULL;
> > >                 goto out;
> > >         }
> > > +
> > > +       trace_fuse_backing_open(fc, res, fb);
> > >  out:
> > >         pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
> > >
> > > @@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int =
backing_id)
> > >         if (err)
> > >                 goto out_fb;
> > >
> > > +       trace_fuse_backing_close(fc, backing_id, fb);
> > > +
> >
> > If I'm understanding it correctly, the lines above (added from the
> > previous patch) are
> >
> > + err =3D ops->may_admin ? ops->may_admin(fc, 0) : 0;
> > + if (err)
> > +       goto out_fb;
> > +
> > + err =3D ops->may_close ? ops->may_close(fc, fb->file) : 0;
> > + if (err)
> > +        goto out_fb;
>
> That's correct.
>
> > and will also do the close in the out_fb goto. So should the
> > trace_fuse_backing_close() be moved to before the "err =3D
> > ops->may_admin..." line so it doesn't get missed in the "if (err)..."
> > cases?
>
> No.  If either ->may_admin or ->may_close return nonzero, then this
> function drops the active reference to @fb that it obtained from
> __fuse_backing_lookup without calling fuse_backing_id_remove.
> Therefore, the fuse connection retains its mapping of backing_id to a
> fuse_backing object, which means that nothing is closed.
>
> --D

That makes sense, thanks for the explanation.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

>
> > Thanks,
> > Joanne
> >
> > >         err =3D -ENOENT;
> > >         test_fb =3D fuse_backing_id_remove(fc, backing_id);
> > >         if (!test_fb)
> > >

