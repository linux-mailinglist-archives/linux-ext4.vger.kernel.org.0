Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93112186953
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgCPKpG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 06:45:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730478AbgCPKpF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Mar 2020 06:45:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D63C5D2B9DB25FD55C8;
        Mon, 16 Mar 2020 18:45:02 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 18:44:59 +0800
Subject: Re: [PATCH] ext4: using matching invalidatepage in ext4_writepage
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>
References: <20200226041002.13914-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <9b5009e3-cc2f-4960-be94-30784e85c8b3@huawei.com>
Date:   Mon, 16 Mar 2020 18:44:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200226041002.13914-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted, can you consider to apply this patch.

On 2020/2/26 12:10, yangerkun wrote:
> Run generic/388 with journal data mode sometimes may trigger the warning
> in ext4_invalidatepage. Actually, we should use the matching invalidatepage
> in ext4_writepage.
>
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/ext4/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa0ff78dc033..78e805d42ada 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1974,7 +1974,7 @@ static int ext4_writepage(struct page *page,
>   	bool keep_towrite = false;
>   
>   	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
> -		ext4_invalidatepage(page, 0, PAGE_SIZE);
> +		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
>   		unlock_page(page);
>   		return -EIO;
>   	}

