Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9745384A9
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiE3PWC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbiE3PUy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 11:20:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29211E496
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 07:22:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 187041F42F58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653920518;
        bh=TzgxYWpAfoBjfR6O8nAsv6Bx6kyqPUpBe2il7+4gsvw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iSqwgZbp8bEfMbFBiyYWslZ6xS3su0wtlFeKDdAIeVr4StoHnAoXV6EdWcGrQXemg
         GhRHdTt1tsqXy2VofdGNB4Gx6fhoIj9JZf7b761UJlcN2+ic//osgc1DO2PvcKXhnB
         +S61KBibJf7Dt+9S4htASqC7N76HU6SOza/s/2aHS1m9WH4W2ch5YF01+WSqCRa1Ql
         fC919anWxwimn8hLkqq/zAGowtCDVHPqK5ZIqmsUlt0UqAYiIM4tyHJLw2JKwf3iUd
         vn3Jq5pUnqjsExvre12v19pwpXrN0gauALsaijE4aSbKGMqyl/xxJjV1U8xNK0swb/
         zsPKrlRDZbq8w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Organization: Collabora
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
Date:   Mon, 30 May 2022 10:21:54 -0400
In-Reply-To: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
        (Stephen E. Baker's message of "Sat, 28 May 2022 18:55:45 -0400")
Message-ID: <87sfor85j1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Stephen E. Baker" <baker.stephen.e@gmail.com> writes:

> Hello,
>
> I have a Samsung Chromebook Plus (rk3399-gru-kevin) which boots linux
> off an external ssd plugged into USB. The root filesystem is ext4 with
> unicode support, case folding is enabled only on some directories in
> my home directory.
>
> Since 5.17 the system has been unbootable. I ran a git bisect and it
> pointed to aa8bf298a96acaaaa3af07d09cf7ffeb9798e48a ext4: simplify
> ext4_sb_read_encoding

Hi Stephen,

This series moved the UTF-8 data tables to a kernel module; before it,
the module had to be built-in.

Since you have your rootfs as a case-insensitive filesystem, either the
utf8data module needs to be available in the initramfs or unicode
needs to be built-in.  Are you building your own kernel?

Can you confirm that utf8data.ko exists in your initramfs, and
regenerate it if missing?  Alternatively, make sure that you have
CONFIG_UNICODE=y in your kernel configuration file.

If that doesn't work, can you provide the kernel log?  If you can't
collect the console output, a photo of the screen displaying the error
will suffice.

Thank you!

-- 
Gabriel Krisman Bertazi
