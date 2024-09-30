Return-Path: <linux-ext4+bounces-4377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230B989941
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 04:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D9D28269D
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F631CABA;
	Mon, 30 Sep 2024 02:36:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270322904
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663787; cv=none; b=jNMKdzoKVRny0N2hMGLUBfL51aR6zgZGVAbi1xRODbDtq/XVT/ev+HBBLjQc8aScL4ItCM78VcqKndocUU8jGvfgDTOzTcjnlwUeQs7bZHKlSu6sOjqQR/USSywOICJCt4R++4e1fbsxFY5Tk0n20EgABtTMnEhHvyKO5gbPcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663787; c=relaxed/simple;
	bh=rPPI6NUx2y57E++RKEdWYxIW0912AlxXuOjjZ/aRJbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATtYu2/QdL8AHTo3cyPdN9oRXZTdIm24m529GnUid0PmIxQySfucnQ2XsEmCVwjqdbME/80nMDoVRw3x7ghTk9gPrn9OQ0Boum8jGCTgHidLxSQTweOoTDU82XcjQaLp5+W8AUnGd0KjpFRjyVs91q1pHrKADyGOFfd4Dr+SdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XH4v32ZcKz4f3jdb
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:35:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEE1D1A058E
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:36:15 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8edDvpmCSDzCg--.55415S3;
	Mon, 30 Sep 2024 10:36:15 +0800 (CST)
Message-ID: <be4798a6-773e-44ae-b9ec-3a5198d8d390@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:36:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] jbd2: remove redundant judgments for check v1
 checksum
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-2-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240930005942.626942-2-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+8edDvpmCSDzCg--.55415S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1rWr17WFWDXr18ZF13Jwb_yoWfWFXEgw
	40krZ5Z397XFn2va45Aw15Wr1a9rsxWr1rCwnFy34Y9a4UX34kXFWqq34DXryDWrZa9FW8
	CrZruFW8tF93tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/30 8:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> 'need_check_commit_time' is only used by v2/v3 checksum, so there isn't
> need to add 'need_check_commit_time' judegement for v1 checksum logic.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 667f67342c52..5efbca6a98c4 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -619,7 +619,6 @@ static int do_one_pass(journal_t *journal,
>  			if (pass != PASS_REPLAY) {
>  				if (pass == PASS_SCAN &&
>  				    jbd2_has_feature_checksum(journal) &&
> -				    !need_check_commit_time &&
>  				    !info->end_transaction) {
>  					if (calc_chksums(journal, bh,
>  							&next_log_block,


