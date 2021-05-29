Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF51394B78
	for <lists+linux-ext4@lfdr.de>; Sat, 29 May 2021 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhE2J5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 May 2021 05:57:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2096 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2J5G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 May 2021 05:57:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FscHt59FJzWphg
        for <linux-ext4@vger.kernel.org>; Sat, 29 May 2021 17:50:50 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:55:28 +0800
Received: from [127.0.0.1] (10.174.177.249) by dggema765-chm.china.huawei.com
 (10.1.198.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:55:27 +0800
Subject: Re: [PATCH 10/12] hashmap: change return value type of,
 ext2fs_hashmap_add()
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        Wu Guanghao <wuguanghao3@huawei.com>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <13880683-11b1-395a-05d0-f9076cca1672@huawei.com>
 <ECE8BAEA-EDA7-472D-9163-ABD0709F91F7@gmail.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <42b64a9f-05ff-2c8d-e991-e4e91a26b57c@huawei.com>
Date:   Sat, 29 May 2021 17:55:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ECE8BAEA-EDA7-472D-9163-ABD0709F91F7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2021/5/25 20:45, Благодаренко Артём wrote:
>
>> On 24 May 2021, at 14:25, Wu Guanghao <wuguanghao3@huawei.com> wrote:
>>
>> In ext2fs_hashmap_add(), new entry is allocated by calling
>> malloc(). If malloc() return NULL, it will cause a
>> segmentation fault problem.
>>
>> Here, we change return value type of ext2fs_hashmap_add()
>> from void to int. If allocating new entry fails, we will
>> return 1, and the callers should also verify the return
>> value of ext2fs_hashmap_add().
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> ---
>> contrib/android/base_fs.c | 12 +++++++++---
>> lib/ext2fs/fileio.c       | 11 +++++++++--
>> lib/ext2fs/hashmap.c      | 12 ++++++++++--
>> lib/ext2fs/hashmap.h      |  4 ++--
>> 4 files changed, 30 insertions(+), 9 deletions(-)
>>
>> diff --git a/contrib/android/base_fs.c b/contrib/android/base_fs.c
>> index 652317e2..d3e00d18 100644
>> --- a/contrib/android/base_fs.c
>> +++ b/contrib/android/base_fs.c
>> @@ -110,10 +110,16 @@ struct ext2fs_hashmap *basefs_parse(const char *file, const char *mountpoint)
>> 	if (!entries)
>> 		goto end;
>>
>> -	while ((entry = basefs_readline(f, mountpoint, &err)))
>> -		ext2fs_hashmap_add(entries, entry, entry->path,
>> +	while ((entry = basefs_readline(f, mountpoint, &err))) {
>> +		err = ext2fs_hashmap_add(entries, entry, entry->path,
>> 				   strlen(entry->path));
>> -
>> +		if (err) {
>> +			free_base_fs_entry(entry);
>> +			fclose(f);
>> +			ext2fs_hashmap_free(entries);
>> +			return NULL;
>> +		}
>> +	}
>> 	if (err) {
>> 		fclose(f);
>> 		ext2fs_hashmap_free(entries);
>> diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
>> index a0b5d971..b86951d9 100644
>> --- a/lib/ext2fs/fileio.c
>> +++ b/lib/ext2fs/fileio.c
>> @@ -475,8 +475,15 @@ errcode_t ext2fs_file_write(ext2_file_t file, const void *buf,
>>
>> 			if (new_block) {
>> 				new_block->physblock = file->physblock;
>> -				ext2fs_hashmap_add(fs->block_sha_map, new_block,
>> -					new_block->sha, sizeof(new_block->sha));
>> +				int ret = ext2fs_hashmap_add(fs->block_sha_map,
>> +						new_block, new_block->sha,
>> +						sizeof(new_block->sha));
>> +				if (ret) {
>> +					retval = EXT2_ET_NO_MEMORY;
>> +					free(new_block);
>> +					new_block = NULL;
> There is no need to set new_block to NULL here.. new_block is a local variable and the function returns after "fail" label.
> Same for blocks above which also jump to the “fail” label.

Thanks for your suggestion.

we will send the v2 patches.

>> +					goto fail;
>> +				}
>> 			}
>>
>> 			if (bmap_flags & BMAP_SET) {
>> diff --git a/lib/ext2fs/hashmap.c b/lib/ext2fs/hashmap.c
>> index ffe61ce9..7278edaf 100644
>> --- a/lib/ext2fs/hashmap.c
>> +++ b/lib/ext2fs/hashmap.c
>> @@ -36,6 +36,9 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
>> {
>> 	struct ext2fs_hashmap *h = calloc(sizeof(struct ext2fs_hashmap) +
>> 				sizeof(struct ext2fs_hashmap_entry) * size, 1);
>> +	if (!h)
>> +		return NULL;
>> +
>> 	h->size = size;
>> 	h->free = free_fct;
>> 	h->hash = hash_fct;
>> @@ -43,12 +46,15 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
>> 	return h;
>> }
>>
>> -void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
>> -			size_t key_len)
>> +int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
>> +		void *data, const void *key, size_t key_len)
>> {
>> 	uint32_t hash = h->hash(key, key_len) % h->size;
>> 	struct ext2fs_hashmap_entry *e = malloc(sizeof(*e));
>>
>> +	if (!e)
>> +		return -1;
>> +
>> 	e->data = data;
>> 	e->key = key;
>> 	e->key_len = key_len;
>> @@ -62,6 +68,8 @@ void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
>> 	h->first = e;
>> 	if (!h->last)
>> 		h->last = e;
>> +
>> +	return 0;
>> }
>>
>> void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
>> diff --git a/lib/ext2fs/hashmap.h b/lib/ext2fs/hashmap.h
>> index dcfa7455..0c09d2bd 100644
>> --- a/lib/ext2fs/hashmap.h
>> +++ b/lib/ext2fs/hashmap.h
>> @@ -27,8 +27,8 @@ struct ext2fs_hashmap_entry {
>> struct ext2fs_hashmap *ext2fs_hashmap_create(
>> 				uint32_t(*hash_fct)(const void*, size_t),
>> 				void(*free_fct)(void*), size_t size);
>> -void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
>> -			size_t key_len);
>> +int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
>> +		       void *data, const void *key,size_t key_len);
>> void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
>> 			    size_t key_len);
>> void *ext2fs_hashmap_iter_in_order(struct ext2fs_hashmap *h,
>> -- 
> Best regards,
> Artem Blagodarenko
>
>
> .

