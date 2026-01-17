Return-Path: <linux-ext4+bounces-12954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A2D38D3F
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4FD301FB54
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DE32C949;
	Sat, 17 Jan 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyv3gTHA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B745301717
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768639744; cv=none; b=Tv1vO6XlLMSVgO2cyKWL8LEtgupLmmgwSg2ieSWlthvAX+fEYkvpKsG0XemYEDEWhlHufxIH28I9yzl3Pw0IU0rxMYZRKB/bjQ6QSrFWpYMrVnodBEZurV/Lrf3b4kKD1v/lT7GcoZw/VE+YAArTkiuk0Yw7dBw25Jtz8v9Zbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768639744; c=relaxed/simple;
	bh=Zghp4GhHP6Cr2pU08isnutoktnKunS64IWy3sHBO0AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2Pnm4GW2qnjCJ5jXTlhW7s0Bu6phIiMIb/VT2g+0DglJI2Pjla0uYw4WWS+EzeVvFi/5LhE/rIgvgZxjdyGeTNDTzmx6O437HbHdufTWCT1+0F6gqAUeYX+DXV2LPD6NiIyn+1IUWJJcy1L39EpZ/imyfnzbxn6Cn+u5aNWjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyv3gTHA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f42a49437so1494674b3a.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768639742; x=1769244542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r14vS7xiIhvIFEql+V2qVSsw8DxAOSd2NvUbBF0bHUY=;
        b=Qyv3gTHAofobt9Y/Qo+Gp5i1/MqzD+TqJ1GdrXrjjbdWLDktGGCCSUh393UjDdij5w
         kUGFIw573D3IO5k8qlp2cUkE/H4xCz1YKxgm1swkpz8MUrggur3D9vq6KBijhH5wYRa7
         8pKE0cQ8XWceR+mX9DEfBRJmFM7KVfsXHBJZ5nPomqIZ5YaqT6Lg1tHiiNEFHg+wZBA/
         os9S3+tJlvGTzyjG8nNVnJTqKL2oY8bsp1XZGWcLOtzZ3puph/jORp+AnfjDRrqUsZtG
         JDVMGVWKvHFH12QcGi/AfGCH/sTurCAECt8SFFZSlca2tECcOInafZfFX7G+9hB0GnyB
         To6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768639742; x=1769244542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r14vS7xiIhvIFEql+V2qVSsw8DxAOSd2NvUbBF0bHUY=;
        b=mXUQyzt+y/tp98kOfk+3jFRfVi60B0t/dEUcPmU0qt/2kvAr0wduxKfPXQ/Ufb41Yc
         ahFHWCq4wFu+5S0kYK4THZVPQU7F+95JqoG1pq22gU59em4HTAh2gIEoSmeaSqk65J9A
         78jtEUX81FRgz6Oiu6qb3hogN0SD7JarSCvPcph32j5t+OGBpc/RiDyoCN93fbtrqMnh
         7OOvyDr7xaG/gSKZaY0Csw2qZdmLepzZThLRNsWrodx7f79/8aZTGtxSbgpxhuyNS+Rz
         busN1Xdc66DavJdJCO01z0jWdFl/l9IgbrPWFGFroqOfc22l1Y7ZEo8hETErtUff9onH
         +NaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2m3Ge4KKH69eZb9+qZCr6GUTcVVeok5w+BSB5M5O/icEgWrJB2XZvYiQBiXTOrKX43KOr1FgowAtH@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXPcg/kPbHWjGGlwPcRMYlg0f0++2iwWH6U4fgdAkaKGIhH9F
	bD20Dk6W4EcIaD825+O6MlZwXUUEmYfnstGsVCpNgDpLBJy+bTqWG2hW
X-Gm-Gg: AY/fxX7KNjgDEMlIGW3VGCUyEBji2sGbUDsat0sSekr1arKUq8qpyvw2ivs/J/s14OW
	Xz9W9VElRpt309WXQEXED3VCieLEIapwE+T+2nDeS5dF5oKyHCyIloaNFD2v5Il09SuGX7POq9N
	mlPTtRgrKsSBLoOhZT87JCvsaqDOr61KlYLJ73tUELbDWEoP0qb9Rg7uw5vEhOLYvdjgt5ZSazv
	k/w+zUUSw7+Okhxy8r13NVtNEWSoQ3JUXBvMbDIDPakddO3d4ykhcXUcPRaVhcpzHTiZpJaamo4
	wgG2TvzgDSCWDj4hTbthr1U1MKApzG+7dPuyUz0l9PZsrMOoS2zKqMI2hLxYZiJ16ao6ZcJoqGo
	1WnsTXzMe25Zi6C2FDansfia+CCGgXFip1Xu59tmNf0wHwxwRANjq8LiGetOlLJX2SiGmaQH1nE
	IuHI2j29bFLJv+suEXuQEWCZ/GiOLxdtE1tr+vPxDmUoIyldlrol9QxVV/KuY=
X-Received: by 2002:a05:6a00:2989:b0:81e:af19:34b8 with SMTP id d2e1a72fcca58-81fa01e487dmr5147424b3a.43.1768639741537;
        Sat, 17 Jan 2026 00:49:01 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b30f0sm3913855b3a.61.2026.01.17.00.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:49:01 -0800 (PST)
Message-ID: <2da17870-9dab-414a-b74d-23c43cdbe58a@gmail.com>
Date: Sat, 17 Jan 2026 16:48:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ext4: kunit tests for higher level extent
 manipulation functions
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <9d586426ba81a0b9fcb359325a23a0b7ae1d7cbf.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <9d586426ba81a0b9fcb359325a23a0b7ae1d7cbf.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Add more kunit tests to cover the high level caller
> ext4_map_create_blocks(). We pass flags in a manner that covers
> the below function:
> 
> 1. ext4_ext_handle_unwritten_extents()
>    1.1 - Split/Convert unwritten extent to written in endio convtext.
>    1.2 - Split/Convert unwritten extent to written in non endio context.
>    1.3 - Zeroout tests for the above 2 cases
> 2. convert_initialized_extent() - Convert written extent to unwritten
>     during zero range
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>


It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/ext4.h           |   4 +
>   fs/ext4/extents-test.c   | 287 ++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/extents_status.c |   3 +
>   fs/ext4/inode.c          |   8 +-
>   4 files changed, 295 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 174c51402864..5f744bd19dea 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3786,6 +3786,10 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
>   					     ext4_io_end_t *io_end);
>   extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
>   			   struct ext4_map_blocks *map, int flags);
> +extern int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +				  struct ext4_map_blocks *map, int flags);
> +extern int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> +				  struct ext4_map_blocks *map, int flags);
>   extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
>   						   int num,
>   						   struct ext4_ext_path *path);
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 02565ad19abe..ebd7af64315a 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -77,10 +77,18 @@ struct kunit_ext_data_state {
>   	ext4_lblk_t len_blk;
>   };
>   
> +enum kunit_test_types {
> +	TEST_SPLIT_CONVERT,
> +	TEST_CREATE_BLOCKS,
> +};
> +
>   struct kunit_ext_test_param {
>   	/* description of test */
>   	char *desc;
>   
> +	/* determines which function will be tested */
> +	int type;
> +
>   	/* is extent unwrit at beginning of test */
>   	bool is_unwrit_at_start;
>   
> @@ -90,6 +98,9 @@ struct kunit_ext_test_param {
>   	/* map describing range to split */
>   	struct ext4_map_blocks split_map;
>   
> +	/* disable zeroout */
> +	bool disable_zeroout;
> +
>   	/* no of extents expected after split */
>   	int nr_exp_ext;
>   
> @@ -131,6 +142,9 @@ static struct file_system_type ext_fs_type = {
>   
>   static void extents_kunit_exit(struct kunit *test)
>   {
> +	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
> +
> +	kfree(sbi);
>   	kfree(k_ctx.k_ei);
>   	kfree(k_ctx.k_data);
>   }
> @@ -162,6 +176,13 @@ static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
>   	return;
>   }
>   
> +void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> +				ext4_lblk_t len, ext4_fsblk_t pblk,
> +				unsigned int status, bool delalloc_reserve_used)
> +{
> +	return;
> +}
> +
>   static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
>   {
>   	return;
> @@ -220,6 +241,7 @@ static int extents_kunit_init(struct kunit *test)
>   	struct ext4_inode_info *ei;
>   	struct inode *inode;
>   	struct super_block *sb;
> +	struct ext4_sb_info *sbi = NULL;
>   	struct kunit_ext_test_param *param =
>   		(struct kunit_ext_test_param *)(test->param_value);
>   
> @@ -237,7 +259,20 @@ static int extents_kunit_init(struct kunit *test)
>   	sb->s_blocksize = 4096;
>   	sb->s_blocksize_bits = 12;
>   
> -	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10) << sb->s_blocksize_bits;
> +	sbi = kzalloc(sizeof(struct ext4_sb_info), GFP_KERNEL);
> +	if (sbi == NULL)
> +		return -ENOMEM;
> +
> +	sbi->s_sb = sb;
> +	sb->s_fs_info = sbi;
> +
> +	if (!param || !param->disable_zeroout)
> +		sbi->s_extent_max_zeroout_kb = 32;
> +
> +	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
> +			 << sb->s_blocksize_bits;
> +	ei->i_flags = 0;
> +	ext4_set_inode_flag(inode, EXT4_INODE_EXTENTS);
>   	inode->i_sb = sb;
>   
>   	k_ctx.k_data = kzalloc(EX_DATA_LEN * 4096, GFP_KERNEL);
> @@ -277,6 +312,8 @@ static int extents_kunit_init(struct kunit *test)
>   				   __ext4_ext_dirty_stub);
>   	kunit_activate_static_stub(test, ext4_es_remove_extent,
>   				   ext4_es_remove_extent_stub);
> +	kunit_activate_static_stub(test, ext4_es_insert_extent,
> +				   ext4_es_insert_extent_stub);
>   	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
>   	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
>   	kunit_activate_static_stub(test, ext4_issue_zeroout,
> @@ -301,6 +338,30 @@ static int check_buffer(char *buf, int c, int size)
>   	return 1;
>   }
>   
> +/*
> + * Simulate a map block call by first calling ext4_map_query_blocks() to
> + * correctly populate map flags and pblk and then call the
> + * ext4_map_create_blocks() to do actual split and conversion. This is easier
> + * than calling ext4_map_blocks() because that needs mocking a lot of unrelated
> + * functions.
> + */
> +static void ext4_map_create_blocks_helper(struct kunit *test,
> +					  struct inode *inode,
> +					  struct ext4_map_blocks *map,
> +					  int flags)
> +{
> +	int retval = 0;
> +
> +	retval = ext4_map_query_blocks(NULL, inode, map, flags);
> +	if (retval < 0) {
> +		KUNIT_FAIL(test,
> +			   "ext4_map_query_blocks() failed. Cannot proceed\n");
> +		return;
> +	}
> +
> +	ext4_map_create_blocks(NULL, inode, map, flags);
> +}
> +
>   static void test_split_convert(struct kunit *test)
>   {
>   	struct ext4_ext_path *path;
> @@ -330,8 +391,18 @@ static void test_split_convert(struct kunit *test)
>   
>   	map.m_lblk = param->split_map.m_lblk;
>   	map.m_len = param->split_map.m_len;
> -	ext4_split_convert_extents(NULL, inode, &map, path,
> -				   param->split_flags, NULL);
> +
> +	switch (param->type) {
> +	case TEST_SPLIT_CONVERT:
> +		path = ext4_split_convert_extents(NULL, inode, &map, path,
> +						  param->split_flags, NULL);
> +		break;
> +	case TEST_CREATE_BLOCKS:
> +		ext4_map_create_blocks_helper(test, inode, &map, param->split_flags);
> +		break;
> +	default:
> +		KUNIT_FAIL(test, "param->type %d not support.", param->type);
> +	}
>   
>   	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
>   	ex = path->p_ext;
> @@ -383,6 +454,7 @@ static void test_split_convert(struct kunit *test)
>   static const struct kunit_ext_test_param test_split_convert_params[] = {
>   	/* unwrit to writ splits */
>   	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -391,6 +463,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
>   	  .is_zeroout_test = 0 },
>   	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -399,6 +472,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
>   	  .is_zeroout_test = 0 },
>   	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -410,6 +484,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   
>   	/* writ to unwrit splits */
>   	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 0,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>   	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -418,6 +493,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
>   	  .is_zeroout_test = 0 },
>   	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 0,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>   	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -426,6 +502,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
>   	  .is_zeroout_test = 0 },
>   	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 0,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>   	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -440,6 +517,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   	 */
>   	/* unwrit to writ splits */
>   	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -451,6 +529,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
>   			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
>   	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -462,6 +541,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
>   			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
>   	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>   	  .is_unwrit_at_start = 1,
>   	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>   	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -476,6 +556,185 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   
>   };
>   
> +static const struct kunit_ext_test_param test_convert_initialized_params[] = {
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +};
> +
> +static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
> +	/* unwrit to writ splits via endio path */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/* unwrit to writ splits via non-endio path */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/*
> +	 * ***** zeroout tests *****
> +	 */
> +	/* unwrit to writ splits (endio)*/
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of data followed by 2 blocks of zeroes */
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of zeroes followed by 2 blocks of data */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  /* [zeroes] [data] [zeroes] */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
> +
> +	/* unwrit to writ splits (non-endio)*/
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of data followed by 2 blocks of zeroes */
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of zeroes followed by 2 blocks of data */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  /* [zeroes] [data] [zeroes] */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
> +
> +};
> +
>   static void ext_get_desc(struct kunit *test, const void *p, char *desc)
>   
>   {
> @@ -493,6 +752,24 @@ static int test_split_convert_param_init(struct kunit *test)
>   	return 0;
>   }
>   
> +static int test_convert_initialized_param_init(struct kunit *test)
> +{
> +	size_t arr_size = ARRAY_SIZE(test_convert_initialized_params);
> +
> +	kunit_register_params_array(test, test_convert_initialized_params,
> +				    arr_size, ext_get_desc);
> +	return 0;
> +}
> +
> +static int test_handle_unwritten_init(struct kunit *test)
> +{
> +	size_t arr_size = ARRAY_SIZE(test_handle_unwritten_params);
> +
> +	kunit_register_params_array(test, test_handle_unwritten_params,
> +				    arr_size, ext_get_desc);
> +	return 0;
> +}
> +
>   /*
>    * Note that we use KUNIT_CASE_PARAM_WITH_INIT() instead of the more compact
>    * KUNIT_ARRAY_PARAM() because the later currently has a limitation causing the
> @@ -503,6 +780,10 @@ static int test_split_convert_param_init(struct kunit *test)
>   static struct kunit_case extents_test_cases[] = {
>   	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
>   				   test_split_convert_param_init, NULL),
> +	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
> +				   test_convert_initialized_param_init, NULL),
> +	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
> +				   test_handle_unwritten_init, NULL),
>   	{}
>   };
>   
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 6c1faf7c9f2a..095ccb7ba4ba 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -916,6 +916,9 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct pending_reservation *pr = NULL;
>   	bool revise_pending = false;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
> +				   pblk, status, delalloc_reserve_used);
> +
>   	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>   		return;
>   
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c60813260f9a..8a6ad16e7417 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -542,8 +542,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
>   	return map->m_len;
>   }
>   
> -static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> -				 struct ext4_map_blocks *map, int flags)
> +int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +			  struct ext4_map_blocks *map, int flags)
>   {
>   	unsigned int status;
>   	int retval;
> @@ -589,8 +589,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>   	return retval;
>   }
>   
> -static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> -				  struct ext4_map_blocks *map, int flags)
> +int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> +			   struct ext4_map_blocks *map, int flags)
>   {
>   	unsigned int status;
>   	int err, retval = 0;


