Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64077EFAD
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 05:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjHQDyI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 23:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbjHQDx7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 23:53:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E165270C;
        Wed, 16 Aug 2023 20:53:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRB293Ybmz4f3jLX;
        Thu, 17 Aug 2023 11:53:53 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCXuGzQmd1kyy6SAw--.18720S2;
        Thu, 17 Aug 2023 11:53:53 +0800 (CST)
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
 <20230816034730.GT2247938@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
Date:   Thu, 17 Aug 2023 11:53:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230816034730.GT2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCXuGzQmd1kyy6SAw--.18720S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1xuw4Uuw18CF4ftry8AFb_yoW3Zrc_Xr
        yIgF4DX3s5Krs3Aan3Krn0grWxCF4UA347AF18ur97WrykWrZ5XayDWrZrZryDAa47tas8
        C343KFy7KrySvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/16/2023 11:47 AM, Theodore Ts'o wrote:
> On Thu, Jun 29, 2023 at 08:00:43PM +0800, Kemeng Shi wrote:
>> Commit 0acdb8876fead ("ext4: don't call update_backups() multiple times
>> for the same bg") add check in ext4_flex_group_add to avoid call
>> update_backups multiple times for block group descriptors in the same
>> group descriptor block. However, we have already call update_backups in
>> block step, so the added check is unnecessary.
> 
> I'm having trouble understaind this comit.  What do you mean by the
> "block step" in the last paragraph?
> 
Sorry for the confusing stuff. I mean we foreach in group descriptor block
step instead of foreach in group descriptor step to update backup.
So there is no chance to call update_backups for different descriptors
in the same bg.

> 					- Ted
> 

