Return-Path: <linux-ext4+bounces-669-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE1823C60
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 07:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2077AB24DB3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5881EB3E;
	Thu,  4 Jan 2024 06:50:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4A1D68E;
	Thu,  4 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T5HK51dvmz4f3kFB;
	Thu,  4 Jan 2024 14:50:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 867321A0AD8;
	Thu,  4 Jan 2024 14:50:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgAXcEArVZZlGBdpFg--.12294S2;
	Thu, 04 Jan 2024 14:50:20 +0800 (CST)
Subject: Re: [PATCH v2 2/9] ext4: remove unused parameter group in
 ext4_mb_choose_next_group_*()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
 <20240103102821.448134-3-shikemeng@huaweicloud.com>
 <ZZZI2yTyAXs3gIzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7a7df602-37b1-d134-ec51-7dba26f72213@huaweicloud.com>
Date: Thu, 4 Jan 2024 14:50:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZZI2yTyAXs3gIzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXcEArVZZlGBdpFg--.12294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw15CF1rAFWfKr17WryfZwb_yoW8Jr13pa
	9xJF18CryfXr1DuF12ga12qa4Fqw4IgF1jyryfXw15XrZrJrykGFy7tr1ruF1UAFs7G3Wf
	X3ZIvFyrCa17uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



on 1/4/2024 1:57 PM, Ojaswin Mujoo wrote:
> On Wed, Jan 03, 2024 at 06:28:14PM +0800, Kemeng Shi wrote:
>> Remove unused parameter group in ext4_mb_choose_next_group_*().
> 
> Hey Kemeng, 
> 
> Just a small thing, the parameter we are removing is "ngroups" rather
> than "group" so maybe fix that in the commit message. 
> 
> Other than that looks good, feel free to add
> 
Thanks for let me know. I will fix it in next version.
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>>  fs/ext4/mballoc.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 9f9b8dd06..765b62729 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -870,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>>   * cr level needs an update.
>>   */
>>  static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
>> -			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
>> +			enum criteria *new_cr, ext4_group_t *group)
>>  {
> 


