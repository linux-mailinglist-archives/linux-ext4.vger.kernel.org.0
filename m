Return-Path: <linux-ext4+bounces-10432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B69CBA22C1
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ED61B2858A
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682731D5ABA;
	Fri, 26 Sep 2025 01:55:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3E1C4609
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851711; cv=none; b=VedM0ZnPJkG6cdCI8N3SVlhw+Kp8oGBHlTliSrpwxWVJzRibwX0IPw6jJU+SC5xq6Tm05pJciKclGNspwRIYPPm8Zjzmn2iDKD3rMER4uEDt1ru35kJl+iasF+SXFnJEBxHkDRuBIP1bdNTzzf15US6CayKoJ/VSyADu1tJ6fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851711; c=relaxed/simple;
	bh=KCP4nj8pBMQl5QfxgrWmORAbtmYftVVa2w9uiJXCmIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaeGRn4QPWe0Au+I9AuuIZS3UfDE67oUqZ/NxaE0ZzM8NHFAXaquzeE0BSkxoa5oZxR2tmLPOhtjECB7xM1csjcobbUQXeGXixjLIIo0oST4oRgecvWhKT79Ax/5pqZgHm678egwc5kYkKCoT4ZRjFtgVuF9buEKdLhdP2Eq6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cXtv20GwPzYQtxr
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 09:54:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3353C1A0EA9
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 09:55:04 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHGWF18tVo1jxaAw--.1424S3;
	Fri, 26 Sep 2025 09:55:04 +0800 (CST)
Message-ID: <0ddc8f96-04f5-4d9b-b51e-d6d2666b5a57@huaweicloud.com>
Date: Fri, 26 Sep 2025 09:55:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix checks for orphan inodes
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
References: <20250925123038.20264-2-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250925123038.20264-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHGWF18tVo1jxaAw--.1424S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rXw45Zw17AryktF45GFg_yoWrAFykpr
	s3GF18Ca1DZFy09an7KF42vr10q3WxK3yUWryF9r40qFZxXry8tr1rtw1UAFyDZrW8Xr4Y
	qF40kr1UZw47WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/25/2025 8:30 PM, Jan Kara wrote:
> When orphan file feature is enabled, inode can be tracked as orphan
> either in the standard orphan list or in the orphan file. The first can
> be tested by checking ei->i_orphan list head, the second is recorded by
> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> we want to check whether inode is tracked as orphan and only some of
> them properly check for both possibilities. Luckily the consequences are
> mostly minor, the worst that can happen is that we track an inode as
> orphan although we don't need to and e2fsck then complains (resulting in
> occasional ext4/307 xfstest failures). Fix the problem by introducing a
> helper for checking whether an inode is tracked as orphan and use it in
> appropriate places.
> 
> Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
> Signed-off-by: Jan Kara <jack@suse.cz>

Ha, this is a good catch!

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4.h   | 10 ++++++++++
>  fs/ext4/file.c   |  2 +-
>  fs/ext4/inode.c  |  2 +-
>  fs/ext4/orphan.c |  6 +-----
>  fs/ext4/super.c  |  4 ++--
>  5 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 01a6e2de7fc3..72e02df72c4c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1981,6 +1981,16 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>  
>  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
>  
> +/*
> + * Check whether the inode is tracked as orphan (either in orphan file or
> + * orphan list).
> + */
> +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
> +{
> +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> +		!list_empty(&EXT4_I(inode)->i_orphan);
> +}
> +
>  /*
>   * Codes for operating systems
>   */
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 93240e35ee36..7a8b30932189 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
>  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
>  	 * now.
>  	 */
> -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
>  		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  
>  		if (IS_ERR(handle)) {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..5230452e29dd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4748,7 +4748,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
>  		 * old inodes get re-used with the upper 16 bits of the
>  		 * uid/gid intact.
>  		 */
> -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
> +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
>  			raw_inode->i_uid_high = 0;
>  			raw_inode->i_gid_high = 0;
>  		} else {
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 524d4658fa40..0fbcce67ffd4 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
> -	/*
> -	 * Inode orphaned in orphan file or in orphan list?
> -	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> -	    !list_empty(&EXT4_I(inode)->i_orphan))
> +	if (ext4_inode_orphan_tracked(inode))
>  		return 0;
>  
>  	/*
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a8..ba497387b9c8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1438,9 +1438,9 @@ static void ext4_free_in_core_inode(struct inode *inode)
>  
>  static void ext4_destroy_inode(struct inode *inode)
>  {
> -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
> +	if (ext4_inode_orphan_tracked(inode)) {
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): orphan list check failed!",
> +			 "Inode %lu (%p): inode tracked as orphan!",
>  			 inode->i_ino, EXT4_I(inode));
>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>  				EXT4_I(inode), sizeof(struct ext4_inode_info),


