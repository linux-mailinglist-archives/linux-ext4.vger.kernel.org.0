Return-Path: <linux-ext4+bounces-1506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102F871684
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 08:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE21F280CFC
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB827E774;
	Tue,  5 Mar 2024 07:15:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C267D3F6;
	Tue,  5 Mar 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622906; cv=none; b=t3db0xUCpM0WdjIJQDn6VRvhafrt7/bHWvoaxF/vyItoJlpBcJIpkOi/ae5J50zGUteluePwqcQkIA8ctbgn07eQP6vaZlq9aNmouArOvt36QL+1QaV5LRcdjgUp9jEHQ3AmCEHh5LMBJ5mmO8ts0kZhvLHItdw816VQK4Y+zfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622906; c=relaxed/simple;
	bh=8ppaqLFoWO/WWu5W/XYvLpaUmsloJSIw9NKR69mfcug=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=biGq53DRoiYsLFyxyC4eJzwdavYhIofpTEDswVa/2jIkyGROlgZsm4CKQUkjFpeHnnBv+zccEscPj5ZB3dvVxnT3la4coEsN6ND7RyWqVhlE92PTVPdD/NBzVXYeuWaSoTH3z3v8WFfT9pNZZbj+/rl8EbNAfRNatCKRI308fnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpmzK0FD1z4f3lVs;
	Tue,  5 Mar 2024 15:14:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7FEEE1A0175;
	Tue,  5 Mar 2024 15:15:00 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCXsgtyxuZl+HL9Fw--.33858S2;
	Tue, 05 Mar 2024 15:15:00 +0800 (CST)
Subject: Re: [PATCH v4 0/3] Fix crashes and warnings in ext4 unit test
To: Guenter Roeck <linux@roeck-us.net>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
 daniel.diaz@linaro.org, brauner@kernel.org
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
 <8d0506f8-7df2-45f6-85a4-2a0075b00050@roeck-us.net>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <81b872cf-440e-b1c1-3d95-570bd65fe4fa@huaweicloud.com>
Date: Tue, 5 Mar 2024 15:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8d0506f8-7df2-45f6-85a4-2a0075b00050@roeck-us.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXsgtyxuZl+HL9Fw--.33858S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUU
	UU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/5/2024 2:55 AM, Guenter Roeck wrote:
> On Tue, Mar 05, 2024 at 12:35:40AM +0800, Kemeng Shi wrote:
>> v3->v4:
>> -fix that sbi->s_dirtyclusters_counter is used before
>> initialization.
>>
> 
> I see no more ext4 related crashes, unit test failures, or tracebacks
> with this version of the series applied on top of next-20240304.
> 
> I'll send Tested-by: tags as response to the individual patches.
I'm so glad that the unit test works better. Thanks a lot for testing and
letting me konw.
Kemeng
> 
> Thanks,
> Guenter
> 


