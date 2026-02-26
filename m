Return-Path: <linux-ext4+bounces-14042-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KXjBOIzoGmLgAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14042-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:52:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563651A5595
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85D89303D695
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DF36A032;
	Thu, 26 Feb 2026 11:49:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63233A932
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106554; cv=none; b=NO3+D//nNloPBT78+NRkDHasBYta2CfddQzPWRIJq4i6dD3ipP5Pm7M1SH/rQoAzvXBI2aajX2JlHNN57d6N0/xDDsS0zUDIZbdrLRLg6LxFm0Tc2WnnZi8kvQ646zI3Wws2EO00lX6RRADLa56RVuqVoRSqd8i5e+acC+5kJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106554; c=relaxed/simple;
	bh=aSEC6BAEnPYRS5TwcDqJ2PHO8r5kxQP6zlAuiQ2cZfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN49BqNIRcecqK0o1l2AK868JCELC3fWeyBxU9GXVxJ2KT/yXVAD69D53v8h6jvw9dQJX9ZE+8eVRgTHMKW61SXtS9AZeLIV9e9sEAZ5YH540TjzTAh4He/XpkKp6o5aMLx9bEjUUR0vd4FpD79zaFOV7Nj3OD3trotsVTfQ29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fM8qc0fVCzYQtqW
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:48:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6D9324056B
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:49:09 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnFvczM6BpwhVQIw--.15494S3;
	Thu, 26 Feb 2026 19:49:09 +0800 (CST)
Message-ID: <fc3355a3-d195-463d-89d2-5d561cc0a107@huaweicloud.com>
Date: Thu, 26 Feb 2026 19:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: Make recently_deleted() properly work with lazy
 itable initialization
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Free Ekanayaka <free.ekanayaka@gmail.com>
References: <20260211140209.30337-1-jack@suse.cz>
 <20260216164848.3074-3-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260216164848.3074-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnFvczM6BpwhVQIw--.15494S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45WF47AF4UXF17CFykZrb_yoW8GFyDpF
	Wakan8Kr1Yvasruan7Gry0qF10qa18G3yUXrWrur4UZrW7JFyvqF4kKryFv3W2yrZ8C3Wj
	qF1UCF1rCw18WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14042-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,huawei.com:email]
X-Rspamd-Queue-Id: 563651A5595
X-Rspamd-Action: no action

On 2/17/2026 12:48 AM, Jan Kara wrote:
> recently_deleted() checks whether inode has been used in the near past.
> However this can give false positive result when inode table is not
> initialized yet and we are in fact comparing to random garbage (or stale
> itable block of a filesystem before mkfs). Ultimately this results in
> uninitialized inodes being skipped during inode allocation and possibly
> they are never initialized and thus e2fsck complains.  Verify if the
> inode has been initialized before checking for dtime.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Ha, this is a nice catch! Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ialloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index b20a1bf866ab..d858ae10a329 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -686,6 +686,12 @@ static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
>  	if (unlikely(!gdp))
>  		return 0;
>  
> +	/* Inode was never used in this filesystem? */
> +	if (ext4_has_group_desc_csum(sb) && 
> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT) ||
> +	     ino >= EXT4_INODES_PER_GROUP(sb) - ext4_itable_unused_count(sb, gdp)))
> +		return 0;
> +
>  	bh = sb_find_get_block(sb, ext4_inode_table(sb, gdp) +
>  		       (ino / inodes_per_block));
>  	if (!bh || !buffer_uptodate(bh))


