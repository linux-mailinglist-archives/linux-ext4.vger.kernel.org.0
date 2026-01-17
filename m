Return-Path: <linux-ext4+bounces-12955-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299BD38D42
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34CAA3018F6F
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2B3043D5;
	Sat, 17 Jan 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLEDys+l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E96271457
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640313; cv=none; b=LUkKOqsSsSb3HipjKHIMMlYZI331UH+9wONoyoZ7EfavsBM6havXNeHToD5ga5vsyHtMgokdGOsoBZCFEqIfxk8GGt6chk4waDVoz7oMsXmAa+B4f7EM1DL9sZDwOn4Fz5ga9THVon7SplApJkSnPXDeyaQ3WclSo3UwucI01UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640313; c=relaxed/simple;
	bh=3xhBe8Asqy4TvRjEme78fq1U5yTlJs60FUALvifKXkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpMTbdYdLEeWn0xhqUTr3N/+3B6TJUB+L+Kh0ab6g49Fi2GqE4qbhZ8EqcjHbWqCkzGMSqjLXTF4Ung60UdG4ZXM9+NnuIR3FeYBT2e17UX8ejA4BweHv6wBOfn1bgAFAhtdUWV/MP3sSHJBoOn9maOMXFjPUL14BeZHT3EBFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLEDys+l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f4e36512aso2760947b3a.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768640311; x=1769245111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQm4a1CQEeZpLwGMG96rqCjr6WDIkHkCEWh81Q7byxU=;
        b=gLEDys+lPtzMXy/CGmzdKXDCeD8zChq7VEaqaOjE9z9ZlkFx9mlYhon5MoJE25v7VK
         M4dcUmxbZn70arSh+EWb5lZjTuvvkqz4qQ6HYdkgn/ioFML+mv8A7SGsdAfiQ40QvxNO
         k/A7AuPLg/jrlK+FBWCLoLbyeFXPTHLbCQIHkGTmQ3T3HTtTghX9HHCwNrqqCxHdgJ48
         oFne8x486HDQPzqvZCFkXNXALvjM+NwDaOsbjpQy6jVdQylQGFzaMDQNM0Np0za4JTWK
         1Ised9UwiheFXJDkOobpDnDLRgJKb8aMArp7G3hWnmnipKzhdVWk6wCiAZO5IaZDGflV
         kzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768640311; x=1769245111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQm4a1CQEeZpLwGMG96rqCjr6WDIkHkCEWh81Q7byxU=;
        b=DP7t9td4N0kfeSU8AFG+T1vG7z8qXsjTIQBhQU49tR/T0/iZ2B8zDhGHallA/SLjc7
         aM4sPqNHGFWqbpAEv8/+B7kwhhYjQYu63ArmVTuGT+DBtnh9ydKwcRiHIwfX+me5u0nR
         MCd59PQ5phAFN6r4n0ikL8O4KMPBw8tp8WrXIB4YMmtDjQb13rZ1+qWwLj25TQITpG/N
         YJf99KM/Enug6YnFtdoE/zcHFpHrRlvKBIQgzCrwXI/S+Ppl3kOsb6fOU3KNtSOeIsyK
         N9BB3rNdpWUZCy2/3JvRNl+HXRtPXTLA8rxTRCobzHmNruQHB6Xe/8czKEvkU5nhqA4H
         73xA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmqcQl1RHq5AHVAF4GV1q2BXUq2dSMq5xGFKoyZAApnCRQeKPu+pdluvBeu/Cptt0HhrMn5P91QEs@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKwwQaKsfjxQIf64HYEmAkl9MlO2Bu1xZAbRgJSzu3X9hTP0x
	VS6DZcNr2FXj53hoKej6h1FYVBX+mvCyOcDPxKV6netu2kuRt08t27p7
X-Gm-Gg: AY/fxX6YmJqwbY5VllvrLTvyuWkuPHFC5bVFBAZrSt5x7iDWO4jwbOYm4OO5jvnZfxN
	ffTzgJfPY7vMCxsUTzy1s9FaN9WmggteQ5cJpZx3EGAE8fLnqwUSy6jKRvnDHQRwzpAPZCbg3Iq
	1sUcXpfV1DOl7ykwLvNh+zu4R35AO/H/3CiY/SwQlUL2fihV87v2CdD+yyNyZRv+5YjuoJBnXoD
	NTcvsr17Kq2uO1TGH8p0GOXvjBgIg3he6kA0ofCAU9ztcPFzWqdkaegfPMx+YRObels8lVyVHZx
	iWKEsOHHW1wzobFDgKegzGtXby7jYNizzRWQL8h2kqHWC8rX1tktsxwJRx73OPz7EWIdZ2PFNqC
	czmzDb+GMFz5i/wcGP/aUvH7F3XWfCKxudRSXzrny/mZrViOOCPrhDol/2ob46x5HHT2FbGzQeU
	0qIyihhW70Hay0gM4jVPxep3YgpbRjSMs=
X-Received: by 2002:a05:6a00:3e0e:b0:81f:9b97:c12d with SMTP id d2e1a72fcca58-81fa1883455mr5092857b3a.62.1768640311065;
        Sat, 17 Jan 2026 00:58:31 -0800 (PST)
Received: from [192.168.0.104] ([115.198.242.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10a03ffsm3969456b3a.6.2026.01.17.00.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:58:30 -0800 (PST)
Message-ID: <2e59c284-dfef-46e2-a1d5-6cfd2581a627@gmail.com>
Date: Sat, 17 Jan 2026 16:58:05 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] ext4: Add extent status cache support to kunit
 tests
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <4ff7e1f19b9663f20735d321af3a8133567400f8.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <4ff7e1f19b9663f20735d321af3a8133567400f8.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Add support in Kunit tests to ensure that the extent status cache is
> also in sync after the extent split and conversion operations.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents-test.c   | 106 ++++++++++++++++++++++++---------------
>   fs/ext4/extents.c        |   2 -
>   fs/ext4/extents_status.c |   5 --
>   3 files changed, 65 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index ebd7af64315a..86fcac66be6f 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -149,12 +149,6 @@ static void extents_kunit_exit(struct kunit *test)
>   	kfree(k_ctx.k_data);
>   }
>   
> -static void ext4_cache_extents_stub(struct inode *inode,
> -				    struct ext4_extent_header *eh)
> -{
> -	return;
> -}
> -
>   static int __ext4_ext_dirty_stub(const char *where, unsigned int line,
>   				 handle_t *handle, struct inode *inode,
>   				 struct ext4_ext_path *path)
> @@ -170,24 +164,6 @@ ext4_ext_insert_extent_stub(handle_t *handle, struct inode *inode,
>   	return ERR_PTR(-ENOSPC);
>   }
>   
> -static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> -				       ext4_lblk_t len)
> -{
> -	return;
> -}
> -
> -void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> -				ext4_lblk_t len, ext4_fsblk_t pblk,
> -				unsigned int status, bool delalloc_reserve_used)
> -{
> -	return;
> -}
> -
> -static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
> -{
> -	return;
> -}
> -
>   /*
>    * We will zeroout the equivalent range in the data area
>    */
> @@ -244,13 +220,7 @@ static int extents_kunit_init(struct kunit *test)
>   	struct ext4_sb_info *sbi = NULL;
>   	struct kunit_ext_test_param *param =
>   		(struct kunit_ext_test_param *)(test->param_value);
> -
> -	/* setup the mock inode */
> -	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
> -	if (k_ctx.k_ei == NULL)
> -		return -ENOMEM;
> -	ei = k_ctx.k_ei;
> -	inode = &ei->vfs_inode;
> +	int err;
>   
>   	sb = sget(&ext_fs_type, NULL, ext_set, 0, NULL);
>   	if (IS_ERR(sb))
> @@ -269,6 +239,24 @@ static int extents_kunit_init(struct kunit *test)
>   	if (!param || !param->disable_zeroout)
>   		sbi->s_extent_max_zeroout_kb = 32;
>   
> +	/* setup the mock inode */
> +	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
> +	if (k_ctx.k_ei == NULL)
> +		return -ENOMEM;
> +	ei = k_ctx.k_ei;
> +	inode = &ei->vfs_inode;
> +
> +	err = ext4_es_register_shrinker(sbi);
> +	if (err)
> +		return err;
> +
> +	ext4_es_init_tree(&ei->i_es_tree);
> +	rwlock_init(&ei->i_es_lock);
> +	INIT_LIST_HEAD(&ei->i_es_list);
> +	ei->i_es_all_nr = 0;
> +	ei->i_es_shk_nr = 0;
> +	ei->i_es_shrink_lblk = 0;
> +
>   	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
>   			 << sb->s_blocksize_bits;
>   	ei->i_flags = 0;
> @@ -305,16 +293,15 @@ static int extents_kunit_init(struct kunit *test)
>   	if (!param || param->is_unwrit_at_start)
>   		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
>   
> +	ext4_es_insert_extent(inode, EX_DATA_LBLK, EX_DATA_LEN, EX_DATA_PBLK,
> +			      ext4_ext_is_unwritten(EXT_FIRST_EXTENT(eh)) ?
> +				      EXTENT_STATUS_UNWRITTEN :
> +				      EXTENT_STATUS_WRITTEN,
> +			      0);
> +
>   	/* Add stubs */
> -	kunit_activate_static_stub(test, ext4_cache_extents,
> -				   ext4_cache_extents_stub);
>   	kunit_activate_static_stub(test, __ext4_ext_dirty,
>   				   __ext4_ext_dirty_stub);
> -	kunit_activate_static_stub(test, ext4_es_remove_extent,
> -				   ext4_es_remove_extent_stub);
> -	kunit_activate_static_stub(test, ext4_es_insert_extent,
> -				   ext4_es_insert_extent_stub);
> -	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
>   	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
>   	kunit_activate_static_stub(test, ext4_issue_zeroout,
>   				   ext4_issue_zeroout_stub);
> @@ -379,11 +366,12 @@ static void test_split_convert(struct kunit *test)
>   		kunit_activate_static_stub(test, ext4_ext_insert_extent,
>   					   ext4_ext_insert_extent_stub);
>   
> -	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
>   	ex = path->p_ext;
>   	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
>   	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
> -	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
> +	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start,
> +			ext4_ext_is_unwritten(ex));
>   	if (param->is_zeroout_test)
>   		KUNIT_EXPECT_EQ(test, 0,
>   				check_buffer(k_ctx.k_data, 'X',
> @@ -404,17 +392,47 @@ static void test_split_convert(struct kunit *test)
>   		KUNIT_FAIL(test, "param->type %d not support.", param->type);
>   	}
>   
> -	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
>   	ex = path->p_ext;
>   
>   	for (int i = 0; i < param->nr_exp_ext; i++) {
>   		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
> +		bool es_check_needed = param->type != TEST_SPLIT_CONVERT;
> +		struct extent_status es;
> +		int contains_ex, ex_end, es_end, es_pblk;
>   
>   		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
>   		KUNIT_EXPECT_EQ(test, exp_ext.ex_len,
>   				ext4_ext_get_actual_len(ex));
>   		KUNIT_EXPECT_EQ(test, exp_ext.is_unwrit,
>   				ext4_ext_is_unwritten(ex));
> +		/*
> +		 * Confirm extent cache is in sync. Note that es cache can be
> +		 * merged even when on-disk extents are not so take that into
> +		 * account.
> +		 *
> +		 * Also, ext4_split_convert_extents() forces EXT4_EX_NOCACHE hence
> +		 * es status are ignored for that case.
> +		 */
> +		if (es_check_needed) {
> +			ext4_es_lookup_extent(inode, ex->ee_block, NULL, &es,
> +					      NULL);
> +
> +			ex_end = exp_ext.ex_lblk + exp_ext.ex_len;
> +			es_end = es.es_lblk + es.es_len;
> +			contains_ex = es.es_lblk <= exp_ext.ex_lblk &&
> +				      es_end >= ex_end;
> +			es_pblk = ext4_es_pblock(&es) +
> +				  (exp_ext.ex_lblk - es.es_lblk);
> +
> +			KUNIT_EXPECT_EQ(test, contains_ex, 1);
> +			KUNIT_EXPECT_EQ(test, ext4_ext_pblock(ex), es_pblk);
> +			KUNIT_EXPECT_EQ(test, 1,
> +					(exp_ext.is_unwrit &&
> +					 ext4_es_is_unwritten(&es)) ||
> +						(!exp_ext.is_unwrit &&
> +						 ext4_es_is_written(&es)));
> +		}
>   
>   		/* Only printed on failure */
>   		kunit_log(KERN_INFO, test,
> @@ -424,6 +442,12 @@ static void test_split_convert(struct kunit *test)
>   			  "# [extent %d] got: lblk:%d len:%d unwrit:%d\n", i,
>   			  ex->ee_block, ext4_ext_get_actual_len(ex),
>   			  ext4_ext_is_unwritten(ex));
> +		if (es_check_needed)
> +			kunit_log(
> +				KERN_INFO, test,
> +				"# [extent %d] es: lblk:%d len:%d pblk:%lld type:0x%x\n",
> +				i, es.es_lblk, es.es_len, ext4_es_pblock(&es),
> +				ext4_es_type(&es));
>   		kunit_log(KERN_INFO, test, "------------------\n");
>   
>   		ex = ex + 1;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4cebd82ef3e4..a581e9278d48 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3149,8 +3149,6 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>   	ext4_fsblk_t ee_pblock;
>   	unsigned int ee_len;
>   
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_zeroout_es, inode, ex);
> -
>   	ee_block = le32_to_cpu(ex->ee_block);
>   	ee_len = ext4_ext_get_actual_len(ex);
>   	ee_pblock = ext4_ext_pblock(ex);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 095ccb7ba4ba..a1538bac51c6 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -916,9 +916,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct pending_reservation *pr = NULL;
>   	bool revise_pending = false;
>   
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
> -				   pblk, status, delalloc_reserve_used);
> -
>   	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>   		return;
>   
> @@ -1631,8 +1628,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>   	int reserved = 0;
>   	struct extent_status *es = NULL;
>   
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_es_remove_extent, inode, lblk, len);
> -
>   	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>   		return;
>   


