Return-Path: <linux-ext4+bounces-3743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729059548A4
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A530C1C22A70
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A501AD9E2;
	Fri, 16 Aug 2024 12:21:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D812AAC6;
	Fri, 16 Aug 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810896; cv=none; b=sTEAJP0SdHrUVABzel/d9lvGQaVBWBmaNUXGeVj+8yEP3edqUzCrjeruBFnmdbhCGYYADticCDiY+l3z02LnY7Q1ceslLA9WQXUHFWjOrUmyuCT/Mzt2hV7olEA/nwCPTmN8n6CXiBE56Z6RhfBnoea2uZlPbclWSvXhDd8qWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810896; c=relaxed/simple;
	bh=TkX6qWziGg4Tt4r7MEJjYTjrsF+fQMQK1CuUPADhI3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCAPQWpzufN8IZKYMuqfojTcElBe6v/JEGLxja+Xy66JkFR1g0BVZBH5N9ki9Z9IacBe//NaeHJQX3c4LmsICqd2PJ2T+y/tZmTDcf0x0/OcwDi4Aux3JMt7haO7UeR2v+u+FXbtf600DRhkw8MOqYbkBkiwuFRbA6mjRadCNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wlh122nyrz4f3jMP;
	Fri, 16 Aug 2024 20:21:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 451631A0359;
	Fri, 16 Aug 2024 20:21:24 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4VCRL9mJ4dqBw--.4895S3;
	Fri, 16 Aug 2024 20:21:24 +0800 (CST)
Message-ID: <9de82d23-902f-cb18-7688-f5e687e86d14@huaweicloud.com>
Date: Fri, 16 Aug 2024 20:21:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ext4: disambiguate the return value of
 ext4_dio_write_end_io()
To: alexjlzheng@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinliang Zheng <alexjlzheng@tencent.com>
References: <20240815112746.18570-1-alexjlzheng@tencent.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240815112746.18570-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4VCRL9mJ4dqBw--.4895S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1rtFWfGFyDZr1UKw4Uurg_yoW8XF1kpr
	s0kasFyryqv342k397KF1DZr18ua18G3y5XF909w17ZrZFvrn5KF1Utas0vF10yrZ7Ww4F
	qa1ktr9Ivw1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/15 19:27, alexjlzheng@gmail.com 写道:
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
> ---
>   fs/ext4/file.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c89e434db6b7..6df5a92cec2b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>   	 */
>   	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
>   	    pos + size <= i_size_read(inode))
> -		return size;
> -	return ext4_handle_inode_extension(inode, pos, size);
> +		return 0;
> +	error = ext4_handle_inode_extension(inode, pos, size);
> +	return error < 0 ? error : 0;

Why?

iomap_dio_complete can use the return value directly without any bug. 
And I think the code now seems more clearly...

>   }
>   
>   static const struct iomap_dio_ops ext4_dio_write_ops = {


