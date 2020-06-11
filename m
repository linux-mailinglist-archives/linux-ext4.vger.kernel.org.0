Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA51F5F2A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 02:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFKAZF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 20:25:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40676 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFKAZF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Jun 2020 20:25:05 -0400
Received: by mail-il1-f199.google.com with SMTP id s4so2736307ilc.7
        for <linux-ext4@vger.kernel.org>; Wed, 10 Jun 2020 17:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5h8mXCxAyDZSlKXtJUEYKqhTlNYUsrPeduOrUEGY4RQ=;
        b=GhGlldqTjraN5cqOMWcJes0J96E/zqLKucnIhE9GNFuYsPvB80ordrDmTWm0RPeoXy
         kudR9fZHyg0Fzjg/fvhw6Js80i835G5zpvXqLo2qv2bkie0qGvaSoC8VVeW9vTk9JZCA
         jE2KWnAtA4ADJWNl/DCWprftOZQ0fLteuqsPVdSBhfzgKOr0EcnHJVENkDujeiNQj+dg
         jxfnFcB4kjkKjAGDxOh36irPCltlS4sED+11BIHKvbKpLiXP72Ymq/xAwlFs82kRadMs
         m3hGX+wSSCYey/v59PKZd8D90bMBE/WlfKX3wrIBE/0saq/2bdkKx78Y8t15quRfh1Lz
         2BNQ==
X-Gm-Message-State: AOAM530fHxRS1S4aWsnnlQq9B34VMFw0fHS19i1z9hA2TjCu4xCXhO1u
        JbCyeQLdGnR2JH0yUrzNn0I1bf9t2ZDEaAMoshO0flYfQ4m0
X-Google-Smtp-Source: ABdhPJyrMgQvz66Vb9aVe5TnjxkkUv8YU1EGJlD+BgcZtIAC9MgHdnop0BgRS67Ewa1mFKkjCYM2u6Us3ThS9zyTBpDa96B8JLeb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr800041jap.125.1591835102980;
 Wed, 10 Jun 2020 17:25:02 -0700 (PDT)
Date:   Wed, 10 Jun 2020 17:25:02 -0700
In-Reply-To: <20200610220710.GL1347934@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab72f05a7c3fd77@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com

Tested on:

commit:         5749fe5a ext4: avoid race conditions when remounting with ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=175fcaead7a60c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
