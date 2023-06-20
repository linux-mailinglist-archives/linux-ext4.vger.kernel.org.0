Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A6736102
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jun 2023 03:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFTBMz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jun 2023 21:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTBMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Jun 2023 21:12:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB3FC
        for <linux-ext4@vger.kernel.org>; Mon, 19 Jun 2023 18:12:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlTC30s1yz4f41VF
        for <linux-ext4@vger.kernel.org>; Tue, 20 Jun 2023 09:12:47 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+kO_ZBkC4cTMA--.20736S3;
        Tue, 20 Jun 2023 09:12:48 +0800 (CST)
Subject: Re: [PATCH v2] jbd2: skip reading super block if it has been verified
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
 <20230616132745.d3enqs4uni55abrj@quack3>
 <bfd1b9f3-7f0e-4b3c-9399-4d697be37a9e@huaweicloud.com>
 <20230617185057.GA343628@mit.edu>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <3e75763b-731f-98d2-a203-af4aab84f547@huaweicloud.com>
Date:   Tue, 20 Jun 2023 09:12:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230617185057.GA343628@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBnW+kO_ZBkC4cTMA--.20736S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4fKry3tFy5tF4xuw1fCrg_yoW5WFy8pr
        yYva48CrWqk3y7ZFn2qF47GrWFvw40kayUGrn5urWvy3y5Wrn7tr18Gw15XFy8CrZ3Ww10
        qF4Uu39xCa1YyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/18 2:50, Theodore Ts'o wrote:
> On Sat, Jun 17, 2023 at 10:42:59AM +0800, Zhang Yi wrote:
>>> This works as a workaround. It is a bit kludgy but for now I guess it is
>>> good enough. Thanks for the fix and feel free to add:
>>
>> Thanks for the review. Yes, I suppose it's better to find a way to adjust
>> the sequence of journal load and feature checking in ocfs2_check_volume(),
>> so that we could completely remove the journal_get_superblock() in
>> jbd2_journal_check_used_features().
> 
> Indeed, thanks for the fix.
> 
> This is would be for after the merge window, but I think we can clean
> this up in the jbd2 layer by simply moving the call to
> load_superblock() from jbd2_journal_load() and jbd2_journal_wipe() to
> journal_init_common().  This change would mean the journal superblock
> gets read as part of the call to jbd2_journal_init_{dev,inode}.
> 
> That way, once the file system has a journal_t object, it's guaranteed
> that the j_sb_buffer contains valid data, and so we can drop the call
> to journal_get_superblock() from jbd2_journal_check_used_features().
> 
> And after we do that, we should be able to inline the code in
> load_superblock() and journal_get_superblock() into
> journal_init_common(), which would simplify things in
> jfs/jbd2/journal.c
> 
> Finally, so we can provide better error handling, we could change
> Jbd2_journal_init_{dev,inode} to return an ERR_PTR instead of a NULL
> if there is a failure.  And since it's a good idea to change the
> function name when changing the function signature, we could rename
> those functions to something like jbd2_open_{dev,inode} at the same
> time.
> 
> 						- Ted
> 
> P.S.  The only reason why we don't load the superblock in
> jbd2_journal_init_{dev,common} was that back in 2001, it was possible
> to create the journal by creating a zero length file in the file
> system, noting the inode number of the file system, unmounting the
> file system from ext2, and then remounting it with "mount -t ext3 -o
> journal=NNN ...".  In order to do this, the ext3 file system code
> called journal_init_inode() with the inode, and then follow it up with
> a call to journal_create(), which would actually write out the journal
> superblock.  For that reason, journal_init_inode() had to avoid
> reading the journal superblock, since it might not be initialized yet.
> 
> We removed jbd2_journal_create() from fs/jbd2 back in 2009, and it
> hadn't been in use for quite a while before that --- in fact, I'm not
> sure ext4 ever supported this ext3-style "let's create a journal
> without e2fsprogs support because Stephen Tweedie was implementing the
> ext3 journal kernel code without wanting to make changes to e2fsprogs
> first" feature.  :-)
> 

Thanks for the suggestion and historical details, we could do the cleanup
in jbd2 layer after the merge window.

Thanks,
Yi.

