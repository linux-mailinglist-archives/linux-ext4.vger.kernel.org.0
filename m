Return-Path: <linux-ext4+bounces-14043-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNLQA/81oGkqgwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14043-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:01:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A41A5802
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB99E316E153
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81237B3F4;
	Thu, 26 Feb 2026 11:56:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DAB3081C2;
	Thu, 26 Feb 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107003; cv=none; b=Wo4JrTG9PHmeSQ+cbpsY+RXFvs4UswM05uQWK2MXWjc0MkdpKMMtO3608biIVXUeSqfkT2nwN75/fNBW0psWQAcSE1J/9AoVavoPv+G5u8xz3vtWgEiPM0hLpgKEp0KvYoD9R1dAAHG3CAB5Qar4rspONOKEMFk/GLLfA1rOvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107003; c=relaxed/simple;
	bh=chN8UIOzo+zwYQrs/gHMIagh1QCyj6o3YDmyfYQ6DDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHn9DvkAPa9hnQ01Rj6wgR3VeJtH4gJcxKeLMVJitQM5m/R/ChuvkdMSHROzl4WlZ1DiK6t9Uf/IqgJQQXw8nw4ASJcCkjgqwgoJl52myilX3Taqo3zUT10MytQKr69/XBwiBu5/nglXFteJqrjdmztiO3dxAUUCR6jT+QwBIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fM8zc35HbzKHMfr;
	Thu, 26 Feb 2026 19:55:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AC1B940539;
	Thu, 26 Feb 2026 19:56:37 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnFPXzNKBp0LdQIw--.41476S3;
	Thu, 26 Feb 2026 19:56:35 +0800 (CST)
Message-ID: <85f5a062-2cdb-48ef-8250-cdc022209634@huaweicloud.com>
Date: Thu, 26 Feb 2026 19:56:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: Fix fsync(2) for nojournal mode
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Free Ekanayaka <free.ekanayaka@gmail.com>,
 stable@vger.kernel.org
References: <20260211140209.30337-1-jack@suse.cz>
 <20260216164848.3074-4-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260216164848.3074-4-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnFPXzNKBp0LdQIw--.41476S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13JFykGw43XrW5AFWDurg_yoW8tw1fpr
	WfKr1fJr4vvFWxu3yIkF1UZryFgan7WrW7Wr4UWa48Xry5tw1jgF1jvr1Fv3WqqrZrWw4F
	qr4qkFW5u3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwzuWDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14043-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_EMAILBL_FAIL(0.00)[yi.zhang.huawei.com:query timed out,freeekanayaka.gmail.com:query timed out,jack.suse.cz:query timed out];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.877];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,suse.cz:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: B03A41A5802
X-Rspamd-Action: no action

On 2/17/2026 12:48 AM, Jan Kara wrote:
> When inode metadata is changed, we sometimes just call
> ext4_mark_inode_dirty() to track modified metadata. This copies inode
> metadata into block buffer which is enough when we are journalling
> metadata. However when we are running in nojournal mode we currently
> fail to write the dirtied inode buffer during fsync(2) because the inode
> is not marked as dirty.

Please let me understand this. You mean that because some places we
directly call ext4_mark_inode_dirty() to mark the inode as dirty, instead
of using the generic mark_inode_dirty(), this results in the inode missing
the I_DIRTY_INODE flag. Consequently, generic_buffers_fsync_noflush()->
sync_inode_metadata() does not write the inode, leading to the metadata
not being updated on disk after fsync(2), right?

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> Use explicit ext4_write_inode() call to make
> sure the inode table buffer is written to the disk. This is a band aid
> solution but proper solution requires a much larger rewrite including
> changes in metadata bh tracking infrastructure.
> 
> Reported-by: Free Ekanayaka <free.ekanayaka@gmail.com>
> Link: https://lore.kernel.org/all/87il8nhxdm.fsf@x1.mail-host-address-is-not-set/
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/fsync.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index e476c6de3074..bd8f230fa507 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -83,11 +83,23 @@ static int ext4_fsync_nojournal(struct file *file, loff_t start, loff_t end,
>  				int datasync, bool *needs_barrier)
>  {
>  	struct inode *inode = file->f_inode;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 0,
> +	};
>  	int ret;
>  
>  	ret = generic_buffers_fsync_noflush(file, start, end, datasync);
> -	if (!ret)
> -		ret = ext4_sync_parent(inode);
> +	if (ret)
> +		return ret;
> +
> +	/* Force writeout of inode table buffer to disk */
> +	ret = ext4_write_inode(inode, &wbc);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_sync_parent(inode);
> +
>  	if (test_opt(inode->i_sb, BARRIER))
>  		*needs_barrier = true;
>  


