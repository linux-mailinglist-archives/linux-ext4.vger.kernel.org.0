Return-Path: <linux-ext4+bounces-1453-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07786DDCB
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D028ADF5
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C556A328;
	Fri,  1 Mar 2024 09:03:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B367E7A;
	Fri,  1 Mar 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283813; cv=none; b=eKW/x4g9Z1xOeoZHhHGDVnXS8hXrTQaAXRscqc2ztBQf/41FzfvN8Aa1hkl1SQ+5vsqZy7eaeVRZKPPfORDRaP2FTzTIVPlqb3YpvyiDte4xp+0PBHPXx1HTza4qLvOCBrf0sOjtS+exdCPhfQYgaP7f2MEM2aqquzqjCD+H9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283813; c=relaxed/simple;
	bh=oD3NmHcE+EZtd+/bsX+K5LPApFpsLvZKYdyavBZQE0c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aXQQeM0HjLyoMU/5CrDEQl9P9OkdlBhpH/I+EPFxlghW/uRvdRtih5nansecv6nPWboyKP9tmAKKs90m+P2yqpn7i4bTrq5/GgkXfmTMca0XzvsuZTVK5GxOgPam0+Uh1nHvWNI4NAZ7m5qq2KSBY3mOUjDxr6HiJ1EHIxYMHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TmMZJ0Ngcz4f3mJg;
	Fri,  1 Mar 2024 17:03:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5520A1A2266;
	Fri,  1 Mar 2024 17:03:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCHogvbmeFlgjJqFg--.48146S2;
	Fri, 01 Mar 2024 17:03:25 +0800 (CST)
Subject: Re: [PATCH 1/2] ext4: alloc test super block from sget
To: Christian Brauner <brauner@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
 daniel.diaz@linaro.org, linux@roeck-us.net
References: <20240301120816.22581-1-shikemeng@huaweicloud.com>
 <20240301120816.22581-2-shikemeng@huaweicloud.com>
 <20240301-neuland-zoomen-4152b34c6fba@brauner>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <48d4b5a1-8f2a-454e-7455-fb1184e576dc@huaweicloud.com>
Date: Fri, 1 Mar 2024 17:03:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240301-neuland-zoomen-4152b34c6fba@brauner>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHogvbmeFlgjJqFg--.48146S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW5Zr18uryfCF1DZw1fWFg_yoW5tFW5pF
	y3ZFyFkr48WrWqga1IqFykZrySq3WxWFykGry29w1rJF90gry8GFWktF1rury8urWxGFs5
	ZF1DKrW7ur15Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/1/2024 4:25 PM, Christian Brauner wrote:
> On Fri, Mar 01, 2024 at 08:08:15PM +0800, Kemeng Shi wrote:
>> This fix the oops in ext4 unit test which is cuased by NULL sb.s_user_ns
>> as following:
>> <4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
>> <4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
>> <4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174)
>> <4>[ 14.346696] alloc_inode (fs/inode.c:268)
>> <4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
>> <4>[ 14.348016] new_inode (fs/inode.c:1033)
>> <4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:3719)
>> <4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
>> fs/ext4/mballoc-test.c:314)
>> <4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c:443)
>> <4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30)
>> <4>[ 14.351530] kthread (kernel/kthread.c:388)
>> <4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
>> <0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)
>>
>> Alloc test super block from sget to properly initialize test super block
>> to fix the issue.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  fs/ext4/mballoc-test.c | 46 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
>> index 12d0b22cabe1..1da52bbf4599 100644
>> --- a/fs/ext4/mballoc-test.c
>> +++ b/fs/ext4/mballoc-test.c
>> @@ -21,16 +21,27 @@ struct mbt_ctx {
>>  };
>>  
>>  struct mbt_ext4_super_block {
>> -	struct super_block sb;
>> +	struct ext4_super_block es;
>> +	struct ext4_sb_info sbi;
>>  	struct mbt_ctx mbt_ctx;
>>  };
>>  
>> -#define MBT_CTX(_sb) (&(container_of((_sb), struct mbt_ext4_super_block, sb)->mbt_ctx))
>> +#define MBT_SB(_sb) (container_of((_sb)->s_fs_info, struct mbt_ext4_super_block, sbi))
>> +#define MBT_CTX(_sb) (&MBT_SB(_sb)->mbt_ctx)
>>  #define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
>>  
>>  static const struct super_operations mbt_sops = {
>>  };
>>  
>> +static void mbt_kill_sb(struct super_block *sb)
>> +{
>> +}
>> +
>> +static struct file_system_type mbt_fs_type = {
>> +	.name			= "mballoc test",
>> +	.kill_sb		= mbt_kill_sb,
>> +};
>> +
>>  static int mbt_mb_init(struct super_block *sb)
>>  {
>>  	int ret;
>> @@ -72,43 +83,48 @@ static void mbt_mb_release(struct super_block *sb)
>>  	kfree(sb->s_bdev);
>>  }
>>  
>> +static int mbt_set(struct super_block *sb, void *data)
>> +{
>> +	return 0;
>> +}
>> +
>>  static struct super_block *mbt_ext4_alloc_super_block(void)
>>  {
>> -	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
>> -	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>>  	struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
>> +	struct super_block *sb = sget(&mbt_fs_type, NULL, mbt_set, 0, NULL);
>> +	struct ext4_sb_info *sbi;
>>  
>> -	if (fsb == NULL || sbi == NULL || es == NULL)
>> +	if (fsb == NULL || sb == NULL)
> 
> sget() returns error pointer on failure. So you should check for IS_ERR(sb).
> 
Thanks a lot for review. I will fix it in next version.


