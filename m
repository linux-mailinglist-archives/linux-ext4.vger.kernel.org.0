Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE48614666E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 12:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWLPw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 06:15:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:54290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWLPv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 06:15:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31D0EB260;
        Thu, 23 Jan 2020 11:15:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E21241E0B01; Thu, 23 Jan 2020 12:15:43 +0100 (CET)
Date:   Thu, 23 Jan 2020 12:15:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/1] jbd2_seq_info_next should increase position index
Message-ID: <20200123111543.GC5728@quack2.suse.cz>
References: <d13805e5-695e-8ac3-b678-26ca2313629f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13805e5-695e-8ac3-b678-26ca2313629f@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 23-01-20 12:05:10, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> Script below generates endless output
>  $ q=;while read -r r;do echo "$((++q)) $r";done </proc/fs/jbd2/DEV/info

I've just tried and this works for me just fine with openSUSE 15.1
(4.12.14-based) kernel. Is it some recent regression?

								Honza

> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/jbd2/journal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 5e408ee..b3e2433 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -982,6 +982,7 @@ static void *jbd2_seq_info_start(struct seq_file *seq, loff_t *pos)
>  
>  static void *jbd2_seq_info_next(struct seq_file *seq, void *v, loff_t *pos)
>  {
> +	(*pos)++;
>  	return NULL;
>  }
>  
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
