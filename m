Return-Path: <linux-ext4+bounces-4356-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C370B988033
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EDF283BCB
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87C1898F4;
	Fri, 27 Sep 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W6hoZgsW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602117E44F
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425364; cv=none; b=eYD0e0XBKfmeCbtf3mL5OS1W8HsrElXGYT5hwdjI5KaDE3BUwOzoy3Py/3kuWIwyiSfosXVSxOFzVDcAYYmpTwv/xA/3njPRqa9siO85ViUX+kLGJ5pSytuiZTLc6Y5kcHy5Rf9zSvnwxDKgvmapgQ2ZKoBWRwiXqZsFnMYZnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425364; c=relaxed/simple;
	bh=nCofjQvqVmGPYIlxe6BoJ7pyKEd8n5AkGXr9/7mxEVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+oM3kGVzB3pU5/XgryG/MFEaneuVaur+EqlfubD16zzLFgHK8GF4jQlaiDL89F1vFTktuCqxay5GTbfijn9qQZ+SYOAlWj8uDbG9HkcfmOEPDJmPTJKbe9cEvv0QVmHH7JYPQ4121ysAwb1PDBNJcKf//SSfUIXwQkxngAromQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W6hoZgsW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2F8D3F880
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727425360;
	bh=6o4BzwXJTtkXK6Zwi1/UCNsYes9vFKCE8U5Ra86zWN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=W6hoZgsW3IsWPBFFWDInCgJQ7g7d2mDayj+u+k/K/rqR5NSae3bKs8umYiBn+P33x
	 UeAsKrmA5+fR0jD/uIiQK4kXxmEJQ+wqdwz1M2weHAWiCUB/6Wdj+aMq6sX/SZk5uQ
	 xD5XIUUa4Wct0b3CPdSPib9R/kONJsrt95+u4xb6muAP9WZ2GAMwFQmFKs6R71mKXV
	 RD6Zw1bNoE2619WxTW1V6K7Lgn2XZEiYA1D19Xe9o1LD2+FfnmgUuxQWqfGJVYPM5k
	 tvGpWiqS8smUtuw9NHSd+8SGq+YOUE2PTmXg+V0jsi2hdETRmP99S1min3DUJ8f5YA
	 zB+VtuM674M/A==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-502b313cc49so536860e0c.1
        for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 01:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727425355; x=1728030155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4BzwXJTtkXK6Zwi1/UCNsYes9vFKCE8U5Ra86zWN0=;
        b=hIY+Dzu+34B98Uzc6aJk2VxBaoqhjNBODtH46VJXBsJma8nl4uOEQPq/kEaMSN9A+H
         9t0gkjmrh09MEa6STFtbd+sFBI35e3pghGGSf2W/juz/+f97z77mAnEFdij5AGDuq6MX
         FsuV73sZcv+AYE1YE+7dWXUNaXAzjG042VBx8mEicThLTXCzgCYKfFezdsd/J9aYADAv
         W3Dd4xGySRcxMt8OBC1WoGZiqPypSlfIejCiyvsYbPRp+hvnWTSA2gvfbDF+rqHnugsv
         QDpWEjhrixPlnX7QXHOK16bhoqmfqfBaiBW5dEjhlSAwAnCSlnoiRjYS2rWc33Ki+lEQ
         IciA==
X-Gm-Message-State: AOJu0Yz9N371jJVx1E8pXK1tKJMHjLRufV772JSMwkzJkgZ5LuIimcxR
	0SiSEzbHfFtd51tTO+hR0yyseTGT2TM+d1jyeXBQGnmYpqN0SEUGMi0YntnzKNZFXzHZjqWCU6S
	5wFOgf9urRIp5U5WKj8wOhF8ema+wFvieLgrL2G0ZwHTXs8+9aX3swNQe+iv1G4T0wRKNrNcZoi
	3bbXqd4ZXsHTMZpMvXoEcIvqp55UxSDnRgz8Dm6FrMxzE9k5l2lQ==
X-Received: by 2002:a05:6122:2210:b0:4f5:2276:137c with SMTP id 71dfb90a1353d-507818a2492mr1709925e0c.8.1727425354653;
        Fri, 27 Sep 2024 01:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqpL30ZkblX/b944Huzx7lqUbyEFfDe+FJLlF1k9fhXsMfFJZLEfn4eshi1gmcIvh7QJhcfAr0c3paWnuNKZE=
X-Received: by 2002:a05:6122:2210:b0:4f5:2276:137c with SMTP id
 71dfb90a1353d-507818a2492mr1709910e0c.8.1727425354306; Fri, 27 Sep 2024
 01:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927063620.2630898-1-libaokun@huaweicloud.com>
In-Reply-To: <20240927063620.2630898-1-libaokun@huaweicloud.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 27 Sep 2024 10:22:23 +0200
Message-ID: <CAEivzxej-DiXpkcQeYrVVPXbXXnCf=4d3EWyhw8euwBjuB8S9w@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 8:39=E2=80=AFAM <libaokun@huaweicloud.com> wrote:
>
> From: Baokun Li <libaokun1@huawei.com>
>
> Wesley reported an issue:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/resize.c:324!
> CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
> RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> Call Trace:
>  __ext4_ioctl+0x4e0/0x1800
>  ext4_ioctl+0x12/0x20
>  __x64_sys_ioctl+0x99/0xd0
>  x64_sys_call+0x1206/0x20d0
>  do_syscall_64+0x72/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> While reviewing the patch, Honza found that when adjusting resize_bg in
> alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
> flexbg_size.
>
> The reproduction of the problem requires the following:
>
>  o_group =3D flexbg_size * 2 * n;
>  o_size =3D (o_group + 1) * group_size;
>  n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>  o_size =3D (n_group + 1) * group_size;
>
> Take n=3D0,flexbg_size=3D16 as an example:
>
>               last:15
> |o---------------|--------------n-|
> o_group:0    resize to      n_group:30
>
> The corresponding reproducer is:
>
> img=3Dtest.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 8M
> dev=3D`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 248M
>
> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
> to prevent the issue from happening again.
>
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mik=
halitsyn@canonical.com/
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Eric Sandeen <sandeen@redhat.com>
> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc=
_flex_gd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks, Baokun!

JFYI, I'm on the way to submit a test to xfstests suite.

Kind regards,
Alex

> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..397970121d43 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd=
(unsigned int flexbg_size,
>         /* Avoid allocating large 'groups' array if not needed */
>         last_group =3D o_group | (flex_gd->resize_bg - 1);
>         if (n_group <=3D last_group)
> -               flex_gd->resize_bg =3D 1 << fls(n_group - o_group + 1);
> +               flex_gd->resize_bg =3D 1 << fls(n_group - o_group);
>         else if (n_group - last_group < flex_gd->resize_bg)
> -               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group =
+ 1),
> +               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group)=
,
>                                               fls(n_group - last_group));
>
>         flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> --
> 2.46.0
>

