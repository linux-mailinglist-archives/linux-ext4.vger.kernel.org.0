Return-Path: <linux-ext4+bounces-12126-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D68C9B7C7
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB630347E04
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A74311C0C;
	Tue,  2 Dec 2025 12:24:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA12FD7CA;
	Tue,  2 Dec 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678274; cv=none; b=Ipf6FB0Wj86Wj6VUz82kLrPmsqkIWFo4FXGr65ZO1pe9QfP8tAEL8MCmxMWSa6Id6cfvV8pjMt/ZFr9hH4AO3g3vaqPA0i5TM+ihuRmLy3mEk/9xT+Vc78Br8JxeR2RE/PxFDdmx167GFWwIEGYFhOUFTUaVFlB67+SdXZNZeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678274; c=relaxed/simple;
	bh=HJYJ+ydm0kaOyvt++PJiT0QXWnLnON8uTu6azt2gVKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d062yCuzDaRsihNXu1us0pGF+ie0bD1zUF7qzqYdZ6UKzVWrBNxTEWGNatYBqKS8I+t/q0xIo5/EJx42230Mkyi2laHUvclL4+gqTKiO3ftZqd1Q4PeeOyf+sBFhD+bayeNPsrgkd1f+X/RXycRQl1K7EB7rzzwF0GT4EfPR3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dLKhW0CmpzYQtkY;
	Tue,  2 Dec 2025 20:24:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA2431A07BB;
	Tue,  2 Dec 2025 20:24:28 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnSFJ52i5poHNfAQ--.27417S3;
	Tue, 02 Dec 2025 20:24:26 +0800 (CST)
Message-ID: <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
Date: Tue, 2 Dec 2025 20:24:24 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnSFJ52i5poHNfAQ--.27417S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47Ww4rJryDXr1ktr1kKrg_yoWrZFyDpF
	WYkr1qyrWqqr1DCana93Z3Zr1Fk39IgrWUGFWfKw12v3Z3ZF18KF47ta1kuF47Kr15JF4S
	qF48Ja47Xa1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi Deepanshu!

On 11/30/2025 10:06 AM, Deepanshu Kartikey wrote:
> On Sat, Nov 22, 2025 at 7:27 AM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
>>
>> When delayed block allocation fails due to filesystem corruption,
>> ext4's writeback error handling invalidates affected folios by calling
>> mpage_release_unused_pages() with invalidate=true, which explicitly
>> clears the uptodate flag:
>>
>>     static void mpage_release_unused_pages(..., bool invalidate)
>>     {
>>         ...
>>         if (invalidate) {
>>             block_invalidate_folio(folio, 0, folio_size(folio));
>>             folio_clear_uptodate(folio);
>>         }
>>     }
>>
>> If ext4_page_mkwrite() is subsequently called on such a non-uptodate
>> folio, it can proceed to mark the folio dirty without checking its
>> state. This triggers a warning in __folio_mark_dirty():
>>
>>     WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
>>     __folio_mark_dirty+0x578/0x880
>>
>>     Call Trace:
>>      fault_dirty_shared_page+0x16e/0x2d0
>>      do_wp_page+0x38b/0xd20
>>      handle_pte_fault+0x1da/0x450
>>      __handle_mm_fault+0x652/0x13b0
>>      handle_mm_fault+0x22a/0x6f0
>>      do_user_addr_fault+0x200/0x8a0
>>      exc_page_fault+0x81/0x1b0
>>
>> This scenario occurs when:
>> 1. A write with delayed allocation marks a folio dirty (uptodate=1)
>> 2. Writeback attempts block allocation but detects filesystem corruption
>> 3. Error handling calls mpage_release_unused_pages(invalidate=true),
>>    which clears the uptodate flag via folio_clear_uptodate()
>> 4. A subsequent ftruncate() triggers ext4_truncate()
>> 5. ext4_block_truncate_page() attempts to zero the page tail
>> 6. This triggers a write fault on the mmap'd page
>> 7. ext4_page_mkwrite() is called with the non-uptodate folio
>> 8. Without checking uptodate, it proceeds to mark the folio dirty
>> 9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate())

Thank you a lot for analyzing this issue and the fix patch. As I was
going through the process of understanding this issue, I had one
question. Is the code flow that triggers the warning as follows?

wp_page_shared()
  do_page_mkwrite()
    ext4_page_mkwrite()
      block_page_mkwrite()   //The default delalloc path
        block_commit_write()
          mark_buffer_dirty()
            __folio_mark_dirty(0)  //'warn' is false, doesn't trigger warning
        folio_mark_dirty()
          ext4_dirty_folio()
            block_dirty_folio  //newly_dirty is false, doesn't call __folio_mark_dirty()
  fault_dirty_shared_page()
    folio_mark_dirty()  //Trigger warning ?

This folio has been marked as dirty. How was this warning triggered?
Am I missing something?

Thanks,
Yi.

>>
>> Fix this by checking folio_test_uptodate() early in ext4_page_mkwrite()
>> and returning VM_FAULT_SIGBUS if the folio is not uptodate. This prevents
>> attempting to write to invalidated folios and properly signals the error
>> to userspace.
>>
>> The check is placed early, before the delalloc/journal/normal code paths,
>> as none of these paths should proceed with a non-uptodate folio.
>>
>> Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
>> Tested-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> ---
>>  fs/ext4/inode.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index e99306a8f47c..18a029362c1f 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -6688,6 +6688,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>>         if (err)
>>                 goto out_ret;
>>
>> +       folio_lock(folio);
>> +       if (!folio_test_uptodate(folio)) {
>> +               folio_unlock(folio);
>> +               ret = VM_FAULT_SIGBUS;
>> +               goto out;
>> +       }
>> +       folio_unlock(folio);
>> +
>>         /*
>>          * On data journalling we skip straight to the transaction handle:
>>          * there's no delalloc; page truncated will be checked later; the
>> --
>> 2.43.0
>>
> 
> Hi Ted and ext4 maintainers,
> 
> I wanted to follow up on this patch submitted a week ago. This fixes
> a syzbot-reported WARNING in __folio_mark_dirty() that occurs when
> ext4_page_mkwrite() is called with a non-uptodate folio after delayed
> allocation writeback failure.
> 
> Please let me know if there's any feedback or if I should make any
> changes.
> 
> Thanks,
> Deepanshu
> 


