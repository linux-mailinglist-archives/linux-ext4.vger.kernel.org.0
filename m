Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44206412D5
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Dec 2022 01:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiLCAyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 19:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiLCAyT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 19:54:19 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1289A4E5
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 16:53:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so5713392pgh.4
        for <linux-ext4@vger.kernel.org>; Fri, 02 Dec 2022 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4gE22UEJMKiRLenIWOFZNJhaaD3BRTTXiaPb8E6e3M=;
        b=Sxj2Ry0hT1/GjLp/66GVQlB3dHL3YjShTaXrFB75CTQzyAu08FxSdrCvg7osZUt0WO
         H+j2sLam+Y0Al3TpRtupOmwXL65ihABRmGANBeD3zpHjVFSTGAhaCtufDznGQ/Z9Jyd9
         lyaVoET0oiAsNLlcR7ptWjNuSjmZj9Jv2vcud+Dg+EGkVqc3b7MQPPay7qSSMYRzgc3y
         qR7RpKNXFcmGATLceRDYYuNIh7LIARK10QrbCTBEkxd8desxX8ib51hWFo/IHYW3//7F
         luC+RoS+nxUIHbxdjTvP3s75zZuPUpA0iec0FeRrRf0TavxDARPXT+SzTbLGt6rqmwNj
         NjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4gE22UEJMKiRLenIWOFZNJhaaD3BRTTXiaPb8E6e3M=;
        b=0ZlUKFgCXBwxFu/M+dSR55U38ro/1/PqpKMKc6cZfSm7qMBxCKmFPTu96LZ94cydEE
         Lmtum8OxZj08oEy1FcEhYNa7K/ekmZ3hfmL69J0w6wkEdMpGCTbXxN6Rb/BZycBy8PGj
         IATbXvX336eO8cQDqan+fGyqeZ/UP30zvRYgNB92VtOH6fXPk+Sh3lAqPnuTgT9tUdLK
         LLLqjmp7r1H65nWkb9loP8jWwxg5Y0y8BpqKL1gsHnRDZFeCjfXJQ31yX94zYjbXrHni
         JCB2QElpfiKjPh1VGGF4rsSi/NWWOW/8Oq4RcHJYmUr3zY9GlK7ocJLMZES15Hlj2JWb
         v0Nw==
X-Gm-Message-State: ANoB5pleSNMhOP/jx7QP8uZbx4PlA7exKHgTQOKKwn6duX6Jgg9HVtsW
        Oezb3f4OtREmMFhy/DaMpxrhDrdr6Qo=
X-Google-Smtp-Source: AA0mqf4LIPl2KJI6Z83/KEuRUMo6f6FWwOg4CFTQmdw+GwccrEQpbaRlorUw+JvkSj1DZP5pwHwjOw==
X-Received: by 2002:aa7:9388:0:b0:56d:4c7e:777a with SMTP id t8-20020aa79388000000b0056d4c7e777amr76668197pfe.0.1670028782914;
        Fri, 02 Dec 2022 16:53:02 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709026f1700b00189667acf19sm6099593plk.95.2022.12.02.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:53:02 -0800 (PST)
Date:   Sat, 3 Dec 2022 06:22:56 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/11] ext4: Stop using ext4_writepage() for writeout
 of ordered data
Message-ID: <20221203005256.cqrvojj47blasal7@riteshh-domain>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/02 07:39PM, Jan Kara wrote:
> Hello,
>
> this patch series modifies ext4 so that we stop using ext4_writepage() for
> writeout of ordered data during transaction commit (through
> generic_writepages() from jbd2_journal_submit_inode_data_buffers()). Instead we
> directly call ext4_writepages() from the
> ext4_journal_submit_inode_data_buffers(). This is part of Christoph's effort
> to get rid of the .writepage() callback in all filesystems.
>
> I have also modified ext4_writepages() to use write_cache_pages() instead of
> generic_writepages() so now we don't expose .writepage hook at all. We still
> keep ext4_writepage() as a callback for write_cache_pages(). We should refactor
> that path as well and get rid of ext4_writepage() completely but that is for a
> separate cleanup. Also note that jbd2 still uses generic_writepages() in its
> jbd2_journal_submit_inode_data_buffers() helper because it is still used from
> OCFS2. Again, something to be dealt with in a separate patchset.
>
> Changes since v1:
> * Added Reviewed-by tags from Ritesh
> * Added patch to get rid of generic_writepages() in ext4_writepages()
> * Added patch to get rid of .writepage hook

Oh! And what about the WARN_ON_ONCE in ext4_writepages() while loop, which we
were discussing here [1]. Do you think that will help in catching anything nasty?

[1]: https://lore.kernel.org/linux-ext4/20221201115500.kbxtteft3v4pzqqx@quack3/T/#mcf7b6cc301062e52a3600194b03a9fd872ba52c5


One thing I guess I missed in my previous review is the fast commit path.
In my overnight testing of previous patch series I observed this warning.

WARNING: CPU: 1 PID: 1746936 at fs/ext4/inode.c:1994 ext4_writepage+0x4e6/0x5e0
RIP: 0010:ext4_writepage+0x4e6/0x5e0
Call Trace:
 <TASK>
 __writepage+0x17/0x70
 write_cache_pages+0x166/0x3c0
 ? dirty_background_bytes_handler+0x30/0x30
 ? finish_task_switch.isra.0+0x8e/0x260
 ? _raw_spin_lock_irqsave+0x19/0x50
 ? finish_wait+0x34/0x70
 ? _raw_spin_unlock_irqrestore+0x1e/0x40
 generic_writepages+0x4f/0x80
 jbd2_journal_submit_inode_data_buffers+0x64/0x90
 ext4_fc_commit+0x2e0/0x830
 ? file_check_and_advance_wb_err+0x2e/0xd0
 ? preempt_count_add+0x70/0xa0
 ext4_sync_file+0x15c/0x380
 __do_sys_msync+0x1c1/0x2a0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

-ritesh


>
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20221130162435.2324-1-jack@suse.cz # v1
