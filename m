Return-Path: <linux-ext4+bounces-189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5492E7F9A44
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1032A280DC3
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C1DDC3;
	Mon, 27 Nov 2023 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A6139
	for <linux-ext4@vger.kernel.org>; Sun, 26 Nov 2023 22:54:09 -0800 (PST)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sdx652kc5zShQ4;
	Mon, 27 Nov 2023 14:49:49 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Nov 2023 14:54:06 +0800
Message-ID: <38c05f45-a2c7-071b-692a-ba757d5344d1@huawei.com>
Date: Mon, 27 Nov 2023 14:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] debugfs: Fix infinite loop when dump log
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <louhongxiang@huawei.com>
References: <20231117102315.2431846-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20231117102315.2431846-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected

On 2023/11/17 18:23, Wenchao Hao wrote:
> There are 2 scenarios which would trigger infinite loop:
> 
> 1. None log is recorded, then dumplog with "-n", for example:
>     debugfs -R "logdump -O -n 10" /dev/xxx
>     while /dev/xxx has no valid log recorded.
> 2. The log area is full and cycle write is triggered, then dumplog with
>     debugfs -R "logdump -aOS" /dev/xxx
> 
> This patch add a new flag "reverse_flag" to mark if logdump has reached
> to tail of logarea, it is default false, and set in macro WRAP().
> 
> If reverse_flag is true, and we comes to first_transaction_blocknr
> again, just break the logdump loop.

Friendly ping...

> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   debugfs/logdump.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index b600228e..05ea839a 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -52,6 +52,7 @@ static int64_t		dump_counts;
>   static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
>   static unsigned int	group_to_dump, inode_offset_to_dump;
>   static ext2_ino_t	inode_to_dump;
> +static bool		reverse_flag;
>   
>   struct journal_source
>   {
> @@ -80,8 +81,10 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
>   static void do_hexdump (FILE *, char *, int);
>   
>   #define WRAP(jsb, blocknr, maxlen)					\
> -	if (blocknr >= (maxlen))					\
> -	    blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));
> +	if (blocknr >= (maxlen)) {					\
> +		blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));	\
> +		reverse_flag = true;					\
> +	}
>   
>   void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>   		    void *infop EXT2FS_ATTR((unused)))
> @@ -115,6 +118,7 @@ void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>   	inode_block_to_dump = ANY_BLOCK;
>   	inode_to_dump = -1;
>   	dump_counts = -1;
> +	reverse_flag = false;
>   
>   	reset_getopt();
>   	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
> @@ -477,8 +481,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>   		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
>   			break;
>   
> -		if ((blocknr == first_transaction_blocknr) &&
> -		    (cur_counts != 0) && dump_old && (dump_counts != -1)) {
> +		if ((blocknr == first_transaction_blocknr) && dump_old && reverse_flag) {
>   			fprintf(out_file, "Dump all %lld journal records.\n",
>   				(long long) cur_counts);
>   			break;


