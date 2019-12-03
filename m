Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1110FED4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCN3V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 08:29:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCN3V (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Dec 2019 08:29:21 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0FA609B09C375BFB8CD9;
        Tue,  3 Dec 2019 21:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 21:29:10 +0800
Subject: Re: [PATCH v2 2/4] ext4, jbd2: ensure panic when journal aborting
 with zero errno
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
References: <20191203092756.26129-1-yi.zhang@huawei.com>
 <20191203092756.26129-3-yi.zhang@huawei.com>
 <20191203121046.GC8206@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <0194132e-66a2-728e-e2d9-f084cf935fb4@huawei.com>
Date:   Tue, 3 Dec 2019 21:29:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203121046.GC8206@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/12/3 20:10, Jan Kara wrote:
> On Tue 03-12-19 17:27:54, zhangyi (F) wrote:
>> JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
>> aborted, and then __ext4_abort() and ext4_handle_error() can invoke
>> panic if ERRORS_PANIC is specified. But if the journal has been aborted
>> with zero errno, jbd2_journal_abort() didn't set this flag so we can
>> no longer panic. Fix this by rename JBD2_REC_ERR to JBD2_ABORT_DONE and
>> set such flag even if there is no need to record errno in the jbd2 super
>> block.
>>
>> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> OK, makes sense. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Although I'd note that after your patch 1, there is only a single place
> that will call jbd2_journal_abort() with 0 errno - namely one place in
> fs/jbd2/checkpoint.c and I think it would make sense for that call site to
> just pass -EIO and we can completely drop the checks whether errno != 0.
> 

Thanks for review. I think a zero errno designed for the case that no
further changes to the journal, and the journal on the disk is
consistent and can recover well, so we don't want to record the errno
and mark the filesystem error. But now it looks that we don't have
such strong cases (shutdown is an exception) and pass none-zero errno
is also OK for every jbd2_journal_abort().

Thanks,
Yi.

>> ---
>>  fs/ext4/super.c      |  4 ++--
>>  fs/jbd2/journal.c    | 10 +++++-----
>>  include/linux/jbd2.h |  3 ++-
>>  3 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index dd654e53ba3d..25b0c883bd15 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -482,7 +482,7 @@ static void ext4_handle_error(struct super_block *sb)
>>  		sb->s_flags |= SB_RDONLY;
>>  	} else if (test_opt(sb, ERRORS_PANIC)) {
>>  		if (EXT4_SB(sb)->s_journal &&
>> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
>> +		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_DONE))
>>  			return;
>>  		panic("EXT4-fs (device %s): panic forced after error\n",
>>  			sb->s_id);
>> @@ -701,7 +701,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
>>  	}
>>  	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
>>  		if (EXT4_SB(sb)->s_journal &&
>> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
>> +		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_DONE))
>>  			return;
>>  		panic("EXT4-fs panic from previous error\n");
>>  	}
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 1c58859aa592..a78b07841080 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -2118,12 +2118,12 @@ static void __journal_abort_soft (journal_t *journal, int errno)
>>  
>>  	__jbd2_journal_abort_hard(journal);
>>  
>> -	if (errno) {
>> +	if (errno)
>>  		jbd2_journal_update_sb_errno(journal);
>> -		write_lock(&journal->j_state_lock);
>> -		journal->j_flags |= JBD2_REC_ERR;
>> -		write_unlock(&journal->j_state_lock);
>> -	}
>> +
>> +	write_lock(&journal->j_state_lock);
>> +	journal->j_flags |= JBD2_ABORT_DONE;
>> +	write_unlock(&journal->j_state_lock);
>>  }
>>  
>>  /**
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 603fbc4e2f70..71cab887fb98 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1248,7 +1248,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
>>  #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
>>  						 * data write error in ordered
>>  						 * mode */
>> -#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
>> +#define JBD2_ABORT_DONE	0x080	/* Abort done, the errno in the sb has been
>> +				 * recorded if necessary */
>>  
>>  /*
>>   * Function declarations for the journaling transaction and buffer
>> -- 
>> 2.17.2
>>

