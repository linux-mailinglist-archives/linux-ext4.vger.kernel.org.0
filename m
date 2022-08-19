Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56581599698
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Aug 2022 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347270AbiHSIAR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Aug 2022 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbiHSIAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Aug 2022 04:00:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257A52DE4;
        Fri, 19 Aug 2022 01:00:15 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8Dc20qsbzkWVh;
        Fri, 19 Aug 2022 15:56:50 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 16:00:13 +0800
Subject: Re: [PATCH RFC] jbd2: detect old record when do journal scan
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <20220810013442.3474533-1-yebin10@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>
From:   yebin <yebin10@huawei.com>
Message-ID: <62FF430D.9040405@huawei.com>
Date:   Fri, 19 Aug 2022 16:00:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220810013442.3474533-1-yebin10@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping...

On 2022/8/10 9:34, Ye Bin wrote:
> As https://github.com/tytso/e2fsprogs/issues/120 describe tune2fs do not update
> j_tail_sequence when do journal recovery. This maybe recover old journal record,
> then will lead to file system corruption.
> To avoid file system corruption in this case, if detect current transaction's
> commit time earlier than previous transaction's commit time when do journal
> scan, just return error.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/jbd2/recovery.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index f548479615c6..f3def21a96a5 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -812,8 +812,17 @@ static int do_one_pass(journal_t *journal,
>   					break;
>   				}
>   			}
> -			if (pass == PASS_SCAN)
> +			if (pass == PASS_SCAN) {
> +				if (commit_time < last_trans_commit_time) {
> +					pr_err("JBD2: old journal record found "
> +					       "in transaction %u\n",
> +					       next_commit_ID);
> +					err = -EFSBADCRC;
> +					brelse(bh);
> +					goto failed;
> +				}
>   				last_trans_commit_time = commit_time;
> +			}
>   			brelse(bh);
>   			next_commit_ID++;
>   			continue;

