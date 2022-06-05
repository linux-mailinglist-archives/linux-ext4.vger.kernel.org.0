Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D173553DA7E
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Jun 2022 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbiFEGbR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Jun 2022 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiFEGbP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Jun 2022 02:31:15 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 23:31:13 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3235ABF
        for <linux-ext4@vger.kernel.org>; Sat,  4 Jun 2022 23:31:13 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F01A06602260;
        Sun,  5 Jun 2022 07:23:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654410211;
        bh=jmN9lwJTlalBZPY9h/MDqE9uMdy8eIz/ZLzlVAJ7lyk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NM7ekKNbFI3rUiEUbpVsr3Tt26BjYaoM66+Pj4XUf9t0NW0XJPNtder0YH0qWIw+5
         B+rbnpI/WGraVXN5JxpVKFv/fmAAMSKNKceDOUWaB/wB3GDyPdw1wzt1hms0BRUZXd
         5W5XnTRfmQ2ZnuBSVAvhTgmjNgluSqzZXmb7kCv/1UqkehLRAeMXPgBq+Pqa28Fxds
         jBIJa1j8VSU0JXCrpMGfgOiUbFrLbBRV8b9QDUXa6L3tehl+4RqbVJY8/ttkBUq4i9
         4LNAwPkFuluFc0+c5sB5z0Sg6/JNmtR4Qfn/G58VXNaE0VX6o/tbeD5C1R6LOAYqzX
         8Y6RFxRq5e2Gg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     amstan@chromium.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Organization: Collabora
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
        <87sfor85j1.fsf@collabora.com>
        <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
        <874k13t0tk.fsf@collabora.com>
        <CAFDdnB143WXo2sz5trAhh2nH=CJ50U3GgkgDe_YJ394=G6ongg@mail.gmail.com>
        <CAFDdnB0uH_KqpN12pE2pyfb-vh_6Uab8Xdcb=NzQQy8ATEL+gA@mail.gmail.com>
Date:   Sun, 05 Jun 2022 02:23:26 -0400
In-Reply-To: <CAFDdnB0uH_KqpN12pE2pyfb-vh_6Uab8Xdcb=NzQQy8ATEL+gA@mail.gmail.com>
        (Stephen E. Baker's message of "Sat, 4 Jun 2022 23:21:46 -0400")
Message-ID: <87tu8zsk69.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Stephen E. Baker" <baker.stephen.e@gmail.com> writes:

> On Sat, Jun 4, 2022 at 8:11 PM Stephen E. Baker
> <baker.stephen.e@gmail.com> wrote:
>>
>> I reached out on the archlinuxarm IRC room and amstan offered the use
>> of his device.
>>
>> When he boots my image he sees:
>> "EXT4-fs (sda2): can't mount with superblock charset: utf8-12.1.0 not
>> supported by the kernel. flags: 0x0."
>
> At amstan's request I created a new root filesystem without casefold,
> and created a loop device with casefold enabled. I am able to boot
> with that filesystem.
>
> zgrep UNICODE /proc/config
> CONFIG_UNICODE=y
> CONFIG_UNICODE_UTF8_DATA=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
>
> mount /dev/loop0p1 /mnt
> [ 679.358591] EXT-fs (loop0p1): can't mount with superblock charset:
> utf8-12.1.0 not supported by the kernel. flags: 0x0

That is great news.  It should allow us to do more investigation.  This
message can unfortunately come from a few error cases, but, most likely,
it is from a failure to get the utf8_data_table symbol.

Since you don't need the module to boot this kernel anymore now that
your rootfs is no longer casefolded, can you try building with
CONFIG_UNICODE=m, modprobe the module, and see if you can mount
/dev/loop0p1 successfully?  If it works, we should be able to discard
the steps being done to generate the bootable uimg and the flashing from
the equation being done at [1].

I've built a vanilla aarch64 kernel and ran over qemu, but I haven't
been able to reproduce it, or notice anything out of the ordinary in the
symbols.  It makes this bug quite puzzling at the moment.

[1] https://github.com/archlinuxarm/PKGBUILDs/blob/30c181baea493effe3bea7b3a2c3ec6ee62b41ae/core/linux-aarch64/PKGBUILD#L201-L228.

-- 
Gabriel Krisman Bertazi
