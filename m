Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE8736142
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jun 2023 03:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFTBui (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jun 2023 21:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTBuh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Jun 2023 21:50:37 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A55E4A;
        Mon, 19 Jun 2023 18:50:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QlV2b0dW7z4f3qRr;
        Tue, 20 Jun 2023 09:50:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgC3bLDnBZFkbqVlMA--.19679S2;
        Tue, 20 Jun 2023 09:50:33 +0800 (CST)
Subject: Re: [PATCH v4 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-14-shikemeng@huaweicloud.com>
 <20230611050532.GE1436857@mit.edu>
 <cd236fdb-c48c-69b0-10a3-3df8a34f0a6e@huaweicloud.com>
 <20230612034900.GI1436857@mit.edu>
 <dfd93c84-757c-bf38-4b38-193d0ee2a425@huaweicloud.com>
Message-ID: <ef4dc225-f8de-9586-5cc5-4045f46d4d00@huaweicloud.com>
Date:   Tue, 20 Jun 2023 09:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <dfd93c84-757c-bf38-4b38-193d0ee2a425@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgC3bLDnBZFkbqVlMA--.19679S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kurWfWw13tF4kXF1rCrg_yoW5KFy8pa
        47Zan5KF10g3yUuF4xJ3yxXF4I9w4rAr4UAry5Ww17urZ8Wrn29Fn7tF45WF1qgrWxCa1Y
        vFW5Z3yYgwnYyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 6/13/2023 9:22 AM, Kemeng Shi wrote:
> 
> 
> on 6/12/2023 11:49 AM, Theodore Ts'o wrote:
>> On Mon, Jun 12, 2023 at 10:24:55AM +0800, Kemeng Shi wrote:
>>
>>> Hi ted, sorry for this issue. This patch added a WARN_ON for case that we free block
>>> to uninitialized block group which should be invalid.
>>> We can simply remove the WARN_ON to allow free on uninitialized block group as old
>>> way for emergency fix and I will find out why we free blocks to uninitialized block
>>> group in fast commit code path and is it a valid behavior.
>>
>> What I've done for now in the dev branch was to drop patches 12
>> through 19 of this patch series.  That seemed to be a good break
>> point, and I wanted to make sure we had something working so we can
>> start doing a lot more intesive testing on the patches so far.
>>
>> Also, that way, when you resend the last 8 patches in the patch
>> series, we can make sure they get a proper review as opposed to making
>> changes on the fly.
> Sure, I will resend last 8 patches after I solve the issue. I can also take my time
> to look at problem in this way :)
Updates for how WARN_ON of free blocks to uninitialized block group is triggerred under
fast commit path in test generic/468.

# /sbin/mkfs.ext4  -F  -q -O inline_data,fast_commit  /dev/vdc
# /bin/mount -t ext4 -o acl,user_xattr -o block_validity /dev/vdc /vdc
# /root/xfstests/bin/xfs_io -i -f -c 'truncate 4202496' -c 'pwrite 0
4202496' -c fsync -c 'falloc  4202496 104857600' /vdc/testfile

The "falloc  4202496 104857600" will trigger block allocation in a
new uninitialized block group for file range "4202496 104857600" as
following:
ext4_map_blocks
  /*
   * Alloc blocks from uninitialized block group. Change to set
   * group intialized will be full journaled.
   */
  ext4_mb_new_blocks

  [...]

  /*
   * New extents will be tracked in fast commit.
   */
  ext4_fc_track_range

  /*
   * Add new extents of allocated range to inode which still has sapce
   * in ext_inode_hdr
   */
  ext4_ext_insert_extent
    [...]
    /*
     * depth is 0 as inode has space in ext_inode_hdr, this will track
     * inode in fast commit.
     */
    ext4_ext_dirty(handle, inode, path + path->p_depth);
      ext4_mark_inode_dirty
        ext4_mark_iloc_dirty
          ext4_fc_track_inode

# /root/xfstests/bin/xfs_io -i -c fsync /vdc/testfile
The fast commit is performed in fsync as following:
vfs_fsync
  ext4_fsync_journal
    ext4_fc_commit
      ext4_fc_perform_commit
        add EXT4_FC_TAG_ADD_RANGE of new extent range
        add EXT4_FC_TAG_INODE of changed inode

# /root/xfstests/src/godown /vdc
Journaled change to set group intialized is discard as following:
ext4_shutdown
  jbd2_journal_abort

# /bin/umount /dev/vdc
# /bin/mount -t ext4 -o acl,user_xattr -o block_validity /dev/vdc /vdc
Replay fast commit when mounting and added WARN_ON is triggered as
following:
ext4_fc_replay
  /*
   * replay EXT4_FC_TAG_ADD_RANGE, add extents contains blocks from
   * uninitialized group back to inode
   */
  ext4_fc_replay_add_range

  /*
   * replay EXT4_FC_TAG_INODE, this will mark trigger WARN_ON
   */
  ext4_fc_replay_inode
    /*
     * mark all blocks in old inode free, then blocks from uninitialized
     * block is freed and WARN_ON occurs
     */
    ext4_ext_clear_bb

    /* update inode with data journaled in fast commit */
    [...]

    /*
     * mark all blocks in new inode in use, and gdp will be mark
     * initialized normally
     */
    ext4_fc_record_modified_inode
    [...]
    ext4_fc_set_bitmaps_and_counters

In this situation, free blocks to uninitialized block group do no harm.
And there may be more harmless situations, so I would like to simply
drop WARN_ON in next version.

-- 
Best wishes
Kemeng Shi

