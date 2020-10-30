Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50252A0C83
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 18:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgJ3RaL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 13:30:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48735 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgJ3RaJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Oct 2020 13:30:09 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kYYE3-0002cB-Iz
        for linux-ext4@vger.kernel.org; Fri, 30 Oct 2020 17:30:07 +0000
Received: by mail-wm1-f71.google.com with SMTP id 22so1494921wmo.3
        for <linux-ext4@vger.kernel.org>; Fri, 30 Oct 2020 10:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh1lq+DBgT0C7O2EzV0yELJUBanEwe8OT79vVbP/7Jo=;
        b=qQgXNVtCfAzuYJs/0uSaZ1HgPTb5KeRBqPwpV6J0/eoSIZtoDDsrPc9a7powdsepi3
         vOwFVvvhSuwqtRJho1DeXV9d+aGfFsQAlwFLxbjXibP4KfTMy4xpwGMoSleQArdkByDY
         VFNEIwN5o7UpKz6CUmfouIgpNohhjtAFeLDJwioQMQAm0SDQYMP57ASOfeeEtan8JDn2
         1PPduZXaE8Gln6MfZgn9tlNHfwz7v8Ekx9UIqORCUa9CWhM7Y8rWtX2yOT9wvvmK9bwZ
         w1RLKKQDT6ONkMvofpk5VhT5zdbNLP85QqXanGdB3Khh/sbns4nYLQSfT+qULCJvod4q
         v+LA==
X-Gm-Message-State: AOAM530igMYyNhfsnjZ0VDLUxDdvTkpC0knMsXUYtjlEvrC8ypqxouoN
        Vtto2sY8vXfzA6bUThm/+R+tW4ZwfC9h8ZOsxy1MPCKyKnZ4JhDHhEI+6Vara1W1CKSzh3r9ESD
        uA1YSy+kpFxgNNi+r74IJj4wEmr7m09TvTeQDvE+leiYey2Ap8NNb0Rg=
X-Received: by 2002:a7b:c387:: with SMTP id s7mr3841608wmj.52.1604079007094;
        Fri, 30 Oct 2020 10:30:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3H/ezC4j3flacfEbeloGGEYcrTNSfXyX/e1T2LIFgE9aSVaOi/tYrstkvCQwzbmwGgRR4qSoXZ8XJ6eQX/Y4=
X-Received: by 2002:a7b:c387:: with SMTP id s7mr3841586wmj.52.1604079006803;
 Fri, 30 Oct 2020 10:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201030114737.GC3251003@mwanda>
In-Reply-To: <20201030114737.GC3251003@mwanda>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Fri, 30 Oct 2020 14:29:55 -0300
Message-ID: <CAO9xwp2Z8gj1Ayr3BmNEpgR6325Udc2HHPr5LJafPqYBcVLshA@mail.gmail.com>
Subject: Re: [bug report] ext4: data=journal: fixes for ext4_page_mkwrite()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Dan,

Thanks for the static checker/analysis report.

On Fri, Oct 30, 2020 at 8:47 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Mauricio Faria de Oliveira,
>
> The patch 64a9f1449950: "ext4: data=journal: fixes for
> ext4_page_mkwrite()" from Oct 5, 2020, leads to the following static
> checker warning:
>
>         fs/ext4/inode.c:6136 ext4_page_mkwrite()
>         error: uninitialized symbol 'get_block'.
>

The conditionals on ext4_should_journal_data() intentionally prevent
the uninitialized case.
Apparently that has not been considered by the checker. This is the
associated code path:

...
         // skip initialization
         if (ext4_should_journal_data(inode))
                  goto retry_alloc;
...
         // initialization
         get_block = ...
...
retry_alloc:
...
         // usage only if ! skip initialization
          if (!ext4_should_journal_data(inode)) {
                  err = block_page_mkwrite(vma, vmf, get_block);
...

If a patch to initialize it to NULL is welcome, I'd be happy to send it out.
It should fail similarly (i.e., invalid instruction memory access for
the get_block function pointer)
_if_ a future patch misses and compromises the conditionals, but
should silence the checker.

cheers,
Mauricio

> fs/ext4/inode.c
>   6040  vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>   6041  {
>   6042          struct vm_area_struct *vma = vmf->vma;
>   6043          struct page *page = vmf->page;
>   6044          loff_t size;
>   6045          unsigned long len;
>   6046          int err;
>   6047          vm_fault_t ret;
>   6048          struct file *file = vma->vm_file;
>   6049          struct inode *inode = file_inode(file);
>   6050          struct address_space *mapping = inode->i_mapping;
>   6051          handle_t *handle;
>   6052          get_block_t *get_block;
>                 ^^^^^^^^^^^^^^^^^^^^^^
>
>   6053          int retries = 0;
>   6054
>   6055          if (unlikely(IS_IMMUTABLE(inode)))
>   6056                  return VM_FAULT_SIGBUS;
>   6057
>   6058          sb_start_pagefault(inode->i_sb);
>   6059          file_update_time(vma->vm_file);
>   6060
>   6061          down_read(&EXT4_I(inode)->i_mmap_sem);
>   6062
>   6063          err = ext4_convert_inline_data(inode);
>   6064          if (err)
>   6065                  goto out_ret;
>   6066
>   6067          /*
>   6068           * On data journalling we skip straight to the transaction handle:
>   6069           * there's no delalloc; page truncated will be checked later; the
>   6070           * early return w/ all buffers mapped (calculates size/len) can't
>   6071           * be used; and there's no dioread_nolock, so only ext4_get_block.
>   6072           */
>   6073          if (ext4_should_journal_data(inode))
>   6074                  goto retry_alloc;
>                         ^^^^^^^^^^^^^^^^
> This goto is new.
>
>   6075
>   6076          /* Delalloc case is easy... */
>   6077          if (test_opt(inode->i_sb, DELALLOC) &&
>   6078              !ext4_nonda_switch(inode->i_sb)) {
>   6079                  do {
>   6080                          err = block_page_mkwrite(vma, vmf,
>   6081                                                     ext4_da_get_block_prep);
>   6082                  } while (err == -ENOSPC &&
>   6083                         ext4_should_retry_alloc(inode->i_sb, &retries));
>   6084                  goto out_ret;
>   6085          }
>   6086
>   6087          lock_page(page);
>   6088          size = i_size_read(inode);
>   6089          /* Page got truncated from under us? */
>   6090          if (page->mapping != mapping || page_offset(page) > size) {
>   6091                  unlock_page(page);
>   6092                  ret = VM_FAULT_NOPAGE;
>   6093                  goto out;
>   6094          }
>   6095
>   6096          if (page->index == size >> PAGE_SHIFT)
>   6097                  len = size & ~PAGE_MASK;
>   6098          else
>   6099                  len = PAGE_SIZE;
>   6100          /*
>   6101           * Return if we have all the buffers mapped. This avoids the need to do
>   6102           * journal_start/journal_stop which can block and take a long time
>   6103           *
>   6104           * This cannot be done for data journalling, as we have to add the
>   6105           * inode to the transaction's list to writeprotect pages on commit.
>   6106           */
>   6107          if (page_has_buffers(page)) {
>   6108                  if (!ext4_walk_page_buffers(NULL, page_buffers(page),
>   6109                                              0, len, NULL,
>   6110                                              ext4_bh_unmapped)) {
>   6111                          /* Wait so that we don't change page under IO */
>   6112                          wait_for_stable_page(page);
>   6113                          ret = VM_FAULT_LOCKED;
>   6114                          goto out;
>   6115                  }
>   6116          }
>   6117          unlock_page(page);
>   6118          /* OK, we need to fill the hole... */
>   6119          if (ext4_should_dioread_nolock(inode))
>   6120                  get_block = ext4_get_block_unwritten;
>   6121          else
>   6122                  get_block = ext4_get_block;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Initialized here.
>
>   6123  retry_alloc:
>   6124          handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
>   6125                                      ext4_writepage_trans_blocks(inode));
>   6126          if (IS_ERR(handle)) {
>   6127                  ret = VM_FAULT_SIGBUS;
>   6128                  goto out;
>   6129          }
>   6130          /*
>   6131           * Data journalling can't use block_page_mkwrite() because it
>   6132           * will set_buffer_dirty() before do_journal_get_write_access()
>   6133           * thus might hit warning messages for dirty metadata buffers.
>   6134           */
>   6135          if (!ext4_should_journal_data(inode)) {
>   6136                  err = block_page_mkwrite(vma, vmf, get_block);
>                                                            ^^^^^^^^^
> Smatch warning here.
>
>   6137          } else {
>   6138                  lock_page(page);
>   6139                  size = i_size_read(inode);
>   6140                  /* Page got truncated from under us? */
>   6141                  if (page->mapping != mapping || page_offset(page) > size) {
>   6142                          ret = VM_FAULT_NOPAGE;
>   6143                          goto out_error;
>
> regards,
> dan carpenter



-- 
Mauricio Faria de Oliveira
