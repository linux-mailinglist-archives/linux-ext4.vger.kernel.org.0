Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6089D17B4D0
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 04:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFDRt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 22:17:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42189 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFDRt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 22:17:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id f5so378567pfk.9;
        Thu, 05 Mar 2020 19:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xo9nEuabIYuceOGMah6qpuhpoEbv6aajq9SnDkIO+FY=;
        b=lIAaYs3ppSoS7o6sb1sdW+16vZiCgmKikSc0IrvBzVWAR66mo53oCgw4bzQtkjbbzj
         ff4xOi3P27NaP3YX2LrovyPDy2O53xWnHTrkWqalpw3tzXRTRlrWe2NuWv/7ahPTZ3GL
         uyFUUvwp91hMlufa6+D+TLGjlXEqbgRbBj+AXL7RgSh/NRtS1u60iIrpMf/tYmExwrJR
         L0Bu8S3ZCZQIgdLjGj8OcMXFxP/4Z1BippZTtzIT6eynbr5bogPnjwnXY7H8VtAAfTr1
         0LZHYHRNZya09MqtFWJ8PmhwZSkeJ0pEq+UQMQo1lFmQorwCGrZDttgDv8yuR4BaYUGG
         GLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xo9nEuabIYuceOGMah6qpuhpoEbv6aajq9SnDkIO+FY=;
        b=eG1nqo498OPq15nLO4NY1gz2hH2e7khRgbClIU0dESk6CE6eViDrJrx76Yge+C0+gi
         CEqjTkwD1ZCIlulvmEROSx/oJDEBdRwzQ3HbNgKS3i8IdQ42/6wVzluq23NDjelGQzwR
         Y0pSuGdwGcV+D7uTbSsjuWI8f2Rc63ofyzyq9r69otpAuBRkTDyhtSZ+ODrup8BatPcz
         Tm6SKOTT1YNo7DRP+5y3q5eFsNLSv20ukogL03/v1EhWfZBFAtjGiEN1Ynb4PQfYTeSE
         4YCmPt7tZBSIcVGGYWGJNrknSixiu4XFkv2OQLDLf6cZ0+bCCZi6wJwWqyVbg3kvrFfC
         oUcg==
X-Gm-Message-State: ANhLgQ1MtsNiuCL6BiC8GPRLBZSV5ugzxEJ5od+7bvTYeMHrG5e8ghwy
        nm3d1O2slVKFrFyQtQqzByO4ESYm
X-Google-Smtp-Source: ADFU+vuOcXk1o7tFatRTS6tMsZHY9SSotaqSr8FeL1agRRtULwceOFWLw5AwaxTpcwddwfdCM2aLqQ==
X-Received: by 2002:a63:574c:: with SMTP id h12mr1302060pgm.424.1583464666675;
        Thu, 05 Mar 2020 19:17:46 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s23sm7412112pjp.28.2020.03.05.19.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 19:17:46 -0800 (PST)
Subject: Re: [PATCH] ext4: mark extents index blocks as dirty to avoid
 information leakage
From:   brookxu <brookxu.cn@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org
References: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Message-ID: <ccfb3a62-f0dd-4bca-0c78-54f78d418815@gmail.com>
Date:   Fri, 6 Mar 2020 11:17:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

PING

brookxu wrote on 2020/3/3 16:51:
> From: Chunguang Xu <brookxu@tencent.com>
>
> In the scene of deleting a file, the physical block information in the
> extent will be cleared to 0, the buffer_head contains these extents is
> marked as dirty, and then managed by jbd2, which will clear the
> buffer_head's dirty flag by clear_buffer_dirty. However, when the entire
> extent block is deleted, it is revoked from the jbd2, but  the extents
> block is not redirtied.
>
> Not quite reasonable here, for the following concerns:
>
> 1. This has the risk of information leakage and leads to an interesting
> phenomenon that deleting the entire file is no more secure than truncate
> to 1 byte, because the whole extents physical block clear to zero in cache
> will never written back as the page is not redirtied.
>
> 2. For large files, the number of index block is usually very small.
> Ignoring index pages not get much more benefit in IO performance. But if
> we remark the page as dirty, the page is then written back by the system
> writeback mechanism asynchronously with little performance impact. As a
> result, the risk of information leakage can be avoided. At least not wrose
> than truncate file length to 1 byte
>
> Therefore, when the index block is released, we need to remark its page
> as dirty, so that the index block on the disk will be updated and the
> data is more security.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  fs/ext4/ext4.h      | 1 +
>  fs/ext4/ext4_jbd2.c | 8 ++++++++
>  fs/ext4/extents.c   | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 61b37a0..f9a4d97 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -644,6 +644,7 @@ enum {
>  #define EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER    0x0010
>  #define EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER    0x0020
>  #define EXT4_FREE_BLOCKS_RERESERVE_CLUSTER      0x0040
> +#define EXT4_FREE_BLOCKS_METADATA_INDEX        0x0080
>  
>  /*
>   * ioctl commands
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 1f53d64..7974c62 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -275,7 +275,15 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
>          ext4_set_errno(inode->i_sb, -err);
>          __ext4_abort(inode->i_sb, where, line,
>                 "error %d when attempting revoke", err);
> +    } else  {
> +        /*
> +         * we dirtied index block to ensure that related changes to
> +         * the index block will be stored to disk.
> +         */
> +        if (is_metadata & EXT4_FREE_BLOCKS_METADATA_INDEX)
> +            mark_buffer_dirty(bh);
>      }
> +
>      BUFFER_TRACE(bh, "exit");
>      return err;
>  }
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 954013d..2ee0df0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2431,7 +2431,8 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>      trace_ext4_ext_rm_idx(inode, leaf);
>  
>      ext4_free_blocks(handle, inode, NULL, leaf, 1,
> -             EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
> +             EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET |
> +             EXT4_FREE_BLOCKS_METADATA_INDEX);
>  
>      while (--depth >= 0) {
>          if (path->p_idx != EXT_FIRST_INDEX(path->p_hdr))
