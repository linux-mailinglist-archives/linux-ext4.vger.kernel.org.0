Return-Path: <linux-ext4+bounces-3781-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA3956DB6
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5332A28646A
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DF171E69;
	Mon, 19 Aug 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8CKPWmL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7A16B399;
	Mon, 19 Aug 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078628; cv=none; b=WBFN84+szF7LaDmZiK9f/1Reh8KTxHFDmiMaX+GhuWT+YyexNdHFXUPqWR9nHI8E5UNYYEFmuFr0ulO474RkWd8jIEEgPK7E+KRfgpEylB9qJGGXjJRkQq9VvvLmJjcdo9DhhBIZefQiBa3CTaDm0O24lCo7dJHPQN5w1Aumgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078628; c=relaxed/simple;
	bh=/VrtbbhB5xuTgjJzRXsBZ2qu6eNnfqcRtLePfkE5eJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doh6igiFJgxrS7NSxKUnhCsfh+SJqBxSHh8r3W4wc17aJB05tiIharHTM5Fam3Ma01l3G3zvSxpNUeoRr187/QuPqRZqJ3thC8JuZ0qGx3Zpxco4g0UWyJ5bUdOz5+e/uYluYtEM/VV8q/PEQk4PZvXK4di5N0D+Vni2t4Ba1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8CKPWmL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so386977a12.0;
        Mon, 19 Aug 2024 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078625; x=1724683425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuND7K0ekUC0YS6IT+t8ylUpD84fd3Qi1ukfVX2K7jA=;
        b=S8CKPWmLAOzVxhd0991bvlfHHOyayyE5T1GQXmooahd1WECVYZyHNRp3neBSr6gUNE
         6cSEb0TtBx4+QjqfRcw2dHd1BWQEAYg5pmxPG603rKJd+8j9CmIC1I6c5BRye8JIdx5f
         9MYIFg0SVun3tipjOVsT0+vXvhAYKa1X98zdYLOrG/CLbtaaXdlEuWbDsY2AAfsgUiI9
         ZH/O6IFksyThFV+Qk+ti9McIQYaUY2O6Dommzm8xll+/wA9RPyb1B+KBHGS4iw/XH/XE
         gZjNcHlVhPQDpF4ePUS9FbP4poEFgUBVCIbV/38oIABCny1635GlHdgoSxSTpxdZtNeT
         U23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078625; x=1724683425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuND7K0ekUC0YS6IT+t8ylUpD84fd3Qi1ukfVX2K7jA=;
        b=iGuKI2lXtPyp6qyxOyyAfa+IAzKkXxlyxmNJrIJMS5UckV/snud6mJiriaXefdl47l
         28lUwz+SNXVbMBEgarP+5/jsGTigYOUfQ6tRBvedGZUpXqKoLyEt/MqIBolY7GcCHzXq
         GrnZPj18oTwZmcUql/IWCH0J0s1wyLneWZtbbYyx7fZ76pTjR10oxKnBhP4MlIpTu+l4
         HXxM5tJBqajVjRNLZZUPluL/lsA4HaM9/Otl4px9I7wIKbvzURUTIz1wMceYpP7ESM1F
         XfAKwuqDafxnTn9F0GBXes9XzjyYYjuVgjp/Lq5+HgVSWaleyv2jMK2v/Yy+uRD0LLpT
         qF9w==
X-Forwarded-Encrypted: i=1; AJvYcCVMFeUkFatD0StVGr7AcPWUIdt+A32T2aNZTqSBlRaElTBSbQEGRCZiAfwTKXx+IjaSeGMRUrPYvb6Ym2Md+nvQdKckD/a8Au9v/oFPg7bAP8Tjestfiw/rz+SA4NZrjAZ4Umk/wtB0Mg==
X-Gm-Message-State: AOJu0Yzp+8I+WSMy1gFbbrCzqbAdpNvhTpzCKRmORcODNyRCBoPItCbY
	9PqSOXHGLDKZxMWnSUpSK3PMresta+LHw9gnbiC96r0SenLxU8I2Nl40A43ZT3vO9dQKPBLL2CS
	ucQxu/7VASkMZcRmXSq4P69gYF3U=
X-Google-Smtp-Source: AGHT+IE73IQ5JAxt0eECgIIPdmod+EHyCAWPj8hpNshRr2NIZmu68lEsn9ZJxxBY4mjZB1wHnf/RVXTezw/2zogm5Ew=
X-Received: by 2002:a05:6402:40c5:b0:5be:fa53:f74 with SMTP id
 4fb4d7f45d1cf-5befa531123mr4271487a12.0.1724078624824; Mon, 19 Aug 2024
 07:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000742b9d062005fc1c@google.com> <tencent_879750E9E2EF32CD287A2E6C9C2C856F1C0A@qq.com>
In-Reply-To: <tencent_879750E9E2EF32CD287A2E6C9C2C856F1C0A@qq.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 19 Aug 2024 22:43:32 +0800
Message-ID: <CAHB1NajJsvZgF5AdpaaZbnbBYt4L=Atcymag3aqTknLL0PeGTQ@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: Fix null-ptr-deref in jbd2_journal_update_sb_log_tail
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com, jack@suse.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well,In my modest opinion, j_sb_buffer is an internal variable of
jbd2. Directly accessing internal variables from other modules can
degrade the maintainability of the code (for instance, this variable
might be removed at some point in the future). I have just sent
another patch to address this issue [1].

[1]: https://lore.kernel.org/ocfs2-devel/20240819131120.746077-1-sunjunchao=
2870@gmail.com/

Edward Adam Davis <eadavis@qq.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=B8=80 21:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Journal too short will cause ocfs2_check_volume failed, and will set
> journal->j_sb_buffer to NULL in journal_fail_superblock before running
> journal shutdown.
>
> Reported-and-tested-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D05b9b39d8bdfe1a0861f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ocfs2/journal.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 530fba34f6d3..25821077b855 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1077,9 +1077,11 @@ void ocfs2_journal_shutdown(struct ocfs2_super *os=
b)
>         BUG_ON(atomic_read(&(osb->journal->j_num_trans)) !=3D 0);
>
>         if (ocfs2_mount_local(osb)) {
> -               jbd2_journal_lock_updates(journal->j_journal);
> -               status =3D jbd2_journal_flush(journal->j_journal, 0);
> -               jbd2_journal_unlock_updates(journal->j_journal);
> +               if (journal->j_journal->j_sb_buffer) {
> +                       jbd2_journal_lock_updates(journal->j_journal);
> +                       status =3D jbd2_journal_flush(journal->j_journal,=
 0);
> +                       jbd2_journal_unlock_updates(journal->j_journal);
> +               }
>                 if (status < 0)
>                         mlog_errno(status);
>         }
> --
> 2.43.0
>
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

