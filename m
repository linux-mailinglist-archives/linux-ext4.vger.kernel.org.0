Return-Path: <linux-ext4+bounces-4220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB0097C679
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D651F26B91
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7719993E;
	Thu, 19 Sep 2024 08:59:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB413AF9;
	Thu, 19 Sep 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736372; cv=none; b=hkKtLYTzSc9Q0s90tQpu7oebSB+7H6Bupkef53RAWuriaAPi3552peelxwhJVEjgEWj3L/gL6LWZ3wLaIqo7kSuWrCofmlWoqgMjzDXatKTBkLhGP9GUYo9+0N62u221OKYskXuziaa//FaFZzaBPZUnZ7hv4K438Le5eLDxaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736372; c=relaxed/simple;
	bh=K1suAl7abba12RVc5oK05LCqysoJ71qEMa+IRfHiqoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmKZFV4zRW/v5ics3i7gfE0YeAuZazMzh055Yp96/Fq1nr7hzIocI2KtiuAmmg/cCk8ZAJJWwmm8ZmJ/ulv7JSa2a8LzJB+9Qq0oEMZl1rS3MkVhiz9j5ZBF6ajwxKDaIiobsjLAFFVIX2vqU4EQQTAYxeUgTZxwcRd1EHy39EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8Tw66P0nz4f3lVP;
	Thu, 19 Sep 2024 16:59:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 824331A07B6;
	Thu, 19 Sep 2024 16:59:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMjk5+tmOt7+Bg--.44541S3;
	Thu, 19 Sep 2024 16:59:18 +0800 (CST)
Message-ID: <24162f0c-e104-40cd-b0f3-0a14086db1b0@huaweicloud.com>
Date: Thu, 19 Sep 2024 16:59:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] ext4: disambiguate the return value of
 ext4_dio_write_end_io()
To: alexjlzheng@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinliang Zheng <alexjlzheng@tencent.com>
References: <20240919082539.381626-1-alexjlzheng@tencent.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240919082539.381626-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnXMjk5+tmOt7+Bg--.44541S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUWF4rtrW8WFWrKFyfWFg_yoW8Wr48pr
	sxCasFyryjv347CrZagF1DZr18ua18G3y0qF909w17ZrZFvrn5Kr1UKayYq3W0yrWkWw4r
	Xa1v9r9Ivw12yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/19 16:25, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> direct IO") causes confusion about the meaning of the return value of
> ext4_dio_write_end_io().
> 
> Specifically, when the ext4_handle_inode_extension() operation succeeds,
> ext4_dio_write_end_io() directly returns count instead of 0.
> 
> This does not cause a bug in the current kernel, but the semantics of the
> return value of the ext4_dio_write_end_io() function are wrong, which is
> likely to introduce bugs in the future code evolution.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Make sense to me,

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
> Changelog: Just RESEND
> 
> v1: https://lore.kernel.org/linux-ext4/20240815112746.18570-1-alexjlzheng@tencent.com/
> ---
>  fs/ext4/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c89e434db6b7..6df5a92cec2b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>  	 */
>  	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
>  	    pos + size <= i_size_read(inode))
> -		return size;
> -	return ext4_handle_inode_extension(inode, pos, size);
> +		return 0;
> +	error = ext4_handle_inode_extension(inode, pos, size);
> +	return error < 0 ? error : 0;
>  }
>  
>  static const struct iomap_dio_ops ext4_dio_write_ops = {


