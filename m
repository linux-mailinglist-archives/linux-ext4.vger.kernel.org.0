Return-Path: <linux-ext4+bounces-6410-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF88A3020B
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 04:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03296163D22
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE21D5ABA;
	Tue, 11 Feb 2025 03:15:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0BD26BD9E
	for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2025 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739243703; cv=none; b=PLeAJdlOiTGJeml+mFlcmiO8HcZBm1V2HNLFa2qaH9/jH0Tts5f6UacQflkk11iWy0D9Ynh6zwnc0MZIoKltlStCaRkrJDbeeRIS+BT3Wq51w1L3bZ0kQIo4zQZdshOqhLAb4GQVN+EDe+bwcHFgULbqIrrxGZ+L0yQ7HooO6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739243703; c=relaxed/simple;
	bh=HcvM6dSxl+3TH4/VkecIaK+VUCyOkL/ME9aJ+vMs/wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mFepmH254XIZ8SmKBANOMA5MlTzePShAnlWii/P+tyOWP+NidxqYSzCvM3YzQgq/VW02DX1GZC+s/OOPx90STEgo3urX8s+AT4xQ0TN33Ob9ADV8PA7PrBw/+yS84SGmGYjXinrAyFbKw6yA4ins1ybffynuPGu7n58TZS4u+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YsRKs2Byqz1ltZF;
	Tue, 11 Feb 2025 11:11:13 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EB061A016C;
	Tue, 11 Feb 2025 11:14:57 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Feb 2025 11:14:56 +0800
Message-ID: <d191d727-2496-4272-8c2a-b97aa5eec3f8@huawei.com>
Date: Tue, 11 Feb 2025 11:14:55 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] jbd2: Do not try to recover wiped journal
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>
References: <20250205183930.12787-1-jack@suse.cz>
 <20250206094657.20865-4-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250206094657.20865-4-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/2/6 17:46, Jan Kara wrote:
> If a journal is wiped, we will set journal->j_tail to 0. However if
> 'write' argument is not set (as it happens for read-only device or for
> ocfs2), the on-disk superblock is not updated accordingly and thus
> jbd2_journal_recover() cat try to recover the wiped journal. Fix the
> check in jbd2_journal_recover() to use journal->j_tail for checking
> empty journal instead.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Ha, right, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 9192be7c19d8..23502f1a67c1 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -287,19 +287,20 @@ static int fc_do_one_pass(journal_t *journal,
>  int jbd2_journal_recover(journal_t *journal)
>  {
>  	int			err, err2;
> -	journal_superblock_t *	sb;
> -
>  	struct recovery_info	info;
>  
>  	memset(&info, 0, sizeof(info));
> -	sb = journal->j_superblock;
>  
>  	/*
>  	 * The journal superblock's s_start field (the current log head)
>  	 * is always zero if, and only if, the journal was cleanly
> -	 * unmounted.
> +	 * unmounted. We use its in-memory version j_tail here because
> +	 * jbd2_journal_wipe() could have updated it without updating journal
> +	 * superblock.
>  	 */
> -	if (!sb->s_start) {
> +	if (!journal->j_tail) {
> +		journal_superblock_t *sb = journal->j_superblock;
> +
>  		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
>  			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
>  		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;


