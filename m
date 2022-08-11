Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C958FC53
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiHKMd3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Aug 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHKMd2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Aug 2022 08:33:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6B11C0E
        for <linux-ext4@vger.kernel.org>; Thu, 11 Aug 2022 05:33:25 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M3R360Mqzz1M8kN;
        Thu, 11 Aug 2022 20:30:10 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 20:33:22 +0800
Received: from [10.174.177.52] (10.174.177.52) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 20:33:22 +0800
Message-ID: <e5ac1309-67a3-322b-71df-dd1fee2bf4ef@huawei.com>
Date:   Thu, 11 Aug 2022 20:33:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] debugfs:add logdump with option -n that display n records
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <608df030-593f-8c69-cb65-632a34729d23@huawei.com>
Content-Language: en-US
In-Reply-To: <608df030-593f-8c69-cb65-632a34729d23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.52]
X-ClientProxiedBy: dggpeml500022.china.huawei.com (7.185.36.66) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Friendly ping...

On 2022/7/14 9:32, lihaoxiang (F) wrote:
> The current version's debugfs possessed the function logdump. Executing
> with option -O could output the log history. But when it occurred the block
> which had no magic number in it's header, the program would exit.
> 
> Sometimes we were locating problems, needed for more transactions that
> had replayed instead of the latest batch of transactions and we weren't
> hope to display all the history in the meanwhile. So we introduced
> the option -n used for controlling the print of history transactions.
> Specially, this parameter was depending on the option -O otherwise it
> couldn't work.
> 
> So in this modification, we used logdump with -O -n <history trans num>.
> It would not stop searching even if occurred no magic blocks or not
> corherent transactions. The only terminated condition was that all logs
> had been outputed or the outputed log counts reached the limitation of -n.
> 
> Signed-off-by: lihaoxiang <lihaoxiang9@huawei.com>
> ---
>  debugfs/logdump.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 4154ef2a..1067961f 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -48,6 +48,7 @@ enum journal_location {JOURNAL_IS_INTERNAL, JOURNAL_IS_EXTERNAL};
>  #define ANY_BLOCK ((blk64_t) -1)
> 
>  static int		dump_all, dump_super, dump_old, dump_contents, dump_descriptors;
> +static int64_t		dump_counts;
>  static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
>  static unsigned int	group_to_dump, inode_offset_to_dump;
>  static ext2_ino_t	inode_to_dump;
> @@ -113,9 +114,10 @@ void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>  	bitmap_to_dump = -1;
>  	inode_block_to_dump = ANY_BLOCK;
>  	inode_to_dump = -1;
> +	dump_counts = -1;
> 
>  	reset_getopt();
> -	while ((c = getopt (argc, argv, "ab:ci:f:OsS")) != EOF) {
> +	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
>  		switch (c) {
>  		case 'a':
>  			dump_all++;
> @@ -148,6 +150,14 @@ void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>  		case 'S':
>  			dump_super++;
>  			break;
> +		case 'n':
> +			dump_counts = strtol(optarg, &tmp, 10);
> +			if (*tmp) {
> +				com_err(argv[0], 0,
> +					"Bad log counts number - %s", optarg);
> +				return;
> +			}
> +			break;
>  		default:
>  			goto print_usage;
>  		}
> @@ -289,7 +299,7 @@ cleanup:
>  	return;
> 
>  print_usage:
> -	fprintf(stderr, "%s: Usage: logdump [-acsOS] [-b<block>] [-i<filespec>]\n\t"
> +	fprintf(stderr, "%s: Usage: logdump [-acsOS] [-n<num_trans>] [-b<block>] [-i<filespec>]\n\t"
>  		"[-f<journal_file>] [output_file]\n", argv[0]);
>  }
> 
> @@ -369,6 +379,8 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  	int			fc_done;
>  	__u64			total_len;
>  	__u32			maxlen;
> +	int64_t			cur_counts = 0;			
> +	bool			exist_no_magic = false;
> 
>  	/* First, check to see if there's an ext2 superblock header */
>  	retval = read_journal_block(cmdname, source, 0, buf, 2048);
> @@ -459,6 +471,9 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  	}
> 
>  	while (1) {
> +		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
> +			break;
> +		
>  		retval = read_journal_block(cmdname, source,
>  				((ext2_loff_t) blocknr) * blocksize,
>  				buf, blocksize);
> @@ -472,8 +487,16 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  		blocktype = be32_to_cpu(header->h_blocktype);
> 
>  		if (magic != JBD2_MAGIC_NUMBER) {
> -			fprintf (out_file, "No magic number at block %u: "
> -				 "end of journal.\n", blocknr);
> +			if (exist_no_magic == false) {
> +				exist_no_magic = true;
> +				fprintf (out_file, "No magic number at block %u: "
> +					"end of journal.\n", blocknr);
> +			}
> +			if (dump_old && (dump_counts != -1)) {
> +				blocknr++;
> +				WRAP(jsb, blocknr, maxlen);
> +				continue;
> +			}
>  			break;
>  		}
> 
> @@ -500,6 +523,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  			continue;
> 
>  		case JBD2_COMMIT_BLOCK:
> +			cur_counts++;
>  			transaction++;
>  			blocknr++;
>  			WRAP(jsb, blocknr, maxlen);
