Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3928649776F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jan 2022 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiAXChe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jan 2022 21:37:34 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54390 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232730AbiAXChd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 23 Jan 2022 21:37:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2cNU4c_1642991850;
Received: from 30.225.24.74(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V2cNU4c_1642991850)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jan 2022 10:37:31 +0800
Message-ID: <206899ac-c1af-35bb-820a-62a45d93b52a@linux.alibaba.com>
Date:   Mon, 24 Jan 2022 10:37:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Content-Language: en-US
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
Cc:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
References: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
 <20220121071205.100648-3-joseph.qi@linux.alibaba.com>
 <DS7PR10MB487883FE7025BE9FD4623C39F75D9@DS7PR10MB4878.namprd10.prod.outlook.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <DS7PR10MB487883FE7025BE9FD4623C39F75D9@DS7PR10MB4878.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sure, will do it in v2.
So could this patch resolve your issue?

Thanks,
Joseph

On 1/23/22 1:31 PM, Gautham Ananthakrishna wrote:
> Hi,
> This deadlock was originally reported by saeed.mirzamohammadi@oracle.com  Could you please add Saeed as the reportedby.
> 
> Thanks,
> Gautham.
> 
> -----Original Message-----
> From: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Sent: Friday, January 21, 2022 12:42 PM
> To: akpm@linux-foundation.org; tytso@mit.edu; adilger.kernel@dilger.ca
> Cc: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>; ocfs2-devel@oss.oracle.com; linux-ext4@vger.kernel.org
> Subject: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
> 
> commit 6f1b228529ae introduces a regression which can deadlock as
> follows:
> 
> Task1:                              Task2:
> jbd2_journal_commit_transaction     ocfs2_test_bg_bit_allocatable
> spin_lock(&jh->b_state_lock)        jbd_lock_bh_journal_head
> __jbd2_journal_remove_checkpoint    spin_lock(&jh->b_state_lock)
> jbd2_journal_put_journal_head
> jbd_lock_bh_journal_head
> 
> Task1 and Task2 lock bh->b_state and jh->b_state_lock in different order, which finally result in a deadlock.
> 
> So use jbd2_journal_[grab|put]_journal_head instead in
> ocfs2_test_bg_bit_allocatable() to fix it.
> 
> Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
> Fixes: 6f1b228529ae ("ocfs2: fix race between searching chunks and release journal_head from buffer_head")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/suballoc.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c index 481017e1dac5..166c8918c825 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -1251,26 +1251,23 @@ static int ocfs2_test_bg_bit_allocatable(struct buffer_head *bg_bh,  {
>  	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
>  	struct journal_head *jh;
> -	int ret = 1;
> +	int ret;
>  
>  	if (ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap))
>  		return 0;
>  
> -	if (!buffer_jbd(bg_bh))
> +	jh = jbd2_journal_grab_journal_head(bg_bh);
> +	if (!jh)
>  		return 1;
>  
> -	jbd_lock_bh_journal_head(bg_bh);
> -	if (buffer_jbd(bg_bh)) {
> -		jh = bh2jh(bg_bh);
> -		spin_lock(&jh->b_state_lock);
> -		bg = (struct ocfs2_group_desc *) jh->b_committed_data;
> -		if (bg)
> -			ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
> -		else
> -			ret = 1;
> -		spin_unlock(&jh->b_state_lock);
> -	}
> -	jbd_unlock_bh_journal_head(bg_bh);
> +	spin_lock(&jh->b_state_lock);
> +	bg = (struct ocfs2_group_desc *) jh->b_committed_data;
> +	if (bg)
> +		ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
> +	else
> +		ret = 1;
> +	spin_unlock(&jh->b_state_lock);
> +	jbd2_journal_put_journal_head(jh);
>  
>  	return ret;
>  }
> --
> 2.19.1.6.gb485710b
