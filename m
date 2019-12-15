Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B636511F6B3
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Dec 2019 07:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfLOGwB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Dec 2019 01:52:01 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54947 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfLOGwB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Dec 2019 01:52:01 -0500
Received: by mail-io1-f71.google.com with SMTP id a22so3265689iol.21
        for <linux-ext4@vger.kernel.org>; Sat, 14 Dec 2019 22:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u5G1wrWjpZdsvluOyjyhr3hFBI3eS6YddfcUNsAZMTM=;
        b=OpViazhWYf3iCPmUM3GBXyb8NohNwm6cenZmS2zZ9IwUrU5KYFhHHWxM+eNFAyi9CI
         bcepCBAuvk0BpU0p0oUn3lWyVi8jkSFd1zeGw3qc6QdK4AjjQF5MQGPx0623LMGtoC4C
         N+PEecwgT+/t4lwDg/XKll5r/SQpPud/ctViyGjb8Z5sKpd4JGuhPHD0LJ63zoSeWoNS
         aIqYP4oh8elAaGcn4zDhXt//9CHoVYbKkw72YLM+eytEpOnjz4Lqpmzz9ISEapOGNNdZ
         U6UsfiPRs0gGee8OOmCtbkthFDc0jH9i7U4gEZv875xIWXxgwiExunRoxtINTharTKO4
         DKTw==
X-Gm-Message-State: APjAAAXmb9uoz85nWWNisqEmOGzs+kaPHUVpCKaAe45SbzbHzxTPA0i2
        +vX6jYhI1UwJPM0PleDtjYk6eBAX9nleBR+lJma325mO7+P8
X-Google-Smtp-Source: APXvYqxyLGjpjTN0mObYvpOtmBDQtr6uJ7PwrSM6L61lcM5UPHprWuZJancgeOdVtUb3P1pj0JRYbD3+nDwIa7kKTYXjQFKUuwTE
MIME-Version: 1.0
X-Received: by 2002:a92:3b98:: with SMTP id n24mr7262387ilh.189.1576392721076;
 Sat, 14 Dec 2019 22:52:01 -0800 (PST)
Date:   Sat, 14 Dec 2019 22:52:01 -0800
In-Reply-To: <20191215063020.GA11512@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a99070599b888dd@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com,
        b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com

Tested on:

commit:         dfdeeb41 Merge branch 'tt/misc' into dev
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=be3b077056d26622
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b02546e00000

Note: testing is done by a robot and is best-effort only.
