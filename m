Return-Path: <linux-ext4+bounces-4520-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B39927DC
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E971C225C3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D618D62A;
	Mon,  7 Oct 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNeYpzPn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2C18CC16
	for <linux-ext4@vger.kernel.org>; Mon,  7 Oct 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292445; cv=none; b=XtZu1yJblD9Cj23Xq83lhjhmBX4eMWBAgUZYPtcCwv6IBEVYRIuNOsBmZ2KgkpV5gudYcWa9tORI4rRmVUZaFyH6qEmAIKcfs/KsDJ8ECgQIwmZpZg+ANtirvLBhOzueGjO81EBp/4Y2QepGgonig1N38oWjLgpSE5mUGgYCEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292445; c=relaxed/simple;
	bh=e9HlqrNlMM5v6Hkw73yTAbq0uXJFTKcoyI9lU9kNAk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiDQ1Cepmslj/h4/pAUbaMgavudAudgD8GdQJXS4eji80DICUpVSjDtdqqh/2fvZ+F/7RjMORdv+s3h0e60oI0fTRhbbXuypcvzZNinPc66hmGrTtTBFfEp8Q2NG+csUKMLENZEdbvtPGQh62lG3UluQO2P8c3Qn3YHmpofkw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNeYpzPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728292442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU/jVwiA4Y25yIzEGT7Qy83c1BA1Z87gV3bIzZHtaW8=;
	b=RNeYpzPn0tg/xSLcNvAvOuTcTqD2YcmrzyFmjBMcuNsgZadasNVGtRTzqHniqXhsddOmA/
	+X+A4AVEeZ8WiGqAshElDBpKCHJTj81fHSA/Onw6xuYAFABHgyK+AvLHZXeMs+aFxvEoY8
	FI4NaXCWXBB8iUn0S//heZQEY+830BY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-luuhszupNfCDeF2Am6GRVQ-1; Mon, 07 Oct 2024 05:14:01 -0400
X-MC-Unique: luuhszupNfCDeF2Am6GRVQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5e1d13efe2dso1464524eaf.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Oct 2024 02:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728292440; x=1728897240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU/jVwiA4Y25yIzEGT7Qy83c1BA1Z87gV3bIzZHtaW8=;
        b=Ru3MNQr5UcGgX380uBkKPVcOTnSJzzpEoExsZPf0C2IWLxWp1kOuarWebSLW8vuXgb
         EQSK2JF3qkVaagNmvbqCZEOCq3jdLWqUUDX/44Pf1jINoWvjMJIKrxxIG/zVlyg87w/r
         HmDxaJs2ay919wsrMKtQjGXprDk0LRIjKGClH6lf27ddTiiuFBlkYsGjuv/qyoHb/rpS
         5DtPS2dXE/puoRsAFNffWcMgsd+x6B9g/IPX2KWiUD6KkuV+JMP9OYHqNRx7EtG84dAh
         LZ4gnWEND3LC+Sc0DbXwH+egtpj9HiNpmZ/+LBxj+qBdeXg2ZlzaZgS7rjAismTq65cF
         aFyw==
X-Forwarded-Encrypted: i=1; AJvYcCVA0MhtXPstCXXlickzVMuvg1tknTrmf7tacbaCz05E+oZR5PXNYKH+dXjv9tV+Splz+BLEtAJNVr3G@vger.kernel.org
X-Gm-Message-State: AOJu0YyYddvZ4Eq8pAo3eXiryblShjthuWJkV32JtnrH6qv9rMK0/WoA
	ErJ3wqX9Cy495pPI6EZQlnRO/dd7UY8is7fVYb7s0ZLCg35RZEyT1f6vhguBpHuGU5EHjuTWXIC
	qOfY/cA/jl+CcT5wupoKkrCBD0b5/fZA2qj9cqJWnuZiaQTNay6LugNAQkp9C9F0XZd0XcLmquR
	wvu7dEZJ9bx5bH1ok5xqI/A81SLWwjBY9MQoBtN7fG5g==
X-Received: by 2002:a05:6820:a0c:b0:5e1:ea03:928f with SMTP id 006d021491bc7-5e7cc087effmr5196477eaf.7.1728292440545;
        Mon, 07 Oct 2024 02:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHA3Smm8UEhYWZjmLYnCPJgBkxvsCRxSMaLsg7FPmtfmr5Ti4To6AV1+4nKjE6r7bqsgPloC1dRx7YT1zV2EU=
X-Received: by 2002:a05:6820:a0c:b0:5e1:ea03:928f with SMTP id
 006d021491bc7-5e7cc087effmr5196470eaf.7.1728292440257; Mon, 07 Oct 2024
 02:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004221556.19222-1-jack@suse.cz>
In-Reply-To: <20241004221556.19222-1-jack@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Oct 2024 11:13:38 +0200
Message-ID: <CAASaF6wKeEkAWW6SQOur+R7EHwC7YVx_C+DTcQojhOfhUCLvaw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Avoid remount errors with 'abort' mount option
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:16=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> When we remount filesystem with 'abort' mount option while changing
> other mount options as well (as is LTP test doing), we can return error
> from the system call after commit d3476f3dad4a ("ext4: don't set
> SB_RDONLY after filesystem errors") because the application of mount
> option changes detects shutdown filesystem and refuses to do anything.
> The behavior of application of other mount options in presence of
> 'abort' mount option is currently rather arbitary as some mount option
> changes are handled before 'abort' and some after it.
>
> Move aborting of the filesystem to the end of remount handling so all
> requested changes are properly applied before the filesystem is shutdown
> to have a reasonably consistent behavior.
>
> Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Link: https://lore.kernel.org/all/Zvp6L+oFnfASaoHl@t14s
> Signed-off-by: Jan Kara <jack@suse.cz>

In case the mount option isn't getting deprecated right away:
Tested-by: Jan Stancek <jstancek@redhat.com>


> ---
>  fs/ext4/super.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..4645f1629673 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6518,9 +6518,6 @@ static int __ext4_remount(struct fs_context *fc, st=
ruct super_block *sb)
>                 goto restore_opts;
>         }
>
> -       if (test_opt2(sb, ABORT))
> -               ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
> -
>         sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
>                 (test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>
> @@ -6689,6 +6686,14 @@ static int __ext4_remount(struct fs_context *fc, s=
truct super_block *sb)
>         if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
>                 ext4_stop_mmpd(sbi);
>
> +       /*
> +        * Handle aborting the filesystem as the last thing during remoun=
t to
> +        * avoid obsure errors during remount when some option changes fa=
il to
> +        * apply due to shutdown filesystem.
> +        */
> +       if (test_opt2(sb, ABORT))
> +               ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
> +
>         return 0;
>
>  restore_opts:
> --
> 2.35.3
>


