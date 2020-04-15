Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196701A9211
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393149AbgDOEzG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 00:55:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56817 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389360AbgDOEzF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Apr 2020 00:55:05 -0400
Received: by mail-il1-f199.google.com with SMTP id u19so2719138ilj.23
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 21:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Y2W+RK5QX6ymnzvXaAg6rFGFyTW39IKvpdZtQG2d1eM=;
        b=PviCEPBE3E5usT8TgOQ+c1F0U7CEXQ5KfbtwtqMh4Ns6OM2pr6f4iOM/nzRnRa6nEX
         88qmQvS0dTvfT25nE9bkKOmO4LBFWwk2k7r+PFBG4riCy0paXf1JQNv9wwTpmUexanpU
         PufoChziHFSNOkdpZ6IzvfZaoK1C/kIOjzKYoNS59lZ56hXI6FQGxqFvMhqmXOUqcPCl
         havduZe8d19HNS6bgmG25BU5jj1E8AXyl0PrCn1DtEWWl0hCrDCzSLYCDHqsWtsxP20y
         b+YdGM2IB6PC7ZTaF7VaEJQk0Xx2KVfpjHkf/bfJIqqhfNfVTAC376JXZjzz9opbTsGh
         fTzA==
X-Gm-Message-State: AGi0PuY/1UAVHvCcOZ8ZqHGMi6sNT6d2l15rr/xTs9/GECffRsw2rANV
        Y89aNFG6ikPmlif+jMuuCUesJcDEovBOKZKxWlOPwtNrEUdU
X-Google-Smtp-Source: APiQypLoHsOzgEfyXKGl1uv7QMFA3G0iEexcJWQkFz/EJ2Og/YlYLQkyynZxJlWrP+PyBVAXtw3KwYrchO1YR8DpHflA85WQ9cBY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154a:: with SMTP id h10mr24660899iow.137.1586926504681;
 Tue, 14 Apr 2020 21:55:04 -0700 (PDT)
Date:   Tue, 14 Apr 2020 21:55:04 -0700
In-Reply-To: <20200415043553.GH90651@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098a5d505a34d1e48@google.com>
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

commit:         5b8b9d0c Merge branch 'akpm' (patches from Andrew)
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15524a00100000

Note: testing is done by a robot and is best-effort only.
