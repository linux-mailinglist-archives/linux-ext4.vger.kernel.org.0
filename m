Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5656A00A5
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Feb 2023 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWBcF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 20:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBWBcD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 20:32:03 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1843D924;
        Wed, 22 Feb 2023 17:32:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PMb991g68z4f3lXC;
        Thu, 23 Feb 2023 09:31:57 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+UKwvZjQ_FXEA--.62830S2;
        Thu, 23 Feb 2023 09:31:55 +0800 (CST)
Subject: Re: [PATCH 7/7] ext4: improve inode table blocks counting in
 ext4_num_overhead_clusters
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202302222219.u328sqfs-lkp@intel.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <1802222f-9c10-9ea3-93fb-6fce086e201a@huaweicloud.com>
Date:   Thu, 23 Feb 2023 09:31:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <202302222219.u328sqfs-lkp@intel.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAXB+UKwvZjQ_FXEA--.62830S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr13XryUKF4kCr47Wr17Jrb_yoW5tFyrpr
        4jgFn5Jry3Ww429Fs7tw4kX3WrGw1kKw1DJF1rGw13ZF9rWryxurn2gF98uFW2grn8K3ZF
        vrZ7CryUu3Z8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 2/22/2023 11:13 PM, Dan Carpenter wrote:
> Hi Kemeng,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-properly-handle-error-of-ext4_init_block_bitmap-in-ext4_read_block_bitmap_nowait/20230221-115830
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> patch link:    https://lore.kernel.org/r/20230221115919.1918161-8-shikemeng%40huaweicloud.com
> patch subject: [PATCH 7/7] ext4: improve inode table blocks counting in ext4_num_overhead_clusters
> config: riscv-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230222/202302222219.u328sqfs-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202302222219.u328sqfs-lkp@intel.com/
> 
> New smatch warnings:
> fs/ext4/balloc.c:153 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.
> 
> vim +/block_cluster +153 fs/ext4/balloc.c
[...]
> d5b8f31007a937 Theodore Ts'o     2011-09-09  128  	/*
> 2b59a2fd93873a Kemeng Shi        2023-02-21  129  	 * For the allocation bitmaps, we first need to check to see
> 2b59a2fd93873a Kemeng Shi        2023-02-21  130  	 * if the block is in the block group.  If it is, then check
> 2b59a2fd93873a Kemeng Shi        2023-02-21  131  	 * to see if the cluster is already accounted for in the clusters
> 2b59a2fd93873a Kemeng Shi        2023-02-21  132  	 * used for the base metadata cluster and inode tables cluster.
> d5b8f31007a937 Theodore Ts'o     2011-09-09  133  	 * Normally all of these blocks are contiguous, so the special
> d5b8f31007a937 Theodore Ts'o     2011-09-09  134  	 * case handling shouldn't be necessary except for *very*
> d5b8f31007a937 Theodore Ts'o     2011-09-09  135  	 * unusual file system layouts.
> d5b8f31007a937 Theodore Ts'o     2011-09-09  136  	 */
> d5b8f31007a937 Theodore Ts'o     2011-09-09  137  	if (ext4_block_in_group(sb, ext4_block_bitmap(sb, gdp), block_group)) {
> b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  138  		block_cluster = EXT4_B2C(sbi,
> b0dd6b70f0fda1 Theodore Ts'o     2012-06-07  139  					 ext4_block_bitmap(sb, gdp) - start);
> 2b59a2fd93873a Kemeng Shi        2023-02-21  140  		if (block_cluster >= base_clusters &&
> 2b59a2fd93873a Kemeng Shi        2023-02-21  141  		    (block_cluster < itbl_cluster_start ||
> 2b59a2fd93873a Kemeng Shi        2023-02-21  142  		    block_cluster > itbl_cluster_end))
> d5b8f31007a937 Theodore Ts'o     2011-09-09  143  			num_clusters++;
> d5b8f31007a937 Theodore Ts'o     2011-09-09  144  	}
> d5b8f31007a937 Theodore Ts'o     2011-09-09  145  
> d5b8f31007a937 Theodore Ts'o     2011-09-09  146  	if (ext4_block_in_group(sb, ext4_inode_bitmap(sb, gdp), block_group)) {
> 
> These two conditions are exactly the same so I don't see why they can't
> be combined into one condition.  I have read the comment, but I guess I
> don't understand ext4 well enough to really understand it.
These two conditions check two kinds of bitmap block: *block* bitmap block
and *inode* bitmap block. For case that block bitmap in the block group
while inode bitmap in a different group, there is a risk to access
uninitialized  block_cluster.
I will fix this in next version, Thanks!

-- 
Best wishes
Kemeng Shi

