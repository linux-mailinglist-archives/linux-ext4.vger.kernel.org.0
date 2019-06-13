Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7444555
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392647AbfFMQna (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:43:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730463AbfFMGgZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jun 2019 02:36:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73DA9B6D9CABCE71E365;
        Thu, 13 Jun 2019 14:36:23 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 14:36:22 +0800
Subject: Re: [PATCH 2/2] f2fs: only set project inherit bit for directory
To:     Wang Shilong <wangshilong1991@gmail.com>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Wang Shilong <wshilong@ddn.com>, Andreas Dilger <adilger@dilger.ca>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
Date:   Thu, 13 Jun 2019 14:36:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/6/6 12:32, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/f2fs/f2fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 06b89a9862ab..f02ebecb68ea 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2370,7 +2370,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  			   F2FS_PROJINHERIT_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> -#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
> +#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
> +				   F2FS_PROJINHERIT_FL))

Hi Shilong,

Could you please add below diff as ext4 did?

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index efdafa886510..295ca5ed42d9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1759,6 +1759,9 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned
long arg)

 	fsflags &= F2FS_GETTABLE_FS_FL;

+	if (S_ISREG(inode->i_mode))
+		fsflags &= ~FS_PROJINHERIT_FL;
+
 	return put_user(fsflags, (int __user *)arg);
 }

Thanks,

>  
>  /* Flags that are appropriate for non-directories/regular files. */
>  #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
> 
