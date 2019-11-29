Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7B10D5E7
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfK2MzZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Nov 2019 07:55:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41046 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbfK2MzZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Nov 2019 07:55:25 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xATCtJcw013959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 07:55:20 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 18923421A48; Fri, 29 Nov 2019 07:55:19 -0500 (EST)
Date:   Fri, 29 Nov 2019 07:55:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+1e407c24e65e1fca3ecf@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in ext4_mark_inode_dirty
Message-ID: <20191129125519.GA16443@mit.edu>
References: <000000000000fd1f29059877e56a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fd1f29059877e56a@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 29, 2019 at 12:20:10AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a2d79c71 Merge tag 'for-5.3/io_uring-20190711' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1632a03fa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf58f4f254e2639
> dashboard link: https://syzkaller.appspot.com/bug?extid=1e407c24e65e1fca3ecf
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)

#syz dup: KASAN: use-after-free Write in __ext4_expand_extra_isize (2)

     	  	 		      	 - Ted
