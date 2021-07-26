Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2363D5A4A
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZMpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jul 2021 08:45:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36708 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhGZMpp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jul 2021 08:45:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 555A421E80;
        Mon, 26 Jul 2021 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627305973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kODNh6wJbystY4coRRF1+jlG6qUQ4/vyfiU72RMVW0M=;
        b=iXPJCWhTAtlv3EX+SVtZKU7aUI4YPDNlMS6F1QlXn97go9C0SW2HF8cYULzRCcBgBjN8Sw
        Srkxf9Bx6XbgPTkaUCu6rfkwPAkcYQ6nfusaJ4fKS8wYF1rVfmsfI1QMZsTOkLU/klFydW
        Fym+CWpmU+PS9QwSXeKTFF0elF34rOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627305973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kODNh6wJbystY4coRRF1+jlG6qUQ4/vyfiU72RMVW0M=;
        b=32gtVRdMjVKyVkYn3fJAvIOcbIx3av0ATEjTlxDZd5ONhD8C/vThO4z1GmsaJHbGBAgQQX
        wnZb2SHS8lRKMaAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 45460A3B81;
        Mon, 26 Jul 2021 13:26:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 23AF91E3B13; Mon, 26 Jul 2021 15:26:13 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:26:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, jack@suse.cz,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
Message-ID: <20210726132613.GC20621@quack2.suse.cz>
References: <YPsUZX+PF5HASRkK@mit.edu>
 <b83ee217-3dbb-62b8-237f-db8ca663fef5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83ee217-3dbb-62b8-237f-db8ca663fef5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-07-21 15:13:34, yangerkun wrote:
> 
> 
> 在 2021/7/24 3:11, Theodore Ts'o 写道:
> > On Fri, Jul 23, 2021 at 09:11:08PM +0800, yangerkun wrote:
> > > 
> > > For example, before wo goto failed_mount_wq, we may meet some error and will
> > > goto ext4_handle_error which can call
> > > schedule_work(&EXT4_SB(sb)->s_error_work). So the work may start concurrent
> > > with ext4_fill_super goto failed_mount_wq. There does not have any lock to
> > > protect the concurrent read and modifies for sbi->s_journal.
> > 
> > Yes, and I'm asking *how* is this actually happening in practice?
> > I've been going through the code paths and I don't see any place where
> > ext4_error*() would be called.  That's why I wanted to see your test
> > case which was reproducing it.  (Not just where you added the msleep,
> > but how the error was getting triggered in the first place.)
> 
> Hi Ted,
> 
> 
> The problem only happened once early with parallel ltp testcase(but we
> cannot reproduce it again with same case...). And dmesg with latter:
> 
> 
> [32031.739678] EXT4-fs error (device loop66): ext4_fill_super:4672: comm
> chdir01: inode #2: comm chdir01: iget: illegal inode #
> [32031.740193] EXT4-fs (loop66): get root inode failed
> [32031.740484] EXT4-fs (loop66): mount failed

Oh, OK. I guess s_inodes_count was <= 1 which made a check in __ext4_iget()
trip. That is theoretically possible if s_inodes_per_block == 1,
s_inodes_per_group == 1 and s_groups_count == 1. I guess ext4_fill_super()
needs to check s_inodes_count is large enough at least for all reserved
inodes to fit. But it's still unclear to me how we could have succeeded in
loading the journal which apparently has inode number 8 from the error
message below.

In parallel LTP checks I've sometimes noticed strange errors in the past
that looked very much like filesystem being modified through the block
device while being in use by the kernel (maybe some bug in the test
framework). And this is something we just don't support and the kernel can
crash in this case.

In either case I agree it makes sense to make sure error work cannot race
with journal destruction either by flushing it before destroying the
journal or some other means...

								Honza

> [32031.758811] EXT4-fs error (device loop66): ext4_map_blocks:595: inode #8:
> block 532: comm chdir01: lblock 1 mapped to illegal pblock 532 (length 1)
> [32031.759293] jbd2_journal_bmap: journal block not found at offset 1 on
> loop66-8
> [32031.759805] ------------[ cut here ]------------
> [32031.759807] kernel BUG at fs/jbd2/transaction.c:373!
> 
> 
> ext4_fill_super
>     ext4_load_journal
>         EXT4_SB(sb)->s_journal = journal
>     root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL)
>     // will failed and goto failed_mount4
>         __ext4_iget
>            __ext4_error
>                ext4_handle_error
>                   schedule_work(&EXT4_SB(sb)->s_error_work)
> 
> 
> And this trigger the concurrent read and modifies for sbi->s_journal...
> 
> Thanks,
> Kun.
> 
> 
> > 
> > 
> > On Fri, Jul 23, 2021 at 09:25:12PM +0800, yangerkun wrote:
> > > 
> > > > Can you share with me your test case?  Your patch will result in the
> > > > shrinker potentially not getting released in some error paths (which
> > > > will cause other kernel panics), and in any case, once the journal is
> > > 
> > > The only logic we have changed is that we move the flush_work before we call
> > > jbd2_journal_destory. I have not seen the problem you describe... Can you
> > > help to explain more...
> > 
> > Sorry, I was mistaken.  I thought you were moving the
> > ext4_es_unregister_shrinker() and flush_work() before the label for
> > failed_mount_wq; that was a misreading of your patch.
> > 
> > The other way we could fix this might be something like this:
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index dfa09a277b56..d663d11fa0de 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -693,7 +693,7 @@ static void flush_stashed_error_work(struct work_struct *work)
> >   {
> >   	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
> >   						s_error_work);
> > -	journal_t *journal = sbi->s_journal;
> > +	journal_t *journal = READ_ONCE(sbi->s_journal);
> >   	handle_t *handle;
> >   	/*
> > @@ -1184,9 +1184,11 @@ static void ext4_put_super(struct super_block *sb)
> >   	ext4_unregister_sysfs(sb);
> >   	if (sbi->s_journal) {
> > -		aborted = is_journal_aborted(sbi->s_journal);
> > -		err = jbd2_journal_destroy(sbi->s_journal);
> > -		sbi->s_journal = NULL;
> > +		journal_t *journal = sbi->s_journal;
> > +
> > +		WRITE_ONCE(sbi->s_journal, NULL);
> > +		aborted = is_journal_aborted(journal);
> > +		err = jbd2_journal_destroy(journal);
> >   		if ((err < 0) && !aborted) {
> >   			ext4_abort(sb, -err, "Couldn't clean up the journal");
> >   		}
> > @@ -5175,8 +5177,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >   	sbi->s_ea_block_cache = NULL;
> >   	if (sbi->s_journal) {
> > -		jbd2_journal_destroy(sbi->s_journal);
> > -		sbi->s_journal = NULL;
> > +		journal_t *journal = sbi->s_journal;
> > +
> > +		WRITE_ONCE(sbi->s_journal, NULL);
> > +		jbd2_journal_destroy(journal);
> >   	}
> >   failed_mount3a:
> >   	ext4_es_unregister_shrinker(sbi);
> > @@ -5487,7 +5491,7 @@ static int ext4_load_journal(struct super_block *sb,
> >   	EXT4_SB(sb)->s_journal = journal;
> >   	err = ext4_clear_journal_err(sb, es);
> >   	if (err) {
> > -		EXT4_SB(sb)->s_journal = NULL;
> > +		WRITE_ONCE(EXT4_SB(sb)->s_journal, NULL);
> >   		jbd2_journal_destroy(journal);
> >   		return err;
> >   	}
> > 
> > ... and here's another possible fix:
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index dfa09a277b56..e9e122e52ce8 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -704,7 +704,8 @@ static void flush_stashed_error_work(struct work_struct *work)
> >   	 * We use directly jbd2 functions here to avoid recursing back into
> >   	 * ext4 error handling code during handling of previous errors.
> >   	 */
> > -	if (!sb_rdonly(sbi->s_sb) && journal) {
> > +	if (!sb_rdonly(sbi->s_sb) && journal &&
> > +	    !(journal->j_flags & JBD2_UNMOUNT)) {
> >   		struct buffer_head *sbh = sbi->s_sbh;
> >   		handle = jbd2_journal_start(journal, 1);
> >   		if (IS_ERR(handle))
> > 
> > 
> > 
> > But I would be interested in understanding how we could be triggering
> > this problem in the first place before deciding what's the best fix.
> > 
> > Cheers,
> > 
> > 					- Ted
> > .
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
