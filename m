Return-Path: <linux-ext4+bounces-4013-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EF969F3F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6BF2840B8
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88B62A1BF;
	Tue,  3 Sep 2024 13:40:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DEB2868D
	for <linux-ext4@vger.kernel.org>; Tue,  3 Sep 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370803; cv=none; b=VcveM2rNfVLjT1jf66eqcNGuigIrRjYOa+By/HJDH7pT6LdVgKzLl89gEobJiU8llRLjAPGvcLMJeO5Za1cU3oB2ruQIiAJAQpE+VVtloR24xFNApkHMQrShtE80/fxMyN5fMnW2oqtxDkqMCGZRcsokUB5lC5ooDnUrjJ0hymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370803; c=relaxed/simple;
	bh=yKVCrz6ZYq8NotRhXo5qCdBqbYIFLNUJF4q8pkBbCT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OJDr1P9vWb/1r4pOnX5mLCnzMYbwBQ+LPB1FBgtcXWruB2CCCA4r5jlXi7mJyax05yVGCOtbOjKk6z+gR0coBfcuglTa/m+K0XW6ZVZyQjbHHzvVoDmC7qyU5JyFPjXqL7Yn8rwDLyuxV7LLexWihiLmr+ejpIfkoRt0zO3/jpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wymqg5gTxz1HJCH;
	Tue,  3 Sep 2024 21:36:31 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FA86140136;
	Tue,  3 Sep 2024 21:39:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 21:39:57 +0800
Message-ID: <7480a81b-4b95-45cc-bf4e-da34ff148790@huawei.com>
Date: Tue, 3 Sep 2024 21:39:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: Remove redundant null pointer check
To: Theodore Ts'o <tytso@mit.edu>
CC: Li Zetao <lizetao1@huawei.com>, <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>, Yang Erkun
	<yangerkun@huawei.com>
References: <20240820013250.4121848-1-lizetao1@huawei.com>
 <628a0278-6809-4d2e-94f3-14a882bfa34b@huawei.com>
 <20240903125022.GF424729@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240903125022.GF424729@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100021.china.huawei.com (7.185.36.148)

Hi Theodore,

Unfortunately it is possible that the regression was introduced
precisely by the mishandling of conflicts here.

On 2024/9/3 20:50, Theodore Ts'o wrote:
> On Tue, Sep 03, 2024 at 03:52:01PM +0800, Baokun Li wrote:
>> Thanks for the cleanup patch.
>>
>> But the change is already included in the patch:
>>
>>   https://lore.kernel.org/all/20240710040654.1714672-21-libaokun@huaweicloud.com/
> Yeah, I noticed.  I had already applied Zetao's patch when I processed
> yours, so I just ended up manually handling the patch conflict.
>
> (I haven't set out the patch acks yet, because the current state of
> the ext4/dev branch is apparently causing a test regression which I'm
> trying to root cause.  They will be in tomorrow's fs-next and
> linux-next branch, though unless I end up figuring out the problematic
> patch or patch series, and end up dropping them from the ext4 dev
> branch today.  Still, feel free to take a look and let me know if I
> screwed up anything.)
>
> 						- Ted
>

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=92bbb922166cd7a829bf60d168372ffa1c54e81d

The changes after resolving the conflict in ext4_ext_clear_bb() are
as follows:

---------------------------------------------------------------------------

@@ -6128,12 +6122,9 @@ int ext4_ext_clear_bb(struct inode *inode)
         if (IS_ERR(path))
                 return PTR_ERR(path);
         ex = path[path->p_depth].p_ext;
-       if (!ex) {
-               ext4_free_ext_path(path);
-               return 0;
-       }
+       if (!ex)
+               goto out;
         end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-       ext4_free_ext_path(path);

         cur = 0;
         while (cur < end) {
@@ -6146,7 +6137,6 @@ int ext4_ext_clear_bb(struct inode *inode)
                         path = ext4_find_extent(inode, map.m_lblk, 
NULL, 0);
                         if (!IS_ERR(path)) {
                                 for (j = 0; j < path->p_depth; j++) {
-
ext4_mb_mark_bb(inode->i_sb,
path[j].p_block, 1, false);
ext4_fc_record_regions(inode->i_sb, inode->i_ino,
@@ -6161,5 +6151,7 @@ int ext4_ext_clear_bb(struct inode *inode)
                 cur = cur + map.m_len;
         }

+out:
+       ext4_free_ext_path(path);
         return 0;
  }

---------------------------------------------------------------------------

This can cause path leaks and path double free.

----------------------------------------

     path_A = ext4_find_extent
     while (cur < end) {
             path_B = ext4_find_extent(inode, map.m_lblk, NULL, 0);
             // path_A leak
             ext4_free_ext_path(path_B);
     }
out:
     ext4_free_ext_path(path_B); // path_B double free

----------------------------------------

I think it's best to drop Zetao's patch
   b2e662cb86ca ("ext4: remove redundant null pointer check")
and then reapply the conflicting patch
  92bbb922166c ("ext4: make some fast commit functions reuse extents path")

Or apply the following modifications to conflicting patch in the tree:

---------------------------------------------------------------------------

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 789316f22f97..34e25eee6521 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6132,7 +6132,7 @@ int ext4_ext_clear_bb(struct inode *inode)
                 if (ret < 0)
                         break;
                 if (ret > 0) {
-                       path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
+                       path = ext4_find_extent(inode, map.m_lblk, path, 0);
                         if (!IS_ERR(path)) {
                                 for (j = 0; j < path->p_depth; j++) {
ext4_mb_mark_bb(inode->i_sb,
@@ -6140,7 +6140,8 @@ int ext4_ext_clear_bb(struct inode *inode)
ext4_fc_record_regions(inode->i_sb, inode->i_ino,
                                                         0, 
path[j].p_block, 1, 1);
                                 }
-                               ext4_free_ext_path(path);
+                       } else {
+                               path = NULL;
                         }
                         ext4_mb_mark_bb(inode->i_sb, map.m_pblk, 
map.m_len, false);
                         ext4_fc_record_regions(inode->i_sb, inode->i_ino,

---------------------------------------------------------------------------


Cheers,
Baokun


