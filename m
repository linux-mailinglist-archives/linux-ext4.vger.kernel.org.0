Return-Path: <linux-ext4+bounces-5886-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C66A01119
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jan 2025 00:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D5B3A4764
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 23:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074231BEF73;
	Fri,  3 Jan 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjNIaXLw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7976192D6A
	for <linux-ext4@vger.kernel.org>; Fri,  3 Jan 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735948089; cv=none; b=Oqmxd6J/v+IFloM8SiPxgMlXC8jDiKhXQ/zdIjHndYDcko8YC2fgG/ZQAoaI/DEIifhD8ObhKJvlDFDW5XNqiIFVXW+8MqZ8OirVwfUN8RU6d39D76xQ7x27WqY878cBhDSL+Mu5W57kW4rA3zSDs92EyzkaiESv6Dmw3EJET70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735948089; c=relaxed/simple;
	bh=QUcQq2Xy2XP3yy21dwr7x0mNc3p1b004Pvm56helC1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eANlyrIcak5KtiC0NNNEkzW9dH8KymOUnkm9BhyR1tnhnqj9TBJ6lLmHJrbZ4iqyHgmGnIrjkxj8rI4vjCKkdDPbabOVyy+Q10OIxcO5s8hw0jH6T9+oUTQb9SjCMyyaElLTrLkO6n3B5mjY83X7TdKgVQ8+XwvONgVkiY68uLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZjNIaXLw; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-518957b0533so4107985e0c.1
        for <linux-ext4@vger.kernel.org>; Fri, 03 Jan 2025 15:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735948087; x=1736552887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA1LFsYrRFbGWaUD2vlAFi1tXnlB/fIarDiiv3QVltg=;
        b=ZjNIaXLwu6JtUQmMTYsf85HggfGrSHJERrVQvYp0pgT/mfGDm+eER3KnKAQVWHDY3N
         GOJdJ1C6gxan3R6X7pwLYxSaQ691T4c4txGhHjGgdUc6d9HPQ6N3VIp6nfZdJ0Qbthuz
         mrlbAxyS//n3PD8NKLpr+3gIKSitjN3qX1+0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735948087; x=1736552887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA1LFsYrRFbGWaUD2vlAFi1tXnlB/fIarDiiv3QVltg=;
        b=MHcfpGILUmOXVY4jZjH6n3sIhJb2a+YsUvGMJ/vNNYb5jGmRd0hhQDvHuEuVnyFZKq
         EJoxyFVHgRIMPYsfasMnvhqClSr4Ji0QzIdQlvOm5GxjP7oetDT4ctqT/J9QwIto7RKC
         bXwOIALgRioeQY7JNf36XfpBMrCB2pJD1jN7OVFCYb0XlUzZVFMJbxBgj/1crRedy1NA
         ikwh/rc8CFKHn8FEh0H7lY7rXHUOaKXoXy8gLsT9vxn7gNb8+A79qkyWrSxUoddSEaVT
         +lIE0cfnx5ANuusInTAxlnc2HH9fKcj1lPGw0qZfANyf4LuLhdR+2ILRtSiKKRuWxBZm
         MRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcxLyRY7QL40nbBc+1qsQpkfh+EtHLM2S+2iWP8gg8G379sHR2sDfYtvte9KktnKUlf3jtaix69+6H@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvNHHrwL+vwQNXstKdLRTJ4usuOOgr+dKRrJxm2liieQ+Do4w
	tkg6G+M9HFeaSo2wSAiLRjYAjog4uuqkxpIe59gIjlkPpwqmI28WaxtVDMNZN4pTl5TlYD8cxnt
	9mux+5m9EtobRFB1XJ9teq8qn7rxAn6GawNim
X-Gm-Gg: ASbGnctENMM8u2LnxeZ24GO0vfW8JpuQLLCuDq3+K+r7MgyhQmLflCi3tIf4uywxeKc
	rOM4fhbXe1Raz1qwgh8xfflLb/N6n5Ii44RMbDadRbiAUXClWiC/TaJp7S9kglFxZl8bkLaY=
X-Google-Smtp-Source: AGHT+IHD0UTaqPazUvZQMUd0XD0x0A0esjy51GuiaxFlInvIFXdpwukStBlKvELQxN8qlRCp0mgTP0cpqX4rgX4nq1s=
X-Received: by 2002:a05:6102:3f0f:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4b2cc45b62bmr38922182137.21.1735948086816; Fri, 03 Jan 2025
 15:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830185921.2690798-1-gwendal@chromium.org>
 <20240912091558.jbmwtnvfxrymjch2@quack3> <20241025025355.GR3204734@mit.edu>
In-Reply-To: <20241025025355.GR3204734@mit.edu>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Fri, 3 Jan 2025 15:47:55 -0800
Message-ID: <CAPUE2usUprLQboD74x+_137fVmsYVmFULdqKSXG9wM79dXLE-Q@mail.gmail.com>
Subject: Re: [PATCH] tune2fs: do not update quota when not needed
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, uekawa@chromium.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:53=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Thu, Sep 12, 2024 at 11:15:58AM +0200, Jan Kara wrote:
> > On Fri 30-08-24 11:59:21, Gwendal Grignou wrote:
> > > Enabling quota is expensive: All inodes in the filesystem are scanned=
.
> > > Only do it when the requested quota configuration does not match the
> > > existing configuration.
> > >
> > > Test:
> > > Add a tiny patch to print out when core of function
> > > handle_quota_options() is triggered.
> > > Issue commands:
> > > truncate -s 1G unused ; mkfs.ext4 unused
> > >
> > > | commands                                                | trigger |=
 comments
> > > +---------------------------------------------------------+---------+=
---------
> > > | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
> > >                   Quota not set at formatting.
> > > | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
> > >                   Already set just above
> > > | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
> > >                   Disabling a quota option always force a deep look.
>
> I'm not sure why disabling a quota should always "force a deep look"?
> What was your thinking behind this change?
To execute the same code path, in particular, when we disable
`prjquota`, ext2fs_clear_feature_project() is always called, even when
the quota inodes were already removed.

Rereading the code, that seems unnecessary, so Jan's solution is indeed bet=
ter.

Sending a V2 shortly.


Gwendal.
>
> > Why don't you do it like:
> >
> >       for (qtype =3D 0 ;qtype < MAXQUOTAS; qtype++) {
> >               if (quota_enable[qtype] =3D=3D QOPT_ENABLE &&
> >                    *quota_sb_inump(fs->super, qtype) =3D=3D 0) {
> >                       /* Need to enable this quota type. */
> >                       break;
> >               }
> >               if (quota_enable[qtype] =3D=3D QOPT_DISABLE &&
> >                   *quota_sb_inump(fs->super, qtype)) {
> >                       /* Need to disable this quota type. */
> >                       break;
> >               }
> >       }
> >       if (qtype =3D=3D MAXQUOTAS) {
> >               /* Nothing to do. */
> >               return 0;
> >       }
>
> I like Jan's suggestion here, and this could easily just be done at
> the beginning of handle_quota_options(), replacing what's currently
> there:
>
>         for (qtype =3D 0 ; qtype < MAXQUOTAS; qtype++)
>                 if (quota_enable[qtype] !=3D 0)
>                         break;
>         if (qtype =3D=3D MAXQUOTAS)
>                 /* Nothing to do. */
>                 return 0;
>
> It results in simpler and cleaner code, I think....
>
>                                           - Ted

