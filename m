Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C25FA045
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJJOfq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJOfp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 10:35:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F3E02F;
        Mon, 10 Oct 2022 07:35:44 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MmLxP0jLszwPKp;
        Mon, 10 Oct 2022 22:33:13 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 22:35:42 +0800
Subject: Re: [PATCH -next] jbd2: use the correct print format
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <bvanassche@acm.org>, <axboe@kernel.dk>,
        <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>
References: <1665389343-35572-1-git-send-email-cuibixuan@linux.alibaba.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <c30377f7-f9b8-5774-b509-a4285210b40f@huawei.com>
Date:   Mon, 10 Oct 2022 22:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1665389343-35572-1-git-send-email-cuibixuan@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Bixuan,

On 2022/10/10 16:09, Bixuan Cui wrote:
> The print format error was found when using ftrace event:
>      <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
>      <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0
> 
> Print transaction and head with the unsigned format "%u" instead.
> 
> Fixes: 879c5e6b7cb4 ('jbd2: convert instrumentation from markers to tracepoints')
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> ---
>   include/trace/events/jbd2.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
> index 99f783c..ce9accb 100644
> --- a/include/trace/events/jbd2.h
> +++ b/include/trace/events/jbd2.h
> @@ -40,7 +40,7 @@
>   	TP_STRUCT__entry(
>   		__field(	dev_t,	dev			)
>   		__field(	char,	sync_commit		  )
> -		__field(	int,	transaction		  )
> +		__field(	tid_t,	transaction		  )

While you are at it, can you make all the tid tracing consistent. Some 
tracing points using unsigned long such as:

TRACE_EVENT(jbd2_handle_extend,
	TP_PROTO(dev_t dev, unsigned long tid, unsigned int type,
		 unsigned int line_no, int buffer_credits,
		 int requested_blocks),

	TP_ARGS(dev, tid, type, line_no, buffer_credits, requested_blocks),


and the caller passing transaction->t_tid which is tid_t(unsigned int).

	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
				 transaction->t_tid,
				 handle->h_type, handle->h_line_no,
				 handle->h_total_credits,
				 nblocks);

Thanks,
Jason

>   	),
>   
>   	TP_fast_assign(
> @@ -49,7 +49,7 @@
>   		__entry->transaction	= commit_transaction->t_tid;
>   	),
>   
> -	TP_printk("dev %d,%d transaction %d sync %d",
> +	TP_printk("dev %d,%d transaction %u sync %d",




>   		  MAJOR(__entry->dev), MINOR(__entry->dev),
>   		  __entry->transaction, __entry->sync_commit)
>   );
> @@ -97,8 +97,8 @@
>   	TP_STRUCT__entry(
>   		__field(	dev_t,	dev			)
>   		__field(	char,	sync_commit		  )
> -		__field(	int,	transaction		  )
> -		__field(	int,	head		  	  )
> +		__field(	tid_t,	transaction		  )
> +		__field(	tid_t,	head		  	  )
>   	),
>   
>   	TP_fast_assign(
> @@ -108,7 +108,7 @@
>   		__entry->head		= journal->j_tail_sequence;
>   	),
>   
> -	TP_printk("dev %d,%d transaction %d sync %d head %d",
> +	TP_printk("dev %d,%d transaction %u sync %d head %u",
>   		  MAJOR(__entry->dev), MINOR(__entry->dev),
>   		  __entry->transaction, __entry->sync_commit, __entry->head)
>   );
> 
