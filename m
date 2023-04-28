Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD46F1B12
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjD1PG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjD1PG4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 11:06:56 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155612717
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 08:06:52 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32a7770f504so154280175ab.2
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 08:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694411; x=1685286411;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/xD78dMXFtD77NIODcCN7yIVszjk8tbaP5FKYvJrfU=;
        b=CEE2wKFmmzTC3FsDumTU3ZkD9++Hz+T/v/KtoTSnM8HooeROf37qNoVv+q+BTQpvQY
         Cv3vQpxTa63DiFpQgwS91ljLdl1J3ypAJTDgO4QcJku0xAFEHVD2n1J7SsTLA67EacjT
         kCWiObGORERhEoTTf5BaNsol0hIYVEyQdJQv10YhvjXFBQSgCJWi/Pn9TtjVhPvV/p6a
         pFowd4sw0/VWWypHdC1MqaHqIDST+Gq3Ol0MLmVyRJu3LqRo1WbXVKSI6rNozF6GUzzU
         HxPqD1xce71FNcYqEwi12VLmrnOaVJPkBjZvEYrVuvQf+m6Fd8C+Y4wrCFXRHgW1eUYf
         8xow==
X-Gm-Message-State: AC+VfDzj8GqOEbz9uq5JShnJTyyBS5aHi3tIPjQULDh8sxZQ3SqYTrP6
        poQ/pGKK74BvjtiDL4ITZUwnb7Do+TiILIpVTAmH3ADgilrT
X-Google-Smtp-Source: ACHHUZ7cadSF6zDEseaZLvjt5+aY90sLk7ce1A6nPHRNs2rfDdhDgLvGRew1H1zHhXrOjNcXVtscOZoDptIIhZefqatd2XAeqk3v
MIME-Version: 1.0
X-Received: by 2002:a92:ddc9:0:b0:315:8f6c:50a6 with SMTP id
 d9-20020a92ddc9000000b003158f6c50a6mr3519209ilr.1.1682694411424; Fri, 28 Apr
 2023 08:06:51 -0700 (PDT)
Date:   Fri, 28 Apr 2023 08:06:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89a6a05fa66d226@google.com>
Subject: [syzbot] Monthly ext4 report (Apr 2023)
From:   syzbot <syzbot+list6dfc6ea307bfacecbbe0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 0 were fixed.
In total, 72 issues are still open and 82 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  83130   Yes   possible deadlock in jbd2_journal_lock_updates
                   https://syzkaller.appspot.com/bug?extid=79e6bbabf3ce17357969
<2>  7208    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  5604    Yes   possible deadlock in dquot_commit (2)
                   https://syzkaller.appspot.com/bug?extid=70ff52e51b7e7714db8a
<4>  773     Yes   INFO: task hung in __sync_dirty_buffer
                   https://syzkaller.appspot.com/bug?extid=91dccab7c64e2850a4e5
<5>  476     No    possible deadlock in ext4_map_blocks
                   https://syzkaller.appspot.com/bug?extid=6de5025c31d33047d2a4
<6>  361     No    possible deadlock in ext4_multi_mount_protect
                   https://syzkaller.appspot.com/bug?extid=6b7df7d5506b32467149
<7>  203     Yes   kernel BUG in ext4_get_group_info
                   https://syzkaller.appspot.com/bug?extid=e2efa3efc15a1c9e95c3
<8>  93      Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<9>  29      Yes   KASAN: slab-out-of-bounds Read in ext4_enable_quotas
                   https://syzkaller.appspot.com/bug?extid=ea70429cd5cf47ba8937
<10> 22      Yes   WARNING in ext4_xattr_block_set (2)
                   https://syzkaller.appspot.com/bug?extid=6385d7d3065524c5ca6d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
