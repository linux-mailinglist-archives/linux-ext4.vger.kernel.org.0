Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8B6B77F4
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 13:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCMMsW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCMMsU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 08:48:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D538136C9;
        Mon, 13 Mar 2023 05:48:15 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PZxGg1LknzHwqB;
        Mon, 13 Mar 2023 20:46:03 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 20:48:12 +0800
Subject: Re: [PATCH 4/5] jbd2: factor out journal initialization from
 journal_get_superblock()
To:     Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao1@huawei.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-5-chengzhihao1@huawei.com>
 <20230313111253.2eoplgfhcgbaqri2@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <a1aef56e-652e-793c-3913-c083119d4b45@huawei.com>
Date:   Mon, 13 Mar 2023 20:48:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230313111253.2eoplgfhcgbaqri2@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/13 19:12, Jan Kara wrote:
> On Fri 10-03-23 20:52:05, Zhihao Cheng wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Current journal_get_superblock() couple journal superblock checking and
>> partial journal initialization, factor out initialization part from it
>> to make things clear.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>  fs/jbd2/journal.c | 52 ++++++++++++++++++++---------------------------
>>  1 file changed, 22 insertions(+), 30 deletions(-)
> 
> The patch looks mostly good. Just one style nit below.
> 
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index b991d5c21d16..cd94d068b4e6 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -1921,26 +1921,15 @@ static int journal_get_superblock(journal_t *journal)
>>  		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
>>  		goto out;
>>  	}
>> -
>> -	switch(be32_to_cpu(sb->s_header.h_blocktype)) {
>> -	case JBD2_SUPERBLOCK_V1:
>> -		journal->j_format_version = 1;
>> -		break;
>> -	case JBD2_SUPERBLOCK_V2:
>> -		journal->j_format_version = 2;
>> -		break;
>> -	default:
>> +	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
>> +	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
>>  		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
>>  		goto out;
>>  	}
>> -
>> -	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
>> -		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
>> -	else if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
>> +	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
>>  		printk(KERN_WARNING "JBD2: journal file too short\n");
>>  		goto out;
>>  	}
>> -
> 
> Please keep this empty line here. It actually makes the code more readable,
> separating logically different checks. Same with three empty lines below...

Thanks for the comments, I will add them back.

Yi.
