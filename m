Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD02AFF86
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKLGEB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 01:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKLGEB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Nov 2020 01:04:01 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D285C0613D1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 22:04:00 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so3239073pgg.13
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 22:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ovbGZgaEiNcjZ0KYxO02Ls57Y2gfjA4R09sCsp67T5s=;
        b=YCD1ByvTJ4Ea6eiEQA2VRPKzjY3FH6UkMr1XiokjVaObhjrTiT5Qo0hl4lQzSXIw6O
         R1fOmPKWwKjt2UNZUlOMGJS3w57sEAA14RuPtjLFENXbqr4tpe0/ptb/k9GqJhmjCs6X
         S6Qurf/oi+6sd6ezeof1Mg3hwZtr7RA4BpE77uIdJv8LIMLpmzWc09OM18YJe4yrcLG3
         pk0h439aE3oqEkeYQKBF5Pad7fnZG14DoA0cCkBlbUHH1EQLf4uokll3RFRB4zXyGwCa
         rY99ERiA54Nv20NVAwz1sr2Bx+aC9gdExKY5Udr5jBoAFsP2wqAYFKQgFmoyF+En0/VB
         X89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovbGZgaEiNcjZ0KYxO02Ls57Y2gfjA4R09sCsp67T5s=;
        b=IW68DJey1rnU3FUG7ZV10JWFXBIMqimp5wfB4EaiKSuxcb5P0ZoW8VDM+8BVvXjofL
         UOc6rT4LqCPX+xaSlELoA6Ri6qCubISGbUNVGN1UXq9xO3l9JCLoKqWs9Qjn95FiU/qg
         MVOjWQPZqIPQBiEZDtAcIIbGH5P4iIUZJ6MjBImTj4wLKR2ExZ6fGvUTTZrm84hseH3J
         pYCU2FmW8LB05FNaiC8Lmrbs9Qys+gD5vhclQ9yuI1DpOinaWZCaSzTtWjMCcOyo5dVr
         9XmsIzTvC2znq/FW7SX/klhxb73oF6+sBKoVne04YpKX26fFI6IHiIgsYir49+wvd3oX
         pePA==
X-Gm-Message-State: AOAM530wH7xCNdn4r7twoYQud4n1yxIZe8/GXnhPAlzoIjBZlZSRwW67
        O5qViaM0Y/uUCgYvJWpO7ds=
X-Google-Smtp-Source: ABdhPJzs6Nf1dJTc0ZzgGr9GIAgY3xsE3kpKkXz2+aEXnf3Tyu3GXaGT+KAg4eRTcLW1ZVQoB24eXQ==
X-Received: by 2002:a63:b55e:: with SMTP id u30mr23979579pgo.381.1605161039972;
        Wed, 11 Nov 2020 22:03:59 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q23sm4766950pfg.192.2020.11.11.22.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 22:03:59 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:03:53 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Harshad Shirwadkar <harshads@google.com>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: Re: [PATCH] ext4: handle dax mount option collision
Message-ID: <20201112060353.db4ky4ulug3eegst@xzhoux.usersys.redhat.com>
References: <20201111183209.447175-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111183209.447175-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 11, 2020 at 10:32:09AM -0800, Harshad Shirwadkar wrote:
> Mount options dax=inode and dax=never collided with fast_commit and
> journal checksum. Redefine the mount flags to remove the collision.

Tested OK.

Thanks for the quick fix.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Fixes: 9cb20f94afcd2 ("fs/ext4: Make DAX mount option a tri-state")
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/ext4/ext4.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1b399cafb15a..bf9429484462 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1231,13 +1231,13 @@ struct ext4_inode_info {
>  						      blocks */
>  #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
>  						      file systems */
> -#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
> -#define EXT4_MOUNT2_DAX_INODE		0x00000010 /* For printing options only */
> -
>  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
>  						specified journal checksum */
>  
>  #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
> +#define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
> +#define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
> +
>  
>  #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
>  						~EXT4_MOUNT_##opt
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

-- 
Murphy
