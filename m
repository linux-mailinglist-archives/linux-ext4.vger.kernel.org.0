Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66E639437
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Nov 2022 08:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKZHzq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Nov 2022 02:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZHzq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Nov 2022 02:55:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE02E6AF
        for <linux-ext4@vger.kernel.org>; Fri, 25 Nov 2022 23:55:40 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NK3tJ2CGDz15Mt9;
        Sat, 26 Nov 2022 15:55:04 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 15:55:38 +0800
Received: from [10.174.178.112] (10.174.178.112) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 15:55:38 +0800
Message-ID: <4a40e7be-4c68-3ece-6eb2-9a56a6a9a004@huawei.com>
Date:   Sat, 26 Nov 2022 15:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] debugfs:fix repeated output problem with `logdump -O -n
 <num_trans>`
Content-Language: en-US
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <6ab429c0-6dd0-968f-d4e0-54035d177dbf@huawei.com>
In-Reply-To: <6ab429c0-6dd0-968f-d4e0-54035d177dbf@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.112]
X-ClientProxiedBy: dggpeml500023.china.huawei.com (7.185.36.114) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping...

On 2022/11/15 16:29, lihaoxiang (F) wrote:
> Previously, patch 6e4cc3d5eeb2dfaa055e652b5390beaa6c3d05da introduces
> the function of printing the specified number of logs. But there exists
> a shortage when n is larger than the total number of logs, it dumped the
> duplicated records circulately.
> 
> For example, the disk sda only has three records, but using instruction logdump
> -On5, it would output the result as follow:
> ----------------------------------------------------------------------
> Journal starts at block 1, transaction 6
> Found expected sequence 6, type 1 (descriptor block) at block 1
> Found expected sequence 6, type 2 (commit block) at block 4
> No magic number at block 5: end of journal.
> Found sequence 2 (not 7) at block 7: end of journal.
> Found expected sequence 2, type 2 (commit block) at block 7
> Found sequence 3 (not 8) at block 8: end of journal.
> Found expected sequence 3, type 1 (descriptor block) at block 8
> Found sequence 3 (not 8) at block 15: end of journal.
> Found expected sequence 3, type 2 (commit block) at block 15
> Found sequence 6 (not 9) at block 1: end of journal.       <---------begin loop
> Found expected sequence 6, type 1 (descriptor block) at block 1
> Found sequence 6 (not 9) at block 4: end of journal.
> Found expected sequence 6, type 2 (commit block) at block 4
> Found sequence 2 (not 10) at block 7: end of journal.
> Found expected sequence 2, type 2 (commit block) at block 7
> logdump: short read (read 0, expected 1024) while reading journal
> 
> In this commit, we solve the problem above by exiting dumping if the
> blocknr had already encountered, displayed the total number of logs
> that the disk only possessed.
> 
> Signed-off-by: lihaoxiang <lihaoxiang9@huawei.com>
> ---
>  debugfs/logdump.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 614414e5..036b50ba 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -376,6 +376,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  	journal_header_t	*header;
>  	tid_t			transaction;
>  	unsigned int		blocknr = 0;
> +	unsigned int		first_transaction_blocknr;
>  	int			fc_done;
>  	__u64			total_len;
>  	__u32			maxlen;
> @@ -470,10 +471,18 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  			blocknr = 1;
>  	}
> 
> +	first_transaction_blocknr = blocknr;
> +
>  	while (1) {
>  		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
>  			break;
> 
> +		if ((blocknr == first_transaction_blocknr) &&
> +		    (cur_counts != 0) && dump_old && (dump_counts != -1)) {
> +			fprintf(out_file, "Dump all %lld journal records.\n", cur_counts);
> +			break;
> +		}
> +
>  		retval = read_journal_block(cmdname, source,
>  				((ext2_loff_t) blocknr) * blocksize,
>  				buf, blocksize);
