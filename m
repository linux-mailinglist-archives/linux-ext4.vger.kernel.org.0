Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125AC7B75AD
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Oct 2023 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjJDALT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 20:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjJDALT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 20:11:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F38E
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 17:11:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-773ac11de71so106935985a.2
        for <linux-ext4@vger.kernel.org>; Tue, 03 Oct 2023 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696378274; x=1696983074; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6obu1n7zMsHpG2rACoV5yoKMloUYHbZIaCFa5FRwzo=;
        b=Y7dzgumhjpNHBRp+Dcrdtp6RcO7zQX3P0qtxS7eBgyQxfB5rUKfoOtDVYv2vnKdUDz
         7A5ij9vFqa1bJJ6coFW+JGO8EFXDKTMfFZw1B8tek1D5esFSd5WPSg2GzuOYXqFfL+GH
         UV7eXsAmuvRvm7sBMOKSCWn5fqk1RiNiOEt9vpZ2ZfB5Ok4+P43BFSQ41BORzJkAnAq1
         GPRh80rFJiKiX/KzgxHW5rQZccJb4+Ni6OVsgNMPpL6YksKiP/oo7bkAFj21rHobjewg
         mfJ0Av/aSrhDF+DoNkrF0iJgD5dMMz+p8YSKISwSyDCwfNgwcZ3ZvYhLNF1kvAlDGlsJ
         PpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696378274; x=1696983074;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6obu1n7zMsHpG2rACoV5yoKMloUYHbZIaCFa5FRwzo=;
        b=XYC6NAisIJTCf54Gu7KjhlpguqGz+GIXjwHJIYR1W7e1CWahwZb5x0Q9PMa1Wko6T+
         3+B12d7ZyPLUK/huXR3AXAN2h4kZ2T7tNtKn108TtCfssm2g6IgA9Kqt/rmA8xwspQZE
         9hO3BoR/r7QwT2veN7RUZbqqu3aDsckpkOjWi6T1WHKcob73mkXwqpNG3WjVZywBgV+E
         FZ0Hi8esJjND0AbPlvio7OBoH/72GTUvILS3s6Eoy6GGt8hT+5+05wM2ugaximoPUYJE
         ITxKnC1/lu6d/w9d6Q5pncq1jAFBkj0GRrbepsUOVLmxMO2OlQp3/s/DqBQr/KwKVjj5
         UCFQ==
X-Gm-Message-State: AOJu0YyC9Na0VvS1Mbp7icfRSX/C6wySsdRV6zYDir7a/bSE3gjBBFiX
        huk2sk3xtEOXwzdCrecKTWZlSos5XEY=
X-Google-Smtp-Source: AGHT+IFOCrCVC5g/gBN6boKNPjhZzbD9nmfBaNY7oOWZ2/n6GaM/qEIzMrgGvhR/7f9AZGmVQxHhMA==
X-Received: by 2002:a05:620a:211b:b0:774:500:a18e with SMTP id l27-20020a05620a211b00b007740500a18emr974497qkl.75.1696378273974;
        Tue, 03 Oct 2023 17:11:13 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id b7-20020a0ccd07000000b0065b231b2cb4sm875602qvm.105.2023.10.03.17.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:11:13 -0700 (PDT)
Date:   Tue, 3 Oct 2023 20:11:11 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, libaokun1@huawei.com
Subject: probable quota bug introduced in 6.6-rc1
Message-ID: <ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When run on my test hardware, generic/270 triggers hung task timeouts when
run on a 6.6-rc1 (or -rc2, -rc3, -rc4) kernel with kvm-xfstests using the
nojournal test scenario.  The test always passes, but about 60% of the time
the running time of the test increases by an order of magnitude or more and
one or more of the hung task timeout warnings included below can be found in
the log.

This does not reproduce on 6.5.  Bisection leads to this patch:

dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should
provide")

From the log:

generic/270 306s ...  [20:08:45][  311.322318] run fstests generic/270 at 2023-10-03 20:08:45
[  311.579641] EXT4-fs (vdc): mounted filesystem d0e542a0-3342-4d43-aa1f-c918cc92aafa r/w without journal. Quota mode: writeback.
[  311.587978] EXT4-fs (vdc): re-mounted d0e542a0-3342-4d43-aa1f-c918cc92aafa ro. Quota mode: writeback.
[  311.592725] EXT4-fs (vdc): re-mounted d0e542a0-3342-4d43-aa1f-c918cc92aafa r/w. Quota mode: writeback.
[  335.491107] 270 (3092): drop_caches: 3
[  491.167988] INFO: task quotaon:3450 blocked for more than 122 seconds.
[  491.168334]       Not tainted 6.4.0+ #13
[  491.168544] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  491.168936] task:quotaon         state:D stack:0     pid:3450  ppid:3092   flags:0x00004000
[  491.169363] Call Trace:
[  491.169503]  <TASK>
[  491.169620]  __schedule+0x394/0xd40
[  491.169813]  schedule+0x5d/0xd0
[  491.169981]  schedule_timeout+0x1a7/0x1c0
[  491.170191]  ? lock_release+0x139/0x280
[  491.170395]  ? lock_acquire+0xb9/0x180
[  491.170605]  ? do_raw_spin_unlock+0x4b/0xa0
[  491.170837]  __wait_for_common+0xb6/0x1e0
[  491.171046]  ? __pfx_schedule_timeout+0x10/0x10
[  491.171324]  __flush_work+0x2da/0x430
[  491.171517]  ? __pfx_wq_barrier_func+0x10/0x10
[  491.171747]  ? 0xffffffff81000000
[  491.171932]  dquot_disable+0x3e5/0x670
[  491.172134]  ext4_quota_off+0x50/0x1a0
[  491.172332]  __x64_sys_quotactl+0x87/0x1c0
[  491.172545]  do_syscall_64+0x38/0x90
[  491.172731]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  491.172990] RIP: 0033:0x7f3c7c79eada
[  491.173176] RSP: 002b:00007ffed2ff4478 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
[  491.173558] RAX: ffffffffffffffda RBX: 000055886a3997d0 RCX: 00007f3c7c79eada
[  491.173915] RDX: 0000000000000000 RSI: 000055886bf43de0 RDI: 0000000080000301
[  491.174271] RBP: 000055886bf43de0 R08: 0000000000000001 R09: 0000000000000002
[  491.174657] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
[  491.175014] R13: 000055886bf43ea0 R14: 0000000000000001 R15: 0000000000000000
[  491.175373]  </TASK>
[  491.175491] 
[  491.175491] Showing all locks held in the system:
[  491.176706] 1 lock held by rcu_tasks_kthre/12:
[  491.178126]  #0: ffffffff82763970 (rcu_tasks.tasks_gp_mutex){....}-{3:3}, at: rcu_tasks_one_gp+0x30/0x3f0
[  491.180955] 1 lock held by rcu_tasks_rude_/13:
[  491.182394]  #0: ffffffff827636f0 (rcu_tasks_rude.tasks_gp_mutex){....}-{3:3}, at: rcu_tasks_one_gp+0x30/0x3f0
[  491.194388] 1 lock held by khungtaskd/26:
[  491.196153]  #0: ffffffff82764020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0xe/0x110
[  491.199676] 2 locks held by kworker/u4:4/59:
[  491.200722]  #0: ffff88800385cd38 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1f6/0x550
[  491.201600]  #1: ffffc90000513e80 ((quota_release_work).work){....}-{0:0}, at: process_one_work+0x1f6/0x550
[  491.202746] 1 lock held by quotaon/3450:
[  491.203184]  #0: ffff88800afd60e0 (&type->s_umount_key#33){....}-{3:3}, at: user_get_super+0xd3/0x100
[  491.204217] 
[  491.204373] =============================================


Eric
