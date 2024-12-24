Return-Path: <linux-ext4+bounces-5843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B711A9FBD2D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1051620FA
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7351C174E;
	Tue, 24 Dec 2024 12:15:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99519F12A;
	Tue, 24 Dec 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042557; cv=none; b=pGk0hLNyAv+Ek8eZIWfZlftQz0sAlptEvVnN8LKILldxe1IZXNHrhsrhkkWiH4/Ch+grZdFnV1kBYJEGStOqAmsyBJFDO7j6Hzpxl/iPGCzs8gZ/MNyZXvtfWZew6tNVO04YFESws2PATXSCA2b4bur/lKzSFqr9NeRkx28PlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042557; c=relaxed/simple;
	bh=pImsFJwkfIBFgY5OAM47tAbv2zxLC/sc2p8EjQzrGGw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NF2IuXIas7HIwmqKXQ5KAckkNxOUeXYOP3e7L/wZrq9Id8XPlT80+mL9ylBBRjyZ/N8Dl4s0A+hE7NrUWAJFJebjhHbJF06ZFMKIG+ikwEuRfMRZWeaz01wx/1purcEFUQS6WPxIfOlqD814QTqaDTkCFN3O+yUL+PLXiLN9txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHYkW2YN7z4f3jct;
	Tue, 24 Dec 2024 20:15:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0C4F31A0359;
	Tue, 24 Dec 2024 20:15:51 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAnA8D2pWpn6xBnFQ--.24898S2;
	Tue, 24 Dec 2024 20:15:50 +0800 (CST)
Subject: Re: [PATCH 6/6] ext4: calculate rec_len of ".." with correct name
 length 2
To: Andreas Dilger <adilger@dilger.ca>, Markus Elfring <Markus.Elfring@web.de>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20241219110027.1440876-7-shikemeng@huaweicloud.com>
 <0fee3433-1255-42ab-80c6-63a1d9f9d47b@web.de>
 <CFF7E7F5-FCF4-4F79-9A12-CF5937BB93AC@dilger.ca>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b4809330-6d07-b35d-7c2c-404ae5063f51@huaweicloud.com>
Date: Tue, 24 Dec 2024 20:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CFF7E7F5-FCF4-4F79-9A12-CF5937BB93AC@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnA8D2pWpn6xBnFQ--.24898S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kJF43Cw4UWr4UKrWfZrb_yoW8Gw1fpa
	1SgFn7Krs8AF4xAFZa9a1xZw1YyF18Ar45GrnIgrW7CrZ8XF1IqFyxK3yjvFyDC3yrua1r
	Za9rt3yYqF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzi
	SdDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/21/2024 4:38 AM, Andreas Dilger wrote:
> On Dec 20, 2024, at 6:52 AM, Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>> The rec_len of directory ".." should be ext4_dir_rec_len(2, NULL) instead
>>> of ext4_dir_rec_len(1, NULL). Although ext4_dir_rec_len return the same
>>> number either with name_len 1 or name_len 2, it's better use the right
>>> name_len to make code more intuitive.
>>
>> Do you try to point a correctness issue out here?
>>
>> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.13-rc3#n145
> 
> The patch is a no-op in terms of functionality.  Dirent lengths are rounded up to a multiple of 4 bytes, so "1" and "2" give the same value.
> 
> I was looking back at the changes to this code, and it has existed
> since at least when ext4 was cloned from ext3.  In older versions
> of the code this calculation was done *before* the
> 
> I also realized that the original code with "1" is actually correct.
> This code is calculating the dirent length of the ".." entry, but
> this is actually "the rest of the block minus the the '.' dirent size",
> so passing "1" is correct in this case.
> 
> So this patch should not be applied.
Ahh, right... Thanks for point this out. Will drop this in next version.

Thanks,
Kemeng
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


