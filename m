Return-Path: <linux-ext4+bounces-6716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE54A57723
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 02:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAD1891681
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052512E5B;
	Sat,  8 Mar 2025 01:18:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22748CA6F;
	Sat,  8 Mar 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396727; cv=none; b=d+DHm/39m77idXwkH0rav+0LZhS1ahWCbgKiE6nR10Ehp9QtusMXJ/LlW6mtGZBtYbYRsd2UtnMbiXGSQq9/H2umeQTQNkdAWNdE+pTOHntm819yF1cvrSuD8DPvEDQPVykivOeSUdxxrXpPmrvJEt7OhzLamgIq9PqrvCv3ZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396727; c=relaxed/simple;
	bh=dYSGhkoFIkEODa94DKhDhjN80PKRCwnF77LT892tNqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3kDhrIfyCqyvpmZHDCxWmAoxg1wm6iTuBBA4HepvcQqC4X93yCPaPFblfOMXe4KmE8GbMxmRRt6Hkd+Yp4vogmceOqaV2mY4dUYFI2WmCmltss4jyCfxyD7HrEWirTsVPDQ0QtwZ8rKCGrN6videLWr3Y835CxlJenlIzexNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8lYY0ymnz1f0Jv;
	Sat,  8 Mar 2025 09:14:25 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id AAA9D14034D;
	Sat,  8 Mar 2025 09:18:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Mar
 2025 09:18:40 +0800
Message-ID: <ee1ac3cd-da61-415d-a448-53d4464063e3@huawei.com>
Date: Sat, 8 Mar 2025 09:18:40 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ext4: define ext4_journal_destroy wrapper
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <96d5153a015caf5da6b67cffaff3c03c2abecb95.1741270780.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <96d5153a015caf5da6b67cffaff3c03c2abecb95.1741270780.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> Define an ext4 wrapper over jbd2_journal_destroy to make sure we
> have consistent behavior during journal destruction. This will also
> come useful in the next patch where we add some ext4 specific logic
> in the destroy path.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/ext4_jbd2.h | 14 ++++++++++++++
>   fs/ext4/super.c     | 16 ++++++----------
>   2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 3f2596c9e5f2..9b3c9df02a39 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -429,4 +429,18 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
>   	return 1;
>   }
>   
> +/*
> + * Pass journal explicitly as it may not be cached in the sbi->s_journal in some
> + * cases
> + */
> +static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *journal)
> +{
> +	int err = 0;
> +
> +	err = jbd2_journal_destroy(journal);
> +	sbi->s_journal = NULL;
> +
> +	return err;
> +}
> +
>   #endif	/* _EXT4_JBD2_H */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a963ffda692a..8ad664d47806 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1297,8 +1297,7 @@ static void ext4_put_super(struct super_block *sb)
>   
>   	if (sbi->s_journal) {
>   		aborted = is_journal_aborted(sbi->s_journal);
> -		err = jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		err = ext4_journal_destroy(sbi, sbi->s_journal);
>   		if ((err < 0) && !aborted) {
>   			ext4_abort(sb, -err, "Couldn't clean up the journal");
>   		}
> @@ -4960,8 +4959,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>   out:
>   	/* flush s_sb_upd_work before destroying the journal. */
>   	flush_work(&sbi->s_sb_upd_work);
> -	jbd2_journal_destroy(sbi->s_journal);
> -	sbi->s_journal = NULL;
> +	ext4_journal_destroy(sbi, sbi->s_journal);
>   	return -EINVAL;
>   }
>   
> @@ -5652,8 +5650,7 @@ failed_mount8: __maybe_unused
>   	if (sbi->s_journal) {
>   		/* flush s_sb_upd_work before journal destroy. */
>   		flush_work(&sbi->s_sb_upd_work);
> -		jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		ext4_journal_destroy(sbi, sbi->s_journal);
>   	}
>   failed_mount3a:
>   	ext4_es_unregister_shrinker(sbi);
> @@ -5958,7 +5955,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
>   	return journal;
>   
>   out_journal:
> -	jbd2_journal_destroy(journal);
> +	ext4_journal_destroy(EXT4_SB(sb), journal);
>   out_bdev:
>   	bdev_fput(bdev_file);
>   	return ERR_PTR(errno);
> @@ -6075,8 +6072,7 @@ static int ext4_load_journal(struct super_block *sb,
>   	EXT4_SB(sb)->s_journal = journal;
>   	err = ext4_clear_journal_err(sb, es);
>   	if (err) {
> -		EXT4_SB(sb)->s_journal = NULL;
> -		jbd2_journal_destroy(journal);
> +		ext4_journal_destroy(EXT4_SB(sb), journal);
>   		return err;
>   	}
>   
> @@ -6094,7 +6090,7 @@ static int ext4_load_journal(struct super_block *sb,
>   	return 0;
>   
>   err_out:
> -	jbd2_journal_destroy(journal);
> +	ext4_journal_destroy(EXT4_SB(sb), journal);
>   	return err;
>   }
>   



