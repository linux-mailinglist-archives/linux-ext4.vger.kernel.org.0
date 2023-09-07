Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05057974E3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjIGPl6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Sep 2023 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjIGPXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Sep 2023 11:23:39 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0E197
        for <linux-ext4@vger.kernel.org>; Thu,  7 Sep 2023 08:23:34 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1cc4d62dd0cso1235486fac.3
        for <linux-ext4@vger.kernel.org>; Thu, 07 Sep 2023 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100214; x=1694705014;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54RnD0/eaUNNcZhsg2FpPlchnXTxP0bbQAOVgGCedQA=;
        b=XdPKVHrJANL3Q0fyK3hLKSdPPbOHYJqB5qpHjn3zfK/fqlVU2EQEiMhbd/hBac9RYO
         VUkUFbjoD2Hm/ydzirCI3KErQFbOOWIyyqMqNafCrGwqDtGxEYIQSiPU6AHAhvheuu51
         CA9m4+bGGIgkAupZ8XavDPfUXRM6Mtsz5kYhV3qzm1RdiFuHlFkWPd5kGk/f4lefbwEn
         h5oimJK/ms7HDNM4K3rtZ4OZJzQKQhZctyKJgfsBJFk1A/xIdmr3VdVKdX3zjmCIz6FR
         PRqRVA0vmwBpl3E9pj9UfkkPPAPGjYXKLzUPgjryd5whybR7aV8YDi0VjCUJq6F5l8aL
         fgOQ==
X-Gm-Message-State: AOJu0YxaQCRQheKxEaGuJXDqXdNkYTv9xfaY5RJ5BuSYI0/ptr2OyvAh
        K8sjStLR46ssln/kaYsOhNlkx6fbYDGslPUl2uIR3s9ik4bG
X-Google-Smtp-Source: AGHT+IF7nJp7WfGi/JuZ3Xso9VmPQE+Eu5dyn+9jnS4PZNmBcTODjnhA1xHWBvLIq3kc3jCCDDcd8W091tI9+51MmrUx3l8NWUou
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c286:b0:263:317f:7ca4 with SMTP id
 f6-20020a17090ac28600b00263317f7ca4mr4271411pjt.9.1694078750527; Thu, 07 Sep
 2023 02:25:50 -0700 (PDT)
Date:   Thu, 07 Sep 2023 02:25:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002598420604c1721a@google.com>
Subject: [syzbot] Monthly ext4 report (Sep 2023)
From:   syzbot <syzbot+list8aecbc15d3f04988df93@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 3 new issues were detected and 2 were fixed.
In total, 40 issues are still open and 118 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2826    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  221     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  138     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<4>  117     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  73      Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6>  28      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<7>  14      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<8>  7       Yes   KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
                   https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
<9>  6       Yes   INFO: task hung in ext4_evict_ea_inode
                   https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
<10> 6       Yes   KASAN: out-of-bounds Read in ext4_ext_remove_space
                   https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
