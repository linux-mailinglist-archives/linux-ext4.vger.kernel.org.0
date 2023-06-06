Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE26372450B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjFFN6o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjFFN6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:58:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A78F
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:58:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbBs63nQjz4f468V
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:58:34 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgDHuuiJO39kzknyKw--.55363S3;
        Tue, 06 Jun 2023 21:58:35 +0800 (CST)
Subject: Re: [PATCH v2 3/6] jbd2: remove journal_clean_one_cp_list()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
 <20230606061447.1125036-4-yi.zhang@huaweicloud.com>
 <20230606074637.6purq76gaae366t3@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b96f43f9-bb00-3a6b-d428-bf122c3cd04f@huaweicloud.com>
Date:   Tue, 6 Jun 2023 21:58:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230606074637.6purq76gaae366t3@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgDHuuiJO39kzknyKw--.55363S3
X-Coremail-Antispam: 1UD129KBjvJXoWrurW3Xr4kCF18trW7Gr1kAFb_yoW8Jr1rpF
        WfZa4UGrWvvr18uFn2qFWrZFWFvF4vvryUKanxuF9Yvay3GF1fKFy7Jw17Ka4UKFy8WanF
        qr4jq3W7G3WYkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/6 15:46, Jan Kara wrote:
> On Tue 06-06-23 14:14:44, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
>> the same, so merge them into journal_shrink_one_cp_list(), remove the
>> nr_to_scan parameter, always scan and try to free the whole checkpoint
>> list.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Just one nit below:
> 
>> @@ -398,15 +358,14 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>>   * Called with j_list_lock held.
>>   */
>>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>> -						unsigned long *nr_to_scan,
>> -						bool *released)
>> +						bool destroy, bool *released)
>>  {
>>  	struct journal_head *last_jh;
>>  	struct journal_head *next_jh = jh;
>>  	unsigned long nr_freed = 0;
>>  	int ret;
> 
> When changing this function, I think it will be more robust calling
> convention to unconditionally set *released = false at the beginning of
> this function. Then we can remove the initialization from
> __jbd2_journal_clean_checkpoint_list().
> 

Thanks for the review, will change it in my next iteration.

Yi.

