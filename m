Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24512AD57A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 12:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKJLmF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 06:42:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:48560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJLmE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Nov 2020 06:42:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22F39ABD1;
        Tue, 10 Nov 2020 11:42:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB3531E130B; Tue, 10 Nov 2020 12:42:02 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:42:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
Message-ID: <20201110114202.GF20780@quack2.suse.cz>
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Mon 09-11-20 15:11:58, Chris Friesen wrote:
> I'm running a 3.10.0-1127.rt56.1093 CentOS kernel.  I realize you don't
> support this particular kernel but I'm hoping for some general pointers.
> 
> I've got a system with four "housekeeping" CPUs, with rcu_nocbs and
> hohz_full used to reduce system overhead on the "application" CPUs, with
> four CPUs set as "isolcpus" to try and isolate them even further.  I have a
> crashdump vmcore file from a softdog expiry when the process that pets the
> softdog hung trying to write to /dev/log after the unix socket backlog had
> been reached.
> 
> I can see a "jbd2/nvme2n1p4-" process that appears to be hung for over 9
> minutes waiting to commit a transaction.  /dev/nvme2n1p4 corresponds to the
> root filesystem.  The "ps" and "bt" output from the crashdump are below.
> syslog-ng is also blocked waiting on filesystem access, and there are other
> tasks also blocked on disk, including a few jbd2 tasks that are associated
> with device mapper.

Yeah, 9 minutes seems far too long.

> Can anyone give some suggestions on how to track down what's causing the
> delay here?  I suspect there's a race condition somewhere similar to what
> happened with https://access.redhat.com/solutions/3226391, although that one
> was specific to device-mapper and the root filesystem here is directly on
> the nvme device.

Sadly I don't have access to RH portal to be able to check what that hang
was about...

> crash> ps -m 930
> [0 00:09:11.694] [UN]  PID: 930    TASK: ffffa14b5f9032c0  CPU: 1 COMMAND:
> "jbd2/nvme2n1p4-"
> 

Are the tasks below the only ones hanging in D state (UN state in crash)?
Because I can see processes are waiting for the locked buffer but it is
unclear who is holding the buffer lock...

> crash> bt 930
> PID: 930    TASK: ffffa14b5f9032c0  CPU: 1   COMMAND: "jbd2/nvme2n1p4-"
>  #0 [ffffa14b5ff0ba20] __schedule at ffffffffafe1b959
>  #1 [ffffa14b5ff0bab0] schedule at ffffffffafe1be80
>  #2 [ffffa14b5ff0bac8] schedule_timeout at ffffffffafe19d4c
>  #3 [ffffa14b5ff0bb70] io_schedule_timeout at ffffffffafe1ab6d
>  #4 [ffffa14b5ff0bba0] io_schedule at ffffffffafe1ac08
>  #5 [ffffa14b5ff0bbb0] bit_wait_io at ffffffffafe1a561
>  #6 [ffffa14b5ff0bbc8] __wait_on_bit at ffffffffafe1a087
>  #7 [ffffa14b5ff0bc08] out_of_line_wait_on_bit at ffffffffafe1a1f1
>  #8 [ffffa14b5ff0bc80] __wait_on_buffer at ffffffffaf85068a
>  #9 [ffffa14b5ff0bc90] jbd2_journal_commit_transaction at ffffffffc0e543fc
> [jbd2]
> #10 [ffffa14b5ff0be48] kjournald2 at ffffffffc0e5a6ad [jbd2]
> #11 [ffffa14b5ff0bec8] kthread at ffffffffaf6ad781
> #12 [ffffa14b5ff0bf50] ret_from_fork_nospec_begin at ffffffffafe1fe5d
> 
> Possibly of interest, syslog-ng is also blocked waiting on filesystem
> access:
> 
> crash> bt 1912
> PID: 1912   TASK: ffffa14b62dc2610  CPU: 1   COMMAND: "syslog-ng"
>  #0 [ffffa14b635b7980] __schedule at ffffffffafe1b959
>  #1 [ffffa14b635b7a10] schedule at ffffffffafe1be80
>  #2 [ffffa14b635b7a28] schedule_timeout at ffffffffafe19d4c
>  #3 [ffffa14b635b7ad0] io_schedule_timeout at ffffffffafe1ab6d
>  #4 [ffffa14b635b7b00] io_schedule at ffffffffafe1ac08
>  #5 [ffffa14b635b7b10] bit_wait_io at ffffffffafe1a561
>  #6 [ffffa14b635b7b28] __wait_on_bit at ffffffffafe1a087
>  #7 [ffffa14b635b7b68] out_of_line_wait_on_bit at ffffffffafe1a1f1
>  #8 [ffffa14b635b7be0] do_get_write_access at ffffffffc0e51e94 [jbd2]
>  #9 [ffffa14b635b7c80] jbd2_journal_get_write_access at ffffffffc0e521b7
> [jbd2]
> #10 [ffffa14b635b7ca0] __ext4_journal_get_write_access at ffffffffc0eb8e31
> [ext4]
> #11 [ffffa14b635b7cd0] ext4_reserve_inode_write at ffffffffc0e87fa0 [ext4]
> #12 [ffffa14b635b7d00] ext4_mark_inode_dirty at ffffffffc0e8801e [ext4]
> #13 [ffffa14b635b7d58] ext4_dirty_inode at ffffffffc0e8bc40 [ext4]
> #14 [ffffa14b635b7d78] __mark_inode_dirty at ffffffffaf84855d
> #15 [ffffa14b635b7da8] ext4_setattr at ffffffffc0e8b558 [ext4]
> #16 [ffffa14b635b7e18] notify_change at ffffffffaf8363fc
> #17 [ffffa14b635b7e60] chown_common at ffffffffaf8128ac
> #18 [ffffa14b635b7f08] sys_fchown at ffffffffaf813fb7
> #19 [ffffa14b635b7f50] tracesys at ffffffffafe202a8 (via system_call)
> 
> One of the hung jbd2 tasks associated with device mapper:
> 
> crash> bt 1489
> PID: 1489   TASK: ffffa14b641f0000  CPU: 1   COMMAND: "jbd2/dm-0-8"
>  #0 [ffffa14b5fab7a20] __schedule at ffffffffafe1b959
>  #1 [ffffa14b5fab7ab0] schedule at ffffffffafe1be80
>  #2 [ffffa14b5fab7ac8] schedule_timeout at ffffffffafe19d4c
>  #3 [ffffa14b5fab7b70] io_schedule_timeout at ffffffffafe1ab6d
>  #4 [ffffa14b5fab7ba0] io_schedule at ffffffffafe1ac08
>  #5 [ffffa14b5fab7bb0] bit_wait_io at ffffffffafe1a561
>  #6 [ffffa14b5fab7bc8] __wait_on_bit at ffffffffafe1a087
>  #7 [ffffa14b5fab7c08] out_of_line_wait_on_bit at ffffffffafe1a1f1
>  #8 [ffffa14b5fab7c80] __wait_on_buffer at ffffffffaf85068a
>  #9 [ffffa14b5fab7c90] jbd2_journal_commit_transaction at ffffffffc0e543fc
> [jbd2]
> #10 [ffffa14b5fab7e48] kjournald2 at ffffffffc0e5a6ad [jbd2]
> #11 [ffffa14b5fab7ec8] kthread at ffffffffaf6ad781
> #12 [ffffa14b5fab7f50] ret_from_fork_nospec_begin at ffffffffafe1fe5d
> 
> Thanks,
> 
> Chris
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
