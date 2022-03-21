Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C74E2A88
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 15:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbiCUOYz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349206AbiCUOQn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 10:16:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5C1868A8;
        Mon, 21 Mar 2022 07:12:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0ACA0210F0;
        Mon, 21 Mar 2022 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647871957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0VMXVuXbHrrmNPBwvV1OnYWY9yvOnyiQdZRYniD/uM=;
        b=mllgks2eQDEmcJqTBtxPtI6gKLlVLYzQ+vt52jmc6H2wZd3M15BQsMdoLIpSRqgFM2iOLR
        Ymd8f/JYgr7sEhvxpytNL+yeoS+O8vybrOKa6ONIdiFBcZZyhwjS3SfYWpgohB4+Zxe96+
        jzaxgNAvYst/jdyGOA+R+t9drz+KxPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647871957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0VMXVuXbHrrmNPBwvV1OnYWY9yvOnyiQdZRYniD/uM=;
        b=rY88uTr7N8iFZ90/njJx760skU2LgDHqzR+NJRYJgzlJvOiAC+bgm/7jT70JHezpH1kBTK
        As6TxfCI7n5v0RCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E87EEA3B81;
        Mon, 21 Mar 2022 14:12:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9AFBFA0610; Mon, 21 Mar 2022 15:12:36 +0100 (CET)
Date:   Mon, 21 Mar 2022 15:12:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: Fix symlink file size not match to file
 content
Message-ID: <20220321141236.7rmbh77ntsmpc2m6@quack3.lan>
References: <20220321113408.4112428-1-yebin10@huawei.com>
 <20220321113703.cibgeac5ipslg3df@quack3.lan>
 <62387F05.2090408@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62387F05.2090408@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-03-22 21:35:01, yebin wrote:
> 
> 
> On 2022/3/21 19:37, Jan Kara wrote:
> > On Mon 21-03-22 19:34:08, Ye Bin wrote:
> > > We got issue as follows:
> > > [home]# fsck.ext4  -fn  ram0yb
> > > e2fsck 1.45.6 (20-Mar-2020)
> > > Pass 1: Checking inodes, blocks, and sizes
> > > Pass 2: Checking directory structure
> > > Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
> > > Clear? no
> > > Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
> > > Fix? no
> > > 
> > > As symlink file size not match to file content. If symlink data block
> > > writback failed, will call ext4_finish_bio to end io. In this path don't
> > > mark buffer error. When umount do checkpoint can't detect buffer error,
> > > then will cleanup jounral. Actually, correct data maybe in journal area.
> > > To solve this issue, mark buffer error when detect bio error in
> > > ext4_finish_bio.
> > Thanks for the patch! Let me rephrase the text a bit:
> > 
> > As the symlink file size does not match the file content. If the writeback
> > of the symlink data block failed, ext4_finish_bio() handles the end of IO.
> > However this function fails to mark the buffer with BH_write_io_error and
> > so when unmount does journal checkpoint it cannot detect the writeback
> > error and will cleanup the journal. Thus we've lost the correct data in the
> > journal area. To solve this issue, mark the buffer as BH_write_io_error in
> > ext4_finish_bio().
> > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/ext4/page-io.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > > index 495ce59fb4ad..14695e2b5042 100644
> > > --- a/fs/ext4/page-io.c
> > > +++ b/fs/ext4/page-io.c
> > > @@ -134,8 +134,10 @@ static void ext4_finish_bio(struct bio *bio)
> > >   				continue;
> > >   			}
> > >   			clear_buffer_async_write(bh);
> > > -			if (bio->bi_status)
> > > +			if (bio->bi_status) {
> > > +				set_buffer_write_io_error(bh);
> > Why don't you use mark_buffer_write_io_error()? It will also update other IO
> > error counters properly so that e.g. fsync(2) or sync_filesystem() can properly
> > report IO error etc. Granted we'll abort the journal in response to
> > checkpointing error so the failure will be hard to miss anyway but still
> > :).
> > 
> > 								Honza
> 
> 'ext4_finish_bio' already call 'mapping_set_error' set mapping error , I think fsync
> and sync_filesystem can report IO error.
> 
> static inline void mapping_set_error(struct address_space *mapping, int error)
> {
>         if (likely(!error))
>                 return;
> 
>         /* Record in wb_err for checkers using errseq_t based tracking */
>         __filemap_set_wb_err(mapping, error);
> 
>         /* Record it in superblock */
>         if (mapping->host)
>                 errseq_set(&mapping->host->i_sb->s_wb_err, error);
> 
>         /* Record it in flags for now, for legacy callers */
>         if (error == -ENOSPC)
>                 set_bit(AS_ENOSPC, &mapping->flags);
>         else
>                 set_bit(AS_EIO, &mapping->flags);
> }

Good, I've missed that. OK, then feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
