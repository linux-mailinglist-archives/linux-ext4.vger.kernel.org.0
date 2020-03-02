Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE65D1756BE
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2020 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBJRN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Mar 2020 04:17:13 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58533 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgCBJRN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Mar 2020 04:17:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TrOpaEa_1583140629;
Received: from 30.5.112.20(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TrOpaEa_1583140629)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 17:17:09 +0800
Subject: Re: [PATCH] ext4: start to support iopoll method
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        joseph qi <joseph.qi@linux.alibaba.com>
References: <20200207120758.2411-1-xiaoguang.wang@linux.alibaba.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <c535d8f5-e746-30dc-f3e8-aeed04fcb5b8@linux.alibaba.com>
Date:   Mon, 2 Mar 2020 17:17:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200207120758.2411-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

Ted, could you please consider applying this patch? Iouring polling
tests in ext4 needs this patch, Jan Kara has nicely reviewed this patch, thanks.

Regards,
Xiaoguang Wang

> Since commit "b1b4705d54ab ext4: introduce direct I/O read using
> iomap infrastructure", we can easily make ext4 support iopoll
> method, just use iomap_dio_iopoll().
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>   fs/ext4/file.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 5f225881176b..0d624250a62b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -872,6 +872,7 @@ const struct file_operations ext4_file_operations = {
>   	.llseek		= ext4_llseek,
>   	.read_iter	= ext4_file_read_iter,
>   	.write_iter	= ext4_file_write_iter,
> +	.iopoll		= iomap_dio_iopoll,
>   	.unlocked_ioctl = ext4_ioctl,
>   #ifdef CONFIG_COMPAT
>   	.compat_ioctl	= ext4_compat_ioctl,
> 
