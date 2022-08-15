Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB65930A4
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 16:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHOOYN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHOOYN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 10:24:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3AC23177;
        Mon, 15 Aug 2022 07:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10CDBB80EC2;
        Mon, 15 Aug 2022 14:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9616DC433C1;
        Mon, 15 Aug 2022 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660573449;
        bh=9+OSwESZk0JoF5ImuB7pghcMGPuKhyLplI9B+gA5vdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2SnX9Z/tWEZPf7eB3sIFWBVr+memGk2bq5CEGoIDpmwBSVgXs9qZuE+Saapz0is/
         eXxpGqgrI+pfOM+01LDaR0zv34p056wU2q0+Wpa7m5/jk/UEMNDeB1/z/hYTkIZZJZ
         EAYY5hHKorwcgxaD2dlomWb53/956ioHCtoeMB0sUc5/5izPNyYlApnmVPoKLIpub4
         gmy6S7orfPP1mLn2VBY7IlRJx7FiKtY+qyPXneQ/bc2RR3uQ5mbHDvj0hJ9dGRi+wp
         sJHog1bmr+Cp0C7DYicci03c/bC5a0163D3X+WXzwPv8zmcBfLH7quL8L+ivAKzznt
         pmLFpAeb0d0XQ==
Date:   Mon, 15 Aug 2022 07:24:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        tytso@mit.edu, corbet@lwn.net, bagasdotme@gmail.com
Subject: Re: [PATCH] Documentation: ext4: correct the document about
 superblock
Message-ID: <YvpXCXAsX+697d9x@magnolia>
References: <20220815125233.2040-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815125233.2040-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 15, 2022 at 05:52:33AM -0700, JunChao Sun wrote:
> The description of s_lastcheck_hi, s_first_error_time_hi, and
> s_last_error_time_hi fields refer to themselves, while these means
> referring to upper 8 bits (byte) of corresponding fields (s_lastcheck,
> s_first_error_time, and s_last_error_time). Correct the mistake.
> 
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
>       - s_pad[2]
> -- 
> 2.17.1
> 
