Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566550356B
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Apr 2022 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiDPJAp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Apr 2022 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiDPJAp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 16 Apr 2022 05:00:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626FCFA202
        for <linux-ext4@vger.kernel.org>; Sat, 16 Apr 2022 01:58:14 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 963902CC;
        Sat, 16 Apr 2022 08:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 963902CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650099492; bh=OhkediGcyvdQTScZxtwjgXYdQ0PSAnpundIuOBxllNg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MyipeEeFbwS2Ds2yQBHwTfSagmzpaOURNBjU50SNz4FlPw/vjcAne/KHqUJdFtFhl
         eohzz7Jjqfh5D7Nx2ZjqpURf2AVxnkrH4KuD/n4gTuPX2rmVzF8C0o+g2XeqRcZ0rA
         wYDSX6RhhOcLI+pZNcKEWu+FFlOW09/Ph5z3ruQYTA5w0reUbD13mUk20AkAAspwG+
         CcPu6t+1uqNp8kD5QBWf3I4rez54xy8VKtdE0rpmpsy7GEM8/gA//W3j56NHqXSI+r
         LXngFgBYVrGbF4kAx453c04sDnFaQPTT3d6VdQVdF4P3lWDLFMnEumw9firF9dTnh+
         +pxZo7RhCfiyA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] ext4, doc: Fix incorrect h_reserved size
In-Reply-To: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com>
References: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com>
Date:   Sat, 16 Apr 2022 02:58:08 -0600
Message-ID: <87ee1x2yn3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"wangjianjian (C)" <wangjianjian3@huawei.com> writes:

> According to document and code, ext4_xattr_header's size is 32 bytes, so
> h_reserved size should be 3.
>
> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
> ---
>  =C2=A0Documentation/filesystems/ext4/attributes.rst | 2 +-
>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/ext4/attributes.rst=20
> b/Documentation/filesystems/ext4/attributes.rst
> index 54386a010a8d..871d2da7a0a9 100644
> --- a/Documentation/filesystems/ext4/attributes.rst
> +++ b/Documentation/filesystems/ext4/attributes.rst
> @@ -76,7 +76,7 @@ The beginning of an extended attribute block is in
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Checksum of the extended attribute bloc=
k.
>  =C2=A0=C2=A0=C2=A0 * - 0x14
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - \_\_u32
> -=C2=A0=C2=A0=C2=A0=C2=A0 - h\_reserved[2]
> +=C2=A0=C2=A0=C2=A0=C2=A0 - h\_reserved[3]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Zero.
>

So this patch looks whitespace-damaged, please be sure that you can send
applyable patches to the list.

Beyond that, though, while you're in the neighborhood, please fix the
unnecessary underscore escaping (i.e. s/\_/_/).

Thanks,

jon
