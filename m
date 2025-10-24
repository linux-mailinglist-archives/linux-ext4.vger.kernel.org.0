Return-Path: <linux-ext4+bounces-11043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238EC058FB
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4C734E7BFC
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1630F939;
	Fri, 24 Oct 2025 10:24:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229230F81B;
	Fri, 24 Oct 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301473; cv=none; b=nusA3iBUpNwfVuiYboPeqUolTPbLpRh9dER3suZVQqH9jOn1RJMVHya5sbddVwr0BAc/vNMQTl7A+j4eaDVCGwQ7zeWp7mPthiUl6sTEeuNjKlrCiBSeau1u26HGiLlWc/P98+aqV1AF//ex+MjEDrzM5M+jaY8VEVHkDoRlNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301473; c=relaxed/simple;
	bh=4aXgPaoneg7kOwVyEUmk0Cfpvw3kNsYUH7QYV3d1Qow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GD+baMx5wSvAaicY7aoJW8S1FH1mfTxN957dYi2bvwwRBX1J7Q84/Z2IHK6jGe5bMpfrtKe18IfAMz14uqgmqB82Pyef0BEBB0o+HXOnPt73W3ndSnE1kyh7PNU5y7qQIBRFGxges4DooxzrN7Myqy3RRf3jDV3wN87SjPfK3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctJs4195KzKHMfM;
	Fri, 24 Oct 2025 18:23:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CB02A1A0D93;
	Fri, 24 Oct 2025 18:24:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with SMTP id cCh0CgBHbVDSU_toXgS2BQ--.15501S4;
	Fri, 24 Oct 2025 18:24:25 +0800 (CST)
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
Subject: [PATCH v2] mm: do not install PMD mappings when handling a COW fault
Date: Fri, 24 Oct 2025 18:22:37 +0800
Message-ID: <20251024102237.3332200-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHbVDSU_toXgS2BQ--.15501S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1fWw4fCFykCw13Zr13Jwb_yoW5Ww48pa
	yxGa1YkFWfWrn2yF1fuw4vkr45ZwsxGay8WFyxGryj9F15Gr1Y939Yga13A3yUGr18JFWr
	Xr45Kryq9F4q937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUU
	UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When pinning a page with FOLL_LONGTERM in a CoW VMA and a PMD-aligned
(2MB on x86) large folio follow_page_mask() failed to obtain a valid
anonymous page, resulting in an infinite loop issue. The specific
triggering process is as follows:

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
Acked-by: David Hildenbrand <david@redhat.com>
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


