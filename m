Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822D0682BA
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2019 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfGODoi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Jul 2019 23:44:38 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:64775 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbfGODoh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 14 Jul 2019 23:44:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chge@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TWuAJgc_1563162274;
Received: from IT-C02YD3Q7JG5H.local(mailfrom:chge@linux.alibaba.com fp:SMTPD_---0TWuAJgc_1563162274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jul 2019 11:44:35 +0800
Subject: Re: [PATCH 2/2] jbd2: remove jbd2_journal_inode_add_[write|wait]
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, akpm@linux-foundation.org
Cc:     Theodore Ts'o <tytso@mit.edu>, mark@fasheh.com, jlbec@evilplan.org,
        Ross Zwisler <zwisler@google.com>, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, gechangwei@live.cn
References: <1562977611-8412-1-git-send-email-joseph.qi@linux.alibaba.com>
 <1562977611-8412-2-git-send-email-joseph.qi@linux.alibaba.com>
From:   Changwei Ge <chge@linux.alibaba.com>
Message-ID: <eed4b9f4-4afa-ec02-856f-3cc2760654de@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 11:44:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562977611-8412-2-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2019/7/13 8:26 上午, Joseph Qi wrote:
> Since ext4/ocfs2 are using jbd2_inode dirty range scoping APIs now,
> jbd2_journal_inode_add_[write|wait] are not used any more, remove them.
>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Acked-by: Changwei Ge <chge@linux.alibaba.com>


> ---
>   fs/jbd2/journal.c     |  2 --
>   fs/jbd2/transaction.c | 12 ------------
>   include/linux/jbd2.h  |  2 --
>   3 files changed, 16 deletions(-)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 953990e..1c58859 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -89,8 +89,6 @@
>   EXPORT_SYMBOL(jbd2_journal_invalidatepage);
>   EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
>   EXPORT_SYMBOL(jbd2_journal_force_commit);
> -EXPORT_SYMBOL(jbd2_journal_inode_add_write);
> -EXPORT_SYMBOL(jbd2_journal_inode_add_wait);
>   EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
>   EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
>   EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 990e7b5..9bf793d 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2619,18 +2619,6 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>   	return 0;
>   }
>   
> -int jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *jinode)
> -{
> -	return jbd2_journal_file_inode(handle, jinode,
> -			JI_WRITE_DATA | JI_WAIT_DATA, 0, LLONG_MAX);
> -}
> -
> -int jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *jinode)
> -{
> -	return jbd2_journal_file_inode(handle, jinode, JI_WAIT_DATA, 0,
> -			LLONG_MAX);
> -}
> -
>   int jbd2_journal_inode_ranged_write(handle_t *handle,
>   		struct jbd2_inode *jinode, loff_t start_byte, loff_t length)
>   {
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index df03825..603fbc4 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1410,8 +1410,6 @@ extern int	   jbd2_journal_update_sb_log_tail	(journal_t *, tid_t,
>   extern int	   jbd2_journal_bmap(journal_t *, unsigned long, unsigned long long *);
>   extern int	   jbd2_journal_force_commit(journal_t *);
>   extern int	   jbd2_journal_force_commit_nested(journal_t *);
> -extern int	   jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *inode);
> -extern int	   jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *inode);
>   extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
>   			struct jbd2_inode *inode, loff_t start_byte,
>   			loff_t length);
