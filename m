Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB92954E1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 00:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506896AbgJUWpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 18:45:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35298 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506893AbgJUWpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 18:45:09 -0400
Received: by mail-io1-f72.google.com with SMTP id w16so2683578ioa.2
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 15:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7JOVTJJfIbS3N5OEHaDdyiuANlR9ab6tKBOsWZoF0WU=;
        b=Gcpdi7rcTcOVigaU6E3oCzmWeP6lcQDj4Jpwu3tpCX0VCKKPL6aNHX3sVjfmkC3y4E
         npijboB3QlvkQxDFkvJ1E7oQz7R8CSTiv8J5V8hn4mlxBfEQDbH99yefhPmSvGZfeka5
         9d2841M0Hpjto12oRrspF0NcDkX2NcYxRDdIDlpi+Sf5BX+Ik+TI4sLMdipWPYaFcKRK
         alJSzZcPas+g6Xay7zermy845+RmJFuPVCROVUskarm59YFIXr5KGMYmHvBBzcPuWY06
         jxpSD2y92arIKadjSMuUyOnZ9oDwGvk68P1RU/Fyh/nABigthuT+ZoIu5ch8rDlGp86T
         mh+Q==
X-Gm-Message-State: AOAM53189TBnD3XFZu9xTTj+kx7/ZPzu0iFIlnaRA1btTzCmQHg01zFw
        pD1tVxpLfMgtrCkuCcssCY9CGc0bgJCM/1C19SHmDUkLrWdc
X-Google-Smtp-Source: ABdhPJwN64BJqaeYhdPFxyZgp216gXtiWrfyXedsv28m6nR0w3XVay2RZzjVFcyl7xUj2MEtlepDUzCq6jwfiyEJdFioX6l3HEc7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:20a:: with SMTP id e10mr4774996jaq.20.1603320306871;
 Wed, 21 Oct 2020 15:45:06 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:45:06 -0700
In-Reply-To: <089e0825cec8180a2b0568c4ee1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a390a05b2361916@google.com>
Subject: Re: WARNING in ext4_set_page_dirty
From:   syzbot <syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, chris@chris-wilson.co.uk,
        dvyukov@google.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.kuoppala@linux.intel.com,
        rodrigo.vivi@intel.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7dfbf8a07cf8c936b0d6cc810df6ae7923954d5b
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue Jun 30 15:27:24 2020 +0000

    drm/i915: Skip stale object handle for debugfs per-file-stats

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153d895f900000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=9a44753ac327c557796a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10055799e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b852c6e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/i915: Skip stale object handle for debugfs per-file-stats

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
