Return-Path: <linux-ext4+bounces-11029-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C33C04107
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 03:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377B53A530B
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A411E7C08;
	Fri, 24 Oct 2025 01:56:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B531E491B;
	Fri, 24 Oct 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271017; cv=none; b=ksW9C/MbWIz9Rky6Llilr8ACWfYiPu9cwv7RNX+dJofjJuLwSeP5mImuwC/IcPeTphmjoM/BMzb0HpI5NT92JUi0AbxwOjAxKQceqSFExHgc1JliVNMdbmk/S9k2/EI8+ELnxIQZcj1iWb0kIaMWTanASwCld3LP5UmCxrB2WkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271017; c=relaxed/simple;
	bh=5+GhXpuV+HJFKbBvpav/TMm2j/QINaAEaSuYNWAAZO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvdkfD7FnWe3XFKGDurLhQqoW4K3eEHTM/geMwCVKIT9CXaolBjCDwvR4907deEuMR89WA3ypWTw4qp4+tsIPdBmvhSg+z5snuuVdW/TuAv8a16PJIJcOWbzNHhFXs7hEkBggjg8ZL45WUuRqhsMQ+/R5I3dZ5QOFtT1nR0dcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ct5bN3jVszKHLyD;
	Fri, 24 Oct 2025 09:56:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A31BE1A0ADA;
	Fri, 24 Oct 2025 09:56:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXX3PposwChBQ--.8162S4;
	Fri, 24 Oct 2025 09:56:48 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	karol.wachowski@linux.intel.com,
	wangkefeng.wang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] mm: do not install PMD mappings when handling a COW fault
Date: Fri, 24 Oct 2025 09:54:59 +0800
Message-ID: <20251024015459.2824162-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXX3PposwChBQ--.8162S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xury3AFyDZw4DJF4rGrg_yoW5WF4xpa
	yxGa1ayFWfWrn2y3Wxuw4vkr45ZwsxGayUWFyxGryjyF15Gr1Y939Yga13A34UGr4UJFWr
	Xr45Kr909FWq937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUL0edUUU
	UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

During the ping of user pages in FOLL_LONGTERM on a COW VMA and a
PMD-aligned (2MB on x86) large folio, follow_page_mask() failed to
obtain a valid anonymous page, resulting in an infinite loop issue.
The specific triggering process is as follows:

1. User call mmap with a 2MB size in MAP_PRIVATE mode for a file that
   has a 2MB large folio installed in the page cache.

   addr = mmap(NULL, 2*1024*1024, PROT_READ, MAP_PRIVATE, file_fd, 0);

2. The kernel driver pass this mapped address to pin_user_pages_fast()
   in FOLL_LONGTERM mode.

   pin_user_pages_fast(addr, 512, FOLL_LONGTERM, pages);

  ->  pin_user_pages_fast()
  |   gup_fast_fallback()
  |    __gup_longterm_locked()
  |     __get_user_pages_locked()
  |      __get_user_pages()
  |       follow_page_mask()
  |        follow_p4d_mask()
  |         follow_pud_mask()
  |          follow_pmd_mask() //pmd_leaf(pmdval) is true because the
  |                            //huge PMD is installed. This is normal
  |                            //in the first round, but it shouldn't
  |                            //happen in the second round.
  |           follow_huge_pmd() //require an anonymous page
  |            return -EMLINK;
  |   faultin_page()
  |    handle_mm_fault()
  |     wp_huge_pmd() //remove PMD and fall back to PTE
  |     handle_pte_fault()
  |      do_pte_missing()
  |       do_fault()
  |        do_read_fault() //FAULT_FLAG_WRITE is not set
  |         finish_fault()
  |          do_set_pmd() //install a huge PMD again, this is wrong!!!
  |      do_wp_page() //create private anonymous pages
  <-    goto retry;

Due to an incorrectly large PMD set in do_read_fault(),
follow_pmd_mask() always returns -EMLINK, causing an infinite loop.

David pointed out that we can preallocate a page table and remap the PMD
to be mapped by a PTE table in wp_huge_pmd() in the future. But now we
can avoid this issue by not installing PMD mappings when handling a COW
and unshare fault in do_set_pmd().

Fixes: a7f226604170 ("mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page")
Reported-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Closes: https://lore.kernel.org/linux-ext4/844e5cd4-462e-4b88-b3b5-816465a3b7e3@linux.intel.com/
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..0748a31367df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5212,6 +5212,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;
 
+	/* We're about to trigger CoW, so never map it through a PMD. */
+	if (is_cow_mapping(vma->vm_flags) &&
+	    (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)))
+		return ret;
+
 	if (folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 	page = &folio->page;
-- 
2.46.1


