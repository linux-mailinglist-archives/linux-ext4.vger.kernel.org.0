Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B551D117D70
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 03:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLJCBl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Dec 2019 21:01:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56186 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfLJCBl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Dec 2019 21:01:41 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBA21Ukk012184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Dec 2019 21:01:32 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9468A421A48; Mon,  9 Dec 2019 21:01:30 -0500 (EST)
Date:   Mon, 9 Dec 2019 21:01:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     ebiggers3@gmail.com, adilger.kernel@dilger.ca,
        bot+eb13811afcefe99cfe45081054e7883f569f949d@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: ppc64el kernel access of bad area
 (ext4_htree_store_dirent->rb_insert_color)
Message-ID: <20191210020130.GA61323@mit.edu>
References: <20171219215906.GA12465@gmail.com>
 <20191209132914.907306-1-rafaeldtinoco@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209132914.907306-1-rafaeldtinoco@ubuntu.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 09, 2019 at 10:29:14AM -0300, Rafael David Tinoco wrote:
> It looks like the same stacktrace that was reported in this thread. This has
> been reported to ppc64el AND we got a reproducer (ocfs2-tools autopkgtests).

Can you share your reproducer?  Is it a super-simple reproducer that
doesn't require a complex setup and which can be triggered in some
kind of virtual machine (under KVM, etc.)?

> Thread from beginning 2018, so I guess this issue is pretty intermittent but
> might exist, and, perhaps, its related to specific arches/machines ?

What syzbot reported (a) had no reproducer, (b) only reproduced twice
on linux-next in 2017, and never since.  So if you're seeing something
in 2019 in ppc64el, it may not be the same issue.

   	   	       	       	      - Ted
