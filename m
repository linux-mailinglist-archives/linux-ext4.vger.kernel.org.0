Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869866424F1
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiLEIpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 03:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiLEIo6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 03:44:58 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A217586
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 00:44:57 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i2so10398658vsc.1
        for <linux-ext4@vger.kernel.org>; Mon, 05 Dec 2022 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMrGaXb3ASityhiOABfrhaEcWe6UqTL9H63TUuQswvM=;
        b=mOxfqlKCRXykKXE8OVj1jWtGoQEsWNU2B3JehYaG3pljzgDeDC1e99twwepoXYoNjW
         Kt9+PWpDYUphb3gDW2Mi4oDx9VeVh9ZTci9HG+4uDmqJ46rEdkKpWaned5aH0gui7eVl
         Pug69CZAl3dRTb0biJqDx8WqznBNyYm6hi1I4Ra3xqGCxA0w7oDYUnmWPEH/wd2Gu00U
         CLWBWWUhffAG1gOELrEie/DNuxwgHhWH8/V+m1atJYZNYPw/RirqseYp4cEc6v7mOxs/
         oDkoHgC3cGnz7eePyhvAhSBFhA5RPtihAneDhX5tryCdPUTRoBMScWx2SlnrMlM5365n
         uLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMrGaXb3ASityhiOABfrhaEcWe6UqTL9H63TUuQswvM=;
        b=ZFThUuPKOth+eE9REVk/zAecHjoJdLouyLj7Aju/8oL+4oPDacxDbiHzbYpxlrD/dn
         eyb8/M7S6UpdVi4NrD0E9BYDT7jLJQQODYrmUmwSnUkUePYf0Wv4264cktbxrbvQ7/kO
         ASqNBjOjwDuB6YBF4Av+AlRsWNsfQwtXvVye1C4I0iM0jZ8qXAgUeJhNL7Z2GZ9PnL+2
         5H3+5/KqieX2/bMvTYeT0q0EI7ahG+aPf+PHLAvl7aHcTkBYmPiMVuUMUeqdkLCaCkMV
         +dmh8qs3eZLnzBhBM5hsABLGIaUqGZ/cRScJUFE53bWaD9tGYOHgi81xrQlWuSbhMYPW
         fD9g==
X-Gm-Message-State: ANoB5pmtuUpCjBvBdt+eOYOM2CDev9T+pvc7lAp62DhZjLdzzSIPALaC
        xd7Hia9STla2CgCkVJLGlRaXaonerZGJvdRRAv8=
X-Google-Smtp-Source: AA0mqf6KwnQVTNvxo2XgPLzC0qhI93NQKVyNb4dV5DpIWiJTHjAwmxfvbb7c4NxsBdC38TGOx+jcFGayqh24VTvuFoY=
X-Received: by 2002:a05:6102:c8c:b0:3b0:9171:95f7 with SMTP id
 f12-20020a0561020c8c00b003b0917195f7mr22808935vst.3.1670229896655; Mon, 05
 Dec 2022 00:44:56 -0800 (PST)
MIME-Version: 1.0
References: <bug-216775-13602@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216775-13602@https.bugzilla.kernel.org/>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 5 Dec 2022 10:44:44 +0200
Message-ID: <CAOQ4uxi6bV-Z41ENvH_djPxed_ReGL7EKLpHA3PbNjDgk_Ukiw@mail.gmail.com>
Subject: Re: [Bug 216775] New: fanotify reports parent PPID insted of PID for
 FAN_MODIFY events
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 5, 2022 at 7:02 AM <bugzilla-daemon@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=216775
>
>             Bug ID: 216775
>            Summary: fanotify reports parent PPID insted of PID for
>                     FAN_MODIFY events
>            Product: File System
>            Version: 2.5
>     Kernel Version: 5.15.0
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: ext4
>           Assignee: fs_ext4@kernel-bugs.osdl.org
>           Reporter: saikiran.gummaraj@icloud.com
>         Regression: No
>
> Hello,
>
> While I've been developing a library around fanotify in Go, I noticed that
> fanotify subsystem reports the parent process ID in fanotify_event_metadata.pid
> instead of the Process ID when mask is set to FAN_MODIFY. I was able to confirm
> the error through a test and also manually verifying the PIDs in the audit log.
> I did not observe this behaviour for FAN_ACCESS bit.
>
> I've been able to reproduce this on -
>
> Ubuntu 20.04.5 - 5.15.0-53-generic
> Ubuntu 22.10 - 5.19.0-23-generic
>
> It can be reproduced by -
>
> git clone git@github.com:opcoder0/fanotify.git
> cd fanotify
> sudo go test -v
>
> The test "TestWithCapSysAdmFanotifyFileModified" fails reporting pid mismatch.
>

It's a test bug.
The modify event with self pid is generated by os.WriteFile()
Either change test to expect modify event with self pid or move
test file creation before starting the listener.

Thanks,
Amir.
