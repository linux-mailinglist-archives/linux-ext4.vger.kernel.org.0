Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78CCF366A
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfKGR6j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Nov 2019 12:58:39 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38238 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730616AbfKGR6j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Nov 2019 12:58:39 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 55CC52E1552;
        Thu,  7 Nov 2019 20:58:36 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id LeW1YeuNw9-wZAq1p8Q;
        Thu, 07 Nov 2019 20:58:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573149516; bh=ZKdu7DjjRRV4ojXOZkKZpV6414Sz8SohQFYN9jwXu5M=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=fSiWiSwmZIWSDf1pPkRCMufYGjtpdUYoIkhXriAlVklPLO91jvQmjFKlkJ1HXG0gZ
         zb4QTwTE+3I9avjaWF3Ig2isFVpfgsPx7BNulA9xzvM049hlJkSi9xp1pI+oTXBDMO
         t8QPSVnvIQ5z+SdhTZUNfYwI5vEu+NBYXQQKiUu8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id dPaRliDqHU-wZWqNkRQ;
        Thu, 07 Nov 2019 20:58:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>, Jan Kara <jack@suse.cz>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
Message-ID: <c7cb2ea9-2cb8-0af1-3f6d-e5c42d4a016d@yandex-team.ru>
Date:   Thu, 7 Nov 2019 20:58:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157233344808.4027.17162642259754563372.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

+jack@suse.cz into Cc.

On 29/10/2019 10.17, Konstantin Khlebnikov wrote:
> If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
> Delayed allocation extents are freed later in ext4_clear_inode() but this
> happens when quota reference is already dropped. This leads to leak of
> reserved space in quota block, which disappears after umount-mount.
> 
> This seems broken for a long time but worked somehow until recent changes
> in delayed allocation.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   fs/ext4/inode.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..580898145e8f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -293,6 +293,15 @@ void ext4_evict_inode(struct inode *inode)
>   				   inode->i_ino, err);
>   			goto stop_handle;
>   		}
> +	} else if (EXT4_I(inode)->i_reserved_data_blocks) {
> +		/* Deaccount reserve if inode has only delayed allocations. */
> +		err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> +		if (err) {
> +			ext4_warning(inode->i_sb,
> +				     "couldn't remove extents %lu (err %d)",
> +				     inode->i_ino, err);
> +			goto stop_handle;
> +		}
>   	}
>   
>   	/* Remove xattr references. */
> 
