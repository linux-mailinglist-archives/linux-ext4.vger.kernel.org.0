Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AFA77EF3A
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 04:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbjHQC5k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 22:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbjHQC5J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 22:57:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53A273C;
        Wed, 16 Aug 2023 19:57:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RR8mc5TsKz4f3xs2;
        Thu, 17 Aug 2023 10:57:04 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgA3sy9_jN1kfRZjAw--.5111S2;
        Thu, 17 Aug 2023 10:57:05 +0800 (CST)
Subject: Re: [PATCH 08/13] ext4: calculate free_clusters_count in cluster unit
 in verify_group_input
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-9-shikemeng@huaweicloud.com>
 <20230816032212.GP2247938@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cd3d1e6b-d946-8053-fd78-23ffab8176e6@huaweicloud.com>
Date:   Thu, 17 Aug 2023 10:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230816032212.GP2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgA3sy9_jN1kfRZjAw--.5111S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy8CF13Zw45AF13Wr15urg_yoW8JFy8pF
        Z0kFs8KFyrKrWjkFsxJws7XFWFkw4UX3W7XFWUW34ayFZrGryfKFnxKFZ0v3Z0vFnxC3Wj
        qw43CryxCw1DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
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



on 8/16/2023 11:22 AM, Theodore Ts'o wrote:
> On Thu, Jun 29, 2023 at 08:00:39PM +0800, Kemeng Shi wrote:
>> We treat free_clusters_count in cluster unit while free_blocks_count is
>> in block unit. Convert free_blocks_count to cluster unit to match the
>> unit.
>> Currently, verify_group_input is only called from ext4_ioctl_group_add
>> which does not support bigalloc yet. The dismatch is easily ingored
>> when we try to support bigalloc in ext4_ioctl_group_add (ext4_resize_fs
>> already supports resize with bigalloc enabled). Just fix this in
>> advance.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> I'd rewrite the commit description a bit:
> 
> The field free_cluster_count in struct ext4_new_group_data should be
> in units of clusters.  In verify_group_input() this field is being
> filled in units of blocks.  Fortunately, we don't support online
> resizing of bigalloc file systems, and for non-bigalloc file systems,
> the cluster size == block size.  But fix this in case we do support
> online resizing of bigalloc file systems in the future.
> 
Sorry for my poor language and thanks a lot for the rewrite. I will
fill rewriten description in next version!
> Other than that:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> 						- Ted
> 

