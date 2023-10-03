Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF07B6B20
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjJCOLq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJCOLp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 10:11:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081395
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 07:11:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 629AF5C01BC;
        Tue,  3 Oct 2023 10:11:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 03 Oct 2023 10:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696342299; x=1696428699; bh=f5OIuVSTUdWImnFCTEXCJMtsDWw6OTj7aIC
        1dkPr/+Q=; b=iGYfw28UfzEEnbujsAk437h4/+fwFRbhOpFhoPtuEriGamzD6K8
        +sYn9RE8tx+rHKSfGEh1i4+R7cQGdNXakhIymSYcimIIG8EjDuPQQ0/gAlY/z420
        dpQFTdhPjDiiRK43FE0gshknHE7pr8CN66Bodob8yB4wm8P18fqd0Wdw5m4txbo4
        iOe90uvohzoowhFBykSrxOf6SDPd8dzivAPTpIw+RF7BeWADgj1jLMsl/dQvGAPc
        UtZGTHusgQJlAZ78IogHGhoCMq1Ct+Z6FWyEzVrUfDGzLfFFrqu6uncXLnMvGosh
        kMqZokPkFV7iLwyVExYLh+qQ7YMNk4pjFlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696342299; x=1696428699; bh=f5OIuVSTUdWImnFCTEXCJMtsDWw6OTj7aIC
        1dkPr/+Q=; b=o9BvMg2K1BoCZ1BF8l6iHmwf826o/tYoI3GRjfVkT5P4CILp1dQ
        wapaqqPm8Ou3MA3qBzU3pMS+3RTEXlNt51Totj3+JjE8Z6M0EAb9V83QEQdjNcJX
        x6Ll/uOb7xYtdgGPrkth+2fuVKudFBsUuEL5KX4UkkFvo/Ctb+QAcyJ9rK3RaDu1
        03w+aH96pN5LpXoPHc+arwMyFY6hjBoTfuTBDa9o3WIRtle8JYsUkp2bmfCZLiFs
        qoENro4GYQkkpla87zdOT147PHPFpC8eEU//dlyqxxzgE5Jw9hVgiHE4G75lgIiE
        jrjA0NiApYnh18c58SPYyyhCAkjh1SwzWew==
X-ME-Sender: <xms:GiEcZXwfCYLQPJjv_7CO7Dgk0TJ7e6rAqMtteYo8pd21MyFEpjyuYw>
    <xme:GiEcZfTrcWbcLXQd23vDLzGcU4lbgJxnsfuQy86WvbX-h9TwG5JYyFl_k697ydEM3
    nhmddqLe_ae2BoZaw>
X-ME-Received: <xmr:GiEcZRUHzwwp0bsFLbdC9CMRd6ST6s3b0phrbsEP19iUMVj8JgLNh4NerPeyKH5Q7fVUO8Ri>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepuddtieegleejheeujeeiveegueelhfekleeuffdukeduleduffehfffg
    teeivefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:GyEcZRhOwnaI1uNMV-mWPRwFrecdddlQf19nrEPeZ5tAxmS6UTkE7g>
    <xmx:GyEcZZCUSC1ZhVoYVNAAaLndn9-6YL5IlZpsGfqLFkEh2ZIVLgKpDg>
    <xmx:GyEcZaI9B9OoGePo1ycpc5BXbNWrHZYMTL1fHsliQ3t-gr8O8jIXgw>
    <xmx:GyEcZTBbvkMjUcuWjYtWW0P8xSTNjCJ1e2z4wS5otyW-TAd7zCqwAA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 10:11:38 -0400 (EDT)
Date:   Tue, 3 Oct 2023 07:11:38 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-ext4@vger.kernel.org,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Message-ID: <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
 <ZQjKOjrjDYsoXBXj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQjKOjrjDYsoXBXj@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2023-09-18 18:07:54 -0400, Theodore Ts'o wrote:
> On Mon, Sep 18, 2023 at 08:13:30PM +0530, Shreeya Patel wrote:
> > When I tried to reproduce this issue on mainline linux kernel using the
> > reproducer provided by syzbot, I see an endless loop of following errors :-
> >
> > [   89.689751][ T3922] loop1: detected capacity change from 0 to 512
> > [   89.690514][ T3916] EXT4-fs error (device loop4): ext4_map_blocks:577:
> > inode #3: block 9: comm poc: lblock 0 mapped to illegal pblock 9 (length 1)
> > [   89.694709][ T3890] EXT4-fs error (device loop0): ext4_map_blocks:577:
>
> Please note that maliciously corrupted file system is considered low
> priority by ext4 developers.

FWIW, I am seeing occasional hangs in ext4_fallocate with 6.6-rc4 as well,
just doing database development on my laptop.

Oct 03 06:48:30 alap5 kernel: INFO: task postgres:132485 blocked for more than 122 seconds.
Oct 03 06:48:30 alap5 kernel:       Not tainted 6.6.0-rc4-andres-00009-ge38f6d0c8360 #74
Oct 03 06:48:30 alap5 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 03 06:48:30 alap5 kernel: task:postgres        state:D stack:0     pid:132485 ppid:132017 flags:0x00020006
Oct 03 06:48:30 alap5 kernel: Call Trace:
Oct 03 06:48:30 alap5 kernel:  <TASK>
Oct 03 06:48:30 alap5 kernel:  __schedule+0x388/0x13e0
Oct 03 06:48:30 alap5 kernel:  ? nvme_queue_rqs+0x1e6/0x290
Oct 03 06:48:30 alap5 kernel:  schedule+0x5f/0xe0
Oct 03 06:48:30 alap5 kernel:  inode_dio_wait+0xd5/0x100
Oct 03 06:48:30 alap5 kernel:  ? membarrier_register_private_expedited+0xa0/0xa0
Oct 03 06:48:30 alap5 kernel:  ext4_fallocate+0x12f/0x1040
Oct 03 06:48:30 alap5 kernel:  ? io_submit_sqes+0x392/0x660
Oct 03 06:48:30 alap5 kernel:  vfs_fallocate+0x135/0x360
Oct 03 06:48:30 alap5 kernel:  __x64_sys_fallocate+0x42/0x70
Oct 03 06:48:30 alap5 kernel:  do_syscall_64+0x38/0x80
Oct 03 06:48:30 alap5 kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 03 06:48:30 alap5 kernel: RIP: 0033:0x7fda32415f82
Oct 03 06:48:30 alap5 kernel: RSP: 002b:00007ffedbea0828 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
Oct 03 06:48:30 alap5 kernel: RAX: ffffffffffffffda RBX: 00000000002a6000 RCX: 00007fda32415f82
Oct 03 06:48:30 alap5 kernel: RDX: 0000000014b22000 RSI: 0000000000000000 RDI: 0000000000000016
Oct 03 06:48:30 alap5 kernel: RBP: 0000000014b22000 R08: 0000000014b22000 R09: 0000558f70eabed0
Oct 03 06:48:30 alap5 kernel: R10: 00000000002a6000 R11: 0000000000000246 R12: 00000000000000e0
Oct 03 06:48:30 alap5 kernel: R13: 000000000a000013 R14: 0000000000000004 R15: 0000558f709d4e70
Oct 03 06:48:30 alap5 kernel:  </TASK>

cat /proc/132485/stack
[<0>] inode_dio_wait+0xd5/0x100
[<0>] ext4_fallocate+0x12f/0x1040
[<0>] vfs_fallocate+0x135/0x360
[<0>] __x64_sys_fallocate+0x42/0x70
[<0>] do_syscall_64+0x38/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

cat /sys/kernel/debug/block/nvme1n1/hctx*/busy
doesn't show any active IO. Nor does the issue resolve when resetting the
controller - so I don't think this is a disk/block level issue.


This is on 8f1b4600373f, with one local, unrelated, commit ontop.

Unfortunately, so far, I've only reproduced this every couple hours of
interactive work, so bisecting isn't really feasible. I've not hit it on 6.5
over a considerably longer time, so I am reasonably confident this isn't an
older issue.

Greetings,

Andres Freund
