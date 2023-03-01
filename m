Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E16A64CA
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAB24 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 20:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCAB2z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 20:28:55 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53997B446;
        Tue, 28 Feb 2023 17:28:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PRGpf0JHqz4f3jHj;
        Wed,  1 Mar 2023 09:28:42 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAnlS9Iqv5jSnztEA--.47939S2;
        Wed, 01 Mar 2023 09:28:42 +0800 (CST)
Subject: Re: [PATCH v2 00/20] Some bugfix and cleanup to mballoc
To:     Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
 <87356pwxyc.fsf@doe.com> <Y/6AgYotmMdjei3w@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <81568343-36fb-aa90-2952-d1f26547541c@huaweicloud.com>
Date:   Wed, 1 Mar 2023 09:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y/6AgYotmMdjei3w@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAnlS9Iqv5jSnztEA--.47939S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUCr48Kry7CrW5XrWkWFg_yoW8Wr1Dpa
        y8GF1akF4fKrWftr97ur1IgFyrtrZ5AFWUJF45Gw1UuFZ8Z3s2ga4xKr4rZF98AryI9r1a
        ya1Iq3ZIg3Wxt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

on 3/1/2023 6:30 AM, Theodore Ts'o wrote:
> On Tue, Feb 28, 2023 at 10:04:35PM +0530, Ritesh Harjani wrote:
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>
>>> Hi, this series contain some random cleanup patches and some bugfix
>>> patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
>>> from race and so on. More details can be found in git log.
>>> Thanks!
>>
>> Hi Kemeng,
>>
>> Did you run any testing on these patches? Because I was very easily able
>> to hit ext/009 causing kernel BUG_ON with default mkfs/mount options.
>> It's always a good and recommended practice to ensure some level of
>> testing on any of the patches we submit to community for review
>> and call out in the cover letter on what has been tested and what is not.
> 
> Hi Kemeng,
> 
> If you need help running xfstests, I maintain a test appliance which
> makes it very easy to run xfstests on development kernels.  Please see:
> 
> https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
> https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> This test appliance can also be run on Android devices and using
> Google Compute Engine; for more information see:
> 
> 	https://thunk.org/android-xfstests
> 	https://thunk.org/gce-xfstests
> 
> If you're just getting started, I recommend that you start with
> kvm-xfstests, and this is the simplest way to get started.
Hi, Theodore and Ritesh. Thanks for feedback. I will run xfstests before submitting
next version. Thanks!

-- 
Best wishes
Kemeng Shi

