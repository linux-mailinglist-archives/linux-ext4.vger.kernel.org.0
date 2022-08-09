Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89558D753
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiHIKUV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiHIKUV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 06:20:21 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6582BF9;
        Tue,  9 Aug 2022 03:20:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id BEDE55FD05;
        Tue,  9 Aug 2022 13:20:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660040417;
        bh=Y3WuWSvZ7wJgo9yPVxROV6Sg+R19MrMXBZIad/qBeA8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=kUmRLFd/bp4RKyjxGjO9HdaKN8AGjS4J5ZOq5mxKJb2rwUFKw/k0tJO1/Uc0M6hTy
         RA1ls3Wh/ApBjOBOZvxc601AqPDr11NIhqJ6RZ7k45TK3VsDdONeWCR8GK6pEnCOpg
         fEEf+2StUR39k+M1+DJrBhpXQCUcthlsAcW4MHk1uLV/HnlJLf6N2Se3yszwo6jetQ
         eQRe0HpzFRr623MTCZvzjRRIwMsGJ74ptDBHRFwLCKiT/WnTo2o1XcJ+HomhghbZIf
         zUhXyhBXy0dnsAMyK6F4KVWl7TnLq5YoWz68jQ/sHrNdYc5mHNwNnBy7hMkWg1ptl+
         GnmgGZr+h3wKA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 13:20:15 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Ext4 Developers List" <linux-ext4@vger.kernel.org>,
        Aleksey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Thread-Topic: ext2/zram issue [was: Linux 5.19]
Thread-Index: AQHYq8XjXFXUH/5kskS0o+jO/1ewV62mBcyAgAAIiQCAAAf6gIAAAkUAgAAQzIA=
Date:   Tue, 9 Aug 2022 10:20:10 +0000
Message-ID: <20220809102011.pfhfb4k7tdkqvdai@CAB-WSD-L081021.sigma.sbrf.ru>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com> <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
In-Reply-To: <YvImxBsHJcpNzC+i@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B174C30CC06914B82CCEDF3213811B1@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/09 07:32:00 #20083496
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Sergey,

On Tue, Aug 09, 2022 at 06:20:04PM +0900, Sergey Senozhatsky wrote:
> On (22/08/09 18:11), Sergey Senozhatsky wrote:
> > > > > /me needs to confirm.
> > > >=20
> > > > With that commit reverted, I see no more I/O errors, only oom-kille=
r
> > > > messages (which is OK IMO, provided I write 1G of urandom on a mach=
ine w/
> > > > 800M of RAM):
> > >=20
> > > Hmm... So handle allocation always succeeds in the slow path? (when w=
e
> > > try to allocate it second time)
> >=20
> > Yeah I can see how handle re-allocation with direct reclaim can make it=
 more
> > successful, but in exchange it oom-kills some user-space process, I sup=
pose.
> > Is oom-kill really a good alternative though?
>=20
> We likely will need to revert e7be8d1dd983 given that it has some
> user visible changes. But, honestly, failing zram write vs oom-kill
> a user-space is a tough choice.

I think oom-kill is an inevitable escape from low memory situation if we
don't solve original problem with high memory consumption in the user
setup. Reclaim-based zram slow path just delays oom if memory eating
root cause is not resolved.

I totally agree with you that all patches which have visible user
degradations should be reverted, but maybe this is more user setup
problem, what do you think?

If you make the decision to revert slow path removal patch, I would
prefer to review the original patch with unneeded code removal again
if you don't mind:
https://lore.kernel.org/linux-block/20220422115959.3313-1-avromanov@sberdev=
ices.ru/

--=20
Thank you,
Dmitry=
