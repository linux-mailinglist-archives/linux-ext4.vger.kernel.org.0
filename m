Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9E24E6AF
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHVJ3u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 05:29:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgHVJ3t (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Aug 2020 05:29:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9D79BCA4EEA191BB2848;
        Sat, 22 Aug 2020 17:29:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.86) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 17:29:43 +0800
Subject: Re: [PATCH] ext4: Fix unnecessary hold lock when judge jinode in
 ext4_inode_attach_jinode
To:     <adilger.kernel@dilger.ca>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>
References: <20200822092544.2306917-1-yebin10@huawei.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <5F40E587.1080002@huawei.com>
Date:   Sat, 22 Aug 2020 17:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200822092544.2306917-1-yebin10@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry, please  ignore it.

On 2020/8/22 17:25, Ye Bin wrote:
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/ext4/inode.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3a196d81f594..3504b4cec5b8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4100,12 +4100,11 @@ int ext4_inode_attach_jinode(struct inode *inode)
>   		return 0;
>   
>   	jinode = jbd2_alloc_inode(GFP_KERNEL);
> +	if (!jinode)
> +		return -ENOMEM;
> +
>   	spin_lock(&inode->i_lock);
>   	if (!ei->jinode) {
> -		if (!jinode) {
> -			spin_unlock(&inode->i_lock);
> -			return -ENOMEM;
> -		}
>   		ei->jinode = jinode;
>   		jbd2_journal_init_jbd_inode(ei->jinode, inode);
>   		jinode = NULL;


