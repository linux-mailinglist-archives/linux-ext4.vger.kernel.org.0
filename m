Return-Path: <linux-ext4+bounces-12136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F7C9DFA5
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 07:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A773A794C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD66295DA6;
	Wed,  3 Dec 2025 06:52:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E478405C;
	Wed,  3 Dec 2025 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764744767; cv=none; b=Z+snxK2SoYrAmfqI+v8raJxUyOBoNpL1uphG/3EV3JztgBrtSlSIiTvzCkVn0XAYvSvsClP8fej9+qphc3tuXRRYXpDPvYk7apaL6QY4RudxMm84jziRb8k1NA7315gnazhSYa5pS4/9K9tdkTKTn5eBqP+v9K6QR55XFsobfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764744767; c=relaxed/simple;
	bh=Es44BlhA7k285FYYcrk7WddI3P7/vxs3ZfuUy1LGZCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcyOALE4YRZdjNp/PHWi0gk4rgJ/6tngSMg9WVTZIXL5BsdYtlAC937kXNAVeZ56wzi7qYWnXBLTy/F6LceSaaB2x3WxZLn1BhHzmhIc1VHwe3PvnR0FmTWz7cHVnesEFmBC/Iw66iw94PNLhmWjjNIe+FIiFmsYNimC/LwLebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dLpH50mg0zYQtk9;
	Wed,  3 Dec 2025 14:52:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 145A11A13DD;
	Wed,  3 Dec 2025 14:52:36 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgB3WFIy3i9pHVO5AQ--.52136S3;
	Wed, 03 Dec 2025 14:52:35 +0800 (CST)
Message-ID: <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
Date: Wed, 3 Dec 2025 14:52:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, djwong@kernel.org
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3WFIy3i9pHVO5AQ--.52136S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrW8uFy3Zr4Uuw1kGry5CFg_yoWxJw4xpF
	W5CFyqy3yqyrn8twsa9wnavr10k3sIqr45GF13Gw12yasrAF18KF47taykuF47Kr15JF4F
	qF48Ja47X3WjvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/3/2025 9:37 AM, Deepanshu Kartikey wrote:
> On Tue, Dec 2, 2025 at 5:54 PM Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> Hi Deepanshu!
>>
>> On 11/30/2025 10:06 AM, Deepanshu Kartikey wrote:
>>> On Sat, Nov 22, 2025 at 7:27 AM Deepanshu Kartikey
>>> <kartikey406@gmail.com> wrote:
>>>>
>>>> When delayed block allocation fails due to filesystem corruption,
>>>> ext4's writeback error handling invalidates affected folios by calling
>>>> mpage_release_unused_pages() with invalidate=true, which explicitly
>>>> clears the uptodate flag:
>>>>
>>>>     static void mpage_release_unused_pages(..., bool invalidate)
>>>>     {
>>>>         ...
>>>>         if (invalidate) {
>>>>             block_invalidate_folio(folio, 0, folio_size(folio));
>>>>             folio_clear_uptodate(folio);
>>>>         }
>>>>     }
>>>>
>>>> If ext4_page_mkwrite() is subsequently called on such a non-uptodate
>>>> folio, it can proceed to mark the folio dirty without checking its
>>>> state. This triggers a warning in __folio_mark_dirty():
>>>>
>>>>     WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
>>>>     __folio_mark_dirty+0x578/0x880
>>>>
>>>>     Call Trace:
>>>>      fault_dirty_shared_page+0x16e/0x2d0
>>>>      do_wp_page+0x38b/0xd20
>>>>      handle_pte_fault+0x1da/0x450
>>>>      __handle_mm_fault+0x652/0x13b0
>>>>      handle_mm_fault+0x22a/0x6f0
>>>>      do_user_addr_fault+0x200/0x8a0
>>>>      exc_page_fault+0x81/0x1b0
>>>>
>>>> This scenario occurs when:
>>>> 1. A write with delayed allocation marks a folio dirty (uptodate=1)
>>>> 2. Writeback attempts block allocation but detects filesystem corruption
>>>> 3. Error handling calls mpage_release_unused_pages(invalidate=true),
>>>>    which clears the uptodate flag via folio_clear_uptodate()
>>>> 4. A subsequent ftruncate() triggers ext4_truncate()
>>>> 5. ext4_block_truncate_page() attempts to zero the page tail
>>>> 6. This triggers a write fault on the mmap'd page
>>>> 7. ext4_page_mkwrite() is called with the non-uptodate folio
>>>> 8. Without checking uptodate, it proceeds to mark the folio dirty
>>>> 9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate())
>>
>> Thank you a lot for analyzing this issue and the fix patch. As I was
>> going through the process of understanding this issue, I had one
>> question. Is the code flow that triggers the warning as follows?
>>
>> wp_page_shared()
>>   do_page_mkwrite()
>>     ext4_page_mkwrite()
>>       block_page_mkwrite()   //The default delalloc path
>>         block_commit_write()
>>           mark_buffer_dirty()
>>             __folio_mark_dirty(0)  //'warn' is false, doesn't trigger warning
>>         folio_mark_dirty()
>>           ext4_dirty_folio()
>>             block_dirty_folio  //newly_dirty is false, doesn't call __folio_mark_dirty()
>>   fault_dirty_shared_page()
>>     folio_mark_dirty()  //Trigger warning ?
>>
>> This folio has been marked as dirty. How was this warning triggered?
>> Am I missing something?
>>
>> Thanks,
>> Yi.
>>
> 
> Hi Yi,
> 
> Thank you for your question about the exact flow that triggers the warning.
> 

Thank you for the clarification, but there are still some details that
are unclear.

> You're correct that the code paths within ext4_page_mkwrite() and
> block_page_mkwrite() call __folio_mark_dirty() with warn=0, so no
> warning occurs there. The warning actually triggers later, in
> fault_dirty_shared_page() after page_mkwrite returns.
> 
> Here's the complete flow:
> 
>   wp_page_shared()
>     ↓
>     do_page_mkwrite()
>       ↓
>       ext4_page_mkwrite()
>         ↓
>         block_page_mkwrite()
>           ↓
>           mark_buffer_dirty() → __folio_mark_dirty(warn=0)  // No warning

             ↓
             if (!folio_test_set_dirty(folio))
                        //The folio will be mark as dirty --- 1

>         ↓
>         Returns success
>     ↓
>     fault_dirty_shared_page(vma, folio)  ← Warning triggers here
>       ↓
>       folio_mark_dirty(folio)
>         ↓
>         ext4_dirty_folio()
>           ↓
>           block_dirty_folio()
>             ↓
>             if (!folio_test_set_dirty(folio))  // Folio not already dirty

              This makes me confused, this folio should be set to dirty
              at position 1. If it is not dirty here, who cleared the dirty
              flag for this folio?

>               __folio_mark_dirty(folio, mapping, 1)  ← warn=1, triggers WARNING
> 
> The key is that the folio can become non-uptodate between when it's
> initially read and when wp_page_shared() is called. This happens when:
> 
> 1. Delayed block allocation fails due to filesystem corruption
> 2. Error handling in mpage_release_unused_pages() explicitly clears uptodate:
> 
>      if (invalidate) {
>          block_invalidate_folio(folio, 0, folio_size(folio));
>          folio_clear_uptodate(folio);
>      }
> 
> 3. A subsequent operation (like ftruncate) triggers ext4_block_truncate_page()
> 4. This causes a write fault on the mmap'd page
> 5. wp_page_shared() is called with the now-non-uptodate folio
> 
> From my debug logs with a test kernel:
> 
>   [22.387777] EXT4-fs error: lblock 0 mapped to illegal pblock 0
>   [22.389798] EXT4-fs: Delayed block allocation failed... error 117
>   [22.390401] EXT4-fs: This should not happen!! Data will be lost
> 
>   [22.399463] EXT4-fs error: Corrupt filesystem
> 
>   [22.400513] WP_PAGE_SHARED: ENTER folio=... uptodate=0 dirty=0
>   [22.401953] WP_PAGE_SHARED: page_mkwrite failed, returning 2
> 
> With my fix, ext4_page_mkwrite() detects the non-uptodate state and
> returns VM_FAULT_SIGBUS before block_page_mkwrite() is called,
> preventing wp_page_shared() from reaching fault_dirty_shared_page().
> 
> Without the fix, the sequence would be:
> - ext4_page_mkwrite() succeeds (doesn't check uptodate)
> - block_page_mkwrite() marks buffers dirty (warn=0, no warning)
> - Returns to wp_page_shared()
> - fault_dirty_shared_page() calls folio_mark_dirty()
> - block_dirty_folio() finds folio not dirty (uptodate=0, dirty=0)
> - Calls __folio_mark_dirty() with warn=1
> - WARNING triggers: WARN_ON_ONCE(warn && !folio_test_uptodate(folio)
> && !folio_test_dirty(folio))
> 
> The syzbot call trace confirms this:
> 
>   Call Trace:
>    fault_dirty_shared_page+0x16e/0x2d0
>    do_wp_page+0x38b/0xd20
>    handle_pte_fault+0x1da/0x450
> 
> Does this clarify the flow?
> 
> Best regards,
> Deepanshu
> 


