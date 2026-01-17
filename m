Return-Path: <linux-ext4+bounces-12953-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC7D38D3C
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BEE0301FB71
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12458328B6A;
	Sat, 17 Jan 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLYigMlV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E162D0C82
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768639675; cv=none; b=k14uq6HWNsjGAYckCQvZoOvIp2aJXrBBnjx/6ONYqfxGTEA1x+ZCbtInJmp21rsgTOk7UR5ZxQ2Mzrz5UV+CkH/O0jeIa+ldX22/jfgQtJ6sPkWYembN+sbfYu9z0bXN+5olOXT8miaKF0kahVumDhhK8aa7KGUPiV5CZBCei0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768639675; c=relaxed/simple;
	bh=WRZRxmGx2HInVakTZFyfISyrin9vKwqQMBdxF2ts1pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3eSsP+jX2T75tPywGi4t7ajWC9gB0KPTJY1GUkif90u//ogXopJJRST8/J6fhB79eozSdiSVAcpeZeADDgb1nuUZ8hi8RWDVW22aYUWOJaoTRLNsPDcEm7SqcYlwDk4Jg8gxxHQUBrN36vcB5ZIXJ+0+etonDT+srTRaHi5lno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLYigMlV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a081c163b0so15871815ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768639673; x=1769244473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkiC0QK/xnXZCZQjkwds+0ssEkgXOPtGuOyqAlO5yTQ=;
        b=DLYigMlVixGQd4p1VP0d7vJ8HKRzExI6GJ1jR+aSGHQLUA4apTN10dNaz2aGoaor7g
         u9tEf2S1s1uyEGz4/LM2F2GOca0NmCS2Yu27Mdg5qh0xvdhqUUGF6aUBNSafgWtYOdbf
         xbLnQHRiZNqTQdo3b0kzUGyuglHIv6KBaozQN+rth0/ZVrZY82jQ1EO53dEuh4DgWuUe
         s6O0mjWJxAyhBhD/XW7XZkeUlc+RYfRfgGurkiXyLHx5zrVZHrxnxGqGUpQENQSFSt5c
         0HhoZ5Npxg8Pw1A7XQ7djTInbeDPEvYdM4tpP9yB0bd3FdpsP8zUaIQEmZzdiAlx2uWp
         GSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768639673; x=1769244473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkiC0QK/xnXZCZQjkwds+0ssEkgXOPtGuOyqAlO5yTQ=;
        b=fWVN4UIdEy5GYEgfMWciqw27diOcNkd0VcQUPiIH5egDcAx2F0KRoma9lBsNCnfMPX
         noEFFb7jpzaljeTQCTRrQSvfM9o7chvKhXnvlhQ2ONlWDNKwL0FSkO+ae+X7k6/zU5B2
         vOCA85+vKOqhiqZp+PES578upN+3+YoIUCdaGY22x/bKkS3eY9SXOWouzsybTIVnKIw0
         Tm0rSOQ493VGReL8DhSBJgB0+Whw0ARk+hcxkrYKMO5Ka07g1g2qM0nhScyXzOpj5gIr
         jbeyJDoK+OkB/7cFTGGgy4ivQba5ScW8orngp/RStzH+XvCpm0U8dw5mP2ISIedVlCx4
         g/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmWtjCmor8a+53XPk//bcDgX/N3qzVljrqHeyMq5Xri66PAex18jTOWQ6LTTs1EbblmuGkC+pK1XgW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxck2fO151RA8IAWORarQ5zop1YGDrkRxUw/XRG7hCTNiyDwBdU
	1HcOllecKIpvfmYWxZBOT+6ZdmeavPyk0kdoKdpuSaHXfVcUyDOZqPJ7WUEO/+mo95k=
X-Gm-Gg: AY/fxX4K/KdgaOPgEIdUwC2APAF7j+13CvcVZ33Kw1kgPtHDZ+VVjsIeh/k8eyr7Lkc
	Zpjb9ym48qlJvs9qZL6fJ9GyWvmi5AtnS/okvhJDfU9f5JjEbxj1NjMyUwpbcLuLad2PlfgC0LO
	ld/xSiyT7BbkS9ZwOJTteUe5XyozzLJ/bcpPOZsGGpRUDHU3ykIk0Qeq9b3cKBK2Q5Y/sFXBA8Q
	I+68KaYdjbPGTpyxVVn26lQwyixIRPT3oeHVG6c0H1nCeBb5qwQRrkJKwC03u4o71EKwvi4sa4R
	peypHS/zIKKuv8LFE2Ym01IlH5PE+m5AeM7lecl7QehkrqJdXWZDpQ5ui8L90red3GnC6RnNIH9
	nBL0fK2KI8uxs+hScpolZ+Qd8Cszf696XMOgrvusksFwqiPgC5ySJc3j/j2sVYO+TfWQA+gw8P6
	UVWFBWm8oz/fgL0cfV8G7PDAJYizHdUioZQtYq4KxIdPbLdIOZqNUM8Sf9eBBzjGnFBvykfA==
X-Received: by 2002:a17:902:cecf:b0:2a0:c5b8:24b0 with SMTP id d9443c01a7336-2a7177d9a6bmr54318045ad.46.1768639672895;
        Sat, 17 Jan 2026 00:47:52 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9e85sm40941275ad.26.2026.01.17.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:47:52 -0800 (PST)
Message-ID: <4e3ade84-6cfb-48e7-81f7-b12c39ee7931@gmail.com>
Date: Sat, 17 Jan 2026 16:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] ext4: kunit tests for extent splitting and
 conversion
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <da910e221a92a16601654ced8df50348bdff6f31.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <da910e221a92a16601654ced8df50348bdff6f31.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Add multiple KUnit tests to test various permutations of extent
> splitting and conversion.
> 
> We test the following cases:
> 
> 1. Split of unwritten extent into 2 parts and convert 1 part to written
> 2. Split of unwritten extent into 3 parts and convert 1 part to written
> 3. Split of written extent into 2 parts and convert 1 part to unwritten
> 4. Split of written extent into 3 parts and convert 1 part to unwritten
> 5. Zeroout fallback for all the above cases except 3-4 because zeroout
>     is not supported for written to unwritten splits
> 
> The main function we test here is ext4_split_convert_extents().
> Currently some of the tests are failing due to issues in implementation.
> All failures are mitigated at other layers in ext4 [1] but still point
> out the mismatch in expectation of what the caller wants vs what the
> function does.
> 
> The aim is to eventually fix all the failures we see here. More detailed
> implementation notes can be found in the topmost commit in the test file.
> 
> [1] for example, EXT4_GET_BLOCKS_CONVERT doesn't
> really convert the split extent to written, but rather the callers end up
> doing the conversion.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Apart from Jan's comments, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents-test.c   | 518 +++++++++++++++++++++++++++++++++++++++
>   fs/ext4/extents.c        |  23 +-
>   fs/ext4/extents_status.c |   3 +
>   fs/ext4/inode.c          |   4 +
>   4 files changed, 546 insertions(+), 2 deletions(-)
>   create mode 100644 fs/ext4/extents-test.c
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> new file mode 100644
> index 000000000000..02565ad19abe
> --- /dev/null
> +++ b/fs/ext4/extents-test.c
> @@ -0,0 +1,518 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Written by Ojaswin Mujoo <ojaswin@linux.ibm.com> (IBM)
> + *
> + * These Kunit tests are designed to test the functionality of
> + * extent split and conversion in ext4.
> + *
> + * Currently, ext4 can split extents in 2 ways:
> + * 1. By splitting the extents in the extent tree and optionally converting them
> + *    to written or unwritten based on flags passed.
> + * 2. In case 1 encounters an error, ext4 instead zerooes out the unwritten
> + *    areas of the extent and marks the complete extent written.
> + *
> + * The primary function that handles this is ext4_split_convert_extents().
> + *
> + * We test both of the methods of split. The behavior we try to enforce is:
> + * 1. When passing EXT4_GET_BLOCKS_CONVERT flag to ext4_split_convert_extents(),
> + *    the split extent should be converted to initialized.
> + * 2. When passing EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flag to
> + *    ext4_split_convert_extents(), the split extent should be converted to
> + *    uninitialized.
> + * 3. In case we use the zeroout method, then we should correctly write zeroes
> + *    to the unwritten areas of the extent and we should not corrupt/leak any
> + *    data.
> + *
> + * Enforcing 1 and 2 is straight forward, we just setup a minimal inode with
> + * extent tree, call ext4_split_convert_extents() and check the final state of
> + * the extent tree.
> + *
> + * For zeroout testing, we maintain a separate buffer which represents the disk
> + * data corresponding to the extents. We then override ext4's zeroout functions
> + * to instead write zeroes to our buffer. Then, we override
> + * ext4_ext_insert_extent() to return -ENOSPC, which triggers the zeroout.
> + * Finally, we check the state of the extent tree and zeroout buffer to confirm
> + * everything went well.
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/static_stub.h>
> +#include <linux/gfp_types.h>
> +#include <linux/stddef.h>
> +
> +#include "ext4.h"
> +#include "ext4_extents.h"
> +
> +#define EX_DATA_PBLK 100
> +#define EX_DATA_LBLK 10
> +#define EX_DATA_LEN 3
> +
> +struct kunit_ctx {
> +	/*
> +	 * Ext4 inode which has only 1 unwrit extent
> +	 */
> +	struct ext4_inode_info *k_ei;
> +	/*
> +	 * Represents the underlying data area (used for zeroout testing)
> +	 */
> +	char *k_data;
> +} k_ctx;
> +
> +/*
> + * describes the state of an expected extent in extent tree.
> + */
> +struct kunit_ext_state {
> +	ext4_lblk_t ex_lblk;
> +	ext4_lblk_t ex_len;
> +	bool is_unwrit;
> +};
> +
> +/*
> + * describes the state of the data area of a writ extent. Used for testing
> + * correctness of zeroout.
> + */
> +struct kunit_ext_data_state {
> +	char exp_char;
> +	ext4_lblk_t off_blk;
> +	ext4_lblk_t len_blk;
> +};
> +
> +struct kunit_ext_test_param {
> +	/* description of test */
> +	char *desc;
> +
> +	/* is extent unwrit at beginning of test */
> +	bool is_unwrit_at_start;
> +
> +	/* flags to pass while splitting */
> +	int split_flags;
> +
> +	/* map describing range to split */
> +	struct ext4_map_blocks split_map;
> +
> +	/* no of extents expected after split */
> +	int nr_exp_ext;
> +
> +	/*
> +	 * expected state of extents after split. We will never split into more
> +	 * than 3 extents
> +	 */
> +	struct kunit_ext_state exp_ext_state[3];
> +
> +	/* Below fields used for zeroout tests */
> +
> +	bool is_zeroout_test;
> +	/*
> +	 * no of expected data segments (zeroout tests). Example, if we expect
> +	 * data to be 4kb 0s, followed by 8kb non-zero, then nr_exp_data_segs==2
> +	 */
> +	int nr_exp_data_segs;
> +
> +	/*
> +	 * expected state of data area after zeroout.
> +	 */
> +	struct kunit_ext_data_state exp_data_state[3];
> +};
> +
> +static void ext_kill_sb(struct super_block *sb)
> +{
> +	generic_shutdown_super(sb);
> +}
> +
> +static int ext_set(struct super_block *sb, void *data)
> +{
> +	return 0;
> +}
> +
> +static struct file_system_type ext_fs_type = {
> +	.name = "extents test",
> +	.kill_sb = ext_kill_sb,
> +};
> +
> +static void extents_kunit_exit(struct kunit *test)
> +{
> +	kfree(k_ctx.k_ei);
> +	kfree(k_ctx.k_data);
> +}
> +
> +static void ext4_cache_extents_stub(struct inode *inode,
> +				    struct ext4_extent_header *eh)
> +{
> +	return;
> +}
> +
> +static int __ext4_ext_dirty_stub(const char *where, unsigned int line,
> +				 handle_t *handle, struct inode *inode,
> +				 struct ext4_ext_path *path)
> +{
> +	return 0;
> +}
> +
> +static struct ext4_ext_path *
> +ext4_ext_insert_extent_stub(handle_t *handle, struct inode *inode,
> +			    struct ext4_ext_path *path,
> +			    struct ext4_extent *newext, int gb_flags)
> +{
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> +				       ext4_lblk_t len)
> +{
> +	return;
> +}
> +
> +static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
> +{
> +	return;
> +}
> +
> +/*
> + * We will zeroout the equivalent range in the data area
> + */
> +static int ext4_ext_zeroout_stub(struct inode *inode, struct ext4_extent *ex)
> +{
> +	ext4_lblk_t ee_block, off_blk;
> +	loff_t ee_len;
> +	loff_t off_bytes;
> +	struct kunit *test = kunit_get_current_test();
> +
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
> +
> +	KUNIT_EXPECT_EQ_MSG(test, 1, ee_block >= EX_DATA_LBLK, "ee_block=%d",
> +			    ee_block);
> +	KUNIT_EXPECT_EQ(test, 1,
> +			ee_block + ee_len <= EX_DATA_LBLK + EX_DATA_LEN);
> +
> +	off_blk = ee_block - EX_DATA_LBLK;
> +	off_bytes = off_blk << inode->i_sb->s_blocksize_bits;
> +	memset(k_ctx.k_data + off_bytes, 0,
> +	       ee_len << inode->i_sb->s_blocksize_bits);
> +
> +	return 0;
> +}
> +
> +static int ext4_issue_zeroout_stub(struct inode *inode, ext4_lblk_t lblk,
> +				   ext4_fsblk_t pblk, ext4_lblk_t len)
> +{
> +	ext4_lblk_t off_blk;
> +	loff_t off_bytes;
> +	struct kunit *test = kunit_get_current_test();
> +
> +	kunit_log(KERN_ALERT, test,
> +		  "%s: lblk=%u pblk=%llu len=%u", __func__, lblk, pblk, len);
> +	KUNIT_EXPECT_EQ(test, 1, lblk >= EX_DATA_LBLK);
> +	KUNIT_EXPECT_EQ(test, 1, lblk + len <= EX_DATA_LBLK + EX_DATA_LEN);
> +	KUNIT_EXPECT_EQ(test, 1, lblk - EX_DATA_LBLK == pblk - EX_DATA_PBLK);
> +
> +	off_blk = lblk - EX_DATA_LBLK;
> +	off_bytes = off_blk << inode->i_sb->s_blocksize_bits;
> +	memset(k_ctx.k_data + off_bytes, 0,
> +	       len << inode->i_sb->s_blocksize_bits);
> +
> +	return 0;
> +}
> +
> +static int extents_kunit_init(struct kunit *test)
> +{
> +	struct ext4_extent_header *eh = NULL;
> +	struct ext4_inode_info *ei;
> +	struct inode *inode;
> +	struct super_block *sb;
> +	struct kunit_ext_test_param *param =
> +		(struct kunit_ext_test_param *)(test->param_value);
> +
> +	/* setup the mock inode */
> +	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
> +	if (k_ctx.k_ei == NULL)
> +		return -ENOMEM;
> +	ei = k_ctx.k_ei;
> +	inode = &ei->vfs_inode;
> +
> +	sb = sget(&ext_fs_type, NULL, ext_set, 0, NULL);
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
> +
> +	sb->s_blocksize = 4096;
> +	sb->s_blocksize_bits = 12;
> +
> +	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10) << sb->s_blocksize_bits;
> +	inode->i_sb = sb;
> +
> +	k_ctx.k_data = kzalloc(EX_DATA_LEN * 4096, GFP_KERNEL);
> +	if (k_ctx.k_data == NULL)
> +		return -ENOMEM;
> +
> +	/*
> +	 * set the data area to a junk value
> +	 */
> +	memset(k_ctx.k_data, 'X', EX_DATA_LEN * 4096);
> +
> +	/* create a tree with depth 0 */
> +	eh = (struct ext4_extent_header *)k_ctx.k_ei->i_data;
> +
> +	/* Fill extent header */
> +	eh = ext_inode_hdr(&k_ctx.k_ei->vfs_inode);
> +	eh->eh_depth = 0;
> +	eh->eh_entries = cpu_to_le16(1);
> +	eh->eh_magic = EXT4_EXT_MAGIC;
> +	eh->eh_max =
> +		cpu_to_le16(ext4_ext_space_root_idx(&k_ctx.k_ei->vfs_inode, 0));
> +	eh->eh_generation = 0;
> +
> +	/*
> +	 * add 1 extent in leaf node covering lblks [10,13) and pblk [100,103)
> +	 */
> +	EXT_FIRST_EXTENT(eh)->ee_block = cpu_to_le32(EX_DATA_LBLK);
> +	EXT_FIRST_EXTENT(eh)->ee_len = cpu_to_le16(EX_DATA_LEN);
> +	ext4_ext_store_pblock(EXT_FIRST_EXTENT(eh), EX_DATA_PBLK);
> +	if (!param || param->is_unwrit_at_start)
> +		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
> +
> +	/* Add stubs */
> +	kunit_activate_static_stub(test, ext4_cache_extents,
> +				   ext4_cache_extents_stub);
> +	kunit_activate_static_stub(test, __ext4_ext_dirty,
> +				   __ext4_ext_dirty_stub);
> +	kunit_activate_static_stub(test, ext4_es_remove_extent,
> +				   ext4_es_remove_extent_stub);
> +	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
> +	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
> +	kunit_activate_static_stub(test, ext4_issue_zeroout,
> +				   ext4_issue_zeroout_stub);
> +	return 0;
> +}
> +
> +/*
> + * Return 1 if all bytes in the buf equal to c, else return the offset of first mismatch
> + */
> +static int check_buffer(char *buf, int c, int size)
> +{
> +	void *ret = NULL;
> +
> +	ret = memchr_inv(buf, c, size);
> +	if (ret  == NULL)
> +		return 0;
> +
> +	kunit_log(KERN_ALERT, kunit_get_current_test(),
> +		  "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
> +		  ((char *)ret - buf), c, *((char *)ret));
> +	return 1;
> +}
> +
> +static void test_split_convert(struct kunit *test)
> +{
> +	struct ext4_ext_path *path;
> +	struct inode *inode = &k_ctx.k_ei->vfs_inode;
> +	struct ext4_extent *ex;
> +	struct ext4_map_blocks map;
> +	const struct kunit_ext_test_param *param =
> +		(const struct kunit_ext_test_param *)(test->param_value);
> +	int blkbits = inode->i_sb->s_blocksize_bits;
> +
> +	if (param->is_zeroout_test)
> +		/*
> +		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
> +		 */
> +		kunit_activate_static_stub(test, ext4_ext_insert_extent,
> +					   ext4_ext_insert_extent_stub);
> +
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	ex = path->p_ext;
> +	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
> +	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
> +	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
> +	if (param->is_zeroout_test)
> +		KUNIT_EXPECT_EQ(test, 0,
> +				check_buffer(k_ctx.k_data, 'X',
> +					     EX_DATA_LEN << blkbits));
> +
> +	map.m_lblk = param->split_map.m_lblk;
> +	map.m_len = param->split_map.m_len;
> +	ext4_split_convert_extents(NULL, inode, &map, path,
> +				   param->split_flags, NULL);
> +
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	ex = path->p_ext;
> +
> +	for (int i = 0; i < param->nr_exp_ext; i++) {
> +		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
> +
> +		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
> +		KUNIT_EXPECT_EQ(test, exp_ext.ex_len,
> +				ext4_ext_get_actual_len(ex));
> +		KUNIT_EXPECT_EQ(test, exp_ext.is_unwrit,
> +				ext4_ext_is_unwritten(ex));
> +
> +		/* Only printed on failure */
> +		kunit_log(KERN_INFO, test,
> +			  "# [extent %d] exp: lblk:%d len:%d unwrit:%d \n", i,
> +			  exp_ext.ex_lblk, exp_ext.ex_len, exp_ext.is_unwrit);
> +		kunit_log(KERN_INFO, test,
> +			  "# [extent %d] got: lblk:%d len:%d unwrit:%d\n", i,
> +			  ex->ee_block, ext4_ext_get_actual_len(ex),
> +			  ext4_ext_is_unwritten(ex));
> +		kunit_log(KERN_INFO, test, "------------------\n");
> +
> +		ex = ex + 1;
> +	}
> +
> +	if (!param->is_zeroout_test)
> +		return;
> +
> +	/*
> +	 * Check that then data area has been zeroed out correctly
> +	 */
> +	for (int i = 0; i < param->nr_exp_data_segs; i++) {
> +		loff_t off, len;
> +		struct kunit_ext_data_state exp_data_seg = param->exp_data_state[i];
> +
> +		off = exp_data_seg.off_blk << blkbits;
> +		len = exp_data_seg.len_blk << blkbits;
> +		KUNIT_EXPECT_EQ_MSG(test, 0,
> +				    check_buffer(k_ctx.k_data + off,
> +						 exp_data_seg.exp_char, len),
> +				    "# corruption in byte range [%lld, %lld)",
> +				    off, len);
> +	}
> +
> +	return;
> +}
> +
> +static const struct kunit_ext_test_param test_split_convert_params[] = {
> +	/* unwrit to writ splits */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/*
> +	 * ***** zeroout tests *****
> +	 */
> +	/* unwrit to writ splits */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
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
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
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
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
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
> +};
> +
> +static void ext_get_desc(struct kunit *test, const void *p, char *desc)
> +
> +{
> +	struct kunit_ext_test_param *param = (struct kunit_ext_test_param *)p;
> +
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s\n", param->desc);
> +}
> +
> +static int test_split_convert_param_init(struct kunit *test)
> +{
> +	size_t arr_size = ARRAY_SIZE(test_split_convert_params);
> +
> +	kunit_register_params_array(test, test_split_convert_params, arr_size,
> +				    ext_get_desc);
> +	return 0;
> +}
> +
> +/*
> + * Note that we use KUNIT_CASE_PARAM_WITH_INIT() instead of the more compact
> + * KUNIT_ARRAY_PARAM() because the later currently has a limitation causing the
> + * output parsing to be prone to error. For more context:
> + *
> + * https://lore.kernel.org/linux-kselftest/aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/
> + */
> +static struct kunit_case extents_test_cases[] = {
> +	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
> +				   test_split_convert_param_init, NULL),
> +	{}
> +};
> +
> +static struct kunit_suite extents_test_suite = {
> +	.name = "ext4_extents_test",
> +	.init = extents_kunit_init,
> +	.exit = extents_kunit_exit,
> +	.test_cases = extents_test_cases,
> +};
> +
> +kunit_test_suites(&extents_test_suite);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c7c66ab825e7..4cebd82ef3e4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -32,6 +32,7 @@
>   #include "ext4_jbd2.h"
>   #include "ext4_extents.h"
>   #include "xattr.h"
> +#include <kunit/static_stub.h>
>   
>   #include <trace/events/ext4.h>
>   
> @@ -197,6 +198,9 @@ static int __ext4_ext_dirty(const char *where, unsigned int line,
>   {
>   	int err;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(__ext4_ext_dirty, where, line, handle, inode,
> +				   path);
> +
>   	WARN_ON(!rwsem_is_locked(&EXT4_I(inode)->i_data_sem));
>   	if (path->p_bh) {
>   		ext4_extent_block_csum_set(inode, ext_block_hdr(path->p_bh));
> @@ -535,6 +539,8 @@ static void ext4_cache_extents(struct inode *inode,
>   	ext4_lblk_t prev = 0;
>   	int i;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
> +
>   	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
>   		unsigned int status = EXTENT_STATUS_WRITTEN;
>   		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
> @@ -898,6 +904,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>   	int ret;
>   	gfp_t gfp_flags = GFP_NOFS;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_find_extent, inode, block, path, flags);
> +
>   	if (flags & EXT4_EX_NOFAIL)
>   		gfp_flags |= __GFP_NOFAIL;
>   
> @@ -1990,6 +1998,9 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>   	ext4_lblk_t next;
>   	int mb_flags = 0, unwritten;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_ext_insert_extent, handle, inode, path,
> +				   newext, gb_flags);
> +
>   	if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>   		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
>   	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
> @@ -3138,8 +3149,10 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>   	ext4_fsblk_t ee_pblock;
>   	unsigned int ee_len;
>   
> -	ee_block  = le32_to_cpu(ex->ee_block);
> -	ee_len    = ext4_ext_get_actual_len(ex);
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_zeroout_es, inode, ex);
> +
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
>   	ee_pblock = ext4_ext_pblock(ex);
>   
>   	if (ee_len == 0)
> @@ -3155,6 +3168,8 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>   	ext4_fsblk_t ee_pblock;
>   	unsigned int ee_len;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_ext_zeroout, inode, ex);
> +
>   	ee_len    = ext4_ext_get_actual_len(ex);
>   	ee_pblock = ext4_ext_pblock(ex);
>   	return ext4_issue_zeroout(inode, le32_to_cpu(ex->ee_block), ee_pblock,
> @@ -6180,3 +6195,7 @@ int ext4_ext_clear_bb(struct inode *inode)
>   	ext4_free_ext_path(path);
>   	return 0;
>   }
> +
> +#ifdef CONFIG_EXT4_KUNIT_TESTS
> +#include "extents-test.c"
> +#endif
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index fc83e7e2ca9e..6c1faf7c9f2a 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -16,6 +16,7 @@
>   #include "ext4.h"
>   
>   #include <trace/events/ext4.h>
> +#include <kunit/static_stub.h>
>   
>   /*
>    * According to previous discussion in Ext4 Developer Workshop, we
> @@ -1627,6 +1628,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>   	int reserved = 0;
>   	struct extent_status *es = NULL;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_es_remove_extent, inode, lblk, len);
> +
>   	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>   		return;
>   
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2e79b09fe2f0..c60813260f9a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -48,6 +48,8 @@
>   #include "acl.h"
>   #include "truncate.h"
>   
> +#include <kunit/static_stub.h>
> +
>   #include <trace/events/ext4.h>
>   
>   static void ext4_journalled_zero_new_buffers(handle_t *handle,
> @@ -401,6 +403,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
>   {
>   	int ret;
>   
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_issue_zeroout, inode, lblk, pblk, len);
> +
>   	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
>   		return fscrypt_zeroout_range(inode, lblk, pblk, len);
>   


