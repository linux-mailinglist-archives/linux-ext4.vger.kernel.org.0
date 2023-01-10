Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34792663C2F
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAJJF2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjAJJEt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 04:04:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4E4FD6F
        for <linux-ext4@vger.kernel.org>; Tue, 10 Jan 2023 01:04:11 -0800 (PST)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NrlFJ2p22zRr2h;
        Tue, 10 Jan 2023 17:02:28 +0800 (CST)
Received: from [10.174.178.112] (10.174.178.112) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 17:04:08 +0800
Message-ID: <85b8fe22-a24a-a749-400e-eda20435147d@huawei.com>
Date:   Tue, 10 Jan 2023 17:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] debugfs:fix repeated output problem with logdump
Content-Language: en-US
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <6ab429c0-6dd0-968f-d4e0-54035d177dbf@huawei.com>
 <15d1538a-7c47-ca39-960a-ef8e901ecbb9@huawei.com>
 <5e63f2ad-5695-a5ed-9a36-047672727a53@huawei.com>
 <f6655630-c276-b059-8961-c32d55f3330e@huawei.com>
In-Reply-To: <f6655630-c276-b059-8961-c32d55f3330e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.112]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
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

On 2022/12/15 10:31, lihaoxiang (F) wrote:
> Hi professor Tytso, we found that logdump has the problem to print circulately in the case which logs area are full of valid transactions. We propose the final solution as follow:
> ---------------------------------------------------------------------
> Date: Thu, 10 Nov 2022 17:09:20 +0800
> Subject: [PATCH] debugfs:fix repeated output problem with logdump
> 
> Currently, the module of logdump with parameter -O or -On might fall
> into printing duplicate transactions circulately.
> 
> In fact, it would exit when it check the no magic number in transaction's
> block head. But sometimes there hasn't no magic number block spanning
> the whole log area so it cause the multi meaningless loop until a new no
> magic block was founded.
> 
> We record the first blocknr of logs for comparing this value to that when
> it meet the block again. If the comparison is equal then it exit immediately.
> 
> Signed-off-by: lihaoxiang <lihaoxiang9@huawei.com>
> ---
>  debugfs/logdump.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 614414e5..a6d03f5c 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -376,11 +376,14 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  	journal_header_t	*header;
>  	tid_t			transaction;
>  	unsigned int		blocknr = 0;
> +	unsigned int		last_blocknr;
> +	unsigned int		first_transaction_blocknr;
>  	int			fc_done;
>  	__u64			total_len;
>  	__u32			maxlen;
>  	int64_t			cur_counts = 0;
>  	bool			exist_no_magic = false;
> +	bool			reverse_flag = false;
> 
>  	/* First, check to see if there's an ext2 superblock header */
>  	retval = read_journal_block(cmdname, source, 0, buf, 2048);
> @@ -470,10 +473,22 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  			blocknr = 1;
>  	}
> 
> +	first_transaction_blocknr = blocknr;
> +	last_blocknr = blocknr - 1;
> +
>  	while (1) {
>  		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
>  			break;
> 
> +		if (last_blocknr != (blocknr - 1))
> +			reverse_flag = true;
> +		last_blocknr = blocknr;
> +
> +		if ((blocknr == first_transaction_blocknr) && reverse_flag) {
> +			fprintf(out_file, "Dump all %lld journal records.\n", cur_counts);
> +			break;
> +		}
> +
>  		retval = read_journal_block(cmdname, source,
>  				((ext2_loff_t) blocknr) * blocksize,
>  				buf, blocksize);
