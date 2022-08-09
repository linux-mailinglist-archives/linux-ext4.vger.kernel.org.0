Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4658D1C3
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 03:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiHIBdt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 21:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiHIBbZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 21:31:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF612D20
        for <linux-ext4@vger.kernel.org>; Mon,  8 Aug 2022 18:31:24 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1wTW1M31zmVWP;
        Tue,  9 Aug 2022 09:29:19 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 09:31:22 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 09:31:21 +0800
Message-ID: <2ba40455-3e96-528c-ae70-d73a4d7f2869@huawei.com>
Date:   Tue, 9 Aug 2022 09:31:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tune2fs: do not change j_tail_sequence in journal
 superblock
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>,
        Alexey Lyahkov <alexey.lyashkov@gmail.com>
References: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
 <3f55f3ad-ba78-e590-65b7-07ff95c78ed1@huawei.com>
In-Reply-To: <3f55f3ad-ba78-e590-65b7-07ff95c78ed1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100020.china.huawei.com (7.185.36.91) To
 dggpeml100016.china.huawei.com (7.185.36.216)
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

On 2022/8/4 18:33, zhanchengbin wrote:
> The function recover_ext3_journal in debugfs/journal.c, if the log 
> replay is over,
> the j_tail_sequence in journal superblock is not changed to the value of 
> the last
> transaction sequence, this will cause subsequent log commitids to count 
> from the
> commitid in last time.
> After tune2fs -e, the log commitid is counted from the commitid in last 
> time, if
> the log ID of the current operation overlaps with that of the last 
> operation, this
> will cause logs that were previously replayed by tune2fs to be replayed 
> here.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: liangyun <liangyun2@huawei.com>
> ---
>   debugfs/journal.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 095fff00..5bac0d3b 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -769,6 +769,8 @@ static errcode_t recover_ext3_journal(ext2_filsys fs)
>           mark_buffer_dirty(journal->j_sb_buffer);
>       }
> 
> +    journal->j_tail_sequence = journal->j_transaction_sequence;
> +
>   errout:
>       jbd2_journal_destroy_revoke(journal);
>       jbd2_journal_destroy_revoke_record_cache();
