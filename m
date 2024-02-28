Return-Path: <linux-ext4+bounces-1413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5E86A4C0
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 02:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A7EB263AE
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CC15AF;
	Wed, 28 Feb 2024 01:10:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B7EBB;
	Wed, 28 Feb 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082632; cv=none; b=IkdiPz4rmTIwuuSiRigKilzIE+TZX/wcu1AVL9/2H+HRiUr8SfbfxgUBALWZ5SITlT0GR+DbfobhyY3LpnzdSMRNHvGyC86XV6gyNz8ZIdp02+nb9hEKVdZNA4RmU0zKf6IZPJw0opTCLobfjwx7O0/LJobdOib9C1yxy1X4O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082632; c=relaxed/simple;
	bh=gaprHsvvpzB2Qhz4D0S6l9iNs4rVT1XQlJS6wlttrQM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d9yAfh4lzLKKfDWvF9KwRx0THqjA2Smq92U/+IvBOeyrHpB9hC8zjwgOzumZrkjKFMytmTY+uKFdLKa8H4rmYEEiFFnFKIC+J0z7SipJNV6xEowCbSrfvQVqSLLHMaVro1AbO80gdspcP4WJWTFtxM44Wzqod9LuL8MqnyF6hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tkx9V0nGzz4f3k6L;
	Wed, 28 Feb 2024 09:10:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 724411A0C09;
	Wed, 28 Feb 2024 09:10:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCH2Wv_h95lMzTKFQ--.64760S2;
	Wed, 28 Feb 2024 09:10:25 +0800 (CST)
Subject: Re: [PATCH] ext4: kunit: use dynamic inode allocation
To: Arnd Bergmann <arnd@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227161548.2929881-1-arnd@kernel.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9a83d019-b0c7-5a00-c2af-7115bd596c71@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:10:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240227161548.2929881-1-arnd@kernel.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH2Wv_h95lMzTKFQ--.64760S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45WrWUCFWxuw48Xr48Crg_yoW5tr1fpa
	nxCF1Ykr45Wrykuw4I9r4UZr1Sga18XrW8tryfW3yjqFW3XrySkF1ktF18ZF1xtr48Xw42
	v3WjvFyDursru37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/28/2024 12:15 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Storing an inode structure on the stack pushes some functions over the warning
> limit for stack frame size:
> 
> In file included from fs/ext4/mballoc.c:7039:
> fs/ext4/mballoc-test.c:506:13: error: stack frame size (1032) exceeds limit (1024) in 'test_mark_diskspace_used' [-Werror,-Wframe-larger-than]
>   506 | static void test_mark_diskspace_used(struct kunit *test)
>       |             ^
> 
> Use kunit_kzalloc() for all inodes. There may be a better way to do it by
> preallocating the inode, which would result in a larger rework.
> 
> Fixes: 2b81493f8eb6 ("ext4: Add unit test for ext4_mb_mark_diskspace_used")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ext4/mballoc-test.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index 12d0b22cabe1..3b43301054b6 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -332,14 +332,19 @@ static void mbt_kunit_exit(struct kunit *test)
>  static void test_new_blocks_simple(struct kunit *test)
>  {
>  	struct super_block *sb = (struct super_block *)test->priv;
> -	struct inode inode = { .i_sb = sb, };
> +	struct inode *inode;
>  	struct ext4_allocation_request ar;
>  	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
>  	int err = 0;
>  	ext4_fsblk_t found;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  
> -	ar.inode = &inode;
> +	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
> +	if (!inode)
> +		return;
> +
> +	inode->i_sb = sb;
> +	ar.inode = inode;
>  
>  	/* get block at goal */
>  	ar.goal = ext4_group_first_block_no(sb, goal_group);
> @@ -441,15 +446,20 @@ test_free_blocks_simple_range(struct kunit *test, ext4_group_t goal_group,
>  {
>  	struct super_block *sb = (struct super_block *)test->priv;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	struct inode inode = { .i_sb = sb, };
> +	struct inode *inode;
>  	ext4_fsblk_t block;
>  
> +	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
> +	if (!inode)
> +		return;
> +	inode->i_sb = sb;
> +
>  	if (len == 0)
>  		return;
>  
>  	block = ext4_group_first_block_no(sb, goal_group) +
>  		EXT4_C2B(sbi, start);
> -	ext4_free_blocks_simple(&inode, block, len);
> +	ext4_free_blocks_simple(inode, block, len);
>  	validate_free_blocks_simple(test, sb, goal_group, start, len);
>  	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
>  }
> @@ -506,16 +516,21 @@ test_mark_diskspace_used_range(struct kunit *test,
>  static void test_mark_diskspace_used(struct kunit *test)
>  {
>  	struct super_block *sb = (struct super_block *)test->priv;
> -	struct inode inode = { .i_sb = sb, };
> +	struct inode *inode;
>  	struct ext4_allocation_context ac;
>  	struct test_range ranges[TEST_RANGE_COUNT];
>  	int i;
>  
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
>  
> +	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
> +	if (!inode)
> +		return;
> +	inode->i_sb = sb;
> +
>  	ac.ac_status = AC_STATUS_FOUND;
>  	ac.ac_sb = sb;
> -	ac.ac_inode = &inode;
> +	ac.ac_inode = inode;
>  	for (i = 0; i < TEST_RANGE_COUNT; i++)
>  		test_mark_diskspace_used_range(test, &ac, ranges[i].start,
>  					       ranges[i].len);
> 
Thanks for the fix. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>


