Return-Path: <linux-ext4+bounces-11014-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130DBF9C33
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 04:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C9352BB4
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 02:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF78248C;
	Wed, 22 Oct 2025 02:47:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40E322A
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101221; cv=none; b=N1/iInUaxYkWBFUutP0JWmqSjVuJ6mgNVPp1m5yQnTQVhX81tRScqIIQxRADaCFIKJ9zWEKE8DxMZ+F0+2iMdAPi9AQakf3mV2f13iPYPU7l3cmeMI8fhb+9eIZa225YOxAgx9Esd+CD/6yBk9YLq4GsH1mTmaw250TdIJtuQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101221; c=relaxed/simple;
	bh=GP1nVig9LWtwebP6knyzw2UQkHl2V6KhWOqNdzBLK+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prBGNGpXJRf8ZW3pSt4FNnXAZw59chB1MuNYrQdk6woW2ZIRSQyjuWxht/m8trJDZr2bFY5W662j8SQYLWfzTCaxdotuAUZCJ6LBSz+JdabLQt2dMDdRzZ9MbENuYUJM9pbWyYayEMeO0Becx54rz+L3Tb94EBkB67xJjwg97jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4crtns73cTzYQtmG
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 10:45:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9C6C91A168D
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 10:46:47 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBXrESVRfhoiRrABA--.7417S3;
	Wed, 22 Oct 2025 10:46:47 +0800 (CST)
Message-ID: <0fec500c-52ea-473d-b276-826c0f4dd76f@huaweicloud.com>
Date: Wed, 22 Oct 2025 10:46:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org
References: <ebe38d8f-0b09-47b8-9503-2d8e0585672a@huaweicloud.com>
 <20251020084736.591739-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251020084736.591739-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXrESVRfhoiRrABA--.7417S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1DCr1Dtr4kWrWkJw1kKrg_yoWrArW7pF
	W3Gw4ayFWfXrn7try7Ca1kur4Iyws8G3yUGFy0qr1UAwn8CFySvF4kKay5Ary3Kr48Ar4v
	qr4jgr98ZF4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

[add mm list to CC]

On 10/20/2025 4:47 PM, Karol Wachowski wrote:
> Hi,
> 
> I can reproduce this on Intel's x86 (Meteor Lake and Lunar Lake Intel CPUs
> but I believe it's not platform dependent). It reproduces on stable.
> I have bisected this to the mentioned commit: 7ac67301e82f02b77a5c8e7377a1f414ef108b84
> and it reproduces every time if that commit is present. I have attached a patch at the
> end of this message that provides a very simple driver that creates character device
> which calls pin_user_pages_fast() on user provided user pointer and simple test application
> that creates 2 MB file on a filesystem (you have to ensure it's location is on ext4) and
> does IOCTL with pointer obtained through mmap of that file with specific flags to reproduce
> the issue.
> 
> When it reproduces user application hangs indefinitely and has to be interrupted.
> 
> I have also noticed that if we don't write to the file prior to mmap or the write size is less than
> 2 MB issue does not reproduce.
> 
> Patch with reproductor is attached at the end of this message, please let me know if that helps or
> if there's anything else I can provide to help to determine if it's a real issue.
> 
> -
> Karol
> 
Thank you for the reproducer. I can reproduce this issue on my x86 virtual
machine. After debugging and analyzing, I found that this is not a
filesystem issue, we can reproduce it on any filesystem that supports
large folios, such as XFS. However, anyway, IIUC, I think it's a real
issue.

The root cause of this issue is that calling pin_user_pages_fast() triggers
an infinite loop in __get_user_pages() when a PMD-sized(2MB on x86) and COW
mmaped large folio is passed to pin. To trigger this issue on x86, the
following conditions must be met. The specific triggering process is as
follows:

1. Call mmap with a 2MB size in MAP_PRIVATE mode for a file that has a 2MB
   folio installed in the page cache.

   addr = mmap(NULL, 2 * 1024 * 1024, PROT_READ, MAP_PRIVATE, file_fd, 0);
2. The kernel driver pass this mapped address to pin_user_pages_fast() in
   FOLL_LONGTERM mode.

   pin_user_pages_fast(addr, nr_pages, FOLL_LONGTERM, pages);

  ->  pin_user_pages_fast()
  |   gup_fast_fallback()
  |    __gup_longterm_locked()
  |     __get_user_pages_locked()
  |      __get_user_pages()
  |       follow_page_mask()
  |        follow_p4d_mask()
  |         follow_pud_mask()
  |          follow_pmd_mask() //pmd_leaf(pmdval) is true since it's pmd
  |                            //installed, This is normal in the first
  |                            //round, but it shouldn't happen in the
  |                            //second round.
  |           follow_huge_pmd() //gup_must_unshare() is always true
  |            return -EMLINK
  |   faultin_page()
  |    handle_mm_fault()
  |     wp_huge_pmd() //split pmd and fault back to PTE
  |     handle_pte_fault()  //
  |      do_pte_missing()
  |       do_fault()
  |        do_read_fault() //FAULT_FLAG_WRITE is not set
  |         finish_fault()
  |          do_set_pmd() //install leaf pmd again, I think this is wrong!!!
  |      do_wp_page() //copy private anno pages
  <-    goto retry

Due to an incorrectly large PMD set in do_read_fault(), follow_pmd_mask()
always returns -EMLINK, causing an infinite loop. Under normal
circumstances, I suppose it should fall back to do_wp_page(), which installs
the anonymous page into the PTE. This is also why mappings smaller than 2MB
do not trigger this issue. In addition, if you add FOLL_WRITE when calling
pin_user_pages_fast(), it also will not trigger this issue becasue do_fault()
will call do_cow_fault() to create anonymous pages.

The above is my analysis, and I tried the following fix, which can solve
the issue (I haven't done a full test yet). But I am not expert in the MM
field, I might have missed something, and this needs to be reviewed by MM
experts.

Best regards,
Yi.

diff --git a/mm/memory.c b/mm/memory.c
index 74b45e258323..64846a030a5b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5342,6 +5342,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;

+	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE) &&
+	    !pmd_write(*vmf->pmd))
+		return ret;
+
 	if (folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 	page = &folio->page;




