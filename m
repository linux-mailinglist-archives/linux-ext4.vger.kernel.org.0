Return-Path: <linux-ext4+bounces-14191-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL94Ni8FoWmSpgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14191-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 03:45:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0E1B21C4
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 03:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B648300ACA6
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D12EAB83;
	Fri, 27 Feb 2026 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FMlRHWgo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF0D1DE2C9
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772160300; cv=none; b=q69RldEDf7Nii63VroQNNTjuhbuR+B3jmCM6aY7ijaftA1CRUNMSyG+sgzgYxG84UfjPom2rjd7vP50nM20ArgsTcchMAkCKqIHLr9S/RbM2PLMNG9qX676tKVP91FMGfLwST6IK+YH55Rux4zaEPobZgjTMQ+Yn26gJyXxWoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772160300; c=relaxed/simple;
	bh=BOMtamkPlQKY71kjXNakr68dvJEb2l7FXiHBQsTq/Ls=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tEvUDtbExUsQdQsi2p/D+OuQx1qmfK6TqlAdBUI+VybVUBMANe/OhhPj3GLwihKh8wXTl8+sHJTffiu/dEGwzXnfYuBxYUBO6IE8UuupzcOg/XsegQgRM2hacaztZnJng7DB8p3Dsqy8pmfBR08O9A11RS2m+vRjr9h7wzeeyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FMlRHWgo; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=37toRga+eC1HHCWSyv3+pyHCKvuWSNvcvqz940GNVR0=;
	b=FMlRHWgoBexL33qRuomobhHOlaTxOyHToogN9J2SZjSDg4jXVjnQxKK/huxWKnULOGq1PFcyl
	9X+iUP6GWAyPCHFwdX1DzSZC7LngBy/mi4WqfyVPb9b3PFBeZy2bhlxxo/qExdR/5oR1C8ePGat
	QOfvsqyrdpBId2WyjxjXO+E=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fMXc42jvyzpTLP;
	Fri, 27 Feb 2026 10:40:04 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A116740363;
	Fri, 27 Feb 2026 10:44:54 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 10:44:54 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 10:44:53 +0800
Subject: Re: [PATCH] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
To: Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20260226110917.1904980-1-yebin@huaweicloud.com>
 <o65evw32fb2cg2sclvxc3dkbqlhzzdns3uducvb7mgbkp4i5l3@hsluqhpejick>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A10525.4000504@huawei.com>
Date: Fri, 27 Feb 2026 10:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <o65evw32fb2cg2sclvxc3dkbqlhzzdns3uducvb7mgbkp4i5l3@hsluqhpejick>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-14191-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,huawei.com:mid,huawei.com:dkim,huawei.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1A0E1B21C4
X-Rspamd-Action: no action



On 2026/2/26 21:42, Jan Kara wrote:
> On Thu 26-02-26 19:09:17, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
>> To solve this issue, the ext4 test code needs to be decoupled. The ext4
>> test module is compiled into a separate module.
>>
>> Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>> Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
>> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>
> I think this is a good idea but:
>
>> -#ifdef CONFIG_EXT4_KUNIT_TESTS
>> -#include "mballoc-test.c"
>> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
>> +void mb_clear_bits_test(void *bm, int cur, int len)
>> +{
>> +	 mb_clear_bits(bm, cur, len);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_clear_bits_test);
>
> Please use EXPORT_SYMBOL_FOR_MODULES() for the exports to make them clearly
> ext4 internal. Thanks!
>
> 								Honza
>
Thank you for your suggestion.I will send a new version.
>> +
>> +ext4_fsblk_t
>> +ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
>> +			       int *errp)
>> +{
>> +	return ext4_mb_new_blocks_simple(ar, errp);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_mb_new_blocks_simple_test);
>> +
>> +int mb_find_next_zero_bit_test(void *addr, int max, int start)
>> +{
>> +	return mb_find_next_zero_bit(addr, max, start);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_find_next_zero_bit_test);
>> +
>> +int mb_find_next_bit_test(void *addr, int max, int start)
>> +{
>> +	return mb_find_next_bit(addr, max, start);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_find_next_bit_test);
>> +
>> +void mb_clear_bit_test(int bit, void *addr)
>> +{
>> +	mb_clear_bit(bit, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_clear_bit_test);
>> +
>> +int mb_test_bit_test(int bit, void *addr)
>> +{
>> +	return mb_test_bit(bit, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_test_bit_test);
>> +
>> +int ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
>> +				     handle_t *handle)
>> +{
>> +	return ext4_mb_mark_diskspace_used(ac, handle);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_mb_mark_diskspace_used_test);
>> +
>> +int mb_mark_used_test(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>> +{
>> +	return mb_mark_used(e4b, ex);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_mark_used_test);
>> +
>> +void ext4_mb_generate_buddy_test(struct super_block *sb, void *buddy,
>> +				 void *bitmap, ext4_group_t group,
>> +				 struct ext4_group_info *grp)
>> +{
>> +	ext4_mb_generate_buddy(sb, buddy, bitmap, group, grp);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_mb_generate_buddy_test);
>> +
>> +int ext4_mb_load_buddy_test(struct super_block *sb, ext4_group_t group,
>> +			    struct ext4_buddy *e4b)
>> +{
>> +	return ext4_mb_load_buddy(sb, group, e4b);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_mb_load_buddy_test);
>> +
>> +void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b)
>> +{
>> +	ext4_mb_unload_buddy(e4b);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_mb_unload_buddy_test);
>> +
>> +void mb_free_blocks_test(struct inode *inode, struct ext4_buddy *e4b,
>> +			 int first, int count)
>> +{
>> +	mb_free_blocks(inode, e4b, first, count);
>> +}
>> +EXPORT_SYMBOL_GPL(mb_free_blocks_test);
>> +
>> +void ext4_free_blocks_simple_test(struct inode *inode, ext4_fsblk_t block,
>> +				  unsigned long count)
>> +{
>> +	return ext4_free_blocks_simple(inode, block, count);
>> +}
>> +EXPORT_SYMBOL_GPL(ext4_free_blocks_simple_test);
>> +
>> +EXPORT_SYMBOL_GPL(ext4_wait_block_bitmap);
>> +EXPORT_SYMBOL_GPL(ext4_mb_init);
>> +EXPORT_SYMBOL_GPL(ext4_get_group_desc);
>> +EXPORT_SYMBOL_GPL(ext4_count_free_clusters);
>> +EXPORT_SYMBOL_GPL(ext4_get_group_info);
>> +EXPORT_SYMBOL_GPL(ext4_free_group_clusters_set);
>> +EXPORT_SYMBOL_GPL(ext4_mb_release);
>> +EXPORT_SYMBOL_GPL(ext4_read_block_bitmap_nowait);
>> +EXPORT_SYMBOL_GPL(mb_set_bits);
>> +EXPORT_SYMBOL_GPL(ext4_fc_init_inode);
>> +EXPORT_SYMBOL_GPL(ext4_mb_mark_context);
>>   #endif
>> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index 15a049f05d04..b32e03e7ae8d 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -270,4 +270,34 @@ ext4_mballoc_query_range(
>>   	ext4_mballoc_query_range_fn	formatter,
>>   	void				*priv);
>>
>> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
>> +extern void mb_clear_bits_test(void *bm, int cur, int len);
>> +extern int ext4_mb_mark_context(handle_t *handle,
>> +		struct super_block *sb, bool state,
>> +		ext4_group_t group, ext4_grpblk_t blkoff,
>> +		ext4_grpblk_t len, int flags,
>> +		ext4_grpblk_t *ret_changed);
>> +extern ext4_fsblk_t
>> +ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
>> +			       int *errp);
>> +extern int mb_find_next_zero_bit_test(void *addr, int max, int start);
>> +extern int mb_find_next_bit_test(void *addr, int max, int start);
>> +extern void mb_clear_bit_test(int bit, void *addr);
>> +extern int mb_test_bit_test(int bit, void *addr);
>> +extern int
>> +ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
>> +				 handle_t *handle);
>> +extern int mb_mark_used_test(struct ext4_buddy *e4b,
>> +			     struct ext4_free_extent *ex);
>> +extern void ext4_mb_generate_buddy_test(struct super_block *sb,
>> +		void *buddy, void *bitmap, ext4_group_t group,
>> +		struct ext4_group_info *grp);
>> +extern int ext4_mb_load_buddy_test(struct super_block *sb,
>> +		ext4_group_t group, struct ext4_buddy *e4b);
>> +extern void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b);
>> +extern void mb_free_blocks_test(struct inode *inode,
>> +		struct ext4_buddy *e4b, int first, int count);
>> +extern void ext4_free_blocks_simple_test(struct inode *inode,
>> +		ext4_fsblk_t block, unsigned long count);
>> +#endif
>>   #endif
>> --
>> 2.34.1
>>

