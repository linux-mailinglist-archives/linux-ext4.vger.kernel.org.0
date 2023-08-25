Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4F7880D3
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHYHZM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Aug 2023 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHYHZG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Aug 2023 03:25:06 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949A1FC7
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 00:25:03 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so234856241.3
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692948303; x=1693553103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdJN5qOBEAzRMQv4ZiH23HTVW1e26SNFZ1cPb6I8Yhw=;
        b=ZcHSH1aRopQ6/FnKdzdHgcVtvQMjyWfn7fF07tuA1oZDpgb2CmCjj7l1NDbnHO9VMA
         dBsc0A3uECNiMsE5ZwTcEh36pTVPW9rwhudOYHznq7Eg21exyP8c+9MEOw8whdn4uMdX
         Rp9oSsapFKCDCGFGpbF7p6TsMGG3Gyue3f5w3MU6LIxCBW6jju2HZ9rqWNEd/NFREjBT
         5wD4j9u7U4N0w8qMAbwMd1XUl5KjDr75H82DPevc8zKId0OBHBCOjEwGcHF5TDf1tm+g
         SJsHvnx1skvqSluL3Cl7F41kCSnucMJ/jBih5xaXcXl+WYaS1ETngVqbr+DZ2DjNKNDV
         klbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948303; x=1693553103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdJN5qOBEAzRMQv4ZiH23HTVW1e26SNFZ1cPb6I8Yhw=;
        b=c9sdKkUP8WVjn1N/zNM63mKUfzN2V1CLSQGPRDPaHI6R9GzOsB5I2VbNL98QLMXJ3T
         G4f0HzZhDrsXxi878d4ZQJyRP1AWkxtq5Zumo2UpyHH4didPdXwSj8oK4f2zo8w/2gzY
         EGe0JX96sc9A1p1Mus5fD/6BIDvKdSjfUY9vafvUO1kSzqosYpvXzDEgyunryXfWhuA/
         ivf7tf4EkvFtgfW08BEr1c/k6R7o437ClDqq3VyHW7qlWkVydYqJm0id0IREk1PeIdHP
         qYXGsMROX0j5VVfo8E08mJZnNTB39geL64llG48aCs4rSEaAjXzK37RwaWKhOBk2M0LW
         YR2w==
X-Gm-Message-State: AOJu0YxkoHRzMKtZsLdVHS7deyxC5e/InA9Hmd+rddGFdPwEmKpKxOHv
        5ElgYGcfOdqCW0KAlo8gENCmvFluyT9k3uOTmQsGsuULBvg=
X-Google-Smtp-Source: AGHT+IEpB2+AQl95OLEpugQYpaZxMUlsPX81IIlthrTbpi8bR9E19Eu6SJVJkuj5zrljluez4wfUGiSJx+HLs37VzWY=
X-Received: by 2002:a67:de05:0:b0:44d:4f13:7113 with SMTP id
 q5-20020a67de05000000b0044d4f137113mr14511223vsk.19.1692948302938; Fri, 25
 Aug 2023 00:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230616164553.1090-1-jack@suse.cz> <169107341682.1086009.5390893702477027431.b4-ty@mit.edu>
 <CAOQ4uxh-HCE+Fwat8SyAGF3fcFg-xa_tH9jsxCe8=qPfx73K0g@mail.gmail.com>
In-Reply-To: <CAOQ4uxh-HCE+Fwat8SyAGF3fcFg-xa_tH9jsxCe8=qPfx73K0g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 25 Aug 2023 10:24:52 +0300
Message-ID: <CAOQ4uxiAJ8_zsmUCjFzVOOZi0XQoak8+D4GFp1ADW-+EyL1Jtw@mail.gmail.com>
Subject: Re: [PATCH 0/11] ext4: Cleanup read-only and fs aborted checks
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 25, 2023 at 10:15=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Aug 3, 2023 at 6:23=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> >
> >
> > On Fri, 16 Jun 2023 18:50:46 +0200, Jan Kara wrote:
> > > This series arised from me trying to fix races when the ext4 filesyst=
em gets
> > > remounted read-write and users can race in writes before quota subsys=
tem is
> > > prepared to take them. This particular problem got fixed in VFS in th=
e end
> > > but the cleanups are still good in my opinion so I'm submitting them.=
 They
> > > get rid of EXT4_MF_ABORTED flag and cleanup some sb_rdonly() checks.
> > >
> > > Honza
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [01/11] ext4: Remove pointless sb_rdonly() checks from freezing code
> >         commit: 98175720c9ed3bac857b0364321517cc2d695a3f
> > [02/11] ext4: Use sb_rdonly() helper for checking read-only flag
> >         commit: d5d020b3294b69eaf3b8985e7a37ba237849c390
> > [03/11] ext4: Make ext4_forced_shutdown() take struct super_block
> >         commit: eb8ab4443aec5ffe923a471b337568a8158cd32b
> > [04/11] ext4: Make 'abort' mount option handling standard
> >         commit: 22b8d707b07e6e06f50fe1d9ca8756e1f894eb0d
> > [05/11] ext4: Drop EXT4_MF_FS_ABORTED flag
> >         commit: 95257987a6387f02970eda707e55a06cce734e18
> > [06/11] ext4: Avoid starting transaction on read-only fs in ext4_quota_=
off()
> >         commit: e0e985f3f8941438a66ab8abb94cb011b9fb39a7
> > [07/11] ext4: Warn on read-only filesystem in ext4_journal_check_start(=
)
> >         commit: e7fc2b31e04c46c9e2098bba710c9951c6b968af
> > [08/11] ext4: Drop read-only check in ext4_init_inode_table()
> >         commit: ffb6844e28ef6b9d76bee378774d7afbc3db6da9
> > [09/11] ext4: Drop read-only check in ext4_write_inode()
> >         commit: f1128084b40e520bea8bb32b3ff4d03745ab7e64
> > [10/11] ext4: Drop read-only check from ext4_force_commit()
> >         commit: 889860e452d7436ca72018b8a03cbd89c38d6384
> > [11/11] ext4: Replace read-only check for shutdown check in mmp code
> >         commit: 1e1566b9c85fbd6150657ea17f50fd42b9166d31
> >
> > Best regards,
> > --
> > Theodore Ts'o <tytso@mit.edu>
>
> Hi Jan,
>
> Yesterday I ran fanotify LTP tests on linux-next and noticed a regression
> with fanotify22 which tests the FAN_FS_ERROR event on ext4.
> It's 100% reproducible on my machine (see below).
>
> I've bisected the regression down to this series.

Forgot to say that the good baseline for the test is Christian's vfs.all
branch merged into Linus' master and the regression is after merging
commit 1e1566b9c85 from Ted's tree.

> Not sure if this is an acute regression or just the test needs to be adju=
sted.
>
> Thanks,
> Amir.
>
> # ./fanotify/fanotify22
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> [   29.672163] loop0: detected capacity change from 0 to 614400
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra o=
pts=3D''
> mke2fs 1.46.5 (30-Dec-2021)
> [   30.169795] operation not supported error, dev loop0, sector 614272
> op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 2
> [   30.172411] operation not supported error, dev loop0, sector 586 op
> 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 2
> [   30.176215] operation not supported error, dev loop0, sector 15792
> op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 2
> [   30.189827] operation not supported error, dev loop0, sector 278530
> op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 2
> [   30.247427] EXT4-fs (loop0): mounted filesystem
> a2b5d123-2a7a-44cc-96d4-47119b66a9a9 r/w with ordered data mode. Quota
> mode: none.
> tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
> fanotify.h:129: TINFO: fid(test_mnt/internal_dir/bad_dir) =3D
> 32966134.65ed1cb1.7e82.a4cd38.0...
> [   30.275088] EXT4-fs (loop0): unmounting filesystem
> a2b5d123-2a7a-44cc-96d4-47119b66a9a9.
> debugfs 1.46.5 (30-Dec-2021)
> [   30.339363] EXT4-fs (loop0): mounted filesystem
> a2b5d123-2a7a-44cc-96d4-47119b66a9a9 r/w with ordered data mode. Quota
> mode: none.
> fanotify.h:129: TINFO: fid(test_mnt) =3D 32966134.65ed1cb1.2.0.0...
> [   30.346145] EXT4-fs error (device loop0): __ext4_remount:6465: comm
> fanotify22: Abort forced by user
> [   30.348788] Aborting journal on device loop0-8.
> [   30.350608] EXT4-fs (loop0): Remounting filesystem read-only
> [   30.352403] EXT4-fs (loop0): re-mounted
> a2b5d123-2a7a-44cc-96d4-47119b66a9a9 ro. Quota mode: none.
> fanotify22.c:232: TPASS: Successfully received: Trigger abort
> Test timeouted, sending SIGKILL!
> tst_test.c:1612: TINFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1614: TBROK: Test killed! (timeout?)
