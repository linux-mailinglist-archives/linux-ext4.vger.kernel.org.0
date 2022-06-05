Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55553D95F
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Jun 2022 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiFEDWD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Jun 2022 23:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiFEDWB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Jun 2022 23:22:01 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BF31167
        for <linux-ext4@vger.kernel.org>; Sat,  4 Jun 2022 20:21:58 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-fb1ae0cd9cso4758382fac.13
        for <linux-ext4@vger.kernel.org>; Sat, 04 Jun 2022 20:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Nu3DzZA3maR5i7R/67aBZU684AfQLdd8fIphTGB4Bk=;
        b=PZzt5YjeGserRR9qUK+xEyb+vAbmwGtU9L+XBSF03Eou9wxXyiAd5ig2vFyptxb526
         lH1iCt69ZmDOOoPT/vpI/uJLG0AaA++FPq4LGE4SNg/nos8TmSJhkCHriBoTmIzpTt1G
         aKkgZihG236CFH3dkF8eEo5J7DVyC73HFBQbceX5EuG+MFYaVMbnkCmRJ4MhVhNdlLBE
         l5SCmCswcj5kxH9wK1ecAhcJDpP/2PVZ1/24qXeTn0Cugv+EaE8FE5I+Xmm7YP36MBcb
         D6BuHfxGxiB0pMhCVQmM3aizNJyLQ8KJ8NnmcrfefBADBsBTaiIVg+Q5xmVBAKsPk5Hr
         kpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Nu3DzZA3maR5i7R/67aBZU684AfQLdd8fIphTGB4Bk=;
        b=a9nkAwaF9SLXcbRJwy38GiK0r9cXh4XwB5ju/Jxk5foJr1mbGlfS8IWf5i4l2uIk4Y
         wgJKjZeTfM6yjV8WmN8TwLq1kSvbhU5lRCsA+ztWCQrnKCxK8mrmW/1n/JDXkKbvJGEX
         imyc9u9zQmHCkecSHOPont3nKiL1zFtKHcc2mnoLCNx5Qnk5IyD88u7aqxY9w/Y882eO
         Yag7zSqq+H8KTT8Xeuqoj5ZjW/Lkhc3QykKzq+UY6xhaF8HfVxEefOPvT9j4J5fHGoob
         isOSWJL7YZZyI5OfEXBTR6poaLpOfglLQG8NozsWIMlCR2TeE38P5fFe+ZYPYO56m8Xj
         pVog==
X-Gm-Message-State: AOAM530Wdc4dLqCSQfs4TToqoukz13Du8I/TanMHpj2BbwYzX/gxIcD/
        378qh38I5xNUkSrseIaZcEdXHkP+gJd54sN2V4c=
X-Google-Smtp-Source: ABdhPJylkWQlB8HUruacUe++/vx15KdLQKvGwV6Hqscsh4hBNum8Ccaw8YwUtwWaosmupp60Lfq5OeDnaO+vcqCmM2U=
X-Received: by 2002:a05:6870:d211:b0:f2:91f4:3dfb with SMTP id
 g17-20020a056870d21100b000f291f43dfbmr9863403oac.226.1654399317680; Sat, 04
 Jun 2022 20:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
 <87sfor85j1.fsf@collabora.com> <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
 <874k13t0tk.fsf@collabora.com> <CAFDdnB143WXo2sz5trAhh2nH=CJ50U3GgkgDe_YJ394=G6ongg@mail.gmail.com>
In-Reply-To: <CAFDdnB143WXo2sz5trAhh2nH=CJ50U3GgkgDe_YJ394=G6ongg@mail.gmail.com>
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Sat, 4 Jun 2022 23:21:46 -0400
Message-ID: <CAFDdnB0uH_KqpN12pE2pyfb-vh_6Uab8Xdcb=NzQQy8ATEL+gA@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        amstan@chromium.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 4, 2022 at 8:11 PM Stephen E. Baker
<baker.stephen.e@gmail.com> wrote:
>
> I reached out on the archlinuxarm IRC room and amstan offered the use
> of his device.
>
> When he boots my image he sees:
> "EXT4-fs (sda2): can't mount with superblock charset: utf8-12.1.0 not
> supported by the kernel. flags: 0x0."

At amstan's request I created a new root filesystem without casefold,
and created a loop device with casefold enabled. I am able to boot
with that filesystem.

zgrep UNICODE /proc/config
CONFIG_UNICODE=y
CONFIG_UNICODE_UTF8_DATA=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m

mount /dev/loop0p1 /mnt
[ 679.358591] EXT-fs (loop0p1): can't mount with superblock charset:
utf8-12.1.0 not supported by the kernel. flags: 0x0
mount: /mnt: wrong fs type, bad option, bad superblock on
/dev/loop0p1, missing codepage or helper program, or other error.

So it seems I can produce the same error after boot that we saw in
early boot, which makes debugging much easier.

Given that is there anything I should be trying / looking for?
