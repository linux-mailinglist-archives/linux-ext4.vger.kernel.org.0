Return-Path: <linux-ext4+bounces-1389-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1068676F9
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C8128F92E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4612AAE9;
	Mon, 26 Feb 2024 13:42:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C0128839;
	Mon, 26 Feb 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954945; cv=none; b=dGE7KkO4i0NiNvsDL59sCO/ya489q6mEcPrbj/ydSt5aguPobV8dtuNSqNa2982r+O8yt+3i68IY8zKwNuAlZAfAc7c7aFkzbcoL/5/OFpRn3a/+3OFTRBeq7nvHfcw0RRMxRqE5/pwpB51TSiK4TcgC0vB8j7wSGwQVFiX1rCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954945; c=relaxed/simple;
	bh=d9uMUIBBuzBHstvGHMGQxaPJc7Rq6pIVJ/E6nWW6QCc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ByZcjd9rPwPleksdxGrD+ztGhIbiNWaEjvvGyPJq+rvGt/kkL2gh8KtQrE9JW0pJt/41P9mrKkPjYSCcTj5BtCo/0B4zf0v4swemuub/Z+bMeLTbpIOcg7bPMySK5apU3bbjeMJcRDfn+VfxOlggKCsDwQCy5WbVfPXwh9Qw+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tk1xt337vz4f3lgN;
	Mon, 26 Feb 2024 21:42:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B01BF1A084A;
	Mon, 26 Feb 2024 21:42:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgA3qAs0ldxllfFEFQ--.47196S2;
	Mon, 26 Feb 2024 21:42:14 +0800 (CST)
Subject: Re: [PATCH v2 0/5] More unit test for mballoc
To: Guenter Roeck <linux@roeck-us.net>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
 <2e7f5498-1a75-49c7-9217-74eac8895a0c@roeck-us.net>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <028d1885-df3c-eef0-6c8a-cbce78517f89@huaweicloud.com>
Date: Mon, 26 Feb 2024 21:42:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2e7f5498-1a75-49c7-9217-74eac8895a0c@roeck-us.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3qAs0ldxllfFEFQ--.47196S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1DCFWUtr4DWrWDXFWrXwb_yoW8XFy3pr
	WfWFn7GF4rJr18ZFyUZry8tryxXw48AF45Jr95J34fGa48ur1xKFs2gay8WryqvrykZF9I
	vFn3u3y8K34DZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/26/2024 12:07 AM, Guenter Roeck wrote:
> On Wed, Jan 03, 2024 at 06:48:55PM +0800, Kemeng Shi wrote:
>> This series covers more function to mark on-disk bitmap. Besides, some
>> code which is relevant to buddy cache is also tested.
>> Before more work is done, I want to be sure I'm not on a wrong
>> direction!
>>
>> v1->v2:
>> -Fix unused variable warning which is reported at
>> https://lore.kernel.org/lkml/202311260042.kMxL6DnL-lkp@intel.com/T/
>>
> 
> With this patch series in linux-text, and with various debug options
> enabled, unit tests for ext4 fail widely and result in crashes.
> 
> [    4.798582]         # Subtest: test_new_blocks_simple
> [    4.803166] BUG: key 00000000000000a8 has not been registered!
> [    4.803443] ------------[ cut here ]------------
> ILLOPC: ffffffff9050cbf4: 0f 0b
> [    4.803521] DEBUG_LOCKS_WARN_ON(1)
> [    4.803720] WARNING: CPU: 0 PID: 154 at kernel/locking/lockdep.c:4895 lockdep_init_map_type+0x224/0x250
Not sure how this is triggerred.
> ...
> [    4.833277]         # Subtest: test_mb_mark_used
> [    4.835875] ------------[ cut here ]------------
> [    4.836055] kernel BUG at fs/ext4/mballoc.c:2053!
Internal functions mb_mark_used assumes group lock is held but unit
test code doesn't acquire it as there is no concurrent block
allocation/free in test code. Will add lock in unit test to fix this.
> 
> Guenter
> 
Hi Guenter, thanks for test and report this. I will appreciate it if
you could tell me how to reproduce this as I need to debug the first
issue and verify the fix. Thanks!


