Return-Path: <linux-ext4+bounces-3734-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3FE952EEF
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9C51C241BB
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1C19F471;
	Thu, 15 Aug 2024 13:17:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415519F467;
	Thu, 15 Aug 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727873; cv=none; b=tuhtoGBhkOz0Dt6Wrxh1F8kCJv/ZMiTjw1g7fjTygVzKXCzy66HeU3Hl4UM1pKmhKX8n013WhaL+TQSXg7kpLyAaVtS/65VB1e/sjmqxuTfwYdl27ozoSkbZ28ohLmPX9oHdl7LCCcniW0SE2n7zJQp/vP6+S+A7c9fNSLfA7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727873; c=relaxed/simple;
	bh=bLc7megkl+rT6wNw7jAeD6fJx5G6JNXBBzgzkxZ5aW0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gViqBeyyc2hHLNVOLAlCiQ86ZhUnw7ONCw3b38TORtjtMluXM5/ib08Y8v57AUf7FszThVvH5UzszdYNwp6GAxZ1Ehqk4QzRQGsK0koXu9BFCs85YzYRSRgrsLGgg4PBLt418JqhPyBqp1yGQSOC/3WTymU0fQVkto9/slZMH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wl5JX0JJxz4f3kw3;
	Thu, 15 Aug 2024 21:17:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA2D11A0568;
	Thu, 15 Aug 2024 21:17:46 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgDX_4X6_71m0qUQBw--.47465S2;
	Thu, 15 Aug 2024 21:17:46 +0800 (CST)
Subject: Re: [PATCH 7/7] ext4: check buffer_verified in advance to avoid
 unneeded ext4_get_group_info
To: Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240813120712.2592310-8-shikemeng@huaweicloud.com>
 <77c9258a-dce1-4cf8-8e0e-e4073902e25a@web.de>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9c8082c7-510c-5bb1-0649-ecfb2f44e728@huaweicloud.com>
Date: Thu, 15 Aug 2024 21:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <77c9258a-dce1-4cf8-8e0e-e4073902e25a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX_4X6_71m0qUQBw--.47465S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
	r21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/15/2024 7:13 PM, Markus Elfring wrote:
> …
>> This could be a simple cleanup as complier may handle this.
> 
>                                     compiler?
Right.
> 
> 
> Would you like to append parentheses to the mentioned function name?
Sure

Will improve in next version.

Thanks,
Kemeng
> 
> Regards,
> Markus
> 


