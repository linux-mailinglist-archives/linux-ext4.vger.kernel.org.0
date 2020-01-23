Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD11146AE4
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAWOMN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 09:12:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgAWOMN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 09:12:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEF66B1BF;
        Thu, 23 Jan 2020 14:12:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E60F81E0B01; Thu, 23 Jan 2020 15:02:43 +0100 (CET)
Date:   Thu, 23 Jan 2020 15:02:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/1] jbd2_seq_info_next should increase position index
Message-ID: <20200123140243.GA7914@quack2.suse.cz>
References: <d13805e5-695e-8ac3-b678-26ca2313629f@virtuozzo.com>
 <20200123111543.GC5728@quack2.suse.cz>
 <43e6a168-63b6-4a82-7b3d-5dd676b9f9bb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e6a168-63b6-4a82-7b3d-5dd676b9f9bb@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 23-01-20 14:30:14, Vasily Averin wrote:
> 
> 
> On 1/23/20 2:15 PM, Jan Kara wrote:
> > On Thu 23-01-20 12:05:10, Vasily Averin wrote:
> >> if seq_file .next fuction does not change position index,
> >> read after some lseek can generate unexpected output.
> >>
> >> Script below generates endless output
> >>  $ q=;while read -r r;do echo "$((++q)) $r";done </proc/fs/jbd2/DEV/info
> > 
> > I've just tried and this works for me just fine with openSUSE 15.1
> > (4.12.14-based) kernel. Is it some recent regression?
> 
> I think it depends on 
> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> In OpenVz7 we got complain after backport of this patch.

I see. OK. So please add tag:

Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")

likely also:

CC: stable@vger.kernel.org

and you can also add:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

								Honza

> 
> I've reproduced it on last ubuntu kernel
> 
> $ uname -a
> Linux vvs-ws 5.3.0-24-generic #26~18.04.2-Ubuntu SMP Tue Nov 26 12:34:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ q=;while read -r r;do echo "$((++q)) $r";done </proc/fs/jbd2/sda4-8/info  | head -20
> 1 151327 transactions (132200 requested), each up to 65536 blocks
> 2 average:
> 3 0ms waiting for transaction
> 4 0ms request delay
> 5 3816ms running transaction
> 6 0ms transaction was being locked
> 7 0ms flushing data (in ordered mode)
> 8 36ms logging transaction
> 9 29753us average transaction commit time
> 10 1587 handles per transaction
> 11 32 blocks per transaction
> 12 33 logged blocks per transaction
> 13 151327 transactions (132200 requested), each up to 65536 blocks
> 14 151327 transactions (132200 requested), each up to 65536 blocks
> 15 151327 transactions (132200 requested), each up to 65536 blocks
> 16 151327 transactions (132200 requested), each up to 65536 blocks
> 17 151327 transactions (132200 requested), each up to 65536 blocks
> 18 151327 transactions (132200 requested), each up to 65536 blocks
> 19 151327 transactions (132200 requested), each up to 65536 blocks
> 20 151327 transactions (132200 requested), each up to 65536 blocks
> 
> >> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >> ---
> >>  fs/jbd2/journal.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> >> index 5e408ee..b3e2433 100644
> >> --- a/fs/jbd2/journal.c
> >> +++ b/fs/jbd2/journal.c
> >> @@ -982,6 +982,7 @@ static void *jbd2_seq_info_start(struct seq_file *seq, loff_t *pos)
> >>  
> >>  static void *jbd2_seq_info_next(struct seq_file *seq, void *v, loff_t *pos)
> >>  {
> >> +	(*pos)++;
> >>  	return NULL;
> >>  }
> >>  
> >> -- 
> >> 1.8.3.1
> >>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
