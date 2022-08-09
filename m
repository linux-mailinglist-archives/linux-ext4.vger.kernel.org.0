Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E791458D93C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiHINP1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbiHINP0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 09:15:26 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D01085;
        Tue,  9 Aug 2022 06:15:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 258305FD04;
        Tue,  9 Aug 2022 16:15:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660050923;
        bh=fdcqua+qoJXqIu4r14phwpmdi3YOAW+/4+VVwDby/VU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Z27zt2FLK8Bm4U7uUg3f+O0mDLY5mqKelx+uy3kx2pDTnG1p5CJoJujcaAV0kBBlK
         GnzbFvGj7XlR4PKFvP2cnjLkEc2L2IrjNxjk47YjwJLTUvE/nSQxszhTx1Td8KFPMf
         1gHE573HWe8jqqrOLhmH2LrjILy83OnuGZPFVgTSYNi1qmAIBusCGXYA8SIOTuuUsU
         oEDPeQLnSGiYoXOulgOEvIru3QrSglp9IIK1exCEhOGicbLKYkAmr7WpeSO9Icupjc
         e/8B2fqVp89vNRhL75+pHCZ5wfDzMH/QtoxQ3F2w0v/PX6B12bxsmvC4esWBmyj6vL
         1Mdq2m9WcP6pQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 16:15:21 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "Jan Kara" <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Thread-Topic: ext2/zram issue [was: Linux 5.19]
Thread-Index: AQHYq8XjXFXUH/5kskS0o+jO/1ewV62mBcyAgAAIiQCAAAf6gIAAAkUAgAAQzICAABoaAIAAFtEA
Date:   Tue, 9 Aug 2022 13:15:15 +0000
Message-ID: <20220809131516.xfezk7kuyu3eelsb@cab-wsm-0029881.sigma.sbrf.ru>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com> <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <20220809102011.pfhfb4k7tdkqvdai@CAB-WSD-L081021.sigma.sbrf.ru>
 <YvJKwCXewHmuWGdh@google.com>
In-Reply-To: <YvJKwCXewHmuWGdh@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A82F33F262AF441B289C8691322C7A0@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/09 10:46:00 #20084579
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Sergey,

On Tue, Aug 09, 2022 at 08:53:36PM +0900, Sergey Senozhatsky wrote:
> > If you make the decision to revert slow path removal patch, I would
> > prefer to review the original patch with unneeded code removal again
> > if you don't mind:
> > https://lore.kernel.org/linux-block/20220422115959.3313-1-avromanov@sbe=
rdevices.ru/
>=20
> Sure, we can return to it after the merge window.

In that case, do I need to send my original patch again?=20

--=20
Thank you,
Alexey=
