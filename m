Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200DD2A04A9
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJ3Lrs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 07:47:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3Lrs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Oct 2020 07:47:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBkNxu069602;
        Fri, 30 Oct 2020 11:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=OBnNKN12ZuSW4asIHWaUGYpXDoEnArO+3hI590rTBEE=;
 b=dXqD0cl7D1SlsK2k6Wtu4zQUf9wZt4IftetF1cGN9AjpB3OAO/PGcMEsPadt1QfzV8hx
 FoxX2AzI+bqYHRFZ+Moa/0KLOBHc4u95BXgh1lSNX4+lkgNe1J1Vre5LpDUMiJiPR9eu
 wYXBEGll5rejebUpwnCDMWTiD18lq7wvDlAebBSLtY0wusQs7KWJ5011nSUl2FCNm86c
 o9CRSBPBi6O8NzXr5VdhvPX02XPr5hXAYgf+LoY9QTR28t9DriWrMbxqjnLPXzcbCMe/
 T2PR+o7O0K3LybMZSRbMIBfrRz0uqG0nphI4UYx1E7B0ho8wwpXod9DtkRO7ctEFEZph cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7m9a5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 11:47:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBiYmt176130;
        Fri, 30 Oct 2020 11:47:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34cwuqvsmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 11:47:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UBlh0D022927;
        Fri, 30 Oct 2020 11:47:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 04:47:42 -0700
Date:   Fri, 30 Oct 2020 14:47:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mfo@canonical.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: data=journal: fixes for ext4_page_mkwrite()
Message-ID: <20201030114737.GC3251003@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300091
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Mauricio Faria de Oliveira,

The patch 64a9f1449950: "ext4: data=journal: fixes for
ext4_page_mkwrite()" from Oct 5, 2020, leads to the following static
checker warning:

	fs/ext4/inode.c:6136 ext4_page_mkwrite()
	error: uninitialized symbol 'get_block'.

fs/ext4/inode.c
  6040  vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
  6041  {
  6042          struct vm_area_struct *vma = vmf->vma;
  6043          struct page *page = vmf->page;
  6044          loff_t size;
  6045          unsigned long len;
  6046          int err;
  6047          vm_fault_t ret;
  6048          struct file *file = vma->vm_file;
  6049          struct inode *inode = file_inode(file);
  6050          struct address_space *mapping = inode->i_mapping;
  6051          handle_t *handle;
  6052          get_block_t *get_block;
                ^^^^^^^^^^^^^^^^^^^^^^

  6053          int retries = 0;
  6054  
  6055          if (unlikely(IS_IMMUTABLE(inode)))
  6056                  return VM_FAULT_SIGBUS;
  6057  
  6058          sb_start_pagefault(inode->i_sb);
  6059          file_update_time(vma->vm_file);
  6060  
  6061          down_read(&EXT4_I(inode)->i_mmap_sem);
  6062  
  6063          err = ext4_convert_inline_data(inode);
  6064          if (err)
  6065                  goto out_ret;
  6066  
  6067          /*
  6068           * On data journalling we skip straight to the transaction handle:
  6069           * there's no delalloc; page truncated will be checked later; the
  6070           * early return w/ all buffers mapped (calculates size/len) can't
  6071           * be used; and there's no dioread_nolock, so only ext4_get_block.
  6072           */
  6073          if (ext4_should_journal_data(inode))
  6074                  goto retry_alloc;
                        ^^^^^^^^^^^^^^^^
This goto is new.

  6075  
  6076          /* Delalloc case is easy... */
  6077          if (test_opt(inode->i_sb, DELALLOC) &&
  6078              !ext4_nonda_switch(inode->i_sb)) {
  6079                  do {
  6080                          err = block_page_mkwrite(vma, vmf,
  6081                                                     ext4_da_get_block_prep);
  6082                  } while (err == -ENOSPC &&
  6083                         ext4_should_retry_alloc(inode->i_sb, &retries));
  6084                  goto out_ret;
  6085          }
  6086  
  6087          lock_page(page);
  6088          size = i_size_read(inode);
  6089          /* Page got truncated from under us? */
  6090          if (page->mapping != mapping || page_offset(page) > size) {
  6091                  unlock_page(page);
  6092                  ret = VM_FAULT_NOPAGE;
  6093                  goto out;
  6094          }
  6095  
  6096          if (page->index == size >> PAGE_SHIFT)
  6097                  len = size & ~PAGE_MASK;
  6098          else
  6099                  len = PAGE_SIZE;
  6100          /*
  6101           * Return if we have all the buffers mapped. This avoids the need to do
  6102           * journal_start/journal_stop which can block and take a long time
  6103           *
  6104           * This cannot be done for data journalling, as we have to add the
  6105           * inode to the transaction's list to writeprotect pages on commit.
  6106           */
  6107          if (page_has_buffers(page)) {
  6108                  if (!ext4_walk_page_buffers(NULL, page_buffers(page),
  6109                                              0, len, NULL,
  6110                                              ext4_bh_unmapped)) {
  6111                          /* Wait so that we don't change page under IO */
  6112                          wait_for_stable_page(page);
  6113                          ret = VM_FAULT_LOCKED;
  6114                          goto out;
  6115                  }
  6116          }
  6117          unlock_page(page);
  6118          /* OK, we need to fill the hole... */
  6119          if (ext4_should_dioread_nolock(inode))
  6120                  get_block = ext4_get_block_unwritten;
  6121          else
  6122                  get_block = ext4_get_block;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
Initialized here.

  6123  retry_alloc:
  6124          handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
  6125                                      ext4_writepage_trans_blocks(inode));
  6126          if (IS_ERR(handle)) {
  6127                  ret = VM_FAULT_SIGBUS;
  6128                  goto out;
  6129          }
  6130          /*
  6131           * Data journalling can't use block_page_mkwrite() because it
  6132           * will set_buffer_dirty() before do_journal_get_write_access()
  6133           * thus might hit warning messages for dirty metadata buffers.
  6134           */
  6135          if (!ext4_should_journal_data(inode)) {
  6136                  err = block_page_mkwrite(vma, vmf, get_block);
                                                           ^^^^^^^^^
Smatch warning here.

  6137          } else {
  6138                  lock_page(page);
  6139                  size = i_size_read(inode);
  6140                  /* Page got truncated from under us? */
  6141                  if (page->mapping != mapping || page_offset(page) > size) {
  6142                          ret = VM_FAULT_NOPAGE;
  6143                          goto out_error;

regards,
dan carpenter
