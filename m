Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9079103C
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 05:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjIDDBu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 23:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIDDBu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 23:01:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE413B6;
        Sun,  3 Sep 2023 20:01:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfD1g55b6z4f3jLd;
        Mon,  4 Sep 2023 11:01:43 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAHc2eWSPVkwFEtCQ--.17367S2;
        Mon, 04 Sep 2023 11:01:44 +0800 (CST)
Subject: Re: [PATCH v6 11/11] ext4: run mballoc test with different layouts
 setting
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87msy6kljt.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <456dffa7-1a28-0b11-1928-3bf31fc97074@huaweicloud.com>
Date:   Mon, 4 Sep 2023 11:01:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87msy6kljt.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHc2eWSPVkwFEtCQ--.17367S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43KFWUCr47tr4xKFy3urg_yoW5tFy8pF
        ZFyF1Fkr4UWFsF93WSg34UZw4Svwn2yr48JryfWry8GFy3J3ykCF1DtryFgw1vqr4kJrnY
        vwn09F9rC3y5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwMKuUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/1/2023 10:36 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> Use KUNIT_CASE_PARAM to run mbalaloc test with different layouts setting.
>                               ^^^ mballoc
> small nit below
>   
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++------------
>>  1 file changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
>> index d643c56ac003..af48a39c8ba2 100644
>> --- a/fs/ext4/mballoc-test.c
>> +++ b/fs/ext4/mballoc-test.c
>> @@ -196,21 +196,11 @@ static int ext4_mb_mark_context_stub(struct ext4_mark_context *mc,
>>  	return 0;
>>  }
>>  
>> -#define TEST_BLOCKSIZE_BITS 10
>> -#define TEST_CLUSTER_BITS 3
>> -#define TEST_BLOCKS_PER_GROUP 8192
>> -#define TEST_GROUP_COUNT 4
>> -#define TEST_DESC_SIZE 64
>>  #define TEST_GOAL_GROUP 1
>>  static int mbt_kunit_init(struct kunit *test)
>>  {
>> -	struct mbt_ext4_block_layout layout = {
>> -		.blocksize_bits = TEST_BLOCKSIZE_BITS,
>> -		.cluster_bits = TEST_CLUSTER_BITS,
>> -		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
>> -		.group_count = TEST_GROUP_COUNT,
>> -		.desc_size = TEST_DESC_SIZE,
>> -	};
>> +	struct mbt_ext4_block_layout *layout =
>> +		(struct mbt_ext4_block_layout *)(test->param_value);
>>  	struct super_block *sb;
>>  	int ret;
>>  
>> @@ -218,7 +208,7 @@ static int mbt_kunit_init(struct kunit *test)
>>  	if (sb == NULL)
>>  		return -ENOMEM;
>>  
>> -	mbt_init_sb_layout(sb, &layout);
>> +	mbt_init_sb_layout(sb, layout);
>>  
>>  	ret = mbt_ctx_init(sb);
>>  	if (ret != 0) {
>> @@ -304,9 +294,43 @@ static void test_new_blocks_simple(struct kunit *test)
>>  		"unexpectedly get block when no block is available");
>>  }
>>  
>> +static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
>> +	{
>> +		.blocksize_bits = 10,
>> +		.cluster_bits = 3,
>> +		.blocks_per_group = 8192,
>> +		.group_count = 4,
>> +		.desc_size = 64,
>> +	},
>> +	{
>> +		.blocksize_bits = 12,
>> +		.cluster_bits = 3,
>> +		.blocks_per_group = 8192,
>> +		.group_count = 4,
>> +		.desc_size = 64,
>> +	},
>> +	{
>> +		.blocksize_bits = 18,
> 
> 64k blocksize is more common due to platforms with 64k pagesize like
> Power and sometimes arm64. I would rather make it 16 here.
> 
> I tested it on Power - 
Sure, I will make it 16 in next version. Thanks!

> 
> [    2.546687][    T1] KTAP version 1
> [    2.547123][    T1] 1..2
> [    2.547447][    T1]     KTAP version 1
> [    2.547927][    T1]     # Subtest: ext4_mballoc_test
> [    2.548562][    T1]     1..1
> [    2.548933][    T1]         KTAP version 1
> [    2.549457][    T1]         # Subtest: test_new_blocks_simple
> [    2.549550][  T108] kunit_try_catch (108) used greatest stack depth: 14512 bytes left
> [    2.549644][    T1]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    2.552780][  T110] kunit_try_catch (110) used greatest stack depth: 14464 bytes left
> [    2.552882][    T1]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    2.555909][    T1]         ok 3 block_bits=18 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    2.557184][    T1]     # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
> [    2.557186][    T1]     ok 1 test_new_blocks_simple
> [    2.558083][    T1] # Totals: pass:3 fail:0 skip:0 total:3
> [    2.558688][    T1] ok 1 ext4_mballoc_test
> 
> Looks good to me. Feel free to add -
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 

