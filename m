Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872932CC2C3
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLBQu5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 11:50:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33164 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbgLBQu4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 11:50:56 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2Go6Uv001043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 11:50:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BDD28420136; Wed,  2 Dec 2020 11:50:06 -0500 (EST)
Date:   Wed, 2 Dec 2020 11:50:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 02/15] ext2fs, e2fsck: add kernel endian-ness conversion
 macros
Message-ID: <20201202165006.GF390058@mit.edu>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-3-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191606.2224881-3-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:53AM -0800, Harshad Shirwadkar wrote:
> diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
> index 505b3c9c..3c7b2496 100644
> --- a/lib/ext2fs/bitops.h
> +++ b/lib/ext2fs/bitops.h
> @@ -247,6 +247,14 @@ extern errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap
>  #endif /* __STDC_VERSION__ >= 199901L */
>  #endif /* INCLUDE_INLINE_FUNCS */
>  
> +/* Macros for kernel compatibility */
> +#define be32_to_cpu(x)		ext2fs_be32_to_cpu(x)
> +#define le32_to_cpu(x)		ext2fs_le32_to_cpu(x)
> +#define le16_to_cpu(x)		ext2fs_le16_to_cpu(x)
> +
> +#define cpu_to_be32(x)		ext2fs_cpu_to_be32(x)
> +#define cpu_to_be16(x)		ext2fs_cpu_to_be16(x)
> +#define cpu_to_le16(x)		ext2fs_cpu_to_le16(x)
>  /*
>   * Fast bit set/clear functions that doesn't need to return the
>   * previous bit value.

Kernel compatibility #define's should be in e2fsck/jfs_user.h.

The problem with putting them in lib/ext2fs/bitops.h is that this a
published header file which will be pulled in by external userspace
applications which #include <ext2fs/ext2fs.h>.  And we don't want to
have namespace leakage which might interfere with other header files
or the application's definition of these cpp macros.

						- Ted
