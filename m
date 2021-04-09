Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06635A816
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhDIUpI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 16:45:08 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhDIUpH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 16:45:07 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGQzj-1lLHMv16PV-00GmKb for <linux-ext4@vger.kernel.org>; Fri, 09 Apr
 2021 22:44:52 +0200
Received: by mail-ot1-f53.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so6960066oto.2
        for <linux-ext4@vger.kernel.org>; Fri, 09 Apr 2021 13:44:52 -0700 (PDT)
X-Gm-Message-State: AOAM5339L3yXVVQsJ1Olh62GmBvmHbVuNdXV2FxkL+2peJSC1qizvGnz
        k9lKoGfO/XtUkZT4y8NBjpBp6vdpxcMiovRQ0yI=
X-Google-Smtp-Source: ABdhPJxU+rBi0mGEwUX9aAHSirkrZuwzwNeHi4q+xFtv2b8iubqzn/uo2welcN6tkvABpPLb3rn5L1OVea6z3JrE5wo=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr13660259otk.305.1618001091031;
 Fri, 09 Apr 2021 13:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <202104100225.GIF5USvR-lkp@intel.com>
In-Reply-To: <202104100225.GIF5USvR-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Apr 2021 22:44:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0noWaAQV=cqXhLuEXC_zr35Bb45PiLhgE3bXqFnNtyQA@mail.gmail.com>
Message-ID: <CAK8P3a0noWaAQV=cqXhLuEXC_zr35Bb45PiLhgE3bXqFnNtyQA@mail.gmail.com>
Subject: Re: [ext4:dev 9/17] fs/ext4/fast_commit.c:1738:5: warning: format
 specifies type 'int' but the argument has type 'unsigned long'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GmHmDOWADxWL5ogzC0hlkWC/a55s2VURWjUFQUXbclFCFUjJ8go
 E/lZ9hV5Yxumfvk3cnQiwfbefAmUQdwARs5rUoxsOilOjG1RsOaI+z3P2reHTsSe4KKcxEb
 /vempkI8kb85soMy0vdJxWxbT9Et5bl5a/XqwgLrhO9/BcscP8uI+hBHxD0B6SlgWf2swg9
 5MOmlIE/Fz9EsLO51IlkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mG1wwEU8ph4=:Nm3XdgEJIFU8Eskom6HZHb
 iN+IRAaCOAzBk7ft5X1xw8Aj2+LrVGmHsumZIIFdYabCgvB4+f+BWV9SBWHbEx8o+YHtYYwz1
 DnmumpfelxBAjnMQbw5uQTmyCj42u9agfkjCWpx+uOIFxDI9decd93RhW2ks9q+Q6nba2kEVV
 6lJUm4e/EDXKW6kaqAKRFFbQZTcmpwhJipwN6cvhVcp6hC/dtUv4ly7ouryxh5xScrHekcshC
 6eU+0oablPqgqSC4AE1OuKyFLrfwFmD0/inq8eCvTQGVQvFWvaL1IQULRczR9lohAX2sfmXXS
 9vfaBIQfnrDYsX1j49yX2EGFWs41SoeLYKo9LMYYJUmSC2ki7Dla3Pm1mqdE8ZLavqS+VrYF8
 pLFhnURvHeA2VUeMbuj2/BD2ujroGKuVXySf53zPI4fsZgP6/kYdf1nVwk82xsTeLmzyWCSvA
 9YAtMWNFTdWo1EWOCJprz/QU6g9LPqdQC6bAdnriTlv0IoXt5JzgLqsNiQHG6U4inBrkvrgeS
 9Cel4d39cgzKUDye3u5rqulMoQ49MB1Rsv3TgpnkQbzNyjbz64WYRIae/ZUEBnepf4xt0e7n4
 c3tTgeVJB4R4SYFk0Y1jURNNdwPv99gdta
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 9, 2021 at 8:59 PM kernel test robot <lkp@intel.com> wrote:

>
> All warnings (new ones prefixed by >>):
>
> >> fs/ext4/fast_commit.c:1738:5: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
>                                    map.m_flags & EXT4_MAP_UNWRITTEN,
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/jbd2.h:64:51: note: expanded from macro 'jbd_debug'
>    #define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
>                                               ~~~    ^
>    include/linux/printk.h:140:17: note: expanded from macro 'no_printk'
>                    printk(fmt, ##__VA_ARGS__);             \
>                           ~~~    ^~~~~~~~~~~
>    1 warning generated.
> --
> >> fs/jbd2/recovery.c:256:54: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
>                    jbd_debug(3, "Processing fast commit blk with seq %d");
>                                                                      ~^
>    include/linux/jbd2.h:64:44: note: expanded from macro 'jbd_debug'
>    #define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
>                                               ^~~
>    include/linux/printk.h:140:10: note: expanded from macro 'no_printk'
>                    printk(fmt, ##__VA_ARGS__);             \
>                           ^~~
>    1 warning generated.
>

I sent a patch now. For some reason I ended up testing with -Wempty-body enabled
but all -Wformat warnings disabled when I tested this before sending.

        Arnd
