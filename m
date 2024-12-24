Return-Path: <linux-ext4+bounces-5840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF49FBD17
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400D77A1CDD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05A1B85E2;
	Tue, 24 Dec 2024 12:10:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109418EFDE;
	Tue, 24 Dec 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042199; cv=none; b=JGYugOPamOrVDSBoeXf6sKNvMV9K2yscmjoO/rGAOGZ4EjIFch1s3ieWWUG6vE4KPHQo5tSQ22yDJ6L6N+zD7w6tKKvbv3A+vCsMCpyyFlkyGklAqASckVDRrDulXXGkq7e/Ir1tPwhP6JRTZCD4CVU+x4pNusBe8oRC+PM0m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042199; c=relaxed/simple;
	bh=7D58hYa0h8sL+saoMjiDqfk9qQfDO5m/pvjQ2gDIM7A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lo7jn4hYPD9GrctHa8qUkZPMQi4wqaXeUSj9MSiTIN7qcqvns77SD5KNqktd4bWDN8KJruxsmLv3kmFfxKJS2BHt9j3kwi7WzN2Gx1OnHCEA7MtOMCz6z3wDRXQBv9kqdtKKAPFBp6XQaRDvC7FbH3y2stVyn+Zs/NHJz0VuxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHYbW2GWJz4f3jcv;
	Tue, 24 Dec 2024 20:09:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 02D691A018D;
	Tue, 24 Dec 2024 20:09:47 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgA3ysaHpGpneq9mFQ--.25243S2;
	Tue, 24 Dec 2024 20:09:44 +0800 (CST)
Subject: Re: [PATCH 2/6] ext4: remove unneeded bits mask in dx_get_block()
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-3-shikemeng@huaweicloud.com>
 <8554AB6E-55CA-4F61-BE34-1260555785D1@dilger.ca>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e575a8e9-5a90-6fc7-62eb-ee3f433bc687@huaweicloud.com>
Date: Tue, 24 Dec 2024 20:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8554AB6E-55CA-4F61-BE34-1260555785D1@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3ysaHpGpneq9mFQ--.25243S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8ZF1rAF17KF48Kw1kuFg_yoW8AF13pa
	1rKanxKr4DGrZakas7GwsFvw4Yvw4rZFsxJrn8Cry7uFWUGF1fZF1Uta1Yva47Gr4xKFyj
	qF42grykC3W5Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/20/2024 9:10 AM, Andreas Dilger wrote:
> On Dec 19, 2024, at 4:00 AM, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> As high four bits of block in dx_entry is not used by any feature for now, we can remove unneeded bits mask in dx_get_block() and add it back
>> when it's really needed.
> 
> Actually, the opposite is true.  This mask protects the *CURRENT* code
> from any future use for these bits, so removing it now means that they
> could never be used in the future, since the block number would be
> taken as all 32 bits instead of only the bottom 28 bits.  I don't think
> we are in any danger of having a 16TB single directory any time soon.
> 
> However, the top bits were intended to store a "fullness" for the index
> blocks, to optimize online directory shrinking without having to scan
> each of the blocks for how many entries are currently in the block.
> This would allow the dirent removal to easily see "this block and the
> previous/next block are only 1/3 full and could be merged".
> 
> See the following thread for a prototype patch and discussion on this:
> https://patchwork.ozlabs.org/project/linux-ext4/patch/20190821182740.97127-1-harshadshirwadkar@gmail.com/
> 
> I think removing this mask has a negative effect on future usefulness,
> and virtually no benefit to the code today, so I would object to landing
> it.
Sure, it makes sense to reserve bit for future use if it will likely be
used. But I wonder would it be better to catch using high four bits in
in ext4_append() in which case we could forbit using high four bits in
time rather than lost dir when reserved bits are really used in future.
This also reduce cpu cost as dx_get_block() is used likely more frequent
than ext4_append().
Just a thought.

Thanks,
Kemeng


