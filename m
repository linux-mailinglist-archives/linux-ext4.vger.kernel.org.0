Return-Path: <linux-ext4+bounces-6409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A27A3020A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50014188CF3E
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6161CAA89;
	Tue, 11 Feb 2025 03:13:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925A1B6CE4;
	Tue, 11 Feb 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739243596; cv=none; b=EN4yuPHJLucds5/yULcEUU9ygGS9CJkAlXd43ls7OgsiyhvajmGHxK6UHTp0w6NqryNj0nSL/z+1no8jXTCmyRU5889aX11q2pj+gzSgRvn8wYY1XIfcsO/eSpMGHxPkNrymFc3/TLAb0GsT3OZdxWVDJ9K8PdkbgJ4xX54kqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739243596; c=relaxed/simple;
	bh=cej5WlRsEGBMmh/MFQPwhynlu4p3y8goOYjIDUlRNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBUzbNAjF4VDcZca+75qJ7Uvzi07YEMqXacPWPsppiSnKrSAZwnEizeUlS2/B5h7InEGjacyGLpk9DQ5HWkj2JMC4xDczsD4s5iZ+l6+fU+jKhZ30xtUu3f29JFN/+vY8IuKZRiKDMF6DuGP5rc5XDK7d9K0TzZAceS6uz0PaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YsRMh1h3tz4f3kj5;
	Tue, 11 Feb 2025 11:12:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 833981A11CC;
	Tue, 11 Feb 2025 11:13:09 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu19DwKpn6gEIDg--.45172S3;
	Tue, 11 Feb 2025 11:13:09 +0800 (CST)
Message-ID: <56423ecf-3ded-43ed-8270-0f62aa085316@huaweicloud.com>
Date: Tue, 11 Feb 2025 11:13:07 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] jbd2: Remove wrong sb->s_sequence check
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 Ted Tso <tytso@mit.edu>
References: <20250205183930.12787-1-jack@suse.cz>
 <20250206094657.20865-3-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250206094657.20865-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXu19DwKpn6gEIDg--.45172S3
X-Coremail-Antispam: 1UD129KBjvdXoWrury3urykKr1kAFWrZr45trb_yoWfKrb_Xr
	40yry8X39Iqr45Ar48uw18ur1akrs7Wrn5Gw1SywsrKr15Ja4UJr1UX34Yvr9ru34vkrWU
	urn2kw48KF9FvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/2/6 17:46, Jan Kara wrote:
> Journal emptiness is not determined by sb->s_sequence == 0 but rather by
> sb->s_start == 0 (which is set a few lines above). Furthermore 0 is a
> valid transaction ID so the check can spuriously trigger. Remove the
> invalid WARN_ON.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

This is indeed subtle, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 7e49d912b091..354c9f691df3 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1879,7 +1879,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
>  
>  	/* Log is no longer empty */
>  	write_lock(&journal->j_state_lock);
> -	WARN_ON(!sb->s_sequence);
>  	journal->j_flags &= ~JBD2_FLUSHED;
>  	write_unlock(&journal->j_state_lock);
>  


