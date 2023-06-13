Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859172D941
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjFMFcW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 01:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjFMFb7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 01:31:59 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A51711
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 22:30:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9e5c011cfso5956321cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686634222; x=1689226222;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNjW5QXHksOvUW8JnWDub7KJ4E5HMj8BbaQmIyxgfrw=;
        b=r/YZLBVLwurP/fJAkMZqoflOpSObZIL8jKFmZWtqXbShyZ8JzC6U78OMf9km8YLwft
         sz10OVQnxgc5xhWBbOsTFAJysmN9u3oaITdir6KlSagXPA1cJciOhXQeq2b+nFcR06E8
         nCZiXxD5/Mdshgjo2PUAsFnDfCKZ2rTArk/3SgtKWQ53gI+3De5i/55tbZLlvXx5sRR7
         6xbFZT47w9BjD5muXjyW+6P4LGFBcNX0zAHqeZJGPK/qYqSHzXRrlAlPgMs2ViaN7GeM
         S0hwgpIFrt0orxrL1XxlrSzwRxNLWJnrmb5yfKqnhB6pqZBSSFi5E/fjZH+grBpzxVl7
         aOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686634222; x=1689226222;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNjW5QXHksOvUW8JnWDub7KJ4E5HMj8BbaQmIyxgfrw=;
        b=V6GNvRhtQ+xh36CY174igIrrKFiovLj2hXmE6L6VW019BXn1ulwSnYq6z9VR7IXPCt
         2eJ30+xazoWYJQEIgaM1RqvWLzv+LtvJAEiI337cDg78jNPQimLHLeM8p9/2cl3CdBlq
         6kBU25ggBbZh6t+FvA5GCdQA8BwvlGPP8pe71jAe169jR/JYfMNdJeQJELFuOV018bRm
         A2vGAfJdFmr6P7KELoL7f8Wm+ETVgEVX0xQ3G3I05XeTfUc+Namc00e7LjeKwzHJ5Wyo
         lv/w8tlrrFkzP4mZTDwvDOZ/3WmKlhzf3gAPKqyMSVrH3n2UbHHAKI9cwW2hohGcN9vE
         0yvQ==
X-Gm-Message-State: AC+VfDzJknOO2SAiv7uVPiV0pF9lL8JBAZcnuL4RZFum248BnZNFCNX4
        k1CWIzl91M/CVjrWt1nTT+7FLt3CcMM=
X-Google-Smtp-Source: ACHHUZ4Xies0FPgeC7HwdC4SRr5KoEYohVBvlaJuhYPaIMEv69J0o5w1nzVvJJNThDuqDoDq2aeW2w==
X-Received: by 2002:a05:622a:1a25:b0:3f5:c9f:1b27 with SMTP id f37-20020a05622a1a2500b003f50c9f1b27mr15306377qtb.1.1686634222574;
        Mon, 12 Jun 2023 22:30:22 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id h13-20020a65518d000000b0053f5ff753e2sm7752483pgq.23.2023.06.12.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 22:30:21 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:00:19 +0530
Message-Id: <87wn0853pw.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
In-Reply-To: <20230612053731.585947-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> wiring up a dummy direct_IO method to indicate support for direct I/O.
>
> Do that for ext4 so that noop_direct_IO can eventually be removed.

Looks straight forward change to me. 

However I got some query...

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 02de439bf1f04e..b9c1cfa1864779 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3573,7 +3571,6 @@ static const struct address_space_operations ext4_da_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.direct_IO		= noop_direct_IO,
>  	.migrate_folio		= buffer_migrate_folio,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> @@ -3582,7 +3579,6 @@ static const struct address_space_operations ext4_da_aops = {
>  
>  static const struct address_space_operations ext4_dax_aops = {
>  	.writepages		= ext4_dax_writepages,
> -	.direct_IO		= noop_direct_IO,
>  	.dirty_folio		= noop_dirty_folio,
>  	.bmap			= ext4_bmap,
>  	.swap_activate		= ext4_iomap_swap_activate,

why do we require .direct_IO function op for any of the dax_aops?
IIUC, any inode if it supports DAX i.e. IS_DAX(inode), then it takes the
separate path in file read/write iter path.

so it should never do ->direct_IO on an inode which supports DAX right?

Maybe I am missing something and I will have to check when does
->direct_IO gets called for DAX... 
   ... Or is it due to CONFIG_FS_DAX?

e.g. 

ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
{
	struct inode *inode = file_inode(iocb->ki_filp);

	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
		return -EIO;

#ifdef CONFIG_FS_DAX
	if (IS_DAX(inode))
		return ext4_dax_write_iter(iocb, from);
#endif
	if (iocb->ki_flags & IOCB_DIRECT)
		return ext4_dio_write_iter(iocb, from);
	else
		return ext4_buffered_write_iter(iocb, from);
}

-ritesh
