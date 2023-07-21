Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179E75C37F
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjGUJsn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGUJsT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 05:48:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D5E75
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jul 2023 02:47:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so46185e9.1
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jul 2023 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689932852; x=1690537652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqfvFf9xIhxpdVCPq68g9SUDSB4UZpj++bvp7P1BZ+M=;
        b=Rs/QeoKiPi4hI3mKDDNyqjtTECFzRbRAtgkIYuyw9ixHJOdVio+yxrf83nTF2gAyxw
         Mn4U/4XE+ibLUJDVjxPPj9JzuzYCCUvpVPWBl5wNuxQ1hKHQm1ZNkrkTsco3hNPy1vVL
         ecFupbNxTVnUOhNwTHoy0AniHF48zdL+AMtMBoAV1WW8IjNXSdlXlpqjrhlWhBLyhbPj
         ssih0eyEjDhq69ySJTRp9wCOBj9Yku6JWLRZ7zjf9w0pl34VBADWz1KM4Fx+cEvC/sH+
         +W7OcPzbeDxTPEw/wJN4K44HaBM0iD8XNU6lXuR+iT/X1pyXnLdyIEUSzeyKvkuVcrlz
         ItfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932852; x=1690537652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqfvFf9xIhxpdVCPq68g9SUDSB4UZpj++bvp7P1BZ+M=;
        b=gKqpriRo8UvbfIQs9eq8GwZI8KzdB1QVuj2VAp7RM/UE1nFV/q1owuJ4dy027GDwGi
         mmCV2SYLsl7JkTfk/ifszyiiQqEecjRWDbv08cVYBkn6N9GCIIuRKjy70YbHzg152gjQ
         kaL64ptvlVqUQcrjSNKCmDbZmkNRtVRjGyx/HHSJTLD5szbLUzp4KwJPS8EaICNs7Rck
         nyeUUxaqPhfWl0kcx3jpea88FhY7rRdsHCWtA3OeEHhXZjrk6bi0Z58OCSf5tU277qxL
         ateuoBtfOf4TdYxAf3sDrlH3vdRCUSGN8BuPUsgGKMp7d1NKjufAe3HWoRMLhToILU3k
         3nVg==
X-Gm-Message-State: ABy/qLYF0YFNaqZFB5UUzRBXEUmWOuZr5Nm8scW6TIKruwIioyO8XANC
        nKCLZ2W2r2uUlQI063dPKeqhmTpVAI07eLOB8CFdTk8gRe+LOGhklAwnAA==
X-Google-Smtp-Source: APBJJlHsTNBMf/W59rloGf70oxm11BF5D1J5sg1xVvbOIBYTaXaLWanJ/vxpttr+FKfAALI+vCr16+8yKjCvMFsXcE8=
X-Received: by 2002:a05:600c:1e08:b0:3f4:2736:b5eb with SMTP id
 ay8-20020a05600c1e0800b003f42736b5ebmr59334wmb.1.1689932852605; Fri, 21 Jul
 2023 02:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c11ed40600e994b1@google.com> <000000000000d96eec0600fbea8f@google.com>
In-Reply-To: <000000000000d96eec0600fbea8f@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 21 Jul 2023 11:47:20 +0200
Message-ID: <CANp29Y7Sgbfa5u-wSe1rTJiyKQb7d1GWcnTm+GZBvTcYdjvx-g@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ep_poll_callback
To:     syzbot <syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, brauner@kernel.org, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30=E2=80=AFAM syzbot
<syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Thu Feb 14 23:00:46 2019 +0000
>
>     locking/lockdep: Free lock classes that are no longer in use

No, that doesn't seem like a real cause commit.

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16c0c84ea8=
0000

The reproducer actually causes a lot of different crashes, which
apparently confused the bisector.

run #0: crashed: general protection fault in ext4_finish_bio
run #1: crashed: general protection fault in ext4_finish_bio
run #2: crashed: KASAN: wild-memory-access Read in force_sig_info_to_task
run #3: crashed: KASAN: wild-memory-access Read in force_sig_info_to_task
run #4: crashed: BUG: unable to handle kernel paging request in __run_timer=
s
run #5: crashed: BUG: unable to handle kernel paging request in __run_timer=
s
run #6: crashed: general protection fault in mac80211_hwsim_netlink_notify
run #7: crashed: general protection fault in mac80211_hwsim_netlink_notify
run #8: crashed: general protection fault in __run_timers
run #9: crashed: general protection fault in __run_timers
run #10: crashed: KASAN: wild-memory-access Read in process_one_work
run #11: crashed: KASAN: wild-memory-access Read in process_one_work
run #12: crashed: general protection fault in timerqueue_del
run #13: crashed: general protection fault in timerqueue_del
run #14: crashed: kernel BUG in corrupted
run #15: crashed: kernel BUG in corrupted
run #16: crashed: general protection fault in mm_update_next_owner
run #17: crashed: general protection fault in mm_update_next_owner

Isn't it a sign of a severe memory corruption caused by the reproducer?


> start commit:   bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.ker=
n..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D15c0c84ea8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11c0c84ea8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D27e33fd2346a5=
4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc2b68bdf76e4428=
36443
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D111c904ea80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D116b0faaa8000=
0
>
> Reported-by: syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no long=
er in use")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
