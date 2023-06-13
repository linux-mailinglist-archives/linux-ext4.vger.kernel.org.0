Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1762A72D6CF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 03:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFMBW0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFMBWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 21:22:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE719E9;
        Mon, 12 Jun 2023 18:22:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qg9lG0RXyz4f3jLq;
        Tue, 13 Jun 2023 09:22:18 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAHF+jJxIdk1ZT2LQ--.55421S2;
        Tue, 13 Jun 2023 09:22:19 +0800 (CST)
Subject: Re: [PATCH v4 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-14-shikemeng@huaweicloud.com>
 <20230611050532.GE1436857@mit.edu>
 <cd236fdb-c48c-69b0-10a3-3df8a34f0a6e@huaweicloud.com>
 <20230612034900.GI1436857@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dfd93c84-757c-bf38-4b38-193d0ee2a425@huaweicloud.com>
Date:   Tue, 13 Jun 2023 09:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230612034900.GI1436857@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHF+jJxIdk1ZT2LQ--.55421S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar43XF4Uuw1Utw17Kry5twb_yoW7Ar17pr
        Wjkws5G3y8K34UGa97Xw45Ga1xu348Cr1UGryfWryDuFW5ta42gF9rKF45ZFWYkFs7X3ZI
        qF42y34DC3Wjka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 6/12/2023 11:49 AM, Theodore Ts'o wrote:
> On Mon, Jun 12, 2023 at 10:24:55AM +0800, Kemeng Shi wrote:
> 
>> Hi ted, sorry for this issue. This patch added a WARN_ON for case that we free block
>> to uninitialized block group which should be invalid.
>> We can simply remove the WARN_ON to allow free on uninitialized block group as old
>> way for emergency fix and I will find out why we free blocks to uninitialized block
>> group in fast commit code path and is it a valid behavior.
> 
> What I've done for now in the dev branch was to drop patches 12
> through 19 of this patch series.  That seemed to be a good break
> point, and I wanted to make sure we had something working so we can
> start doing a lot more intesive testing on the patches so far.
> 
> Also, that way, when you resend the last 8 patches in the patch
> series, we can make sure they get a proper review as opposed to making
> changes on the fly.
Sure, I will resend last 8 patches after I solve the issue. I can also take my time
to look at problem in this way :)
> The current contents of the dev branch are:
> 
> % git log --reverse --oneline origin..dev
> 40fa8be3852f ext4: kill unused function ext4_journalled_write_inline_data
> a030569c34be ext4: Change remaining tracepoints to use folio
> d1ffc6fb5ded ext4: Make mpage_journal_page_buffers use folio
> 5ac99c22fa84 ext4: Make ext4_write_inline_data_end() use folio
> d578dfc510cf ext4: Call fsverity_verify_folio()
> 30f0bd64ed09 ext4: fix wrong unit use in ext4_mb_normalize_request
> b9dc976cc348 ext4: fix unit mismatch in ext4_mb_new_blocks_simple
> 9afc5e21107a ext4: fix wrong unit use in ext4_mb_find_by_goal
> 860f86ccff6e ext4: treat stripe in block unit
> 710c384f1536 ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
> f242d8a98a6f ext4: remove ext4_block_group and ext4_block_group_offset declaration
> 5b859728b98b ext4: try all groups in ext4_mb_new_blocks_simple
> ea7bbd168135 ext4: get block from bh before pass it to ext4_free_blocks_simple in ext4_free_blocks
> 757d9100a5d1 ext4: remove unsed parameter and unnecessary forward declaration of ext4_mb_new_blocks_simple
> 5d62e6da25f5 ext4: fix wrong unit use in ext4_mb_clear_bb
> 993d22f0a250 ext4: fix wrong unit use in ext4_mb_new_blocks
> bf4f2aa4844a ext4: mballoc: Remove useless setting of ac_criteria
> 743f4dd07bf9 ext4: Remove unused extern variables declaration
> bc40109767b3 ext4: Convert mballoc cr (criteria) to enum
> 52e3814a1342 ext4: Add per CR extent scanned counter
> a15c09da1255 ext4: Add counter to track successful allocation of goal length
> 26cbe38f0275 ext4: Avoid scanning smaller extents in BG during CR1
> 9c8f8195852c ext4: Don't skip prefetching BLOCK_UNINIT groups
> cd303d98b9b5 ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
> ea639ce794e5 ext4: Abstract out logic to search average fragment list
> b080c84db854 ext4: Add allocation criteria 1.5 (CR1_5)
> 3a08f7ac3bfa ext4: Give symbolic names to mballoc criterias
> d14b5d0b1373 ext4: only update i_reserved_data_blocks on successful block allocation
> b352d1f09a20 ext4: add a new helper to check if es must be kept
> 579c020ea7b7 ext4: factor out __es_alloc_extent() and __es_free_extent()
> f4ddcde91d00 ext4: use pre-allocated es in __es_insert_extent()
> e77481862663 ext4: use pre-allocated es in __es_remove_extent()
> 28774513875c ext4: using nofail preallocation in ext4_es_remove_extent()
> e109a1db5b09 ext4: using nofail preallocation in ext4_es_insert_delayed_block()
> 14d876070f03 ext4: using nofail preallocation in ext4_es_insert_extent()
> 2af6f615b18b ext4: make ext4_es_remove_extent() return void
> 0ee9cccd1971 ext4: make ext4_es_insert_delayed_block() return void
> 7a7c285c485d ext4: make ext4_es_insert_extent() return void
> 9d1c6dea1aa3 ext4: make ext4_zeroout_es() return void
> 2e3f4cdef544 ext4: clean up mballoc criteria comments
> acef67482edf ext4: allow concurrent unaligned dio overwrites
> 63bc068f0d1a ext4: Fix reusing stale buffer heads from last failed mounting
> 3a57c2f88be3 ext4: ext4_put_super: Remove redundant checking for 'sbi->s_journal_bdev'
> 6b960d2155f9 jbd2: remove unused feature macros
> 4b049709e652 jbd2: switch to check format version in superblock directly
> d9eafe0afafa jbd2: factor out journal initialization from journal_get_superblock()
> 6eecd1f4c7ef jbd2: remove j_format_version
> 431ca11fafd3 jbd2: continue to record log between each mount
> 2ea31402649c ext4: add journal cycled recording support
> a228f0e153f6 ext4: update doc about journal superblock description
> f9c45d83f4da ext4: turning quotas off if mount failed after enable quotas
> 5404e4738054 ext4: refactoring to use the unified helper ext4_quotas_off()
> d3ab1bca26b4 jbd2: recheck chechpointing non-dirty buffer
> 7b0cfe40a991 jbd2: remove t_checkpoint_io_list
> e86f802ab8d4 jbd2: remove journal_clean_one_cp_list()
> e8ece5c78f36 jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint
> cdffaad9649e jbd2: fix a race when checking checkpoint buffer busy
> 11761ed6026e jbd2: remove __journal_try_to_free_buffer()
> 
> Cheers,
> 
> 					- Ted
> 

-- 
Best wishes
Kemeng Shi

