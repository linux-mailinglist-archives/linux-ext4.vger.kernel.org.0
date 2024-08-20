Return-Path: <linux-ext4+bounces-3791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E3958752
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 14:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ACC1C21A48
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025718FDC5;
	Tue, 20 Aug 2024 12:48:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE818DF97;
	Tue, 20 Aug 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158139; cv=none; b=MXW/6xjB/hGvmvb5SnIw+i79qVAJTdnPkpsXU1726FOWG5DgBY1cau8SAL3YFwR2vHuWTz03Rxa/wXVbZuqi3nZZVZlkp616UDGbhW7kmiIcZZIoAIRO9rJkN8H4Tlp1nt6SOSytcL87Omk+H5TYsFnzWs3wrwVE1Um+W9p0UtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158139; c=relaxed/simple;
	bh=IRr5kvPeQzwZktpjVqtNx732JfgwwJnIDmdq4LhUt0Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XdAIYm+KYJnQnhJKeug8bPrdsuxZT51tlvdOjAa83fuOjlvrxvjLaCyTcN3geHuLJSE7jN4rR0+F/cWah61a6OOXaSIrZQdUOOzZ2gM1vYaHSDR2NYiaW+aFPbqiGCBd0Y7PeJoDvV5laqkAPCIgucFGjGLyzUD8psr7Q+87qPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp8Qw1zlMz4f3kkb;
	Tue, 20 Aug 2024 20:48:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DBFCD1A018D;
	Tue, 20 Aug 2024 20:48:49 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgA36LawkMRmMUCWCA--.20041S2;
	Tue, 20 Aug 2024 20:48:49 +0800 (CST)
Subject: Re: [PATCH v2 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to
 EXT4_NUM_B2C
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
 <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b28ae454-4907-a1ab-e0a3-1c8e85a32498@huaweicloud.com>
Date: Tue, 20 Aug 2024 20:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA36LawkMRmMUCWCA--.20041S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww47uF4UJr15trW3XF4fXwb_yoW8uFy8pr
	WfJ3WUJay5Gr10k3W7WryYgr1vg3y093y3GrWxZr18WryaqFZ3GF9FvwnYkFyxJr4kGa4r
	X3s0vw18ArW7Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/20/2024 5:27 PM, Ojaswin Mujoo wrote:
> Although we have checks to make sure s_stripe is a multiple of cluster
> size, in case we accidentally end up with a scenario where this is not
> the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> cases where EXT4_B2C(stripe) becomes 0.
> 
> Also make the is_stripe_aligned check in regular_allocator a bit more
> robust while we are at it. This should ideally have no functional change
> unless we have a bug somewhere causing (stripe % cluster_size != 0)
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>Looks good to me. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9dda9cd68ab2..99d1a8c730e0 100644
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
> @@ -2928,9 +2928,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			if (cr == CR_POWER2_ALIGNED)
>  				ext4_mb_simple_scan_group(ac, &e4b);
>  			else {
> -				bool is_stripe_aligned = sbi->s_stripe &&
> +				bool is_stripe_aligned =
> +					(sbi->s_stripe >=
> +					 sbi->s_cluster_ratio) &&
>  					!(ac->ac_g_ex.fe_len %
> -					  EXT4_B2C(sbi, sbi->s_stripe));
> +					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
>  
>  				if ((cr == CR_GOAL_LEN_FAST ||
>  				     cr == CR_BEST_AVAIL_LEN) &&
> @@ -3707,7 +3709,7 @@ int ext4_mb_init(struct super_block *sb)
>  	 */
>  	if (sbi->s_stripe > 1) {
>  		sbi->s_mb_group_prealloc = roundup(
> -			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
> +			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
>  	}
>  
>  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
> 


