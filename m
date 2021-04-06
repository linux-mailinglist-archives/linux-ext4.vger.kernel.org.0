Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49613553EE
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbhDFMcm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 08:32:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238115AbhDFMcm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Apr 2021 08:32:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BD67B178;
        Tue,  6 Apr 2021 12:32:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 07D541F2B77; Tue,  6 Apr 2021 14:32:33 +0200 (CEST)
Date:   Tue, 6 Apr 2021 14:32:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KCSAN: data-race in __jbd2_journal_file_buffer /
 jbd2_journal_dirty_metadata
Message-ID: <20210406123232.GD19407@quack2.suse.cz>
References: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Sun 04-04-21 17:40:44, Hao Sun wrote:
> When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> the Linux kernel, I found a data-race vulnerability in
> __jbd2_journal_file_buffer / jbd2_journal_dirty_metadata.
> Sorry, data-race is usually difficult to reproduce. I cannot provide
> you with a reproducing program.
> I hope that the call stack information in the crash log can help you
> locate the problem.
> Kernel config and full log can be found in the attachment.
> 
> Here is the detailed information:
> commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
> version:   linux 5.11
> git tree:    upstream
> report:
> ==================================================================
> BUG: KCSAN: data-race in __jbd2_journal_file_buffer /
> jbd2_journal_dirty_metadata
> write to 0xffff88800af6da38 of 8 bytes by task 4822 on cpu 1:
>  __jbd2_journal_file_buffer+0x18d/0x370 linux/fs/jbd2/transaction.c:2518
>  __jbd2_journal_refile_buffer+0x155/0x230 linux/fs/jbd2/transaction.c:2612
>  jbd2_journal_commit_transaction+0x24c6/0x3200 linux/fs/jbd2/commit.c:1084
>  kjournald2+0x253/0x470 linux/fs/jbd2/journal.c:213
>  kthread+0x1f0/0x220 linux/kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 linux/arch/x86/entry/entry_64.S:294

Thanks for report but I'm not sure what KCSAN is complaining about - isn't
the report truncated? I'm missing 'read' part of the report... The complaint
is on line:

jh->b_transaction = transaction;

I would guess the complaint is because of the check:

        /*
         * This and the following assertions are unreliable since we may see jh
         * in inconsistent state unless we grab bh_state lock. But this is
         * crucial to catch bugs so let's do a reliable check until the
         * lockless handling is fully proven.
         */
        if (jh->b_transaction != transaction &&
            jh->b_next_transaction != transaction) {

And the comment explains, why we do this unreliable check. Again, if we
wanted to silence KCSAN, we could use data_race() macro but AFAIU Ted isn't
very fond of that annotation.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
