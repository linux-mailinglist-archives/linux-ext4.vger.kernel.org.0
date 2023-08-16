Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66B277EC44
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 23:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbjHPVw4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjHPVwa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 17:52:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED31FD0;
        Wed, 16 Aug 2023 14:52:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 349951F85D;
        Wed, 16 Aug 2023 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692222748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xguN9t/SjGklflT204Mw1GXNW/IQjQio3dunDAplZj8=;
        b=ZiQ7Z6NL0p77OBXg9zwcN6MqB8WITOcEpmxoGvcz+XPOPjlO5r+d9nXkDGbv27wdToWpfJ
        XlUJZOdv8HJDXrYGR5F7oCLubRVE0gbVZIHpsRx4DYzxEmppNUadDDEqQ25t1UcSijtQVn
        P09S5ack4BnFiogGQxb/6WOfeAyq/B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692222748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xguN9t/SjGklflT204Mw1GXNW/IQjQio3dunDAplZj8=;
        b=3NUHQFPdO27jxtzU8l/4mH6EyCNvgX65ozUOYFaY/XViL90DiILT3rISTsYKFmSxJaMd/A
        k3vOfSo10Zbyr5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 250F21353E;
        Wed, 16 Aug 2023 21:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XoH/CBxF3WTgRwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 21:52:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2B62A0769; Wed, 16 Aug 2023 23:52:27 +0200 (CEST)
Date:   Wed, 16 Aug 2023 23:52:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Re: Tasks stuck jbd2 for a long time
Message-ID: <20230816215227.jlvmqasfbc73asi4@quack3>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-08-23 11:32:47, Bhatnagar, Rishabh wrote:
> On 8/16/23 7:53 AM, Jan Kara wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > On Tue 15-08-23 20:57:14, Bhatnagar, Rishabh wrote:
> > > On 8/15/23 7:28 PM, Theodore Ts'o wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > It would be helpful if you can translate address in the stack trace to
> > > > line numbers.  See [1] and the script in
> > > > ./scripts/decode_stacktrace.sh in the kernel sources.  (It is
> > > > referenced in the web page at [1].)
> > > > 
> > > > [1] https://docs.kernel.org/admin-guide/bug-hunting.html
> > > > 
> > > > Of course, in order to interpret the line numbers, we'll need a
> > > > pointer to the git repo of your kernel sources and the git commit ID
> > > > you were using that presumably corresponds to 5.10.184-175.731.amzn2.x86_64.
> > > > 
> > > > The stack trace for which I am particularly interested is the one for
> > > > the jbd2/md0-8 task, e.g.:
> > > Thanks for checking Ted.
> > > 
> > > We don't have fast_commit feature enabled. So it should correspond to this
> > > line:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/jbd2/commit.c?h=linux-5.10.y#n496
> > > 
> > > > >         Not tainted 5.10.184-175.731.amzn2.x86_64 #1
> > > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2
> > > > > flags:0x00004080
> > > > > Call Trace:
> > > > > __schedule+0x1f9/0x660
> > > > >    schedule+0x46/0xb0
> > > > >    jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]  <--------- line #?
> > > > >    ? update_load_avg+0x7a/0x5d0
> > > > >    ? add_wait_queue_exclusive+0x70/0x70
> > > > >    ? lock_timer_base+0x61/0x80
> > > > >    ? kjournald2+0xcf/0x360 [jbd2]
> > > > >    kjournald2+0xcf/0x360 [jbd2]
> > > > Most of the other stack traces you refenced are tasks that are waiting
> > > > for the transaction commit to complete so they can proceed with some
> > > > file system operation.  The stack traces which have
> > > > start_this_handle() in them are examples of this going on.  Stack
> > > > traces of tasks that do *not* have start_this_handle() would be
> > > > specially interesting.
> > > I see all other stacks apart from kjournald have "start_this_handle".
> > That would be strange. Can you post full output of "echo w
> > > /proc/sysrq-trigger" to dmesg, ideally passed through scripts/faddr2line as
> > Ted suggests. Thanks!
> 
> Sure i'll try to collect that. The system freezes when such a situation
> happens and i'm not able
> to collect much information. I'll try to crash the kernel and collect kdump
> and see if i can get that info.

Thanks!

> Can low available memory be a reason for a thread to not be able to close
> the transaction handle for a long time?
> Maybe some writeback thread starts the handle but is not able to complete
> writeback?

Well, even that would be a bug but low memory conditions are certainly some
of less tested paths so it is possible there's a bug lurking there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
