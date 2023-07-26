Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5B763B13
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 17:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGZPaJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjGZPaI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 11:30:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A0268B;
        Wed, 26 Jul 2023 08:30:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58451ecf223so5360817b3.1;
        Wed, 26 Jul 2023 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690385403; x=1690990203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrg+45f8OyZpsYrZsCtiNxFu62qT5zsFL2TVU9KzV9Y=;
        b=IfQOikjTb54JcoQOnhR/3Fq0FlEKu8EnycAFmIQLw1zLeRNxqDoNAwmyVIhZkPF/QT
         +JKHfyxiDvW04jhJpcOFcj0C2PKdMmWCrunMR2AzxG0XfyRJJBMCaQhTRoLGmYm3IYXd
         lGIO55xgdc1kvjTJ6XJE1yNt1XIOO0MtUoCMwigMn0OAQWsmSvhujLJ15v6B0t2yd6pw
         X0MidQmtlMJG6RVSarnypuX/llFdlPvZ6IDlkQkBN9OSZUjnDHzhCWSbuvBlNcp7FRAP
         sfVGXpcdfaxj9zK9FMZMTyJODEA5x5SDojiVCcamwVuuOafYQuYqurs6a8cIWKqW1bCF
         zRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385403; x=1690990203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrg+45f8OyZpsYrZsCtiNxFu62qT5zsFL2TVU9KzV9Y=;
        b=G2ESgXcmeAZgIp9K1GKDJJ4qF4wwuf8kt8xqhwzMHznmcIXejYoiVFyGei4yfHc4NP
         LvISr7TtR2akSqwbWIdDQcsjcsxhBZqlxFJu3iqxPQEmyBJ7ozuLlsAUaSPEFj2rpVRr
         EVjyndX54eSzOvZB+Cje+L8xP+RvJYWrjfLE3f7KBPfNbkEKFTfacBP1KvRY7t+hzg17
         LHKwGeB3vRZdyNPN5KN+uaimZutbcoSwh8C6q1KW12rl81nF48mRItwaYli8V1anOsiL
         ShTH38TKExzEhsJcyRsSG9S2zA5iUYJpKuEc0Sj8qUKCtJj1tYEx11k/YdGAv2hVYirD
         Sd4w==
X-Gm-Message-State: ABy/qLbGFRo5doVjFaOdHucpLh5kj+CwB0sICi/+ZOkJSGHjk16zXged
        L3y3N2+YKJ+Y2itt3G4Xm8iW6qPl8PYTb/aBdxI=
X-Google-Smtp-Source: APBJJlH9c/Cm1Gn1k/bqGcIifEtT5WA6JYO4NWDRh17eGkNuN//LPGYMjb5PrsKWtVwk5jtZLub4b2CzwC+F8JFg/Zw=
X-Received: by 2002:a81:a151:0:b0:584:5e7e:40c1 with SMTP id
 y78-20020a81a151000000b005845e7e40c1mr533351ywg.28.1690385402927; Wed, 26 Jul
 2023 08:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <4919.1690365747@warthog.procyon.org.uk>
In-Reply-To: <4919.1690365747@warthog.procyon.org.uk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 26 Jul 2023 23:29:51 +0800
Message-ID: <CACVXFVM8rcGJu-f+6zOgY8t4KPPR0J=giYD5dnCLL8_XVo234w@mail.gmail.com>
Subject: Re: [dm-devel] Processes hung in "D" state in ext4, mm, md and dmcrypt
To:     David Howells <dhowells@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-ext4@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 26, 2023 at 6:02=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi,
>
> With 6.5-rc2 (6.5.0-0.rc2.20230721gitf7e3a1bafdea.20.fc39.x86_64), I'm se=
eing
> a bunch of processes getting stuck in the D state on my desktop after a f=
ew
> hours of reading email and compiling stuff.  It's happened every day this=
 week
> so far and I managed to grab stack traces of the stuck processes this mor=
ning
> (see attached).
>
> There are two blockdevs involved below, /dev/md2 and /dev/md3.  md3 is a =
raid1
> array with two partitions with an ext4 partition on it.  md2 is similar b=
ut
> it's dm-crypted and ext4 is on top of that.
>
...

> =3D=3D=3D117547=3D=3D=3D
>     PID TTY      STAT   TIME COMMAND
>  117547 ?        D      5:12 [kworker/u16:8+flush-9:3]
> [<0>] blk_mq_get_tag+0x11e/0x2b0
> [<0>] __blk_mq_alloc_requests+0x1bc/0x350
> [<0>] blk_mq_submit_bio+0x2c7/0x680
> [<0>] __submit_bio+0x8b/0x170
> [<0>] submit_bio_noacct_nocheck+0x159/0x370
> [<0>] __block_write_full_folio+0x1e1/0x400
> [<0>] writepage_cb+0x1a/0x70
> [<0>] write_cache_pages+0x144/0x3b0
> [<0>] do_writepages+0x164/0x1e0
> [<0>] __writeback_single_inode+0x3d/0x360
> [<0>] writeback_sb_inodes+0x1ed/0x4b0
> [<0>] __writeback_inodes_wb+0x4c/0xf0
> [<0>] wb_writeback+0x298/0x310
> [<0>] wb_workfn+0x35b/0x510
> [<0>] process_one_work+0x1de/0x3f0
> [<0>] worker_thread+0x51/0x390
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30

BTW, -rc3 fixes one similar issue on the above code path, so please try -rc=
3.

106397376c03 sbitmap: fix batching wakeup

Thanks,
Ming Lei
