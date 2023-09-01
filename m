Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA378F72B
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjIACdN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 22:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjIACdN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 22:33:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621FE6E
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 19:33:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcMWz0mnjz4f3mHx
        for <linux-ext4@vger.kernel.org>; Fri,  1 Sep 2023 10:33:03 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqVeTfFkMDBKCA--.12786S3;
        Fri, 01 Sep 2023 10:33:04 +0800 (CST)
Subject: Re: [RFC PATCH 00/16] ext4: more accurate metadata reservaion for
 delalloc mount option
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
 <20230830153035.pnkmbuu5ra5xngp3@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <930970cd-24b5-fe0d-c7b8-7911d7afcddb@huaweicloud.com>
Date:   Fri, 1 Sep 2023 10:33:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230830153035.pnkmbuu5ra5xngp3@quack3>
Content-Type: multipart/mixed;
 boundary="------------0172E9FC06A30383306041EF"
Content-Language: en-US
X-CM-TRANSID: gCh0CgDHoqVeTfFkMDBKCA--.12786S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48tF15Aw1xZw1DXr4xJFb_yoWxKw1DpF
        Wagw1Sq3WkZr18X3Z7Aw1IqFyrua1rtFW5Gr1Fgr1xZws8Wr1Sqr1rKa4YvFW29rZ7J3Wj
        qr4q9a48ua4qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02
        F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
        0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4xvF2IEb7IF0Fy26I8I
        3I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjxUFyxRDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------0172E9FC06A30383306041EF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello! Thanks for your reply.

On 2023/8/30 23:30, Jan Kara wrote:
> Hello!
> 
> On Thu 24-08-23 17:26:03, Zhang Yi wrote:
>> The delayed allocation method allocates blocks during page writeback in
>> ext4_writepages(), which cannot handle block allocation failures due to
>> e.g. ENOSPC if acquires more extent blocks. In order to deal with this,
>> commit '79f0be8d2e6e ("ext4: Switch to non delalloc mode when we are low
>> on free blocks count.")' introduce ext4_nonda_switch() to convert to no
>> delalloc mode if the space if the free blocks is less than 150% of dirty
>> blocks or the watermark.
> 
> Well, that functionality is there mainly so that we can really allocate all
> blocks available in the filesystem. But you are right that since we are not
> reserving metadata blocks explicitely anymore, it is questionable whether
> we really still need this.
> 
>> In the meantime, '27dd43854227 ("ext4:
>> introduce reserved space")' reserve some of the file system space (2% or
>> 4096 clusters, whichever is smaller). Both of those to solutions can
>> make sure that space is not exhausted when mapping delalloc blocks in
>> most cases, but cannot guarantee work in all cases, which could lead to
>> infinite loop or data loss (please see patch 14 for details).
> 
> OK, I agree that in principle there could be problems due to percpu
> counters inaccuracy etc. but were you able to reproduce the problem under
> some at least somewhat realistic conditions? We were discussing making
> free space percpu counters switch to exact counting in case we are running
> tight on space to avoid these problems but it never proved to be a problem
> in practice so we never bothered to actually implement it.
> 

Yes, we catch this problem in our products firstly and we reproduced it
when doing stress test on low free space disk, but the frequency is
very low. After analysis we found the root cause, and Zhihao helped to
write a 100% reproducer below.

1. Apply the 'infinite_loop.diff' in attachment, add info and delay
   into ext4 code.
2. Run 'enospc.sh' on a virtual machine with 4 CPU (important, because
   the cpu number will affect EXT4_FREECLUSTERS_WATERMARK and also
   affect the reproduce).

After several minutes, the writeback process will loop infinitely, and
other processes which rely on it will hung.

[  304.815575] INFO: task sync:7292 blocked for more than 153 seconds.
[  304.818130]       Not tainted 6.5.0-dirty #578
[  304.819926] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  304.822747] task:sync            state:D stack:0     pid:7292  ppid:1      flags:0x00004000
[  304.825677] Call Trace:
[  304.826538]  <TASK>
[  304.827307]  __schedule+0x577/0x12b0
[  304.828300]  ? sync_fs_one_sb+0x50/0x50
[  304.829433]  schedule+0x9d/0x1e0
[  304.830451]  wb_wait_for_completion+0x82/0xd0
[  304.831811]  ? cpuacct_css_alloc+0x100/0x100
[  304.833090]  sync_inodes_sb+0xf1/0x440
[  304.834207]  ? sync_fs_one_sb+0x50/0x50
[  304.835304]  sync_inodes_one_sb+0x21/0x30
[  304.836528]  iterate_supers+0xd2/0x180
[  304.837614]  ksys_sync+0x50/0xf0
[  304.838356]  __do_sys_sync+0x12/0x20
[  304.839207]  do_syscall_64+0x68/0xf0
[  304.839964]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

On the contrary, after doing a little tweaking the delay injection
procedure, we could reproduce the data loss problem easily.

1. Apply the 'data_loss.diff' in the attachment.
2. Run 'enospc.sh' like the previous one, then we got below error message.

[   52.226320] EXT4-fs (sda): Delayed block allocation failed for inode 571 at logical offset 8 with max blocks 1 with error 28
[   52.229126] EXT4-fs (sda): This should not happen!! Data will be lost

>> This patch set wants to reserve metadata space more accurate for
>> delalloc mount option. The metadata blocks reservation is very tricky
>> and is also related to the continuity of physical blocks, an effective
>> way is to reserve as the worst case, which means that every data block
>> is discontinuous and one data block costs an extent entry. Reserve
>> metadata space as the worst case can make sure enough blocks reserved
>> during data writeback, the unused reservaion space can be released after
>> mapping data blocks.
> 
> Well, as you say, there is a problem with the worst case estimates - either
> you *heavily* overestimate the number of needed metadata blocks or the code
> to estimate the number of needed metadata blocks is really complex. We used
> to have estimates of needed metadata and we ditched that code (in favor of
> reserved clusters) exactly because it was complex and suffered from
> cornercases that were hard to fix. I haven't quite digested the other
> patches in this series to judge which case is it but it seems to lean on
> the "complex" side :).
> 
> So I'm somewhat skeptical this complexity is really needed but I can be
> convinced :).

I understand your concern. At first I tried to solve this problem with
other simple solutions, but failed. I suppose reserve blocks for the
worst case is the only way to cover all cases, and I noticed that xfs
also uses this reservation method, so I learned the implementation from
it, but it's not exactly the same.

Although it's a worst-case reservation, it is not that complicated.
Firstly, the estimate formula is simple, just add the 'extent & node'
blocks calculated by the **total** delay allocated data blocks and the
remaining btree heights (no need to concern whether the logical
positions of each extents are continuous or not, the btree heights can
be merged between each discontinuous extent entries of one inode, this
can reduce overestimate to some extent). Secondary, the method of
reserving metadata blocks is similar to that of reserving data blocks,
just the estimate formula is different. Fortunately, there already have
data reservation helpers like ext4_da_update_reserve_space() and
ext4_da_release_reserve_space(), it works only takes some minor
changes. BTW, I don't really know the ditched estimation and
cornercases you mentioned, how it's like?

Finally, maybe this reservation could bring other benefits in the long
run. For example, after we've done this, maybe we could also reserve
metadata for DIO and buffer IO with dioread_nolock in the future, then
we could drop EXT4_GET_BLOCKS_PRE_IO safely, which looks like a
compromise, maybe we could get some improve performance if do this (I
haven't thought deeply, just a whim :) ). But it's a different thing.

> 
>> After doing this, add a worker to submit delayed
>> allocations to prevent excessive reservations. Finally, we could
>> completely drop the policy of switching back to non-delayed allocation.
> 
> BTW the worker there in patch 15 seems really pointless. If you do:
> queue_work(), flush_work() then you could just directly do the work inline
> and get as a bonus more efficiency and proper lockdep tracking of
> dependencies. But that's just a minor issue I have noticed.
> 

Yes, I added this worker because I want to run the work asynchronously
if the s_dirtyclusters_counter is running beyond watermark. In this way,
the I/O flow could be smoother. But I didn't implement it because I
don't know if you like this estimate solution, I can do it if so.

Thanks,
Yi.



--------------0172E9FC06A30383306041EF
Content-Type: text/plain; charset=UTF-8;
 name="data_loss.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="data_loss.diff"

ZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5vZGUuYwppbmRleCA0
Mzc3NWE2Y2E1MDUuLjY3NzJjYmM3NDIyNCAxMDA2NDQKLS0tIGEvZnMvZXh0NC9pbm9kZS5j
CisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpAQCAtMjE5Miw2ICsyMTkyLDcgQEAgc3RhdGljIGlu
dCBtcGFnZV9tYXBfb25lX2V4dGVudChoYW5kbGVfdCAqaGFuZGxlLCBzdHJ1Y3QgbXBhZ2Vf
ZGFfZGF0YSAqbXBkKQogICogbWFwcGVkIHNvIHRoYXQgaXQgY2FuIGJlIHdyaXR0ZW4gb3V0
IChhbmQgdGh1cyBmb3J3YXJkIHByb2dyZXNzIGlzCiAgKiBndWFyYW50ZWVkKS4gQWZ0ZXIg
bWFwcGluZyB3ZSBzdWJtaXQgYWxsIG1hcHBlZCBwYWdlcyBmb3IgSU8uCiAgKi8KKyNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPgogc3RhdGljIGludCBtcGFnZV9tYXBfYW5kX3N1Ym1pdF9l
eHRlbnQoaGFuZGxlX3QgKmhhbmRsZSwKIAkJCQkgICAgICAgc3RydWN0IG1wYWdlX2RhX2Rh
dGEgKm1wZCwKIAkJCQkgICAgICAgYm9vbCAqZ2l2ZV91cF9vbl93cml0ZSkKQEAgLTIyMDMs
NiArMjIwNCw3IEBAIHN0YXRpYyBpbnQgbXBhZ2VfbWFwX2FuZF9zdWJtaXRfZXh0ZW50KGhh
bmRsZV90ICpoYW5kbGUsCiAJaW50IHByb2dyZXNzID0gMDsKIAlleHQ0X2lvX2VuZF90ICpp
b19lbmQgPSBtcGQtPmlvX3N1Ym1pdC5pb19lbmQ7CiAJc3RydWN0IGV4dDRfaW9fZW5kX3Zl
YyAqaW9fZW5kX3ZlYzsKKwlzdGF0aWMgaW50IHdhaXQgPSAwOwogCiAJaW9fZW5kX3ZlYyA9
IGV4dDRfYWxsb2NfaW9fZW5kX3ZlYyhpb19lbmQpOwogCWlmIChJU19FUlIoaW9fZW5kX3Zl
YykpCkBAIC0yMjEzLDYgKzIyMTUsMjYgQEAgc3RhdGljIGludCBtcGFnZV9tYXBfYW5kX3N1
Ym1pdF9leHRlbnQoaGFuZGxlX3QgKmhhbmRsZSwKIAkJaWYgKGVyciA8IDApIHsKIAkJCXN0
cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsKIAorCQkJaWYgKCF3YWl0ICYm
IGVyciA9PSAtRU5PU1BDKSB7CisJCQkJd2FpdCA9IDE7CisJCQkJaWYgKCFleHQ0X2NvdW50
X2ZyZWVfY2x1c3RlcnMoc2IpKSB7CisJCQkJCS8qCisJCQkJCSAqIEZhaWxlZCB0byBhbGxv
Y2F0ZSBtZXRhZGF0YSBibG9jaywKKwkJCQkJICogd2lsbCB0cmlnZ2VyIGluZmluaXRlIGxv
b3AgYW5kIGh1bmcuCisJCQkJCSAqLworCQkJCQlwcl9lcnIoIndpbGwgaHVuZ1xuIik7CisJ
CQkJfSBlbHNlIHsKKwkJCQkJLyoKKwkJCQkJICogRmFpbGVkIHRvIGFsbG9jYXRlIGRhdGEg
YmxvY2ssIHdhaXQKKwkJCQkJICogdGVzdC5zaCB0byBmcmVlIGEgYmxvY2suCisJCQkJCSAq
LworCQkJCQlwcl9lcnIoIndhaXQgZnJlZVxuIik7CisJCQkJCW1zbGVlcCgzMDAwKTsKKwkJ
CQkJcHJfZXJyKCJhZnRlciBmcmVlLCBub3cgJWxsdVxuIiwKKwkJCQkJCWV4dDRfY291bnRf
ZnJlZV9jbHVzdGVycyhzYikpOworCQkJCX0KKwkJCX0KKwogCQkJaWYgKGV4dDRfZm9yY2Vk
X3NodXRkb3duKEVYVDRfU0Ioc2IpKSB8fAogCQkJICAgIGV4dDRfdGVzdF9tb3VudF9mbGFn
KHNiLCBFWFQ0X01GX0ZTX0FCT1JURUQpKQogCQkJCWdvdG8gaW52YWxpZGF0ZV9kaXJ0eV9w
YWdlczsKQEAgLTI4ODgsNiArMjkxMCwxMCBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVf
YmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LAogCS8qIEluIGNhc2Ugd3JpdGViYWNrIGJlZ2FuIHdoaWxlIHRoZSBmb2xpbyB3YXMgdW5s
b2NrZWQgKi8KIAlmb2xpb193YWl0X3N0YWJsZShmb2xpbyk7CiAKKwkvKiBVc2UgdGFzayBu
YW1lIGFuZCBESVNDQVJEIG1vdW50IG9wdGlvbiBhcyBkZWxheSBpbmplY3QgZmlsdGVyLiAq
LworCWlmICghc3RyY21wKGN1cnJlbnQtPmNvbW0sICJkZCIpICYmIHRlc3Rfb3B0KGlub2Rl
LT5pX3NiLCBESVNDQVJEKSkKKwkJbXNsZWVwKDMwMDApOworCiAjaWZkZWYgQ09ORklHX0ZT
X0VOQ1JZUFRJT04KIAlyZXQgPSBleHQ0X2Jsb2NrX3dyaXRlX2JlZ2luKGZvbGlvLCBwb3Ms
IGxlbiwgZXh0NF9kYV9nZXRfYmxvY2tfcHJlcCk7CiAjZWxzZQpkaWZmIC0tZ2l0IGEvZnMv
ZXh0NC9zdXBlci5jIGIvZnMvZXh0NC9zdXBlci5jCmluZGV4IGM5NGViZjcwNDYxNi4uNzlm
NGU5NmI4NjkxIDEwMDY0NAotLS0gYS9mcy9leHQ0L3N1cGVyLmMKKysrIGIvZnMvZXh0NC9z
dXBlci5jCkBAIC01NzE1LDYgKzU3MTUsMTUgQEAgc3RhdGljIGludCBleHQ0X2ZpbGxfc3Vw
ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCiAJ
LyogVXBkYXRlIHRoZSBzX292ZXJoZWFkX2NsdXN0ZXJzIGlmIG5lY2Vzc2FyeSAqLwogCWV4
dDRfdXBkYXRlX292ZXJoZWFkKHNiLCBmYWxzZSk7CisKKwlpZiAoIXN0cmNtcChzYi0+c19i
ZGV2LT5iZF9kaXNrLT5kaXNrX25hbWUsICJzZGEiKSkgeworCQlwcl9lcnIoInJfYmxvY2tz
ICVsbGQgc19yZXN2X2NsdXN0ZXJzICVsbHUgZnJlZSAlbGxkIGRpcnR5ICVsbGQgRVhUNF9G
UkVFQ0xVU1RFUlNfV0FURVJNQVJLICV1XG4iLAorCQkJKGV4dDRfcl9ibG9ja3NfY291bnQo
c2JpLT5zX2VzKSA+PiBzYmktPnNfY2x1c3Rlcl9iaXRzKSwKKwkJCWF0b21pYzY0X3JlYWQo
JnNiaS0+c19yZXN2X2NsdXN0ZXJzKSwKKwkJCXBlcmNwdV9jb3VudGVyX3JlYWRfcG9zaXRp
dmUoJnNiaS0+c19mcmVlY2x1c3RlcnNfY291bnRlciksCisJCQlwZXJjcHVfY291bnRlcl9y
ZWFkX3Bvc2l0aXZlKCZzYmktPnNfZGlydHljbHVzdGVyc19jb3VudGVyKSwKKwkJCUVYVDRf
RlJFRUNMVVNURVJTX1dBVEVSTUFSSyk7CisJfQogCXJldHVybiAwOwogCiBmcmVlX3NiaToK

--------------0172E9FC06A30383306041EF
Content-Type: text/plain; charset=UTF-8;
 name="infinite_loop.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="infinite_loop.diff"

ZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5vZGUuYwppbmRleCA0
Mzc3NWE2Y2E1MDUuLjExZTQ3YTUzMDQzNSAxMDA2NDQKLS0tIGEvZnMvZXh0NC9pbm9kZS5j
CisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpAQCAtMjE5Miw2ICsyMTkyLDcgQEAgc3RhdGljIGlu
dCBtcGFnZV9tYXBfb25lX2V4dGVudChoYW5kbGVfdCAqaGFuZGxlLCBzdHJ1Y3QgbXBhZ2Vf
ZGFfZGF0YSAqbXBkKQogICogbWFwcGVkIHNvIHRoYXQgaXQgY2FuIGJlIHdyaXR0ZW4gb3V0
IChhbmQgdGh1cyBmb3J3YXJkIHByb2dyZXNzIGlzCiAgKiBndWFyYW50ZWVkKS4gQWZ0ZXIg
bWFwcGluZyB3ZSBzdWJtaXQgYWxsIG1hcHBlZCBwYWdlcyBmb3IgSU8uCiAgKi8KKyNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPgogc3RhdGljIGludCBtcGFnZV9tYXBfYW5kX3N1Ym1pdF9l
eHRlbnQoaGFuZGxlX3QgKmhhbmRsZSwKIAkJCQkgICAgICAgc3RydWN0IG1wYWdlX2RhX2Rh
dGEgKm1wZCwKIAkJCQkgICAgICAgYm9vbCAqZ2l2ZV91cF9vbl93cml0ZSkKQEAgLTIyMDMs
NiArMjIwNCw3IEBAIHN0YXRpYyBpbnQgbXBhZ2VfbWFwX2FuZF9zdWJtaXRfZXh0ZW50KGhh
bmRsZV90ICpoYW5kbGUsCiAJaW50IHByb2dyZXNzID0gMDsKIAlleHQ0X2lvX2VuZF90ICpp
b19lbmQgPSBtcGQtPmlvX3N1Ym1pdC5pb19lbmQ7CiAJc3RydWN0IGV4dDRfaW9fZW5kX3Zl
YyAqaW9fZW5kX3ZlYzsKKwlzdGF0aWMgaW50IHdhaXQgPSAwOwogCiAJaW9fZW5kX3ZlYyA9
IGV4dDRfYWxsb2NfaW9fZW5kX3ZlYyhpb19lbmQpOwogCWlmIChJU19FUlIoaW9fZW5kX3Zl
YykpCkBAIC0yMjEzLDYgKzIyMTUsMjYgQEAgc3RhdGljIGludCBtcGFnZV9tYXBfYW5kX3N1
Ym1pdF9leHRlbnQoaGFuZGxlX3QgKmhhbmRsZSwKIAkJaWYgKGVyciA8IDApIHsKIAkJCXN0
cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsKIAorCQkJaWYgKCF3YWl0ICYm
IGVyciA9PSAtRU5PU1BDKSB7CisJCQkJd2FpdCA9IDE7CisJCQkJaWYgKCFleHQ0X2NvdW50
X2ZyZWVfY2x1c3RlcnMoc2IpKSB7CisJCQkJCS8qCisJCQkJCSAqIEZhaWxlZCB0byBhbGxv
Y2F0ZSBkYXRhIGJsb2NrLCB3YWl0CisJCQkJCSAqIHRlc3Quc2ggdG8gZnJlZSBhIGJsb2Nr
LgorCQkJCQkgKi8KKwkJCQkJcHJfZXJyKCJ3YWl0IGZyZWVcbiIpOworCQkJCQltc2xlZXAo
MzAwMCk7CisJCQkJCXByX2VycigiYWZ0ZXIgZnJlZSwgbm93ICVsbHVcbiIsCisJCQkJCQll
eHQ0X2NvdW50X2ZyZWVfY2x1c3RlcnMoc2IpKTsKKwkJCQl9IGVsc2UgeworCQkJCQkvKgor
CQkJCQkgKiBGYWlsZWQgdG8gYWxsb2NhdGUgbWV0YWRhdGEgYmxvY2ssCisJCQkJCSAqIHdp
bGwgdHJpZ2dlciBpbmZpbml0ZSBsb29wIGFuZCBodW5nLgorCQkJCQkgKi8KKwkJCQkJcHJf
ZXJyKCJ3aWxsIGh1bmdcbiIpOworCQkJCX0KKwkJCX0KKwogCQkJaWYgKGV4dDRfZm9yY2Vk
X3NodXRkb3duKEVYVDRfU0Ioc2IpKSB8fAogCQkJICAgIGV4dDRfdGVzdF9tb3VudF9mbGFn
KHNiLCBFWFQ0X01GX0ZTX0FCT1JURUQpKQogCQkJCWdvdG8gaW52YWxpZGF0ZV9kaXJ0eV9w
YWdlczsKQEAgLTI4ODgsNiArMjkxMCwxMCBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVf
YmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LAogCS8qIEluIGNhc2Ugd3JpdGViYWNrIGJlZ2FuIHdoaWxlIHRoZSBmb2xpbyB3YXMgdW5s
b2NrZWQgKi8KIAlmb2xpb193YWl0X3N0YWJsZShmb2xpbyk7CiAKKwkvKiBVc2UgdGFzayBu
YW1lIGFuZCBESVNDQVJEIG1vdW50IG9wdGlvbiBhcyBkZWxheSBpbmplY3QgZmlsdGVyLiAq
LworCWlmICghc3RyY21wKGN1cnJlbnQtPmNvbW0sICJkZCIpICYmIHRlc3Rfb3B0KGlub2Rl
LT5pX3NiLCBESVNDQVJEKSkKKwkJbXNsZWVwKDMwMDApOworCiAjaWZkZWYgQ09ORklHX0ZT
X0VOQ1JZUFRJT04KIAlyZXQgPSBleHQ0X2Jsb2NrX3dyaXRlX2JlZ2luKGZvbGlvLCBwb3Ms
IGxlbiwgZXh0NF9kYV9nZXRfYmxvY2tfcHJlcCk7CiAjZWxzZQpkaWZmIC0tZ2l0IGEvZnMv
ZXh0NC9zdXBlci5jIGIvZnMvZXh0NC9zdXBlci5jCmluZGV4IGM5NGViZjcwNDYxNi4uNzlm
NGU5NmI4NjkxIDEwMDY0NAotLS0gYS9mcy9leHQ0L3N1cGVyLmMKKysrIGIvZnMvZXh0NC9z
dXBlci5jCkBAIC01NzE1LDYgKzU3MTUsMTUgQEAgc3RhdGljIGludCBleHQ0X2ZpbGxfc3Vw
ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCiAJ
LyogVXBkYXRlIHRoZSBzX292ZXJoZWFkX2NsdXN0ZXJzIGlmIG5lY2Vzc2FyeSAqLwogCWV4
dDRfdXBkYXRlX292ZXJoZWFkKHNiLCBmYWxzZSk7CisKKwlpZiAoIXN0cmNtcChzYi0+c19i
ZGV2LT5iZF9kaXNrLT5kaXNrX25hbWUsICJzZGEiKSkgeworCQlwcl9lcnIoInJfYmxvY2tz
ICVsbGQgc19yZXN2X2NsdXN0ZXJzICVsbHUgZnJlZSAlbGxkIGRpcnR5ICVsbGQgRVhUNF9G
UkVFQ0xVU1RFUlNfV0FURVJNQVJLICV1XG4iLAorCQkJKGV4dDRfcl9ibG9ja3NfY291bnQo
c2JpLT5zX2VzKSA+PiBzYmktPnNfY2x1c3Rlcl9iaXRzKSwKKwkJCWF0b21pYzY0X3JlYWQo
JnNiaS0+c19yZXN2X2NsdXN0ZXJzKSwKKwkJCXBlcmNwdV9jb3VudGVyX3JlYWRfcG9zaXRp
dmUoJnNiaS0+c19mcmVlY2x1c3RlcnNfY291bnRlciksCisJCQlwZXJjcHVfY291bnRlcl9y
ZWFkX3Bvc2l0aXZlKCZzYmktPnNfZGlydHljbHVzdGVyc19jb3VudGVyKSwKKwkJCUVYVDRf
RlJFRUNMVVNURVJTX1dBVEVSTUFSSyk7CisJfQogCXJldHVybiAwOwogCiBmcmVlX3NiaToK

--------------0172E9FC06A30383306041EF
Content-Type: text/plain; charset=UTF-8;
 name="enospc.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="enospc.sh"

IyEvYmluL2Jhc2gKCnN5c2N0bCAtdyBrZXJuZWwuaHVuZ190YXNrX3RpbWVvdXRfc2Vjcz0x
NQp1bW91bnQgL3Jvb3QvdGVtcApta2ZzLmV4dDQgLUYgLWIgNDA5NiAvZGV2L3NkYSAxMDBN
Cm1vdW50IC9kZXYvc2RhIC9yb290L3RlbXAKZGQgaWY9L2Rldi96ZXJvIG9mPS9yb290L3Rl
bXAvZmlsZSBicz00SyBjb3VudD0xCmZvciBpIGluIHswLi4xMTAwfQpkbwoJdG91Y2ggL3Jv
b3QvdGVtcC9mXyRpCglkZCBpZj0vZGV2L3plcm8gb2Y9L3Jvb3QvdGVtcC9mXyRpIGJzPTRL
IGNvdW50PTEKCWRkIGlmPS9kZXYvemVybyBvZj0vcm9vdC90ZW1wL2ZfJGkgYnM9NEsgY291
bnQ9MSBzZWVrPTIKCWRkIGlmPS9kZXYvemVybyBvZj0vcm9vdC90ZW1wL2ZfJGkgYnM9NEsg
Y291bnQ9MSBzZWVrPTQKCWRkIGlmPS9kZXYvemVybyBvZj0vcm9vdC90ZW1wL2ZfJGkgYnM9
NEsgY291bnQ9MSBzZWVrPTYKZG9uZQpkZCBpZj0vZGV2L3plcm8gb2Y9L3Jvb3QvdGVtcC9j
b25zdW1lciBicz0xTSBjb3VudD02OAp1bW91bnQgL3Jvb3QvdGVtcAoKbW91bnQgLW9kaXNj
YXJkIC9kZXYvc2RhIC9yb290L3RlbXAKZm9yIGkgaW4gezAuLjExMDB9CmRvCglkZCBpZj0v
ZGV2L3plcm8gb2Y9L3Jvb3QvdGVtcC9mXyRpIGJzPTRLIGNvdW50PTEgc2Vlaz04ICYKZG9u
ZQpzbGVlcCAxCmRtZXNnIC1jID4gL2Rldi9udWxsCndhaXQKc3luYyAmCnNsZWVwIDEKd2hp
bGUgdHJ1ZQpkbwoJcmVzPWBkbWVzZyAtY2AKCWlmIFtbICIkcmVzIiA9fiAid2FpdCBmcmVl
IiBdXQoJdGhlbgoJCWVjaG8gImRlbGV0ZSBmaWxlIgoJCXJtIC1mIC9yb290L3RlbXAvZmls
ZQoJCWJyZWFrOwoJZWxpZiBbWyAiJHJlcyIgPX4gIndpbGwgaHVuZyIgXV0KCXRoZW4KCQll
Y2hvICJ3aWxsIGh1bmciCgkJYnJlYWs7CglmaQoJc2xlZXAgMQpkb25lCgo=
--------------0172E9FC06A30383306041EF--

