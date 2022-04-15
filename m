Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11893502028
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiDOBk7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiDOBk6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 21:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91423A88AF
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 18:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49F22B82B23
        for <linux-ext4@vger.kernel.org>; Fri, 15 Apr 2022 01:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86DDC385A5;
        Fri, 15 Apr 2022 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649986709;
        bh=6AOZ+a2CInaxc3b/OZdhMexcuoWOBwQlWeNuP5zL5bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s58RpqmX3sPfNKK8DE9CuXr3liGo4UAMABCmr2IRbYDSeK/uwrGhp9CnSKvhJkqNW
         TEj4qt1bmFp3QO4snlmwShuX2Rk+sfLeWKmO07xH66zpJUYC5sokbFocU1dKYwVpxc
         kNViG5BkuTCnLdONa1Ss++QAgZedBHqkck3PPaugyEvACuPJMnycxMrEINPkN/DEx2
         DNC+TTsGjGbe2oIE6X/q3Y1SRTWqxAX0Z+bJbKmvBL1z2xEZtOGdisCkEXoAciLIgS
         NW/J0gwqVQ6woHnnO7u65n0jNE5ohX8Qxp06/yIomXK6fDR6tV2owpZIqhFeBlogaI
         6ivJBTKRD3Kwg==
Date:   Thu, 14 Apr 2022 18:38:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew G McGovern <matthew@mcgov.dev>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] Ext4 Documentation: ext4_xattr_header struct size fix
Message-ID: <20220415013828.GA16986@magnolia>
References: <pvZcd0oHwCKt92jKr8OMUPT_Y9-UIziM36-74bg8vvEEOKgIW6_KiAdMKw7eRn5L8Tc4AKOSOOcaFmcVCAQ1TYM7gmYI0ZNmNqX_7tkqIE8=@mcgov.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvZcd0oHwCKt92jKr8OMUPT_Y9-UIziM36-74bg8vvEEOKgIW6_KiAdMKw7eRn5L8Tc4AKOSOOcaFmcVCAQ1TYM7gmYI0ZNmNqX_7tkqIE8=@mcgov.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 15, 2022 at 12:50:56AM +0000, Matthew G McGovern wrote:
> From: "Matthew G. McGovern" <matthew@mcgov.dev>
> Date: Wed, 13 Apr 2022 15:48:15 -0700
> Subject: [PATCH] Ext4 Documentation: ext4_xattr_header struct size fix
> 
> An ext4 struct has the wrong array size for a field in the docs.
> 
> - Document correct array size (3) for ext4_xattr_header.h_reserved
> 
> Signed-off-by: Matthew G. McGovern <matthew@mcgov.dev>

Yup.  Thanks for the correction.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/ext4/attributes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/ext4/attributes.rst b/Documentation/filesystems/ext4/attributes.rst
> index 54386a010a8d..871d2da7a0a9 100644
> --- a/Documentation/filesystems/ext4/attributes.rst
> +++ b/Documentation/filesystems/ext4/attributes.rst
> @@ -76,7 +76,7 @@ The beginning of an extended attribute block is in
>       - Checksum of the extended attribute block.
>     * - 0x14
>       - \_\_u32
> -     - h\_reserved[2]
> +     - h\_reserved[3]
>       - Zero.
> 
>  The checksum is calculated against the FS UUID, the 64-bit block number
> 
> base-commit: 96485e4462604744d66bf4301557d996d80b85eb
> --
> 2.25.1
