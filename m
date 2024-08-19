Return-Path: <linux-ext4+bounces-3778-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2C956B3D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AB11C21C76
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F716BE04;
	Mon, 19 Aug 2024 12:52:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC9171AA;
	Mon, 19 Aug 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071926; cv=none; b=A7s4Knet3Q8pOkG/GsERA1Tv6xhkI+YzZ3Qd4KN/vOw+vcWjWQGITuQqy2vhVq720nbF7NCr051OOU+fXuexLocLSYygMlphYrE0SYFssTxJ7AHeYHfwyE0nu1GJ3prKMb5lyidndwjIonTaofdmyl/nb4pOkm6iC3L+G45ElNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071926; c=relaxed/simple;
	bh=i3Jdj4it8XyViTNpXMn7KKLgdUQcwr1kF2uoH5K2U9g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PlptasGnZc44L70nNyuvH9WOjHm5SMujT153oijv9dap+LdcuNi/WrtPMssN5+HUX5g1RSjMu8SdmeR5f5zQTJvzSzas4Qol/SDBdxalhSLFDPFUFZX0twmiyEuQC0DJxr+lw/veN5T9fGq9z8TQ1zQTGa5F9fQGU/KUPdW20fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WnXY23LJTz4f3pC2;
	Mon, 19 Aug 2024 20:51:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0BA231A0568;
	Mon, 19 Aug 2024 20:52:00 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgCXRbTuP8NmZS08CA--.34959S2;
	Mon, 19 Aug 2024 20:51:59 +0800 (CST)
Subject: Re: [PATCH 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to
 EXT4_NUM_B2C
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
References: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
 <02e5b5139294897985f2b99729c5f3da3dd4f6f9.1723794770.git.ojaswin@linux.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <94377e74-3159-8130-df96-7955b55755c2@huaweicloud.com>
Date: Mon, 19 Aug 2024 20:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <02e5b5139294897985f2b99729c5f3da3dd4f6f9.1723794770.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCXRbTuP8NmZS08CA--.34959S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww47uF4UJr15trW3AF18Zrb_yoW8uFW3pr
	WfJF1UJa45Gw10k3W7Wr1Ygr1vg3y8u3y3GrWxZr18WryaqFZ3Gr9Fqwn0kFyxJr4kG34r
	X390vw1xArZrW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/16/2024 3:57 PM, Ojaswin Mujoo wrote:
> Although we have checks to make sure s_stripe is a multiple of cluster
> size, in case we accidentally end up with a scenario where this is not
> the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> cases where EXT4_B2C(stripe) becomes 0.
> 
> Also make the is_stripe_aligned check in regular_allocator a bit more
> robust while we are at it. This should ideally have no functional change
> unless we have a bug somewhere causing (stripe % cluster_size != 0)
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>> ---
>  fs/ext4/mballoc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9dda9cd68ab2..b2e836a4bd18 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2553,7 +2553,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
>  	do_div(a, sbi->s_stripe);
>  	i = (a * sbi->s_stripe) - first_group_block;
>  
> -	stripe = EXT4_B2C(sbi, sbi->s_stripe);
> +	stripe = EXT4_NUM_B2C(sbi, sbi->s_stripe);
>  	i = EXT4_B2C(sbi, i);
>  	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
>  		if (!mb_test_bit(i, bitmap)) {
> @@ -2929,8 +2929,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  				ext4_mb_simple_scan_group(ac, &e4b);
>  			else {
>  				bool is_stripe_aligned = sbi->s_stripe &&
> +					sbi->s_stripe >= sbi->s_cluster_ratio &&
sbi->s_cluster_ratio is >= 1, so sbi->s_stripe >= sbi->s_cluster_ratio could
cover the case that sbi->s_stripe is non-zero. Non-zero check of sbi->s_stripe
seems not needed.
>  					!(ac->ac_g_ex.fe_len %
> -					  EXT4_B2C(sbi, sbi->s_stripe));
> +					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
>  
>  				if ((cr == CR_GOAL_LEN_FAST ||
>  				     cr == CR_BEST_AVAIL_LEN) &&
> @@ -3707,7 +3708,7 @@ int ext4_mb_init(struct super_block *sb)
>  	 */
>  	if (sbi->s_stripe > 1) {
>  		sbi->s_mb_group_prealloc = roundup(
> -			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
> +			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
>  	}
>  
>  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
> 


