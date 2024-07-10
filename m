Return-Path: <linux-ext4+bounces-3171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAC92CB4F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 08:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BD31F23A5F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684C24A08;
	Wed, 10 Jul 2024 06:47:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A253363
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jul 2024 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594059; cv=none; b=f2KzFFT91ogB6nUzoqU1HJlyiFmsI52dOzmC7pha6f8+EuI8ZMhdSeb0peRGqvVyooiPh/3GY5kXQy3w84ZI/SiXe8LF5YSfbHIU37lseeoE0KbBuKd67ku6fy29XTCp3Hwvnw7CdJm7lSt9phA5xlBy2q+YLn8wjIfntLXWos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594059; c=relaxed/simple;
	bh=97JMN+F+/++az9ek/dNImOUtquNaRUv35DHSF9YyVVM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FFYDk9QC39Ir98D2syl8M9rOeb95MbcEN2WmxYYqlP/gBCZ4Vl6ZD812++uN8tE+q5HDz0H118uRtFnJ+Dms8SnO/+PM5MDs4WrGjR1XKmCeR0Ab+yNid/HRdDls76SLXkd1/3y/ZquMnw+wQpqi0+BPK8AevUmnX+JS0Xik/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJpLw2qtzz4f3kw3
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jul 2024 14:47:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3FBEA1A016E
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jul 2024 14:47:33 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgB334SDLo5m2ivCBg--.10827S3;
	Wed, 10 Jul 2024 14:47:33 +0800 (CST)
Subject: Re: Updating i_disksize without acquiring i_data_sem semaphore
To: Rohit Singh <rohitsd1409@gmail.com>, linux-ext4@vger.kernel.org
References: <CAM70bNa8R5R37KFb=ThD4o7gTkna4goMmGho8tkqrCfZ9LBkGQ@mail.gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d78870d1-6c40-ca8c-7740-eaf0c10ac73a@huaweicloud.com>
Date: Wed, 10 Jul 2024 14:47:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM70bNa8R5R37KFb=ThD4o7gTkna4goMmGho8tkqrCfZ9LBkGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB334SDLo5m2ivCBg--.10827S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF18Gr4rGryfZw1xCw1xKrg_yoWDKFb_WF
	Z7t3yDAr1vvwsaga1Y9r47Jrs7KrWxKr1UZ3W8uws8Xry0vanxAr4kZFZaqr17Ga4DGrn8
	CryYg3yavr47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello.

On 2024/7/9 20:46, Rohit Singh wrote:
> Hello.
> I am looking around ext4 code and I observed the following issue.
> 
> Within ext4_insert_range(), EXT4_I(inode)->i_disksize is being updated
> without acquiring i_data_sem.
> 
> I have seen code where this operation is done after acquiring
> i_data_sem such as in
> ext4_update_i_disksize()
> 
> So, is this as expected or is it problematic?
> 

Thanks for pointing this out,  At the moment, IIUC,I don't think it
will cause any real problem since inode->i_rwsem could protect
i_disksize updating from most of race conditions except the write back.
ext4_do_writepages()->mpage_map_and_submit_extent() doesn't hold
inode->i_rwsem when updating i_disksize, but we have flushed dirty
blocks through filemap_write_and_wait_range() in ext4_insert_range()
and can prevent from generating new dirty pages beyond current
i_disksize, so this race is also closed.

However, I suppose we'd still better to move the updating under
i_data_sem to prevent some potential race conditions in the future.

Thanks,
Yi.


