Return-Path: <linux-ext4+bounces-2086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51A8A4768
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 06:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9891F1F2178A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 04:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F81CFA9;
	Mon, 15 Apr 2024 04:28:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FC17BA4;
	Mon, 15 Apr 2024 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713155289; cv=none; b=RLNk3xe4W9BZ75Qj4u0tp6GB4QuC+GeVJWBM/2ZEQWIIBzMg3P6XkWr2Ju84GasBFdHQCURICzBGzLByBnE4ENTtnootnh3EkRemj8F6RyVC2sVzrxuG8f49ZIinQFLL9HubKwF78+CrP92I+Chq6hk4EacYLfUJ5+YrK96DFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713155289; c=relaxed/simple;
	bh=KaN4a9k/RTRQOYd4NZco6wMeCGL0RqyiZGSEBK/2IRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J+/Th1DZBVrhAH66fZz8QIa1buGDYn2VUgFVU+JVs1VuFJWzrOGpJnRaTEmQqpXSBN0jwDz1PEeEHxTgfmX5D21dRbAX60eCY2XdYejXE+Oox1WbF0Ssu9NBoT2Lmpxmmo6qFWYiomlHbO+1C+u0VfR5CH+p3QP6ElURdSFgEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VHvGV41xgz1hwTx;
	Mon, 15 Apr 2024 12:25:06 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D751A0172;
	Mon, 15 Apr 2024 12:28:02 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 12:28:01 +0800
Message-ID: <49d5b109-7cc3-6717-b3c6-6858310aa3ba@huawei.com>
Date: Mon, 15 Apr 2024 12:28:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Theodore
 Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<jun.nie@linaro.org>, <ebiggers@kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu> <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
 <ZH33ZzwyLFY48tfA@casper.infradead.org>
 <20230605150855.7oaiplp7r57dcww3@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230605150855.7oaiplp7r57dcww3@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/6/5 23:08, Jan Kara wrote:
> On Mon 05-06-23 15:55:35, Matthew Wilcox wrote:
>> On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
>>> On Mon 05-06-23 11:16:55, Jan Kara wrote:
>>>> Yeah, I agree, that is also the conclusion I have arrived at when thinking
>>>> about this problem now. We should be able to just remove the conversion
>>>> from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
>>>> growing i_size.
>>> OK, thinking more about this and searching through the history, I've
>>> realized why the conversion is originally in ext4_page_mkwrite(). The
>>> problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
>>> when writing to memory map") but essentially it boils down to the fact that
>>> ext4 writeback code does not expect dirty page for a file with inline data
>>> because ext4_write_inline_data_end() should have copied the data into the
>>> inode and cleared the folio's dirty flag.
>>>
>>> Indeed messing with xattrs from the writeback path to copy page contents
>>> into inline data xattr would be ... interesting. Hum, out of good ideas for
>>> now :-|.
>> Is it so bad?  Now that we don't have writepage in ext4, only
>> writepages, it seems like we have a considerably more benign locking
>> environment to work in.
> Well, yes, without ->writepage() it might be *possible*. But still rather
> ugly. The problem is that in ->writepages() i_size is not stable. Thus also
> whether the inode data is inline or not is not stable. We'd need inode_lock
> for that but that is not easily doable in the writeback path - inode lock
> would then become fs_reclaim unsafe...
>
> 								Honza
Hi Honza!
Hi Ted!
Hi Matthew!

Long time later came back to this, because while discussing another similar
ABBA problem with Hou Tao, he mentioned VM_FAULT_RETRY, and then I
thought that this could be used to solve this problem as well.

The general idea is that if we see a file with inline data in 
ext4_page_mkwrite(),
we release the mmap_lock and grab the inode_lock to convert the inline data,
and then return VM_FAULT_RETRY to retry to get the mmap_lock.

The code implementation is as follows, do you have any thoughts?

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..e044c11c9cf6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6056,15 +6056,36 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
      if (unlikely(IS_IMMUTABLE(inode)))
          return VM_FAULT_SIGBUS;

+    /*
+     * The ext4 writeback code does not expect dirty page for a file with
+     * inline data, so inline data needs to be converted. But it needs to
+     * hold the inode_lock when converting, and trying to lock the inode
+     * while holding the mmap_lock may result in an ABBA deadlock. So here
+     * we release the mmap_lock for conversion and retry after conversion.
+     * Only one retry is allowed to avoid endless loops.
+     * Acquire xattr_sem to avoid race with inline data conversion.
+     */
+    down_read(&EXT4_I(inode)->xattr_sem);
+    if (ext4_has_inline_data(inode)) {
+        up_read(&EXT4_I(inode)->xattr_sem);
+
+        if (!fault_flag_allow_retry_first(vmf->flags))
+            return VM_FAULT_SIGBUS;
+
+        release_fault_lock(vmf);
+
+        inode_lock(inode);
+        ext4_convert_inline_data(inode);
+        inode_unlock(inode);
+        return VM_FAULT_RETRY;
+    }
+    up_read(&EXT4_I(inode)->xattr_sem);
+
      sb_start_pagefault(inode->i_sb);
      file_update_time(vma->vm_file);

      filemap_invalidate_lock_shared(mapping);

-    err = ext4_convert_inline_data(inode);
-    if (err)
-        goto out_ret;
-
      /*
       * On data journalling we skip straight to the transaction handle:
       * there's no delalloc; page truncated will be checked later; the

-- 
With Best Regards,
Baokun Li
.

