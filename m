Return-Path: <linux-ext4+bounces-4329-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A89987000
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3C92819D9
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B231AAE15;
	Thu, 26 Sep 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LidS/bv+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A351ABED3
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342633; cv=none; b=E+7pIo5/JT70qJLAVFWOPa1UDrsG6ralWKO/LhCoLemZeZ3Uj9mKlAJiiN+pX07wwZO2IG+BQNxIz7moabrqZS/uu7RPQ9y+IwPbJAsydFio/Kcny4pr1WVawbGgPco/j9Qm9+hjMeah3HEUUGN87gheV/fdPZ/Qe2sbrCSbpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342633; c=relaxed/simple;
	bh=OGmxnpcDlZNA/AYOJ/6ULikhRdvi0qFPDR/9HM1/x2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUWGhOMMZKhK6k0CF0mci+0PRT/ZrM7LGKQ4f2xxelvTLBFX4GlQZrY1H7ikBRikSDxRtdnG/7mwl2iVYjz4EhrxNAy4tvIxNU2Z/Pj3hmqAaUySKlb7dwNmVs6CGq1+ZIc5EIfQpwhOPAipUiS9+fHapifj/DfNC2j84HTea10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LidS/bv+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A8994064A
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 09:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727342624;
	bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LidS/bv+hDXm2LTBuDxLewxtGeVPSArt2OKAZhdrr0DdM0S8+bdUULITKUktlRkRn
	 9poIiVmtNi7ULt4jzQrJQfckrrtle7izwA+yTCY4hzzvY+6LqP1HtNUKOr/iGEIC8D
	 nEGoG5L0Mem/vTga5BBDj4EHLLp9JfAmS0AH8w7bJcwq2MRsV6GyAirylW6Hu74509
	 JEwPQHrv4T2WNeul1SZ4y4dkOXxA7W2sYupBa7LHDhE+Isk71HeZdBilTdtNEOvpe4
	 mcNp8WR5rU4m1WyzzFE7pHQQx7nwx+pTzXC1O6iPxknrftBxh+j/e23ve5cEJ0UWQv
	 ujvscCq2WtmSg==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-50113b70fbfso198882e0c.3
        for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 02:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342615; x=1727947415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
        b=oth8/fRaxOWol6yxGfJp3o9Sql6hyINB/ql6pqX4NFPZlgbj72rllXFJ4HS7Q1iLjp
         8jebF29Zrl6zdmHTkUrlC4r1TQs2e7/B6y5FX+ncDSjoUAEBxyq7GODxfMkexteGOS3c
         /IeblTTVjoiaex/BEW+FHnpxaY6JEm0c+J1mqFxUpxX7xoMz+gvpdfql7D2hzJp69wVC
         udLVgryvcufvqbPuYMi7DP6Wtbl21O2vweo+lIzWN1gV0/Oy9ZXpRTc7oedffHsuBa49
         fO4FQTD5H4ITDxOBz1fTR/WVLG/DimVOoNZGTLrnLeuyfMl7+4jJjUZmsQ5xFN+ClBsP
         +m6w==
X-Forwarded-Encrypted: i=1; AJvYcCWj3JS6UVHgiYwc07jA7YYniMbbpdbxmy0dzwxqxBghzzyq9X1O7RgUX/xvIjgNvPeaKVuiSFXAdweI@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXDV5oyH/JXuiYivvH1rZOnbx2ZasgRXIdPG58ky2zyK2eTC6
	cMEvvtYw9rphxCF4HhC8iS/ULu9BUoVFkdKBsBKZrQ7c7ixWlXws+Aj/bUKwxYgf/c4X4d//xGl
	5OXcbIiPrO4ZZmRhsgcFlKNwDBY8smavMLBO1FcGaVKWm2OAonflKiPxTmqpZ7nvPcd2e1k+Z6N
	Ii7aaKOmlt/DllN7cf1QPIDOg1KhySkSUIcR5GNphriITE5TOQUA==
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id 71dfb90a1353d-505c20c9250mr4629406e0c.12.1727342615576;
        Thu, 26 Sep 2024 02:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CdqjXmLGTfMBbg30OzbC8qJPvljC2kVMj5wKnnDPZibQ6RE8OS5y2l4s17+ZabfNSzJgl1eo11+fDbgIx2M=
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-505c20c9250mr4629390e0c.12.1727342615085; Thu, 26 Sep 2024
 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
In-Reply-To: <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 11:23:24 +0200
Message-ID: <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:50=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/26 0:17, Aleksandr Mikhalitsyn wrote:
> > On Wed, Sep 25, 2024 at 5:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-=
b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 78643=
2 blocks
> >>> [   33.888740] ------------[ cut here ]------------
> >>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> >> Ah, I was staring at this for a while before I understood what's going=
 on
> >> (it would be great to explain this in the changelog BTW).  As far as I
> >> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory alloc=
ation
> >> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> >> flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*fle=
xbg_size
> >> - 1) which then confuses things. I think that was not really intended =
and
> > Hi Jan,
> >
> > First of all, thanks for your reaction/review on this one ;-)
> >
> > You are absolutely right, have just checked with our reproducer and
> > this modification:
> >
> > diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> > index e04eb08b9060..530a918f0cab 100644
> > --- a/fs/ext4/resize.c
> > +++ b/fs/ext4/resize.c
> > @@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
> > *alloc_flex_gd(unsigned int flexbg_size,
> >                  flex_gd->resize_bg =3D 1 << max(fls(last_group - o_gro=
up + 1),
> >                                                fls(n_group - last_group=
));
> >
> > +       BUG_ON(flex_gd->resize_bg > flexbg_size);
> > +
> >          flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> >                                          sizeof(struct ext4_new_group_d=
ata),
> >                                          GFP_NOFS);
> >
> > and yes, it crashes on this BUG_ON. So it looks like instead of making
> > flex_gd->resize_bg to be smaller
> > than flexbg_size in most cases we can actually have an opposite effect
> > here. I guess we really need to fix alloc_flex_gd() too.
> >
> >> instead of fixing up ext4_alloc_group_tables() we should really change
> >> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exc=
eeds
> >> flexbg size. Baokun?
> > At the same time, if I understand the code right, as we can have
> > flex_gd->resize_bg !=3D flexbg_size after
> > 5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversized
> > flex bg") and
> > 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex=
_gd()")
> > we should always refer to flex_gd->resize_bg value which means that
> > ext4_alloc_group_tables() fix is needed too.
> > Am I correct in my understanding?
>
> Hi Alex,

Hi Baokun,

>
> These two are not exactly equivalent.
>
> The flex_gd->resize_bg is only used to determine how many block groups we
> allocate memory to, i.e., the maximum number of block groups per resize.
> And the flexbg_size is used to make some judgement on flexible block
> groups, for example, the BUG_ON triggered in the issue is to make sure
> src_group and last_group must be in the same flexible block group.

Huge thanks for explaining this!

Then I guess it's better if you send a patch with your fix.
Feel free to add my Tested-by tag.

Question to you and Jan. Do you guys think that it makes sense to try
to create a minimal reproducer for this problem without Incus/LXD involved?
(only e2fsprogs, lvm tools, etc)

I guess this test can be put in the xfstests test suite, right?

Kind regards,
Alex

>
>
> Regards,
> Baokun
>

