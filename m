Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C45A51AA
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiH2Q0W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiH2Q0U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 12:26:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072527DF77;
        Mon, 29 Aug 2022 09:26:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 702994B7;
        Mon, 29 Aug 2022 16:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 702994B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661790379; bh=gwFauWkgqqgf0H4PQVp5F5OjogdUzmVvJgS+PqOMzBE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QWpE8BhSYiVVEwwcKtyMOF4N/lCcjt18vYX9IN+UI4y6lZUHPhqn0XakBMmk/ZqXI
         5l445EvymDaNDToU9NijeQpTiZY7VTLonqyj8dRTBaxBl5r2KdVoGEKA35QymQ2RVh
         digyjS1JexUvuCrkpKSmd9aNesH0bb9G3aa9f5sYKLp3q9IcdCu8bm7Y4oSD4GlVxi
         tMkTV/PoP55wFIJnVsl82VhGqFIEJWx8a+CvAFm+M0xvJ0IOUG/e9ES5SHspYJWmmD
         pOa9jzAxSkp/yRzF4nguVNzw8I5bid/VFlXDkDOjDlZzMg0Amt6BkiiRNp33yyzBuz
         kIe1u+zJcXuaA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     JunChao Sun <sunjunchao2870@gmail.com>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tytso@mit.edu, bagasdotme@gmail.com,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: correct the document about superblock
In-Reply-To: <20220815125233.2040-1-sunjunchao2870@gmail.com>
References: <20220815125233.2040-1-sunjunchao2870@gmail.com>
Date:   Mon, 29 Aug 2022 10:26:18 -0600
Message-ID: <875yibqamt.fsf@meer.lwn.net>
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

JunChao Sun <sunjunchao2870@gmail.com> writes:

> The description of s_lastcheck_hi, s_first_error_time_hi, and
> s_last_error_time_hi fields refer to themselves, while these means
> referring to upper 8 bits (byte) of corresponding fields (s_lastcheck,
> s_first_error_time, and s_last_error_time). Correct the mistake.
>
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>  Documentation/filesystems/ext4/super.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
> index 268888522e35..0152888cac29 100644
> --- a/Documentation/filesystems/ext4/super.rst
> +++ b/Documentation/filesystems/ext4/super.rst
> @@ -456,15 +456,15 @@ The ext4 superblock is laid out as follows in
>     * - 0x277
>       - __u8
>       - s_lastcheck_hi
> -     - Upper 8 bits of the s_lastcheck_hi field.
> +     - Upper 8 bits of the s_lastcheck field.
>     * - 0x278
>       - __u8
>       - s_first_error_time_hi
> -     - Upper 8 bits of the s_first_error_time_hi field.
> +     - Upper 8 bits of the s_first_error_time field.
>     * - 0x279
>       - __u8
>       - s_last_error_time_hi
> -     - Upper 8 bits of the s_last_error_time_hi field.
> +     - Upper 8 bits of the s_last_error_time field.
>     * - 0x27A
>       - __u8

Applied to the docs tree, thanks.

jon
