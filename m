Return-Path: <linux-ext4+bounces-2272-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402348BA5A3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 05:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F1B284963
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B91C6A7;
	Fri,  3 May 2024 03:23:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296818B14;
	Fri,  3 May 2024 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706583; cv=none; b=nYDYmbcoib5GSmvuArzzrkOzCt++bNNyUoATQ7aBxJjFChRm62vPi0ItL2elZmpX/7NyJExHTGYzHw5zMuDQXBYPAy24GvChfOXu9mfHxn4qubolRYNqKu6WGQsBl1wCRbsfJDgz0hr4A6+w3UCMucgRCMjKDa0IDUDkLPFR6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706583; c=relaxed/simple;
	bh=idI6eieR2CBoSNPC1vrjhWeBcTDoMr2hD/PKRvyomvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQDGE8YtOwfHfRmGku6IOqMo8qPYnSF6mrLck2+MMHBUzGBXq2x/gktqqJ2YSzSuAvnAR6bUqg2zR3Q1rvSj12iFKckUQ3IRpeQZ13hjg8MBfuASgKlJuzS1uWS+A/v3PIjmorkDx07c05608v+8APLtuB//Qj8Qw/G+em2B+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VVx2L5lD9z4f3jZ0;
	Fri,  3 May 2024 11:22:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EAAB91A0175;
	Fri,  3 May 2024 11:22:55 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGMWDRmkfpxLg--.60224S3;
	Fri, 03 May 2024 11:22:55 +0800 (CST)
Message-ID: <d21357da-70c0-52c7-9087-8b4ee106a49a@huaweicloud.com>
Date: Fri, 3 May 2024 11:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing
 BUG_ON/SOOB
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc: adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, adobriyan@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
References: <20240319113325.3110393-1-libaokun1@huawei.com>
 <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
 <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>
 <20240503031455.GF1743554@mit.edu>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240503031455.GF1743554@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn+RGMWDRmkfpxLg--.60224S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/3 11:14, Theodore Ts'o wrote:
> On Fri, May 03, 2024 at 10:03:04AM +0800, Baokun Li wrote:
>> Hi Ted,
>>
>> Would you consider merging in this patchset in the current merge
>> window? I would appreciate it if you could.
> Yes, in fact it's next on my review list.  I've been working through
> the patches on ext4's patchwork site roughly in chronological order
> (focusing first on fixes and those that have been reviewed by other
> folks).
>
> Cheers,
>
> 					- Ted
Thanks a million for your work!

Cheers,
Baokun


