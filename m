Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83E7CD867
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJRJmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRJmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 05:42:07 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C9B0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Oct 2023 02:42:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 524895C0292;
        Wed, 18 Oct 2023 05:42:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Oct 2023 05:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697622120; x=1697708520; bh=DZ
        HPd/w5cznOlIbXWa4THJUSA1+jzFw/8kqw1T4hNZU=; b=0Imls5KkCFu91UiNoL
        6dNrLQpyCbndvDfWt8txZuS7x1IAMQK8j4rMfWIRByRBz7pd7GVibMn9lgsOkRj6
        1iTBoFIGKJBUu8JtGGo8wJp9rnVWXIJN1IBR9CjAYRJXl1mkj2AUygjTWWM/DtQn
        NNlVKp0fok9pCKO7ZcHz3f/D3fgt+Rt6bjU3KJQ5MvWWONnc2/7fur5EHp6OAA9x
        pbQLQlO+Y+39FdnaPmhQQtq+ygLYgSzaBD/RsE9GPqqKX5RPnpBd1xKt44/+ACQS
        SalBj+FwTniSavp6JoLKj1rUWKlbkYHnkU4jiBugA3C/bdBwI8+30LRdVSYRHEEv
        Fpbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697622120; x=1697708520; bh=DZHPd/w5cznOl
        IbXWa4THJUSA1+jzFw/8kqw1T4hNZU=; b=HEemyAcBNLMIb1GQYGhojwP8ScLcd
        1CYSZeePezHdkWm7ePsvytzG7YwnULtYfHNDdeQD4486pbP4VG3KDhOwCZDbbCuE
        WA9BSBQc5CzhBS85Ej72lTZX+S5I5uXDyvKyY+RzS7p8KyxtrfUWQFdqVnUaq5Mj
        DqRuLh3DPymlDeORnlgdNphMcQXOicR56AMH0AVkDCdw2WbOl7ti3ItycD518QVU
        Gg3ptoGESk88lvsMvWRO8pwAlUqGFvV013lDMp83HB5yw/G2IfcWhwiMPG11CyDS
        DkHk4GSMahbRSyK/zSqQOw+6swUkvaZ4MeBqZhX5fuzp4Dn8dLrURtTDA==
X-ME-Sender: <xms:Z6gvZWcbe93tP9V9_5Jft5Qb76DJlNeGQriypMMmXnDR_TIMR4qiSQ>
    <xme:Z6gvZQNR88TcXXwTn2ox27sUtgg0yYSWfeH2rpjBTNnG-dQfKgweWLzyBFSBDmScf
    O51R-hsCSeeQtaBrA>
X-ME-Received: <xmr:Z6gvZXiIhraFAdPI-MbGlu3ITbqG8-yp48gHBSlrir6BrTicPMm-y-HO-JzychIFnQ-6-GcihgtOaRv2xyXKKMY3yEN4cIpLsDALsNE0v3evD1skCpowGnEVcCJy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteevudei
    tedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:Z6gvZT9XZ7loOUS0DdUR1LrwA0MJ998XV52Mm6rzBBETigkgm9kwrA>
    <xmx:Z6gvZSuEuhWLbFpeffqJ9av3p7-8-oNzOzOQzbhem9CdbSAt-Au1dA>
    <xmx:Z6gvZaGEs3UarBhGTTnOijVcsj1FJJvoNKgvUsimLsTfpThPFep9DQ>
    <xmx:aKgvZf8hL7BcyC1nOUAigC1VtykwUzVXzr-L36ptGcJHybkB6vk8hQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 05:41:59 -0400 (EDT)
Date:   Wed, 18 Oct 2023 02:41:57 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-ext4@vger.kernel.org,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        gustavo.padovan@collabora.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: task hung in ext4_fallocate #2
Message-ID: <20231018094157.gyfdkgemoissjups@awork3.anarazel.de>
References: <20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de>
 <20231018004335.GA593012@mit.edu>
 <20231018025009.ulkykpefwdgpfvzf@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018025009.ulkykpefwdgpfvzf@awork3.anarazel.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

HI,

On 2023-10-17 19:50:09 -0700, Andres Freund wrote:
> I switched it to CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y and am rebuilding
> with lockdep enabled. Curious to see how long it'll take to trigger the
> problem with it enabled...

After booting into the lockdep enabled kernel I was immediately greeted with a
lockdep splat - in nouveau. Not realizing that would prevent subsequent
lockdep reports, I continued trying to reproduce the issue. Took 2-3h.

The next boot quickly triggered another unrelated lockdep report, possibly
triggered by a usb hub disconnecting.

Luckily the boot after that the problem very quickly reproduced. Lockdep did
not report a bug, but the list of held locks after the "hung task" warning
seems interesting:

[  367.987710] INFO: task iou-wrk-3385:3753 blocked for more than 122 seconds.
[  367.987882]       Not tainted 6.6.0-rc6-andres-00001-g01edcfe38260 #79
[  367.987896] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  367.987907] task:iou-wrk-3385    state:D stack:0     pid:3753  ppid:3320   flags:0x00004000
[  367.987931] Call Trace:
[  367.987942]  <TASK>
[  367.987964]  __schedule+0x4c3/0x17f0
[  367.988000]  ? schedule+0xa6/0xe0
[  367.988030]  schedule+0x5f/0xe0
[  367.988049]  schedule_preempt_disabled+0x15/0x20
[  367.988068]  rwsem_down_read_slowpath+0x2b9/0x590
[  367.988110]  down_read+0x64/0x150
[  367.988128]  ext4_file_write_iter+0x435/0xa90
[  367.988150]  ? find_held_lock+0x2b/0x80
[  367.988170]  ? io_write+0x366/0x4d0
[  367.988184]  ? lock_release+0xba/0x260
[  367.988199]  ? lock_is_held_type+0x84/0xf0
[  367.988225]  io_write+0x12b/0x4d0
[  367.988264]  ? lock_acquire+0xb3/0x2a0
[  367.988280]  ? io_worker_handle_work+0x10c/0x560
[  367.988303]  io_issue_sqe+0x5a/0x340
[  367.988323]  io_wq_submit_work+0x86/0x240
[  367.988342]  io_worker_handle_work+0x156/0x560
[  367.988371]  io_wq_worker+0xf6/0x370
[  367.988392]  ? find_held_lock+0x2b/0x80
[  367.988409]  ? ret_from_fork+0x17/0x50
[  367.988427]  ? lock_release+0xba/0x260
[  367.988441]  ? io_worker_handle_work+0x560/0x560
[  367.988459]  ? io_worker_handle_work+0x560/0x560
[  367.988477]  ret_from_fork+0x2d/0x50
[  367.988493]  ? io_worker_handle_work+0x560/0x560
[  367.988509]  ret_from_fork_asm+0x11/0x20
[  367.988551]  </TASK>
[  367.988562] INFO: task iou-wrk-3385:3855 blocked for more than 122 seconds.
[  367.988575]       Not tainted 6.6.0-rc6-andres-00001-g01edcfe38260 #79
[  367.988586] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  367.988596] task:iou-wrk-3385    state:D stack:0     pid:3855  ppid:3320   flags:0x00004000
[  367.988615] Call Trace:
[  367.988625]  <TASK>
[  367.988641]  __schedule+0x4c3/0x17f0
[  367.988670]  ? schedule+0xa6/0xe0
[  367.988699]  schedule+0x5f/0xe0
[  367.988718]  schedule_preempt_disabled+0x15/0x20
[  367.988736]  rwsem_down_read_slowpath+0x2b9/0x590
[  367.988777]  down_read+0x64/0x150
[  367.988795]  ext4_file_write_iter+0x435/0xa90
[  367.988813]  ? find_held_lock+0x2b/0x80
[  367.988831]  ? io_write+0x366/0x4d0
[  367.988844]  ? lock_release+0xba/0x260
[  367.988858]  ? lock_is_held_type+0x84/0xf0
[  367.988883]  io_write+0x12b/0x4d0
[  367.988922]  ? lock_acquire+0xb3/0x2a0
[  367.988937]  ? io_worker_handle_work+0x10c/0x560
[  367.988959]  io_issue_sqe+0x5a/0x340
[  367.988978]  io_wq_submit_work+0x86/0x240
[  367.988998]  io_worker_handle_work+0x156/0x560
[  367.989026]  io_wq_worker+0xf6/0x370
[  367.989047]  ? find_held_lock+0x2b/0x80
[  367.989064]  ? ret_from_fork+0x17/0x50
[  367.989080]  ? lock_release+0xba/0x260
[  367.989094]  ? io_worker_handle_work+0x560/0x560
[  367.989112]  ? io_worker_handle_work+0x560/0x560
[  367.989130]  ret_from_fork+0x2d/0x50
[  367.989146]  ? io_worker_handle_work+0x560/0x560
[  367.989162]  ret_from_fork_asm+0x11/0x20
[  367.989202]  </TASK>
[  367.989251] INFO: task postgres:3409 blocked for more than 122 seconds.
[  367.989263]       Not tainted 6.6.0-rc6-andres-00001-g01edcfe38260 #79
[  367.989273] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  367.989283] task:postgres        state:D stack:0     pid:3409  ppid:3320   flags:0x00020002
[  367.989301] Call Trace:
[  367.989310]  <TASK>
[  367.989327]  __schedule+0x4c3/0x17f0
[  367.989345]  ? prepare_to_wait+0x19/0x90
[  367.989383]  schedule+0x5f/0xe0
[  367.989403]  inode_dio_wait+0xd5/0x100
[  367.989424]  ? sugov_start+0x120/0x120
[  367.989445]  ext4_fallocate+0x149/0x1140
[  367.989461]  ? lock_acquire+0xb3/0x2a0
[  367.989476]  ? __x64_sys_fallocate+0x42/0x70
[  367.989513]  vfs_fallocate+0x135/0x450
[  367.989534]  __x64_sys_fallocate+0x42/0x70
[  367.989554]  do_syscall_64+0x38/0x80
[  367.989573]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  367.989589] RIP: 0033:0x7f9bbc458f82
[  367.989605] RSP: 002b:00007fff59b4b6a8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[  367.989624] RAX: ffffffffffffffda RBX: 00000000000d0000 RCX: 00007f9bbc458f82
[  367.989637] RDX: 00000000139ec000 RSI: 0000000000000000 RDI: 0000000000000046
[  367.989649] RBP: 00000000139ec000 R08: 00000000139ec000 R09: 0000558ea7726ed0
[  367.989661] R10: 00000000000d0000 R11: 0000000000000246 R12: 0000000000000b98
[  367.989672] R13: 000000000a000013 R14: 0000000000000035 R15: 0000558ea719c070
[  367.989710]  </TASK>
[  367.989723]
               Showing all locks held in the system:
[  367.989749] 1 lock held by khungtaskd/130:
[  367.989762]  #0: ffffffff8412d020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x32/0x1b0
[  367.989864] 1 lock held by iou-wrk-3322/3768:
[  367.989875]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.989918] 1 lock held by iou-wrk-3322/4142:
[  367.989929]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.989968] 1 lock held by iou-wrk-3322/4143:
[  367.989978]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990015] 1 lock held by iou-wrk-3322/4144:
[  367.990025]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990062] 1 lock held by iou-wrk-3322/4145:
[  367.990072]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990109] 1 lock held by iou-wrk-3322/4146:
[  367.990119]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990157] 1 lock held by iou-wrk-3322/4147:
[  367.990167]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990204] 1 lock held by iou-wrk-3322/4148:
[  367.990214]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990252] 1 lock held by iou-wrk-3385/3753:
[  367.990263]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990300] 1 lock held by iou-wrk-3385/3855:
[  367.990310]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990347] 1 lock held by iou-wrk-3386/3953:
[  367.990357]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990394] 1 lock held by iou-wrk-3386/4016:
[  367.990404]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990478] 1 lock held by iou-wrk-3386/4018:
[  367.990489]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990527] 1 lock held by iou-wrk-3386/4026:
[  367.990537]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990574] 1 lock held by iou-wrk-3386/4027:
[  367.990584]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990622] 1 lock held by iou-wrk-3386/4030:
[  367.990632]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990669] 1 lock held by iou-wrk-3386/4031:
[  367.990679]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990716] 1 lock held by iou-wrk-3386/4034:
[  367.990726]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990763] 1 lock held by iou-wrk-3386/4036:
[  367.990773]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990810] 1 lock held by iou-wrk-3386/4037:
[  367.990820]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990857] 1 lock held by iou-wrk-3386/4039:
[  367.990868]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990905] 1 lock held by iou-wrk-3386/4041:
[  367.990915]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990952] 1 lock held by iou-wrk-3386/4043:
[  367.990962]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.990999] 1 lock held by iou-wrk-3386/4045:
[  367.991009]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991046] 1 lock held by iou-wrk-3386/4047:
[  367.991056]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991094] 1 lock held by iou-wrk-3386/4049:
[  367.991104]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991141] 1 lock held by iou-wrk-3386/4052:
[  367.991151]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991188] 1 lock held by iou-wrk-3386/4054:
[  367.991198]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991235] 1 lock held by iou-wrk-3386/4056:
[  367.991245]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991283] 1 lock held by iou-wrk-3386/4058:
[  367.991293]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991330] 1 lock held by iou-wrk-3386/4060:
[  367.991340]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991377] 1 lock held by iou-wrk-3386/4061:
[  367.991387]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991424] 1 lock held by iou-wrk-3386/4063:
[  367.991434]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991471] 1 lock held by iou-wrk-3386/4066:
[  367.991481]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991518] 1 lock held by iou-wrk-3386/4069:
[  367.991528]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991566] 1 lock held by iou-wrk-3386/4071:
[  367.991576]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991613] 1 lock held by iou-wrk-3386/4073:
[  367.991623]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991660] 1 lock held by iou-wrk-3386/4075:
[  367.991670]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991707] 1 lock held by iou-wrk-3386/4076:
[  367.991717]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991754] 1 lock held by iou-wrk-3386/4077:
[  367.991764]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991801] 1 lock held by iou-wrk-3386/4078:
[  367.991811]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991848] 1 lock held by iou-wrk-3386/4079:
[  367.991859]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991896] 1 lock held by iou-wrk-3387/3990:
[  367.991906]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991943] 1 lock held by iou-wrk-3387/3998:
[  367.991953]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.991990] 1 lock held by iou-wrk-3387/4083:
[  367.992001]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992038] 1 lock held by iou-wrk-3387/4085:
[  367.992048]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992085] 1 lock held by iou-wrk-3387/4087:
[  367.992095]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992132] 1 lock held by iou-wrk-3387/4089:
[  367.992142]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992179] 1 lock held by iou-wrk-3387/4091:
[  367.992189]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992226] 1 lock held by iou-wrk-3387/4093:
[  367.992236]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992273] 1 lock held by iou-wrk-3387/4095:
[  367.992283]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992321] 1 lock held by iou-wrk-3387/4097:
[  367.992331]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992368] 1 lock held by iou-wrk-3387/4099:
[  367.992378]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992415] 1 lock held by iou-wrk-3387/4101:
[  367.992425]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992462] 1 lock held by iou-wrk-3387/4103:
[  367.992472]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992509] 1 lock held by iou-wrk-3387/4105:
[  367.992519]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992556] 1 lock held by iou-wrk-3387/4107:
[  367.992566]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992603] 1 lock held by iou-wrk-3387/4109:
[  367.992613]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992650] 1 lock held by iou-wrk-3387/4111:
[  367.992660]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992697] 1 lock held by iou-wrk-3387/4113:
[  367.992707]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992745] 1 lock held by iou-wrk-3387/4115:
[  367.992755]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992792] 1 lock held by iou-wrk-3387/4117:
[  367.992817]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992823] 1 lock held by iou-wrk-3387/4119:
[  367.992825]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992832] 1 lock held by iou-wrk-3387/4122:
[  367.992834]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992840] 1 lock held by iou-wrk-3387/4124:
[  367.992842]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992849] 1 lock held by iou-wrk-3387/4126:
[  367.992851]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992858] 1 lock held by iou-wrk-3387/4128:
[  367.992859]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992866] 1 lock held by iou-wrk-3387/4130:
[  367.992868]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992875] 1 lock held by iou-wrk-3387/4132:
[  367.992876]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992883] 1 lock held by iou-wrk-3387/4134:
[  367.992885]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992892] 1 lock held by iou-wrk-3387/4136:
[  367.992893]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992900] 1 lock held by iou-wrk-3387/4138:
[  367.992902]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992909] 1 lock held by iou-wrk-3387/4139:
[  367.992910]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992917] 1 lock held by iou-wrk-3387/4141:
[  367.992919]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992926] 1 lock held by iou-wrk-3388/3968:
[  367.992927]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992934] 1 lock held by iou-wrk-3388/4013:
[  367.992936]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992943] 1 lock held by iou-wrk-3388/4015:
[  367.992944]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992951] 1 lock held by iou-wrk-3388/4021:
[  367.992953]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992960] 1 lock held by iou-wrk-3388/4150:
[  367.992962]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992968] 1 lock held by iou-wrk-3388/4151:
[  367.992970]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992977] 1 lock held by iou-wrk-3388/4152:
[  367.992979]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992985] 1 lock held by iou-wrk-3388/4153:
[  367.992987]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.992994] 1 lock held by iou-wrk-3388/4154:
[  367.992996]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993002] 1 lock held by iou-wrk-3388/4155:
[  367.993004]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993011] 1 lock held by iou-wrk-3388/4156:
[  367.993013]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993019] 1 lock held by iou-wrk-3388/4157:
[  367.993021]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993028] 1 lock held by iou-wrk-3388/4158:
[  367.993030]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993036] 1 lock held by iou-wrk-3388/4159:
[  367.993038]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993045] 1 lock held by iou-wrk-3388/4160:
[  367.993047]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993054] 1 lock held by iou-wrk-3388/4161:
[  367.993055]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993062] 1 lock held by iou-wrk-3388/4162:
[  367.993064]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993071] 1 lock held by iou-wrk-3388/4163:
[  367.993073]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993079] 1 lock held by iou-wrk-3388/4164:
[  367.993081]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993088] 1 lock held by iou-wrk-3389/3965:
[  367.993089]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993096] 1 lock held by iou-wrk-3389/4005:
[  367.993098]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993105] 1 lock held by iou-wrk-3389/4023:
[  367.993106]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993113] 1 lock held by iou-wrk-3389/4024:
[  367.993115]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993122] 1 lock held by iou-wrk-3389/4025:
[  367.993124]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993130] 1 lock held by iou-wrk-3389/4028:
[  367.993132]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993139] 1 lock held by iou-wrk-3389/4029:
[  367.993140]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993147] 1 lock held by iou-wrk-3389/4032:
[  367.993149]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993156] 1 lock held by iou-wrk-3389/4033:
[  367.993157]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993164] 1 lock held by iou-wrk-3389/4035:
[  367.993166]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993172] 1 lock held by iou-wrk-3389/4038:
[  367.993174]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993181] 1 lock held by iou-wrk-3389/4040:
[  367.993183]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993189] 1 lock held by iou-wrk-3389/4042:
[  367.993191]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993198] 1 lock held by iou-wrk-3389/4044:
[  367.993200]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993206] 1 lock held by iou-wrk-3389/4046:
[  367.993208]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993215] 1 lock held by iou-wrk-3389/4048:
[  367.993217]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993223] 1 lock held by iou-wrk-3389/4050:
[  367.993225]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993232] 1 lock held by iou-wrk-3389/4051:
[  367.993234]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993240] 1 lock held by iou-wrk-3389/4053:
[  367.993242]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993249] 1 lock held by iou-wrk-3389/4055:
[  367.993251]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993257] 1 lock held by iou-wrk-3389/4057:
[  367.993259]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993266] 1 lock held by iou-wrk-3389/4059:
[  367.993268]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993274] 1 lock held by iou-wrk-3389/4062:
[  367.993276]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993283] 1 lock held by iou-wrk-3389/4064:
[  367.993284]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993291] 1 lock held by iou-wrk-3389/4065:
[  367.993293]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993300] 1 lock held by iou-wrk-3389/4067:
[  367.993301]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993308] 1 lock held by iou-wrk-3389/4068:
[  367.993310]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993317] 1 lock held by iou-wrk-3389/4070:
[  367.993318]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993325] 1 lock held by iou-wrk-3389/4072:
[  367.993327]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993334] 1 lock held by iou-wrk-3389/4074:
[  367.993335]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993342] 1 lock held by iou-wrk-3389/4080:
[  367.993344]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993351] 1 lock held by iou-wrk-3389/4081:
[  367.993352]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993359] 1 lock held by iou-wrk-3390/3856:
[  367.993361]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993368] 1 lock held by iou-wrk-3390/4014:
[  367.993370]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993376] 1 lock held by iou-wrk-3390/4017:
[  367.993378]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993385] 1 lock held by iou-wrk-3390/4165:
[  367.993387]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993393] 1 lock held by iou-wrk-3390/4166:
[  367.993395]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993402] 1 lock held by iou-wrk-3390/4167:
[  367.993404]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993410] 1 lock held by iou-wrk-3390/4168:
[  367.993412]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993419] 1 lock held by iou-wrk-3390/4169:
[  367.993420]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993427] 1 lock held by iou-wrk-3390/4170:
[  367.993429]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993436] 1 lock held by iou-wrk-3390/4171:
[  367.993437]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993444] 1 lock held by iou-wrk-3390/4172:
[  367.993446]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993453] 1 lock held by iou-wrk-3390/4173:
[  367.993454]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993461] 1 lock held by iou-wrk-3390/4174:
[  367.993463]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993470] 1 lock held by iou-wrk-3390/4175:
[  367.993471]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993478] 1 lock held by iou-wrk-3390/4176:
[  367.993480]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993486] 1 lock held by iou-wrk-3390/4177:
[  367.993488]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993495] 1 lock held by iou-wrk-3390/4178:
[  367.993497]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993504] 1 lock held by iou-wrk-3392/4000:
[  367.993506]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993512] 1 lock held by iou-wrk-3392/4019:
[  367.993514]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993521] 1 lock held by iou-wrk-3392/4082:
[  367.993523]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993529] 1 lock held by iou-wrk-3392/4084:
[  367.993531]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993538] 1 lock held by iou-wrk-3392/4086:
[  367.993540]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993546] 1 lock held by iou-wrk-3392/4088:
[  367.993548]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993555] 1 lock held by iou-wrk-3392/4090:
[  367.993557]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993563] 1 lock held by iou-wrk-3392/4092:
[  367.993565]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993572] 1 lock held by iou-wrk-3392/4094:
[  367.993574]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993580] 1 lock held by iou-wrk-3392/4096:
[  367.993582]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993589] 1 lock held by iou-wrk-3392/4098:
[  367.993591]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993597] 1 lock held by iou-wrk-3392/4100:
[  367.993599]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993606] 1 lock held by iou-wrk-3392/4102:
[  367.993608]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993614] 1 lock held by iou-wrk-3392/4104:
[  367.993616]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993623] 1 lock held by iou-wrk-3392/4106:
[  367.993625]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993631] 1 lock held by iou-wrk-3392/4108:
[  367.993633]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993640] 1 lock held by iou-wrk-3392/4110:
[  367.993642]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993648] 1 lock held by iou-wrk-3392/4112:
[  367.993650]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993657] 1 lock held by iou-wrk-3392/4114:
[  367.993659]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993665] 1 lock held by iou-wrk-3392/4116:
[  367.993667]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993674] 1 lock held by iou-wrk-3392/4118:
[  367.993676]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993682] 1 lock held by iou-wrk-3392/4120:
[  367.993684]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993691] 1 lock held by iou-wrk-3392/4121:
[  367.993693]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993699] 1 lock held by iou-wrk-3392/4123:
[  367.993701]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993708] 1 lock held by iou-wrk-3392/4125:
[  367.993710]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993716] 1 lock held by iou-wrk-3392/4127:
[  367.993718]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993725] 1 lock held by iou-wrk-3392/4129:
[  367.993727]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993733] 1 lock held by iou-wrk-3392/4131:
[  367.993735]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993742] 1 lock held by iou-wrk-3392/4133:
[  367.993743]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993750] 1 lock held by iou-wrk-3392/4135:
[  367.993752]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993759] 1 lock held by iou-wrk-3392/4137:
[  367.993760]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993767] 1 lock held by iou-wrk-3392/4140:
[  367.993769]  #0: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x435/0xa90
[  367.993780] 2 locks held by postgres/3409:
[  367.993801]  #0: ffff888144c3e3f8 (sb_writers#7){.+.+}-{0:0}, at: __x64_sys_fallocate+0x42/0x70
[  367.993809]  #1: ffff888466a00d70 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_fallocate+0x110/0x1140
[  367.993818] 2 locks held by less/3875:
[  367.993820]  #0: ffff888142f518a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x50
[  367.993828]  #1: ffffc900022ea2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x51b/0x650
[  367.993838] =============================================


Translating the various lock acquisition locations:

addr2line -p -i -e /home/andres/src/kernel/vmlinux ext4_file_write_iter+0x435/0xa90
/home/andres/src/kernel/./include/linux/fs.h:1073
 (inlined by) /home/andres/src/kernel/fs/ext4/file.c:57
 (inlined by) /home/andres/src/kernel/fs/ext4/file.c:564
 (inlined by) /home/andres/src/kernel/fs/ext4/file.c:715

addr2line -p -i -e /home/andres/src/kernel/vmlinux __x64_sys_fallocate+0x42/0x70
/home/andres/src/kernel/./include/linux/file.h:45
 (inlined by) /home/andres/src/kernel/fs/open.c:348
 (inlined by) /home/andres/src/kernel/fs/open.c:355
 (inlined by) /home/andres/src/kernel/fs/open.c:353
 (inlined by) /home/andres/src/kernel/fs/open.c:353

addr2line -p -i -e /home/andres/src/kernel/vmlinux ext4_fallocate+0x110/0x1140
/home/andres/src/kernel/./arch/x86/include/asm/bitops.h:207
 (inlined by) /home/andres/src/kernel/./arch/x86/include/asm/bitops.h:239
 (inlined by) /home/andres/src/kernel/./include/asm-generic/bitops/instrumented-non-atomic.h:142
 (inlined by) /home/andres/src/kernel/fs/ext4/ext4.h:1922
 (inlined by) /home/andres/src/kernel/fs/ext4/extents.c:4735

I think the addresses that lockdep computes must be off a bit - it sure looks
like instead of the address that ext4_fallocate+0x110 maps to, the acquisition
instead was the preceding line, i.e. the inode_lock().

fs/ext4/extents.c:
4727		max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
   0xffffffff815d9de0 <ext4_fallocate+256>:	and    %rdx,%rax
   0xffffffff815d9de3 <ext4_fallocate+259>:	sar    %cl,%rax
   0xffffffff815d9de6 <ext4_fallocate+262>:	sub    %esi,%eax
   0xffffffff815d9de8 <ext4_fallocate+264>:	mov    %eax,-0x60(%rbp)

./include/linux/fs.h:
802		down_write(&inode->i_rwsem);
   0xffffffff815d9deb <ext4_fallocate+267>:	call   0xffffffff8276c0c0 <down_write>

./arch/x86/include/asm/bitops.h:
206		return ((1UL << (nr & (BITS_PER_LONG-1))) &
   0xffffffff815d9df0 <ext4_fallocate+272>:	mov    -0x260(%rbx),%rax

fs/ext4/extents.c:
4735		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {


Looking at the code, I assume the reason lockdep doesn't fire is that it
doesn't understand wait edges via __inode_dio_wait().

Greetings,

Andres Freund
